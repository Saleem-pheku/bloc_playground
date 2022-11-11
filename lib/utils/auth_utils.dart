import 'package:shared_preferences/shared_preferences.dart';

class AuthUtils {
  static const token = "bloc_playground";
  static Future<bool> saveToken(String newToken) async {
    if (newToken == null) return false;
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(token, newToken);
    return true;
  }

  static Future<bool> deleteToken() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(token)) {
      return await prefs.remove(token);
    }
    return true;
  }

  static Future<String?> getToken() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(token)) {
      String? tokenData = prefs.getString(token);
      if (tokenData != null) {
        return tokenData;
      }
    }
    return null;
  }
}
