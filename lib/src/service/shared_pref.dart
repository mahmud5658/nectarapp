import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static const String _loginKey = "isLoggedIn";
  static const String _nameKey = "userName";
  static const String _emailKey = "userEmail";

  static Future<void> setLoginStatus(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loginKey, value);
  }


  static Future<bool> getLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loginKey) ?? false;
  }


  static Future<void> setUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_nameKey, name);
  }


  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_nameKey);
  }


  static Future<void> setUserEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_emailKey, email);
  }

  static Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_emailKey);
  }
}
