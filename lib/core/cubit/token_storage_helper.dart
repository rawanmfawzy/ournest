import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
  }

  static Future<void> saveRefreshToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("refreshToken", token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("refreshToken");
  }

  static Future<bool> hasToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token") != null;
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
  static Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("userId", userId);
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("userId");
  }

  static Future<void> saveRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("role", role);
  }

  static Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("role");
  }

  static Future<void> saveIsPregnant(bool isPregnant) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isPregnant", isPregnant);
  }

  static Future<bool?> getIsPregnant() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isPregnant");
  }

  static Future<void> saveCurrentWeek(int week) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("currentWeek", week);
  }

  static Future<int?> getCurrentWeek() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt("currentWeek");
  }

  static Future<void> saveBabyGender(String gender) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("babyGender", gender);
  }

  static Future<String?> getBabyGender() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("babyGender");
  }

  static Future<void> saveBabyBirthDate(String dob) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("babyBirthDate", dob);
  }

  static Future<String?> getBabyBirthDate() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("babyBirthDate");
  }
}