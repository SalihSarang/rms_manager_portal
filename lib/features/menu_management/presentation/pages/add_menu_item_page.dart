import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/add_menu_item/add_item_page_components/add_menu_item_app_bar.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/add_menu_item/add_item_page_components/add_menu_item_body.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/add_menu_item/add_item_page_components/add_menu_item_listener.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/add_menu_item/add_item_page_components/add_menu_item_providers.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_shared_package/models/menu_models/food_model/food_model.dart';

/// A page for creating or editing a food item.
///
/// If [foodItemToEdit] is provided, the page initializes in edit mode;
/// otherwise, it opens as a blank "Add New Item" form.
/// A page for creating or editing a food item.
///
/// If [foodItemToEdit] is provided, the page initializes in edit mode;
/// otherwise, it opens as a blank "Add New Item" form.
class AddMenuItemPage extends StatelessWidget {
  /// The food item to be edited, or `null` if creating a new item.
  final FoodModel? foodItemToEdit;

  /// Creates an [AddMenuItemPage].
  AddMenuItemPage({super.key, this.foodItemToEdit});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: buildAddMenuItemProviders(foodItemToEdit),
      child: AddMenuItemListener(
        foodItemToEdit: foodItemToEdit,
        child: Scaffold(
          backgroundColor: NeutralColors.background,
          appBar: const AddMenuItemAppBar(),
          body: AddMenuItemBody(
            formKey: _formKey,
            foodItemToEdit: foodItemToEdit,
          ),
        ),
      ),
    );
  }
}
