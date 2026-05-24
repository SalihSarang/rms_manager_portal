import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_shared_package/utils/error_handler.dart';
import 'package:manager_portal/core/utils/image_picker_service/feature_specific_usecase/food_img_picker.dart';
import 'package:manager_portal/features/menu_management/domain/usecases/add_food_item_usecase.dart';
import 'package:manager_portal/features/menu_management/domain/usecases/update_food_item_usecase.dart';
import 'package:rms_shared_package/models/menu_models/portions_and_price/portions_and_price.dart';
import 'package:rms_shared_package/models/menu_models/add_ons_model/add_ons_model.dart';
import 'package:rms_shared_package/models/menu_models/food_model/food_model.dart';

import 'add_menu_item_state.dart';
import 'add_menu_item_event.dart';

export 'add_menu_item_state.dart';
export 'add_menu_item_event.dart';

/// Business logic component for adding or editing individual food items.
///
/// Manages the state of the food item form, including image picking,
/// portions, add-ons, and basic details.
/// Business logic component for adding or editing individual food items.
///
/// Manages the state of the food item form, including image picking,
/// portions, add-ons, and basic details.
class AddMenuItemBloc extends Bloc<AddMenuItemEvent, AddMenuItemState> {
  /// Service for picking and uploading food images.
  /// Service for picking and uploading food images.
  final FoodImgPickerUsecase foodImgPickerUsecase;

  /// Use case for saving a new food item.
  final AddFoodItemUseCase addFoodItemUseCase;

  /// Use case for updating an existing food item.
  final UpdateFoodItemUseCase updateFoodItemUseCase;

  /// Creates an [AddMenuItemBloc] with the required dependencies.
  AddMenuItemBloc({
    required this.foodImgPickerUsecase,
    required this.addFoodItemUseCase,
    required this.updateFoodItemUseCase,
  }) : super(const AddMenuItemState()) {
    on<InitializeForEdit>(_onInitializeForEdit);
    on<NameChanged>(_onNameChanged);
    on<DescriptionChanged>(_onDescriptionChanged);
    on<CategoryChanged>(_onCategoryChanged);
    on<ImageUrlChanged>(_onImageUrlChanged);
    on<PickFoodImage>(_onPickFoodImage);
    on<PortionAdded>(_onPortionAdded);
    on<PortionRemoved>(_onPortionRemoved);
    on<PortionUpdated>(_onPortionUpdated);
    on<AddOnAdded>(_onAddOnAdded);
    on<AddOnRemoved>(_onAddOnRemoved);
    on<AddOnUpdated>(_onAddOnUpdated);
    on<IsVegChanged>(_onIsVegChanged);
    on<IsFeaturedChanged>(_onIsFeaturedChanged);
    on<IsCustomNotesChanged>(_onIsCustomNotesChanged);
    on<SubmitFoodItem>(_onSubmitFoodItem);
  }

  void _onInitializeForEdit(
    InitializeForEdit event,
    Emitter<AddMenuItemState> emit,
  ) {
    emit(
      state.copyWith(
        editingFoodId: event.foodItem.id,
        name: event.foodItem.name,
        description: event.foodItem.description,
        category: event.foodItem.category,
        imageUrl: event.foodItem.imageUrl,
        portions: event.foodItem.portions,
        addOns: event.foodItem.addOns,
        isVeg: event.foodItem.isVeg,
        isFeatured: event.foodItem.isFeatured,
        isCustomNotes: event.foodItem.isCustomNotes,
      ),
    );
  }

  void _onNameChanged(NameChanged event, Emitter<AddMenuItemState> emit) {
    emit(state.copyWith(name: event.name));
  }

  void _onDescriptionChanged(
    DescriptionChanged event,
    Emitter<AddMenuItemState> emit,
  ) {
    emit(state.copyWith(description: event.description));
  }

  void _onCategoryChanged(
    CategoryChanged event,
    Emitter<AddMenuItemState> emit,
  ) {
    emit(state.copyWith(category: event.category));
  }

  void _onImageUrlChanged(
    ImageUrlChanged event,
    Emitter<AddMenuItemState> emit,
  ) {
    emit(state.copyWith(imageUrl: event.imageUrl));
  }

  Future<void> _onPickFoodImage(
    PickFoodImage event,
    Emitter<AddMenuItemState> emit,
  ) async {
    final file = await foodImgPickerUsecase.pick();
    if (file != null) {
      emit(state.copyWith(pickedImage: file));
    }
  }

