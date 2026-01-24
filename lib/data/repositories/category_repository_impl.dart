import 'package:isar/isar.dart';
import 'package:todo/core/constants/initial_data.dart';
import 'package:todo/data/models/category_model.dart';
import 'package:todo/domain/entities/category_entity.dart';
import 'package:todo/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final Isar _isar;

  CategoryRepositoryImpl(this._isar);

  @override
  Future<List<CategoryEntity>> getAllCategory() async {
    final models = await _isar.categoryModels.where().findAll();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> initialCategoryData() async {
    final count = await _isar.categoryModels.count();
    if (count == 0) {
      final initialCategories = InitialData.categories.map((item) => CategoryModel.fromEntity(item)).toList();
      await _isar.writeTxn(() async {
        await _isar.categoryModels.putAll(initialCategories);
      });
    }
  }
}
