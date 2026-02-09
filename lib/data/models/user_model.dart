import 'package:isar/isar.dart';
import 'package:todo/core/constants/key.dart';
import 'package:todo/domain/entities/user_entity.dart';
part 'user_model.g.dart';
@collection
class UserModel {
  Id id = Isar.autoIncrement;
  @Index(unique: true, replace: true)
  late String serverId;
  late String username;
  late String avatarUrl;

  UserEntity toEntity() {
    return UserEntity(id: serverId, username: username, avatarUrl: avatarUrl);
  }

  static UserModel fromEntity(UserEntity entity) {
    return UserModel()
      ..id
      ..username
      ..avatarUrl;
  }

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel()
      ..serverId = json[AppKey.ID].toString()
      ..username = json[AppKey.USERNAME].toString()
      ..avatarUrl = json[AppKey.USER_AVATAR].toString();
  }

  Map<String, dynamic> toJson() {
    return {
      AppKey.ID: id,
      AppKey.USERNAME: username,
      AppKey.USER_AVATAR: avatarUrl,
    };
  }
}
