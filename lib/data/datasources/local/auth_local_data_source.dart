import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/core/constants/key.dart';

class AuthLocalDataSource {
  final SharedPreferences _prefs;
  AuthLocalDataSource(this._prefs);

  static const String _userIdKey = AppKey.USER_ID;
  static const String _userAvtKey = AppKey.USER_AVATAR;

  Future<void> saveUserData(int userId,String userAvtUrl) async {
    await _prefs.setInt(_userIdKey, userId);
    await _prefs.setString(_userAvtKey, userAvtUrl);
  }

  int? getUserId() {
    return _prefs.getInt(_userIdKey);
  }

  String? getUserAvtUrl() {
    return _prefs.getString(_userAvtKey);
  }

  Future<void> clearSession() async {
    await _prefs.remove(_userIdKey);
    await _prefs.remove(_userAvtKey);
  }
}