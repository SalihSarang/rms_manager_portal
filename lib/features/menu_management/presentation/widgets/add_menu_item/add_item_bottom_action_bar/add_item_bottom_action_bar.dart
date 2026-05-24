import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_menu_item/add_menu_item_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/add_menu_item/add_item_bottom_action_bar/components/cancel_action_button.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/add_menu_item/add_item_bottom_action_bar/components/last_saved_indicator.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/add_menu_item/add_item_bottom_action_bar/components/save_action_button.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';

/// [AddItemBottomActionBar] is a sticky footer widget used in the Add/Edit Menu Item screens.
/// It provides the primary actions (Save, Cancel) and displays the current submission status.
///
/// This widget acts as a container for secondary action components.
class AddItemBottomActionBar extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const AddItemBottomActionBar({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    // Listens to the submission state from AddMenuItemBloc
    return BlocBuilder<AddMenuItemBloc, AddMenuItemState>(
      buildWhen: (previous, current) =>
          previous.isSubmitting != current.isSubmitting,
      builder: (context, state) {
        return Container(
          // --- Styling Content ---
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: const BoxDecoration(
            color: NeutralColors.surface,
            border: Border(top: BorderSide(color: NeutralColors.border)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // --- Status Indicator Component ---
              const LastSavedIndicator(),

              // --- Action Buttons Container ---
              Row(
                children: [
                  // --- Cancel Button Component ---
                  CancelActionButton(isSubmitting: state.isSubmitting),

                  const SizedBox(width: 12),

                  // --- Save Button Component ---
                  SaveActionButton(
                    isSubmitting: state.isSubmitting,
                    formKey: formKey,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
