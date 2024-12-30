use super::reader::DatabaseUniverseReader;

pub trait DatabaseUniverseCursor {
    type Reader<'a>: DatabaseUniverseReader
    where
        Self: 'a;

    fn next(&mut self, id: i64) -> Option<Self::Reader<'_>>;
}

pub trait DatabaseUniverseQueryCursor {
    type Reader<'a>: DatabaseUniverseReader
    where
        Self: 'a;

    fn next(&mut self) -> Option<Self::Reader<'_>>;
}
