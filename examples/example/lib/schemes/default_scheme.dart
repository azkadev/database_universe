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
// ignore_for_file: public_member_api_docs

import 'package:general_lib/general_lib.dart';

///
class ExampleDefaultScheme {
  static Map<String, dynamic> account({
    required GeneralLibSchemeType generalLibSchemeType,
  }) {
    final Map<String, dynamic> defaultData = <String, dynamic>{
      "@type": "account${generalLibSchemeType.toSpesialType()}",
      "id": 0,
      "title": "",
      "first_name": "",
      "last_name": "",
      "username": "",
      "api_user_id": 0,
      "app_id": "",
      "telegram_user_id": 0,
      "github_user_id": 0,
      "bio": "",
      "descrition": "",
      "expire_date_plan": "",
      "plan_type": "",
      "plan_first_type": "",
      "type": "user",
      "created_date": 0,
      "is_verified": false,
      "is_sandbox": false,
      "is_admin": false,
      "is_creator": false,
      "origin_language_code": "",
      "expire_create_new_account_date": 0,
    };
    if (generalLibSchemeType == GeneralLibSchemeType.database) {
      defaultData.general_lib_extension_updateForce(data: {
        "expire_check_verified_date": DateTime.now().millisecondsSinceEpoch,
        "sign_up_invoice_url": "",
        "sign_up_invoice_id": "",
        "is_has_pay_sign_up": false,
        "password": "",
        "secret_words": "",
        "account_unique_id": "",
        "balance": "",
      });
      return defaultData;
    } else {
      defaultData.general_lib_extension_updateForce(data: {
        "profile_photo": "",
        "balance": 0,
      });
    }

    return defaultData;
  }

  static Map<String, dynamic> session({
    required GeneralLibSchemeType generalLibSchemeType,
  }) {
    final Map<String, dynamic> jsonData = {
      "@type": "session${generalLibSchemeType.toSpesialType()}",
      "account_user_id": 0,
      "title": "",
      "system_version": "",
      "token": "",
      "ip_address": "",
      "location": "",
      "is_current": true,
      "client_token": "",
      "created_date": 0,
      "last_update_date": 0,
      "program_date": 0,
      "app_id": "",
      "is_default": false,
      "is_sandbox": false,
      "log_in_date": 0,
      "last_active_date": 0,
      "session_id": "",
      "is_password_pending": true,
      "is_unconfirmed": true,
      "can_accept_secret_chats": true,
      "can_accept_calls": true,
      "application_name": "",
      "application_version": "",
      "is_official_application": true,
      "device_model": "",
      "platform": "",
      "code": "",
      "socket_id": "",
    };

    if (generalLibSchemeType == GeneralLibSchemeType.database) {
      // json_data.general_lib_extension_updateForce(data: <String, dynamic>{

      // });
    } else if (generalLibSchemeType == GeneralLibSchemeType.local) {
      jsonData.general_lib_extension_updateForce(data: <String, dynamic>{
        "is_default": false,
      });
    }
    return jsonData;
  }
}
