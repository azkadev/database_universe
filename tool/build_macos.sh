export MACOSX_DEPLOYMENT_TARGET=10.11

rustup target add aarch64-apple-darwin x86_64-apple-darwin
cargo build --target aarch64-apple-darwin --features sqlcipher --release
cargo build --target x86_64-apple-darwin --features sqlcipher --release

lipo "target/aarch64-apple-darwin/release/libDatabaseUniverse.dylib" "target/x86_64-apple-darwin/release/libDatabaseUniverse.dylib" -output "libDatabaseUniverse_macos.dylib" -create
install_name_tool -id @rpath/libDatabaseUniverse.dylib libDatabaseUniverse_macos.dylib