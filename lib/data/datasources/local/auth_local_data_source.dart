import 'package:isar/isar.dart';
import 'package:todo/data/models/user_model.dart';

class AuthLocalDataSource {
  final Isar _isar;

  AuthLocalDataSource({required Isar isar})
    :_isar = isar;

  Future<void> saveUserData(
    int userId,
    String userAvtUrl,
    UserModel user,
  ) async {
    await _isar.writeTxn(() => _isar.userModels.put(user));
  }

  Future<UserModel?> getUserData() async {
    return await _isar.userModels.where().findFirst();
  }

  Future<void> clearSession() async {
    await _isar.userModels.clear();
  }
}
