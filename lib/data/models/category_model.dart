import 'package:isar/isar.dart';
import 'package:todo/domain/entities/category_entity.dart';
part 'category_model.g.dart';
@collection
class CategoryModel {
  Id id = Isar.autoIncrement;
  late String backgroundColor;
  late String icon;
  @Index(type: IndexType.value)
  late String name;

  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      name: name,
      icon: icon,
      backgroundColor: backgroundColor
    );
  }

  static CategoryModel fromEntity(CategoryEntity entity) {
    return CategoryModel()
      ..name = entity.name
      ..icon = entity.icon
      ..backgroundColor = entity.backgroundColor;
  }
}
