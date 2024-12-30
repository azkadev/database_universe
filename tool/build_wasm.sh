rustup target add wasm32-unknown-unknown
cargo build --target wasm32-unknown-unknown --features sqlite --no-default-features -p database_universe --release
mv "target/wasm32-unknown-unknown/release/database_universe.wasm" "database_universe.wasm"