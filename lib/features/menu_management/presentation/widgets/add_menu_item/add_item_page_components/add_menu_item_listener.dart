import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_menu_item/add_menu_item_bloc.dart';
import 'package:rms_design_system/app_colors/semantic_colors.dart';
import 'package:rms_shared_package/models/menu_models/food_model/food_model.dart';

/// A BlocListener widget that handles global UI feedback (e.g. SnackBars, navigation)
/// resulting from AddMenuItemBloc state changes.
class AddMenuItemListener extends StatelessWidget {
  final FoodModel? foodItemToEdit;
  final Widget child;

  const AddMenuItemListener({
    super.key,
    required this.child,
    this.foodItemToEdit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddMenuItemBloc, AddMenuItemState>(
      listenWhen: (previous, current) =>
          previous.isSuccess != current.isSuccess ||
          previous.errorMessage != current.errorMessage,
      listener: (context, state) {
        if (state.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                foodItemToEdit != null
                    ? 'Food item updated successfully!'
                    : 'Food item added successfully!',
              ),
              backgroundColor: SemanticColors.success,
            ),
          );
          Navigator.of(context).pop();
        } else if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: SemanticColors.error,
            ),
          );
        }
      },
      child: child,
    );
  }
}
