#import "DatabaseUniverseFlutterLibsPlugin.h"
#if __has_include(<database_universe_flutter_libs/database_universe_flutter_libs-Swift.h>)
#import <database_universe_flutter_libs/database_universe_flutter_libs-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "database_universe_flutter_libs-Swift.h"
#endif

@implementation DatabaseUniverseFlutterLibsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftDatabaseUniverseFlutterLibsPlugin registerWithRegistrar:registrar];
}
@end
