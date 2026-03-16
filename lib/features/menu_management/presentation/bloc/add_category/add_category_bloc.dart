import 'package:flutter_bloc/flutter_bloc.dart';
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

class AddCategoryBloc extends Bloc<AddCategoryEvent, AddCategoryState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final AddCategoryUseCase addCategoryUseCase;
  final UpdateCategoryUseCase updateCategoryUseCase;
  final GetFoodItemsByCategoryUseCase getFoodItemsByCategoryUseCase;
  final GetAllFoodItemsUseCase getAllFoodItemsUseCase;
  final UpdateFoodItemUsecase updateFoodItemUsecase;

  AddCategoryBloc(
    this.getCategoriesUseCase,
    this.addCategoryUseCase,
    this.updateCategoryUseCase,
    this.getFoodItemsByCategoryUseCase,
    this.getAllFoodItemsUseCase,
    this.updateFoodItemUsecase,
  ) : super(MenuInitial()) {
    on<LoadCategories>((event, emit) async {
      emit(MenuLoading());
      try {
        await _loadCategoriesAndItems(emit);
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

          // Refresh categories and items to ensure sync and update counts
          await _loadCategoriesAndItems(emit, selectedId: currentState.selectedCategoryId);
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

          // Refresh categories and items
          await _loadCategoriesAndItems(emit, selectedId: currentState.selectedCategoryId);
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
          emit(currentState.copyWith(submissionError: e.toString()));
        }
      }
    });
  }

  Future<void> _loadCategoriesAndItems(Emitter<AddCategoryState> emit, {String? selectedId}) async {
    final categories = await getCategoriesUseCase();
    final allFoodItems = await getAllFoodItemsUseCase.execute();

    // Update itemCount for each category
    final updatedCategories = categories.map((cat) {
      final count = allFoodItems.where((food) => food.category.id == cat.id).length;
      return cat.copyWith(itemCount: count);
    }).toList();

    final String finalSelectedId = selectedId ??
        (updatedCategories.isNotEmpty ? updatedCategories.first.id : '');

    List<FoodModel> foodItems = [];
    if (finalSelectedId.isNotEmpty) {
      foodItems = allFoodItems.where((food) => food.category.id == finalSelectedId).toList();
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
