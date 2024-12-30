export IPHONEOS_DEPLOYMENT_TARGET=12.0

rustup target add aarch64-apple-ios aarch64-apple-ios-sim x86_64-apple-ios
cargo build --target aarch64-apple-ios --features sqlcipher --release
cargo build --target aarch64-apple-ios-sim --features sqlcipher --release
cargo build --target x86_64-apple-ios --features sqlcipher --release

lipo "target/aarch64-apple-ios-sim/release/libDatabaseUniverse.a" "target/x86_64-apple-ios/release/libDatabaseUniverse.a" -output "target/aarch64-apple-ios-sim/libDatabaseUniverse.a" -create
xcodebuild \
    -create-xcframework \
    -library target/aarch64-apple-ios/release/libDatabaseUniverse.a \
    -library target/aarch64-apple-ios-sim/libDatabaseUniverse.a \
    -output database_universe.xcframework 

zip -r database_universe_ios.xcframework.zip database_universe.xcframework