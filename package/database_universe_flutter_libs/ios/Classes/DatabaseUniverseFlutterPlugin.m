#import "DatabaseUniverseFlutterPlugin.h"
#if __has_include(<database_universe_flutter/database_universe_flutter-Swift.h>)
#import <database_universe_flutter/database_universe_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "database_universe_flutter-Swift.h"
#endif

@implementation DatabaseUniverseFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftDatabaseUniverseFlutterPlugin registerWithRegistrar:registrar];
}
@end
