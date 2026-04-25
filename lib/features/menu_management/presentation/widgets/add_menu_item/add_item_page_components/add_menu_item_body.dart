import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_menu_item/add_menu_item_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/add_menu_item/add_item_bottom_action_bar/add_item_bottom_action_bar.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/add_menu_item/addons_pricing_section/addons_pricing_section.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/add_menu_item/basic_info_section/basic_info_section.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/add_menu_item/dietary_preferences_section/dietary_preferences_section.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/add_menu_item/portions_pricing_section/portions_pricing_section.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/models/menu_models/food_model/food_model.dart';

/// Renders the main form elements block (Basic Info, Portions, Add-ons, etc.) for AddMenuItemPage.
class AddMenuItemBody extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final FoodModel? foodItemToEdit;

  const AddMenuItemBody({
    super.key,
    required this.formKey,
    this.foodItemToEdit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddMenuItemBloc, AddMenuItemState>(
      builder: (context, state) {
        if (foodItemToEdit != null &&
            state.editingFoodId != foodItemToEdit!.id) {
          return const Center(
            child: CircularProgressIndicator(color: TextColors.primary),
          );
        }

        return Column(
          children: [
            Expanded(
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(32),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 900),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            foodItemToEdit != null
                                ? "Edit Food Item"
                                : "Add New Food Item",
                            style: const TextStyle(
                              color: TextColors.primary,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Configure basic details, portions, and customization settings for your menu.",
                            style: TextStyle(
                              color: TextColors.secondary.withValues(
                                alpha: 0.7,
                              ),
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 32),
                          const BasicInfoSection(),
                          const SizedBox(height: 16),
                          const PortionsAndPricingSection(),
                          const SizedBox(height: 16),
                          const AddOnsAndPricingSection(),
                          const SizedBox(height: 16),
                          const DietaryPreferencesSection(),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            AddItemBottomActionBar(formKey: formKey),
          ],
        );
      },
    );
  }
}
