import 'package:todo/data/datasources/local/category_local_data_source.dart';
import 'package:todo/domain/entities/category_entity.dart';
import 'package:todo/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryLocalDataSource _categoryLocalDataSource;

  CategoryRepositoryImpl(this._categoryLocalDataSource);

  List<CategoryEntity> categories = [];

  @override
  Future<List<CategoryEntity>> getAllCategory() async {
    if (categories.isNotEmpty) return categories;
    final models = await _categoryLocalDataSource.getCategories();
    categories = models.map((m) => m.toEntity()).toList();
    return categories;
  }

  @override
  Future<CategoryEntity> getCategoryById(int id) async {
    if (categories.isEmpty) getAllCategory();
    final result = categories.firstWhere(
      (cat) => cat.id == id,
      orElse: () => categories.first,
    );
    return result;
  }
}
