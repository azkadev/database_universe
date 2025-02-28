/* <!-- START LICENSE -->


This Software / Program / Source Code Created By Developer From Company GLOBAL CORPORATION
Social Media:

   - Youtube: https://youtube.com/@Global_Corporation 
   - Github: https://github.com/globalcorporation
   - TELEGRAM: https://t.me/GLOBAL_CORP_ORG_BOT

All code script in here created 100% original without copy / steal from other code if we copy we add description source at from top code

If you wan't edit you must add credit me (don't change)

If this Software / Program / Source Code has you

Jika Program ini milik anda dari hasil beli jasa developer di (Global Corporation / apapun itu dari turunan itu jika ada kesalahan / bug / ingin update segera lapor ke sub)

Misal anda beli Beli source code di Slebew CORPORATION anda lapor dahulu di slebew jangan lapor di GLOBAL CORPORATION!

Jika ada kendala program ini (Pastikan sebelum deal project tidak ada negosiasi harga)
Karena jika ada negosiasi harga kemungkinan

1. Software Ada yang di kurangin
2. Informasi tidak lengkap
3. Bantuan Tidak Bisa remote / full time (Ada jeda)

Sebelum program ini sampai ke pembeli developer kami sudah melakukan testing

jadi sebelum nego kami sudah melakukan berbagai konsekuensi jika nego tidak sesuai ? 
Bukan maksud kami menipu itu karena harga yang sudah di kalkulasi + bantuan tiba tiba di potong akhirnya bantuan / software kadang tidak lengkap


<!-- END LICENSE --> */
#include "include/database_universe_flutter/database_universe_flutter_plugin.h"

#include <flutter_linux/flutter_linux.h>
#include <gtk/gtk.h>
#include <sys/utsname.h>

#include <cstring>

#define DATABASE_UNIVERSE_FLUTTER_PLUGIN(obj) \
  (G_TYPE_CHECK_INSTANCE_CAST((obj), database_universe_flutter_plugin_get_type(), \
                              DatabaseUniverseFlutterPlugin))

struct _DatabaseUniverseFlutterPlugin {
  GObject parent_instance;
};

G_DEFINE_TYPE(DatabaseUniverseFlutterPlugin, database_universe_flutter_plugin, g_object_get_type())

// Called when a method call is received from Flutter.
static void database_universe_flutter_plugin_handle_method_call(
    DatabaseUniverseFlutterPlugin* self,
    FlMethodCall* method_call) {
  g_autoptr(FlMethodResponse) response = nullptr;

  const gchar* method = fl_method_call_get_name(method_call);

  if (strcmp(method, "getPlatformVersion") == 0) {
    struct utsname uname_data = {};
    uname(&uname_data);
    g_autofree gchar *version = g_strdup_printf("Linux %s", uname_data.version);
    g_autoptr(FlValue) result = fl_value_new_string(version);
    response = FL_METHOD_RESPONSE(fl_method_success_response_new(result));
  } else {
    response = FL_METHOD_RESPONSE(fl_method_not_implemented_response_new());
  }

  fl_method_call_respond(method_call, response, nullptr);
}

static void database_universe_flutter_plugin_dispose(GObject* object) {
  G_OBJECT_CLASS(database_universe_flutter_plugin_parent_class)->dispose(object);
}

static void database_universe_flutter_plugin_class_init(DatabaseUniverseFlutterPluginClass* klass) {
  G_OBJECT_CLASS(klass)->dispose = database_universe_flutter_plugin_dispose;
}

static void database_universe_flutter_plugin_init(DatabaseUniverseFlutterPlugin* self) {}

static void method_call_cb(FlMethodChannel* channel, FlMethodCall* method_call,
                           gpointer user_data) {
  DatabaseUniverseFlutterPlugin* plugin = DATABASE_UNIVERSE_FLUTTER_PLUGIN(user_data);
  database_universe_flutter_plugin_handle_method_call(plugin, method_call);
}

void database_universe_flutter_plugin_register_with_registrar(FlPluginRegistrar* registrar) {
  DatabaseUniverseFlutterPlugin* plugin = DATABASE_UNIVERSE_FLUTTER_PLUGIN(
      g_object_new(database_universe_flutter_plugin_get_type(), nullptr));

  g_autoptr(FlStandardMethodCodec) codec = fl_standard_method_codec_new();
  g_autoptr(FlMethodChannel) channel =
      fl_method_channel_new(fl_plugin_registrar_get_messenger(registrar),
                            "database_universe_flutter",
                            FL_METHOD_CODEC(codec));
  fl_method_channel_set_method_call_handler(channel, method_call_cb,
                                            g_object_ref(plugin),
                                            g_object_unref);

  g_object_unref(plugin);
}
