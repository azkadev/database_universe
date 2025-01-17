// ignore_for_file: non_constant_identifier_names, public_member_api_docs

final List<Map<String, dynamic>> example_api_schemes = [
  {
    "@type": "signIn",
    "username": "",
    "password": "",
    "@return_type": "session",
  },
  {
    "@type": "signUp",
    "username": "",
    "password": "",
    "@return_type": "ok",
  },
  {
    "@type": "resetPassword",
    "secret_word": "",
    "@return_type": "ok",
  },
  {
    "@type": "sendChatbotMessage",
    "text": "",
    "@return_type": "ok",
  },
  {
    "@type": "getChatbotHistoryMessages",
    "offset": 0,
    "limit": 0,
    "@return_type": "ok",
  },
];
