import 'package:isar/isar.dart';
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
}
