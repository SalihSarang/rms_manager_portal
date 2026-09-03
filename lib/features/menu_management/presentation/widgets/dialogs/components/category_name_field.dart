import 'package:flutter/material.dart';
import 'package:manager_portal/core/widgets/inputs/primary_text_field.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class CategoryNameField extends StatelessWidget {
  final TextEditingController controller;

  const CategoryNameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Category Name',
          style: TextStyle(color: TextColors.secondary, fontSize: 14),
        ),
        const SizedBox(height: 8),
        PrimaryTextField(
          controller: controller,
          hintText: 'Category Name',
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter a category name';
            }
            return null;
          },
        ),
      ],
    );
  }
}
