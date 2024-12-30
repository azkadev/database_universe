#!/bin/bash

if [ -z "$DATABASE_UNIVERSE_VERSION" ]; then
    echo "DATABASE_UNIVERSE_VERSION is not set";
    exit 2;
fi

github="https://github.com/database_universe/database_universe/releases/download/$DATABASE_UNIVERSE_VERSION"


curl "${github}/libDatabaseUniverse_android_arm64.so" -o library/database_universe_flutter_libs/android/src/main/jniLibs/arm64-v8a/libDatabaseUniverse.so --create-dirs -L -f
curl "${github}/libDatabaseUniverse_android_armv7.so" -o library/database_universe_flutter_libs/android/src/main/jniLibs/armeabi-v7a/libDatabaseUniverse.so --create-dirs -L -f
curl "${github}/libDatabaseUniverse_android_x64.so" -o library/database_universe_flutter_libs/android/src/main/jniLibs/x86_64/libDatabaseUniverse.so --create-dirs -L

curl "${github}/database_universe_ios.xcframework.zip" -o library/database_universe_flutter_libs/ios/database_universe_ios.xcframework.zip --create-dirs -L -f
unzip -o library/database_universe_flutter_libs/ios/database_universe_ios.xcframework.zip -d library/database_universe_flutter_libs/ios
rm library/database_universe_flutter_libs/ios/database_universe_ios.xcframework.zip

curl "${github}/libDatabaseUniverse_macos.dylib" -o library/database_universe_flutter_libs/macos/libDatabaseUniverse.dylib --create-dirs -L -f
curl "${github}/libDatabaseUniverse_linux_x64.so" -o library/database_universe_flutter_libs/linux/libDatabaseUniverse.so --create-dirs -L -f
curl "${github}/database_universe_windows_x64.dll" -o library/database_universe_flutter_libs/windows/database_universe.dll --create-dirs -L -f

curl "${github}/database_universe.wasm" -o database_universe.wasm -L -f