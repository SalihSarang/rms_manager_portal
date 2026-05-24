import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/core/utils/error_handler.dart';
import 'package:manager_portal/features/menu_management/domain/usecases/add_category_usecase.dart';
import 'package:manager_portal/features/menu_management/domain/usecases/get_all_food_items_usecase.dart';
import 'package:manager_portal/features/menu_management/domain/usecases/get_categories_usecase.dart';
import 'package:manager_portal/features/menu_management/domain/usecases/get_food_items_by_category_usecase.dart';
import 'package:manager_portal/features/menu_management/domain/usecases/update_category_usecase.dart';
import 'package:manager_portal/features/menu_management/domain/usecases/update_food_item_usecase.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_category/add_category_event.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_category/add_category_state.dart';
import 'package:rms_shared_package/models/menu_models/category_model/category_model.dart';
import 'package:rms_shared_package/models/menu_models/food_model/food_model.dart';

/// Business logic component for managing menu categories and their associated food items.
///
/// This BLoC handles loading categories, selecting a category, adding/editing categories,
/// and toggling the availability status of food items.
/// Business logic component for managing menu categories and their associated food items.
///
/// This BLoC handles loading categories, selecting a category, adding/editing categories,
/// and toggling the availability status of food items.
class AddCategoryBloc extends Bloc<AddCategoryEvent, AddCategoryState> {
  /// Use case for fetching all categories.
  /// Use case for fetching all categories.
  final GetCategoriesUseCase getCategoriesUseCase;

  /// Use case for adding a new category.

  /// Use case for adding a new category.
  final AddCategoryUseCase addCategoryUseCase;

  /// Use case for updating an existing category.

  /// Use case for updating an existing category.
  final UpdateCategoryUseCase updateCategoryUseCase;

  /// Use case for fetching food items filtered by category.
  final GetFoodItemsByCategoryUseCase getFoodItemsByCategoryUseCase;

  /// Use case for fetching all food items across categories.
  final GetAllFoodItemsUseCase getAllFoodItemsUseCase;

  /// Use case for updating food item details.
  final UpdateFoodItemUsecase updateFoodItemUsecase;

  /// Creates an [AddCategoryBloc] with the required use cases.
  AddCategoryBloc(
    this.getCategoriesUseCase,
    this.addCategoryUseCase,
    this.updateCategoryUseCase,
    this.getFoodItemsByCategoryUseCase,
    this.getAllFoodItemsUseCase,
    this.updateFoodItemUsecase,
  ) : super(MenuInitial()) {
    on<LoadCategories>((event, emit) async {
      if (state is CategoriesLoaded) {
        emit((state as CategoriesLoaded).copyWith(isLoading: true));
      } else {
        emit(MenuLoading());
      }
      if (state is CategoriesLoaded) {
        emit((state as CategoriesLoaded).copyWith(isLoading: true));
      } else {
        emit(MenuLoading());
      }
      try {
        await _loadCategoriesAndItems(
          emit,
          selectedId: event.selectedCategoryId,
        );
      } catch (e) {
        emit(MenuError(ErrorHandler.getFriendlyMessage(e)));
        emit(MenuError(ErrorHandler.getFriendlyMessage(e)));
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
        emit(
          currentState.copyWith(isFoodLoading: true),
        ); // Only flag food as loading
        try {
          final foodItems = await getFoodItemsByCategoryUseCase(
            event.categoryId,
          );
          emit(
            currentState.copyWith(
              foodItems: foodItems,
              selectedCategoryId: event.categoryId,
              isFoodLoading: false,
            ),
          );
        } catch (e) {
          emit(MenuError(ErrorHandler.getFriendlyMessage(e)));
        }
        add(LoadFoodItems(event.categoryId));
      }
    });

    on<LoadFoodItems>((event, emit) async {
      if (state is CategoriesLoaded) {
        final currentState = state as CategoriesLoaded;
        emit(
          currentState.copyWith(isFoodLoading: true),
        ); // Only flag food as loading
        try {
          final foodItems = await getFoodItemsByCategoryUseCase(
            event.categoryId,
          );
          emit(
            currentState.copyWith(
              foodItems: foodItems,
              selectedCategoryId: event.categoryId,
              isFoodLoading: false,
            ),
          );
        } catch (e) {
          emit(MenuError(ErrorHandler.getFriendlyMessage(e)));
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

          // Refresh categories and items to ensure sync and update counts
          await _loadCategoriesAndItems(
            emit,
            selectedId: currentState.selectedCategoryId,
          );
          // Refresh categories and items to ensure sync and update counts
          await _loadCategoriesAndItems(
            emit,
            selectedId: currentState.selectedCategoryId,
          );
        } catch (e) {
          emit(
            currentState.copyWith(
              isSubmitting: false,
              submissionError: ErrorHandler.getFriendlyMessage(e),
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

          // Refresh categories and items
          await _loadCategoriesAndItems(
            emit,
            selectedId: currentState.selectedCategoryId,
          );
          // Refresh categories and items
          await _loadCategoriesAndItems(
            emit,
            selectedId: currentState.selectedCategoryId,
          );
        } catch (e) {
          emit(
            currentState.copyWith(
              isSubmitting: false,
              submissionError: ErrorHandler.getFriendlyMessage(e),
            ),
          );
        }
      }
    });
    on<ToggleFoodItemStatus>((event, emit) async {
      if (state is CategoriesLoaded) {
        final currentState = state as CategoriesLoaded;

        try {
          final updatedFood = FoodModel(
            id: event.food.id,
            name: event.food.name,
            description: event.food.description,
            imageUrl: event.food.imageUrl,
            category: event.food.category,
            isAvailable: !event.food.isAvailable, // Toggle the availability
            isFeatured: event.food.isFeatured,
            portions: event.food.portions,
            addOns: event.food.addOns,
            isVeg: event.food.isVeg,
            isCustomNotes: event.food.isCustomNotes,
          );

          await updateFoodItemUsecase.execute(updatedFood);

          // Update the list of foods locally to avoid a full fetch
          final updatedFoodItems = currentState.foodItems.map((item) {
            return item.id == event.food.id ? updatedFood : item;
          }).toList();

          emit(currentState.copyWith(foodItems: updatedFoodItems));
        } catch (e) {
          emit(
            currentState.copyWith(
              submissionError: ErrorHandler.getFriendlyMessage(e),
            ),
          );
        }
      }
    });
  }

  Future<void> _loadCategoriesAndItems(
    Emitter<AddCategoryState> emit, {
    String? selectedId,
  }) async {
    final categories = await getCategoriesUseCase();
    final allFoodItems = await getAllFoodItemsUseCase.execute();

    // Update itemCount for each category
    final updatedCategories = categories.map((cat) {
      final count = allFoodItems
          .where((food) => food.category.id == cat.id)
          .length;
      return cat.copyWith(itemCount: count);
    }).toList();

    final String finalSelectedId =
        selectedId ??
        (updatedCategories.isNotEmpty ? updatedCategories.first.id : '');

    List<FoodModel> foodItems = [];
    if (finalSelectedId.isNotEmpty) {
      foodItems = allFoodItems
          .where((food) => food.category.id == finalSelectedId)
          .toList();
    }

    emit(
      CategoriesLoaded(
        categories: updatedCategories,
        selectedCategoryId: finalSelectedId,
        foodItems: foodItems,
        isSubmitting: false,
      ),
    );
  }
}
