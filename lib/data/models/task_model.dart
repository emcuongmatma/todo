import 'package:isar/isar.dart';
import 'package:todo/core/constants/key.dart';
import 'package:todo/domain/entities/category_entity.dart';
import 'package:todo/domain/entities/task_entity.dart';

part 'task_model.g.dart';

@collection
class TaskModel {
  Id id = Isar.autoIncrement;
  String? serverId;
  late int userId;
  @Index()
  late String title;
  late String description;
  late DateTime dateTime;
  late int priority;
  late int categoryId;
  late bool isCompleted;
  @Index()
  bool isSynced = false;

  TaskEntity toEntity(List<CategoryEntity> categories) {
    return TaskEntity(
      id: id,
      title: title,
      description: description,
      dateTime: dateTime,
      priority: priority,
      isCompleted: isCompleted,
      serverId: serverId,
      category: categories.firstWhere(
        (cat) => cat.id == categoryId,
        orElse: () => categories.first,
      ),
    );
  }

  static TaskModel fromEntity(TaskEntity entity, int currentUserId) {
    return TaskModel()
      ..id = entity.id ?? Isar.autoIncrement
      ..title = entity.title
      ..description = entity.description
      ..dateTime = entity.dateTime
      ..priority = entity.priority
      ..isCompleted = entity.isCompleted
      ..serverId = entity.serverId
      ..userId = currentUserId
      ..isSynced = false
      ..categoryId = entity.category.id;
  }

  static TaskModel fromJson(Map<String, dynamic> json) {
    return TaskModel()
      ..serverId = json[AppKey.ID]?.toString()
      ..userId = int.tryParse(json[AppKey.USER_ID]?.toString() ?? '0') ?? 0
      ..title = json[AppKey.TITLE] ?? ''
      ..description = json[AppKey.DESCRIPTION] ?? ''
      ..dateTime =
          DateTime.tryParse(json[AppKey.DATETIME]?.toString() ?? "") ??
          DateTime.now()
      ..priority = json[AppKey.PRIORITY] ?? 0
      ..categoryId = json[AppKey.CATEGORY_ID] ?? 0
      ..isCompleted = json[AppKey.IS_COMPLETED] ?? false
      ..isSynced = true;
  }

  Map<String, dynamic> toJson() {
    return {
      AppKey.USER_ID: userId,
      AppKey.TITLE: title,
      AppKey.DESCRIPTION: description,
      AppKey.DATETIME: dateTime.toString(),
      AppKey.PRIORITY: priority,
      AppKey.CATEGORY_ID: categoryId,
      AppKey.IS_COMPLETED: isCompleted,
    };
  }
}
