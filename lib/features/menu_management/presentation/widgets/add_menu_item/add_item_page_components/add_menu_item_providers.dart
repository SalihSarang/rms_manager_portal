import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/core/di/injector.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_category/add_category_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_category/add_category_event.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_menu_item/add_menu_item_bloc.dart';
import 'package:rms_shared_package/models/menu_models/food_model/food_model.dart';

/// Provides the necessary BLoCs for the Add/Edit Menu Item screen.
List<BlocProvider> buildAddMenuItemProviders(FoodModel? foodItemToEdit) {
  return [
    BlocProvider<AddMenuItemBloc>(
      create: (context) {
        final bloc = getIt<AddMenuItemBloc>();
        if (foodItemToEdit != null) {
          bloc.add(InitializeForEdit(foodItemToEdit));
        }
        return bloc;
      },
    ),
    BlocProvider<AddCategoryBloc>(
      create: (context) => getIt<AddCategoryBloc>()..add(LoadCategories()),
    ),
  ];
}
