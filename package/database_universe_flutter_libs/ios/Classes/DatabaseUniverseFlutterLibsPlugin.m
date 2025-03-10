#import "DatabaseUniverseFlutterLibsPlugin.h"
#if __has_include(<database_universe_flutter_libs/DatabaseUniverseFlutterLibsPlugin-Swift.h>)
#import <database_universe_flutter_libs/DatabaseUniverseFlutterLibsPlugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "DatabaseUniverseFlutterLibsPlugin-Swift.h"
#endif

@implementation DatabaseUniverseFlutterLibsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftDatabaseUniverseFlutterLibsPlugin registerWithRegistrar:registrar];
}
@end
