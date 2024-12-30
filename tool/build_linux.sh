if [ "$1" = "x64" ]; then
  rustup target add target x86_64-unknown-linux-gnu
  cargo build --target x86_64-unknown-linux-gnu --features sqlcipher-vendored --release
  mv "target/x86_64-unknown-linux-gnu/release/libdatabase_universe.so" "libdatabase_universe_linux_x64.so"
else
  rustup target add aarch64-unknown-linux-gnu
  cargo build --target aarch64-unknown-linux-gnu --features sqlcipher-vendored --release
  mv "target/aarch64-unknown-linux-gnu/release/libdatabase_universe.so" "libdatabase_universe_linux_arm64.so"
fi
