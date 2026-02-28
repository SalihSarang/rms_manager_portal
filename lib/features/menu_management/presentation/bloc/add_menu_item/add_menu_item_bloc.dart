import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/core/utils/image_picker_service/feature_specific_usecase/food_img_picker.dart';
import 'package:rms_shared_package/models/menu_models/portions_and_price/portions_and_price.dart';
import 'package:rms_shared_package/models/menu_models/add_ons_model/add_ons_model.dart';
import 'package:rms_shared_package/models/menu_models/food_model/food_model.dart';

import 'add_menu_item_state.dart';
import 'add_menu_item_event.dart';

export 'add_menu_item_state.dart';
export 'add_menu_item_event.dart';

class AddMenuItemBloc extends Bloc<AddMenuItemEvent, AddMenuItemState> {
  final FoodImgPickerUsecase foodImgPickerUsecase;

  AddMenuItemBloc({required this.foodImgPickerUsecase})
    : super(const AddMenuItemState()) {
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
      emit(state.copyWith(errorMessage: 'Name is required'));
      return;
    }
    if (state.category == null) {
      emit(state.copyWith(errorMessage: 'Category is required'));
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
      // ignore: unused_local_variable
      final foodItem = FoodModel(
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

      // TODO: Call usecase to save the food item to backend
      await Future.delayed(const Duration(seconds: 1)); // simulated delay

      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(isSubmitting: false, errorMessage: e.toString()));
    }
  }
}
