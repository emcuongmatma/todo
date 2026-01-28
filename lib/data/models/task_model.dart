import 'package:isar/isar.dart';
import 'package:todo/domain/entities/category_entity.dart';
import 'package:todo/domain/entities/task_entity.dart';
part 'task_model.g.dart';
@collection
class TaskModel {
  @Index(type: IndexType.value)
  Id id = Isar.autoIncrement;
  late String title;
  late String description;
  late DateTime dateTime;
  late int priority;
  late int categoryId;
  late bool isCompleted;
  TaskEntity toEntity(List<CategoryEntity> categories) {
    return TaskEntity(
      id: id,
      title: title,
      description: description,
      dateTime: dateTime,
      priority: priority,
      isCompleted: isCompleted,
      category: categories.firstWhere(
            (cat) => cat.id == categoryId,
        orElse: () => categories.first,
      ),
    );
  }
  static TaskModel fromEntity(TaskEntity entity) {
    return TaskModel()
      ..id = entity.id ?? Isar.autoIncrement
      ..title = entity.title
      ..description = entity.description
      ..dateTime = entity.dateTime
      ..priority = entity.priority
      ..isCompleted = entity.isCompleted
      ..categoryId = entity.category.id;
  }
}