import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String userRoleKey = 'user_role';
  static const String passwordKey = 'password';

  static Future<void> setUserRole(String role) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(userRoleKey, role);
  }

  static Future<String?> getUserRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userRoleKey);
  }

  static Future<void> setPassword(String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(passwordKey, password);
  }

  static Future<String?> getPassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(passwordKey);
  }
   static Future<void> clearUserPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
