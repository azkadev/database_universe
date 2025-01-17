//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <database_universe_flutter_libs/database_universe_flutter_libs_plugin.h>
#include <media_kit_libs_linux_fork/media_kit_libs_linux_plugin.h>
#include <media_kit_video_fork/media_kit_video_plugin.h>
#include <url_launcher_linux/url_launcher_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) database_universe_flutter_libs_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "DatabaseUniverseFlutterLibsPlugin");
  database_universe_flutter_libs_plugin_register_with_registrar(database_universe_flutter_libs_registrar);
  g_autoptr(FlPluginRegistrar) media_kit_libs_linux_fork_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "MediaKitLibsLinuxPlugin");
  media_kit_libs_linux_plugin_register_with_registrar(media_kit_libs_linux_fork_registrar);
  g_autoptr(FlPluginRegistrar) media_kit_video_fork_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "MediaKitVideoPlugin");
  media_kit_video_plugin_register_with_registrar(media_kit_video_fork_registrar);
  g_autoptr(FlPluginRegistrar) url_launcher_linux_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "UrlLauncherPlugin");
  url_launcher_plugin_register_with_registrar(url_launcher_linux_registrar);
}
