import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_shared_package/models/menu_models/food_model/food_model.dart';
import 'menu_details_state.dart';

/// A cubit for managing the detail-view state of a food item.
///
/// It handles the simplistic state transition from initial to loaded
/// for a selected [FoodModel].
class MenuDetailsCubit extends Cubit<MenuDetailsState> {
  MenuDetailsCubit() : super(MenuDetailsInitial());

  void loadDetails(FoodModel item) {
    emit(MenuDetailsLoading());
    // Simulate loading if necessary, but since we already have the item from the list:
    emit(MenuDetailsLoaded(item));
  }
}
