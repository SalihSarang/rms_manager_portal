import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_menu_item/add_menu_item_bloc.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';

/// [SaveActionButton] is the primary action trigger for submitting the food item.
/// It dynamically switches between a "Save" icon and a loading spinner.
class SaveActionButton extends StatelessWidget {
  final bool isSubmitting;

  const SaveActionButton({
    super.key,
    required this.isSubmitting,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      // Triggers the food item submission via BLoC
      onPressed: isSubmitting
          ? null
          : () => context.read<AddMenuItemBloc>().add(
                const SubmitFoodItem(),
              ),
      style: ElevatedButton.styleFrom(
        backgroundColor: PrimaryColors.defaultColor,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      // Icon toggles based on Submission Status
      icon: isSubmitting
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  NeutralColors.white,
                ),
              ),
            )
          : const Icon(Icons.save, size: 16, color: NeutralColors.white),
      // Text toggles based on Submission Status
      label: Text(
        isSubmitting ? 'Saving...' : 'Save Food Item',
        style: const TextStyle(
          color: NeutralColors.white,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }
}
