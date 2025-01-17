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
    final Map<String, dynamic> json_data = {
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
      json_data.general_lib_extension_updateForce(data: <String, dynamic>{
        "is_default": false,
      });
    }
    return json_data;
  }
 

}
