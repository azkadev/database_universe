use super::database_universe_deserializer::DatabaseUniverseDeserializer;
use super::native_collection::NativeCollection;
use super::native_reader::NativeReader;
use super::native_txn::{NativeTxn, TxnCursor};
use super::IdToBytes;
use crate::core::cursor::DatabaseUniverseCursor;
use crate::core::error::Result;

pub struct NativeCursor<'a> {
    cursor: TxnCursor<'a>,
    collection: &'a NativeCollection,
    collections: &'a Vec<NativeCollection>,
}

impl<'a> NativeCursor<'a> {
    pub(crate) fn new(
        txn: &'a NativeTxn,
        collection: &'a NativeCollection,
        collections: &'a Vec<NativeCollection>,
    ) -> Result<Self> {
        let cursor = collection.get_cursor(txn)?;
        let nc = Self {
            cursor,
            collection,
            collections,
        };
        Ok(nc)
    }
}

impl<'a> DatabaseUniverseCursor for NativeCursor<'a> {
    type Reader<'b> = NativeReader<'b> where Self: 'b;

    #[inline]
    fn next(&mut self, id: i64) -> Option<Self::Reader<'_>> {
        if let Some((_, bytes)) = self.cursor.move_to(&id.to_id_bytes()).ok()? {
            let object = DatabaseUniverseDeserializer::from_bytes(bytes);
            Some(NativeReader::new(
                id,
                object,
                self.collection,
                &self.collections,
            ))
        } else {
            None
        }
    }
}
