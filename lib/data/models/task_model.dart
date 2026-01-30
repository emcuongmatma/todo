import 'package:isar/isar.dart';
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

  static TaskModel fromJson(Map<String,dynamic> json){
    return TaskModel()
      ..serverId = json['id']?.toString()
      ..userId = int.tryParse(json['userId']?.toString() ?? '0') ?? 0
      ..title = json['title'] ?? ''
      ..description = json['description'] ?? ''
      ..dateTime = DateTime.now()
      ..priority = json['priority'] ?? 0
      ..categoryId = json['categoryId'] ?? 0
      ..isCompleted = json['isCompleted'] ?? false
      ..isSynced = true;
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'title': title,
      'description': description,
      'dateTime': dateTime.toString(),
      'priority': priority,
      'categoryId': categoryId,
      'isCompleted': isCompleted,
    };
  }
}