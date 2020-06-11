

import 'package:shared_preferences/shared_preferences.dart';

/// 本地存储

class SharedPreferencesUtil {
  static String _token;

  static Future getToken() async {
    if(_token == null || _token.isEmpty) {
      SharedPreferences sp = await SharedPreferences.getInstance();
      _token = sp.getString('access-token') ?? null;
    }
    return _token;
  }

}