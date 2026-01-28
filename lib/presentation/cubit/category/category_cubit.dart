import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/domain/entities/category_entity.dart';
import 'package:todo/domain/repositories/category_repository.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepository _categoryRepo;

  CategoryCubit(this._categoryRepo) : super(const CategoryState());

  void getAllCategory() async {
    if (state.categories.isNotEmpty) return;
    final result = await _categoryRepo.getAllCategory();
    emit(state.copyWith(categories: result));
  }

  Future<CategoryEntity> getCategoryById(int id) async {
    if (state.categories.isNotEmpty) return state.categories.where((cat) => cat.id == id).first;
    await _categoryRepo.getAllCategory();
    return state.categories.where((cat) => cat.id == id).first;
  }
}
