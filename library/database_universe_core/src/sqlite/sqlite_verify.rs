use super::sqlite_collection::{SQLiteCollection, SQLiteProperty};
use super::{sql::sql_data_type, sqlite3::SQLite3};
use crate::core::error::{DatabaseUniverseError, Result};

pub(crate) fn verify_sqlite(sqlite: &SQLite3, cols: &[SQLiteCollection]) -> Result<()> {
    let mut table_names = vec![];

    for col in cols {
        if !col.is_embedded() {
            table_names.push(col.name.clone());
        }
    }
    let mut actual_table_names = sqlite.get_table_names()?;

    table_names.sort();
    actual_table_names.sort();

    if table_names != actual_table_names {
        return Err(DatabaseUniverseError::DbCorrupted {});
    }

    for table in table_names {
        let collection = cols.iter().find(|c| c.name == table).unwrap();

        let mut columns = sqlite.get_table_columns(&table)?;
        let columns_id_len = columns.len();
        columns.retain(|(n, t)| n != SQLiteProperty::ID_NAME && t != "INTEGER");

        if columns_id_len != columns.len() + 1 || columns.len() != collection.properties.len() {
            return Err(DatabaseUniverseError::DbCorrupted {});
        }

        for (column, sql_type) in columns {
            let (data_type, target_col_name) = sql_data_type(&sql_type);
            let target_col_index = if let Some(name) = target_col_name {
                let index = cols.iter().position(|c| c.name == name).map(|i| i as u16);
                if index.is_none() {
                    return Err(DatabaseUniverseError::DbCorrupted {});
                }
                index
            } else {
                None
            };

            let prop = collection.properties.iter().find(|p| p.name == column);

            if let Some(prop) = prop {
                if prop.data_type != data_type {
                    return Err(DatabaseUniverseError::DbCorrupted {});
                }
                if prop.collection_index != target_col_index {
                    return Err(DatabaseUniverseError::DbCorrupted {});
                }
            } else {
                return Err(DatabaseUniverseError::DbCorrupted {});
            }
        }

        let indexes = sqlite.get_table_indexes(&table)?;
        if indexes.len() != collection.indexes.len() {
            return Err(DatabaseUniverseError::DbCorrupted {});
        }

        for (index, unique, cols) in indexes {
            let name = index.strip_prefix(&format!("{}_", table));
            let index = collection.indexes.iter().find(|i| {
                Some(i.name.as_str()) == name && i.unique == unique && i.properties == cols
            });

            if index.is_none() {
                return Err(DatabaseUniverseError::DbCorrupted {});
            }
        }
    }

    Ok(())
}
