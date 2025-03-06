import 'package:shared_preferences/shared_preferences.dart';
class UserSharedPreferences {
  static const _nameKey = 'name';
  static const _userIdKey = 'userId';
  static const _userRoleKey = 'userRole';
  static const _isLoggedInKey='isLoggedIn';
  static const _emailKey='userEmail';
  // Method to load all user data (name, userId, userRole)
  Future<Map<String, String?>> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve the stored values or return null if not found
    String? name = prefs.getString(_nameKey);
    String? userId = prefs.getString(_userIdKey);
    String? userRole = prefs.getString(_userRoleKey);
    String? isLoggedIn = prefs.getString(_isLoggedInKey);
    String? email = prefs.getString(_emailKey);

    return {
      'name': name,
      'userId': userId,
      'userRole': userRole,
      'isLoggedIn':isLoggedIn,
      'email':email
    };
  }

  // Method to save all user data (name, userId, userRole)
  Future<void> saveUserData(String name, String userId, String userRole,String email,String isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save the data to SharedPreferences
    await prefs.setString(_nameKey, name);
    await prefs.setString(_userIdKey, userId);
    await prefs.setString(_userRoleKey, userRole);
    await prefs.setString(_emailKey, email);
    await prefs.setString(_isLoggedInKey,isLoggedIn );
  }
  Future<void>clearUserData()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_nameKey);
    await prefs.remove(_userIdKey);
    await prefs.remove(_userRoleKey);
    await prefs.remove(_emailKey);
    await prefs.remove(_isLoggedInKey);
  }
}