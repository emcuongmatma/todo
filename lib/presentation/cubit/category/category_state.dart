part of 'category_cubit.dart';

class CategoryState extends Equatable {
  final List<CategoryEntity> categories;

  const CategoryState({this.categories = const []});

  CategoryState copyWith({List<CategoryEntity>? categories}) {
    return CategoryState(categories: categories ?? this.categories);
  }

  @override
  List<Object> get props => [categories];
}
