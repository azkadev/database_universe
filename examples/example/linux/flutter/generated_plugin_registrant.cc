//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <database_universe_flutter_libs/database_universe_flutter_libs_plugin.h>
#include <media_universe_flutter/media_universe_flutter.h>
#include <screen_retriever_linux/screen_retriever_linux_plugin.h>
#include <url_launcher_linux/url_launcher_plugin.h>
#include <window_manager/window_manager_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) database_universe_flutter_libs_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "DatabaseUniverseFlutterPlugin");
  database_universe_flutter_libs_plugin_register_with_registrar(database_universe_flutter_libs_registrar);
  g_autoptr(FlPluginRegistrar) media_universe_flutter_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "MediaUniverseFlutter");
  media_universe_flutter_register_with_registrar(media_universe_flutter_registrar);
  g_autoptr(FlPluginRegistrar) screen_retriever_linux_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "ScreenRetrieverLinuxPlugin");
  screen_retriever_linux_plugin_register_with_registrar(screen_retriever_linux_registrar);
  g_autoptr(FlPluginRegistrar) url_launcher_linux_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "UrlLauncherPlugin");
  url_launcher_plugin_register_with_registrar(url_launcher_linux_registrar);
  g_autoptr(FlPluginRegistrar) window_manager_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "WindowManagerPlugin");
  window_manager_plugin_register_with_registrar(window_manager_registrar);
}
