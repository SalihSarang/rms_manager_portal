import 'package:equatable/equatable.dart';
import 'package:rms_shared_package/models/menu_models/category_model/category_model.dart';

abstract class AddCategoryEvent extends Equatable {
  const AddCategoryEvent();

  @override
  List<Object?> get props => [];
}

class LoadCategories extends AddCategoryEvent {}

class SelectCategory extends AddCategoryEvent {
  final String categoryId;

  const SelectCategory(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

class AddCategory extends AddCategoryEvent {
  final String name;
  final bool isActive;

  const AddCategory({required this.name, required this.isActive});

  @override
  List<Object?> get props => [name, isActive];
}

class EditCategory extends AddCategoryEvent {
  final CategoryModel category;

  const EditCategory({required this.category});

  @override
  List<Object?> get props => [category];
}