  void _onPortionAdded(PortionAdded event, Emitter<AddMenuItemState> emit) {
    emit(
      state.copyWith(portions: List.from(state.portions)..add(event.portion)),
    );
  }

  void _onPortionRemoved(PortionRemoved event, Emitter<AddMenuItemState> emit) {
    final portions = List<PortionAndPrice>.from(state.portions);
    if (event.index >= 0 && event.index < portions.length) {
      portions.removeAt(event.index);
      emit(state.copyWith(portions: portions));
    }
  }

  void _onPortionUpdated(PortionUpdated event, Emitter<AddMenuItemState> emit) {
    final portions = List<PortionAndPrice>.from(state.portions);
    if (event.index >= 0 && event.index < portions.length) {
      portions[event.index] = event.portion;
      emit(state.copyWith(portions: portions));
    }
  }

  void _onAddOnAdded(AddOnAdded event, Emitter<AddMenuItemState> emit) {
    emit(state.copyWith(addOns: List.from(state.addOns)..add(event.addOn)));
  }

  void _onAddOnRemoved(AddOnRemoved event, Emitter<AddMenuItemState> emit) {
    final addOns = List<AddOnsModel>.from(state.addOns);
    if (event.index >= 0 && event.index < addOns.length) {
      addOns.removeAt(event.index);
      emit(state.copyWith(addOns: addOns));
    }
  }

  void _onAddOnUpdated(AddOnUpdated event, Emitter<AddMenuItemState> emit) {
    final addOns = List<AddOnsModel>.from(state.addOns);
    if (event.index >= 0 && event.index < addOns.length) {
      addOns[event.index] = event.addOn;
      emit(state.copyWith(addOns: addOns));
    }
  }

  void _onIsVegChanged(IsVegChanged event, Emitter<AddMenuItemState> emit) {
    emit(state.copyWith(isVeg: event.isVeg));
  }

  void _onIsFeaturedChanged(
    IsFeaturedChanged event,
    Emitter<AddMenuItemState> emit,
  ) {
    emit(state.copyWith(isFeatured: event.isFeatured));
  }

  void _onIsCustomNotesChanged(
    IsCustomNotesChanged event,
    Emitter<AddMenuItemState> emit,
  ) {
    emit(state.copyWith(isCustomNotes: event.isCustomNotes));
  }

  Future<void> _onSubmitFoodItem(
    SubmitFoodItem event,
    Emitter<AddMenuItemState> emit,
  ) async {
    // Basic validation
    if (state.name.isEmpty) {
      emit(
        state.copyWith(errorMessage: 'Please enter a name for the food item.'),
      );
      emit(
        state.copyWith(errorMessage: 'Please enter a name for the food item.'),
      );
      return;
    }
    if (state.category == null) {
      emit(state.copyWith(errorMessage: 'Please select a category.'));
      emit(state.copyWith(errorMessage: 'Please select a category.'));
      return;
    }

    emit(state.copyWith(isSubmitting: true, errorMessage: null));

    try {
      String imageUrl = state.imageUrl;
      if (state.pickedImage != null) {
        final uploadedUrl = await foodImgPickerUsecase.upload(
          state.pickedImage!,
        );
        imageUrl = uploadedUrl;
      }

      // Create FoodModel object
      final foodItem = FoodModel(
        id: state.editingFoodId,
        name: state.name,
        description: state.description,
        imageUrl: imageUrl,
        category: state.category!,
        isAvailable: true,
        isFeatured: state.isFeatured,
        portions: state.portions,
        addOns: state.addOns,
        isVeg: state.isVeg,
        isCustomNotes: state.isCustomNotes,
      );

      if (state.editingFoodId != null) {
        // Call usecase to update existing food item
        await updateFoodItemUseCase(foodItem);
      } else {
        // Call usecase to save new food item to backend
        await addFoodItemUseCase(foodItem);
      }

      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    } catch (e) {
      emit(
        state.copyWith(
          isSubmitting: false,
          errorMessage: ErrorHandler.getFriendlyMessage(e),
        ),
      );
      emit(
        state.copyWith(
          isSubmitting: false,
          errorMessage: ErrorHandler.getFriendlyMessage(e),
        ),
      );
    }
  }
}
