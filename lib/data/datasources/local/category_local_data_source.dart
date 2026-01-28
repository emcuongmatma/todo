import 'package:isar/isar.dart';
import 'package:todo/data/models/category_model.dart';

class CategoryLocalDataSource {
  final Isar isar;
  CategoryLocalDataSource(this.isar);

  Future<List<CategoryModel>> getCategories() async { 
    return await isar.categoryModels.where().findAll();
  }
}