import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/menu_management/domain/usecases/add_category_usecase.dart';
import 'package:manager_portal/features/menu_management/domain/usecases/get_categories_usecase.dart';
import 'package:manager_portal/features/menu_management/domain/usecases/get_food_items_by_category_usecase.dart';
import 'package:manager_portal/features/menu_management/domain/usecases/update_category_usecase.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_category/add_category_event.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_category/add_category_state.dart';
import 'package:rms_shared_package/models/menu_models/category_model/category_model.dart';
import 'package:rms_shared_package/models/menu_models/food_model/food_model.dart';

class AddCategoryBloc extends Bloc<AddCategoryEvent, AddCategoryState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final AddCategoryUseCase addCategoryUseCase;
  final UpdateCategoryUseCase updateCategoryUseCase;
  final GetFoodItemsByCategoryUseCase getFoodItemsByCategoryUseCase;

  AddCategoryBloc(
    this.getCategoriesUseCase,
    this.addCategoryUseCase,
    this.updateCategoryUseCase,
    this.getFoodItemsByCategoryUseCase,
  ) : super(MenuInitial()) {
    on<LoadCategories>((event, emit) async {
      emit(MenuLoading());
      try {
        final categories = await getCategoriesUseCase();
        final String selectedId = categories.isNotEmpty
            ? categories.first.id
            : '';

        List<FoodModel> foodItems = [];
        if (selectedId.isNotEmpty) {
          foodItems = await getFoodItemsByCategoryUseCase(selectedId);
        }

        emit(
          CategoriesLoaded(
            categories: categories,
            selectedCategoryId: selectedId,
            foodItems: foodItems,
          ),
        );
      } catch (e) {
        emit(MenuError(e.toString()));
      }
    });

    on<SelectCategory>((event, emit) {
      if (state is CategoriesLoaded) {
        final currentState = state as CategoriesLoaded;
        emit(currentState.copyWith(selectedCategoryId: event.categoryId));
        add(LoadFoodItems(event.categoryId));
      }
    });

    on<LoadFoodItems>((event, emit) async {
      if (state is CategoriesLoaded) {
        final currentState = state as CategoriesLoaded;
        try {
          final foodItems = await getFoodItemsByCategoryUseCase(
            event.categoryId,
          );
          emit(currentState.copyWith(foodItems: foodItems));
        } catch (e) {
          // You might want to handle this error separately or just emit the error
          emit(MenuError(e.toString()));
        }
      }
    });

    on<AddCategory>((event, emit) async {
      if (state is CategoriesLoaded) {
        final currentState = state as CategoriesLoaded;
        emit(currentState.copyWith(isSubmitting: true, submissionError: null));

        try {
          // Generate a simple unique ID and determine sort order
          final String newId = DateTime.now().millisecondsSinceEpoch.toString();
          final int newSortOrder = currentState.categories.length + 1;

          final newCategory = CategoryModel(
            id: newId,
            name: event.name,
            sortOrder: newSortOrder,
            isActive: event.isActive,
          );

          await addCategoryUseCase(newCategory);

          // Refresh categories instead of just appending to ensure sync with remote
          final updatedCategories = await getCategoriesUseCase();

          emit(
            currentState.copyWith(
              categories: updatedCategories,
              isSubmitting: false,
            ),
          );
        } catch (e) {
          emit(
            currentState.copyWith(
              isSubmitting: false,
              submissionError: e.toString(),
            ),
          );
        }
      }
    });

    on<EditCategory>((event, emit) async {
      if (state is CategoriesLoaded) {
        final currentState = state as CategoriesLoaded;
        emit(currentState.copyWith(isSubmitting: true, submissionError: null));

        try {
          await updateCategoryUseCase(event.category);

          final updatedCategories = await getCategoriesUseCase();

          emit(
            currentState.copyWith(
              categories: updatedCategories,
              isSubmitting: false,
            ),
          );
        } catch (e) {
          emit(
            currentState.copyWith(
              isSubmitting: false,
              submissionError: e.toString(),
            ),
          );
        }
      }
    });
  }
}
