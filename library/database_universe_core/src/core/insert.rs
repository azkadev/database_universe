use super::writer::DatabaseUniverseWriter;
use crate::core::error::Result;

pub trait DatabaseUniverseInsert<'a>: DatabaseUniverseWriter<'a> + Sized {
    type Txn;

    fn save(&mut self, id: i64) -> Result<()>;

    fn finish(self) -> Result<Self::Txn>;
}
