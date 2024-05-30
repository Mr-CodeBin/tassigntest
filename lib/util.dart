import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;

class Util {
  static Future<String?> getValueFromEnv(String key) async {
    await dotenv.dotenv.load(); // Load .env file
    String? value = dotenv.dotenv.env[key];
    log('Value for $key is $value');
    return value;
  }
}
