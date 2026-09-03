import 'package:equatable/equatable.dart';
import 'package:rms_shared_package/models/menu_models/category_model/category_model.dart';
import 'package:rms_shared_package/models/menu_models/food_model/food_model.dart';

abstract class AddCategoryState extends Equatable {
  const AddCategoryState();

  @override
  List<Object?> get props => [];
}

class MenuInitial extends AddCategoryState {}

class MenuLoading extends AddCategoryState {}

class CategoriesLoaded extends AddCategoryState {
  final List<CategoryModel> categories;
  final String selectedCategoryId;
  final List<FoodModel> foodItems;
  final bool isSubmitting;
  final bool isLoading;
  final bool isFoodLoading;
  final String? submissionError;

  const CategoriesLoaded({
    required this.categories,
    required this.selectedCategoryId,
    required this.foodItems,
    this.isSubmitting = false,
    this.isLoading = false,
    this.isFoodLoading = false,
    this.submissionError,
  });

  @override
  List<Object?> get props => [
    categories,
    selectedCategoryId,
    foodItems,
    isSubmitting,
    isLoading,
    isFoodLoading,
    submissionError,
  ];

  CategoriesLoaded copyWith({
    List<CategoryModel>? categories,
    String? selectedCategoryId,
    List<FoodModel>? foodItems,
    bool? isSubmitting,
    bool? isLoading,
    bool? isFoodLoading,
    String? submissionError,
  }) {
    return CategoriesLoaded(
      categories: categories ?? this.categories,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      foodItems: foodItems ?? this.foodItems,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isLoading: isLoading ?? this.isLoading,
      isFoodLoading: isFoodLoading ?? this.isFoodLoading,
      submissionError: submissionError, // Can be null to clear error
    );
  }
}

class MenuError extends AddCategoryState {
  final String message;

  const MenuError(this.message);

  @override
  List<Object?> get props => [message];
}
