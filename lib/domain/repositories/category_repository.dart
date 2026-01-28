import 'package:todo/domain/entities/category_entity.dart';

abstract class CategoryRepository {
  Future<List<CategoryEntity>> getAllCategory();
  Future<CategoryEntity> getCategoryById(int id);
}