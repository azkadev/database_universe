use super::database_universe_serializer::DatabaseUniverseSerializer;
use super::native_collection::NativeCollection;
use super::native_txn::{NativeTxn, TxnCursor};
use super::MAX_OBJ_SIZE;
use crate::core::error::{DatabaseUniverseError, Result};
use crate::core::insert::DatabaseUniverseInsert;
use crate::core::watcher::ChangeSet;
use ouroboros::self_referencing;
use std::cell::RefMut;

#[self_referencing]
struct TxnWithCursor {
    txn: NativeTxn,
    #[borrows(txn)]
    #[covariant]
    cursor: TxnCursor<'this>,
    #[borrows(txn)]
    #[covariant]
    change_set: RefMut<'this, ChangeSet>,
}

impl TxnWithCursor {
    fn open(txn: NativeTxn, collection: &NativeCollection) -> Result<Self> {
        Self::try_new(
            txn,
            |txn| collection.get_cursor(txn),
            |txn| Ok(txn.get_change_set()),
        )
    }

    fn put(&mut self, collection: &NativeCollection, id: i64, bytes: &[u8]) -> Result<()> {
        self.with_mut(|mut this| {
            this.txn
                .guard(|| collection.put(this.txn, &mut this.change_set, this.cursor, id, bytes))
        })
    }

    fn close(self) -> NativeTxn {
        self.into_heads().txn
    }
}

pub struct NativeInsert<'a> {
    txn_cursor: TxnWithCursor,
    pub(crate) collection: &'a NativeCollection,
    pub(crate) all_collections: &'a Vec<NativeCollection>,

    remaining: u32,
    pub(crate) object: DatabaseUniverseSerializer,
}

impl<'a> NativeInsert<'a> {
    pub(crate) fn new(
        txn: NativeTxn,
        collection: &'a NativeCollection,
        all_collections: &'a Vec<NativeCollection>,
        count: u32,
    ) -> Result<Self> {
        let buffer = txn.take_buffer();
        let txn_cursor = TxnWithCursor::open(txn, collection)?;
        let insert = Self {
            txn_cursor,
            collection,
            all_collections,
            remaining: count,
            object: DatabaseUniverseSerializer::new(buffer, 0, collection.static_size),
        };
        Ok(insert)
    }
}

impl<'a> DatabaseUniverseInsert<'a> for NativeInsert<'a> {
    type Txn = NativeTxn;

    fn save(&mut self, id: i64) -> Result<()> {
        if self.remaining > 0 {
            let mut buffer = self.object.finish();
            if buffer.len() > MAX_OBJ_SIZE as usize {
                return Result::Err(DatabaseUniverseError::ObjectLimitReached {});
            }
            self.txn_cursor.put(self.collection, id, &buffer)?;

            self.remaining -= 1;
            buffer.clear();
            self.object = DatabaseUniverseSerializer::new(buffer, 0, self.collection.static_size);
            Ok(())
        } else {
            Err(DatabaseUniverseError::UnsupportedOperation {})
        }
    }

    fn finish(self) -> Result<Self::Txn> {
        if self.remaining > 0 {
            Err(DatabaseUniverseError::InsertIncomplete {})
        } else {
            let txn = self.txn_cursor.close();
            txn.put_buffer(self.object.finish());
            Ok(txn)
        }
    }
}
