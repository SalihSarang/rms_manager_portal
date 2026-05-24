import 'package:flutter/material.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/add_menu_item/basic_info_section/components/category_dropdown.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/add_menu_item/basic_info_section/components/food_description_input.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/add_menu_item/basic_info_section/components/food_image_picker.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/add_menu_item/basic_info_section/components/food_name_input.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

/// [BasicInfoSection] is the core data entry area for a food item.
/// It collects essential details like name, category, description, and preview image.
class BasicInfoSection extends StatelessWidget {
  const BasicInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: NeutralColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: NeutralColors.border),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Basic Information',
            style: TextStyle(
              color: TextColors.primary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: FoodNameInput()),
              SizedBox(width: 20),
              Expanded(child: CategoryDropdown()),
            ],
          ),
          SizedBox(height: 24),
          FoodDescriptionInput(),
          SizedBox(height: 24),
          FoodImagePicker(),
        ],
      ),
    );
  }
}