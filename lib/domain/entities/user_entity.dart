import 'package:todo/core/constants/key.dart';

class UserEntity {
  final String username;
  final String avatarUrl;

  UserEntity({required this.username, required this.avatarUrl});

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      username: json[AppKey.USERNAME],
      avatarUrl: json[AppKey.USER_AVATAR],
    );
  }
}
