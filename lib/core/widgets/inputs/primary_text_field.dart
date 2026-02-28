import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class PrimaryTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;

  const PrimaryTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: TextColors.inverse),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: TextColors.secondary.withValues(alpha: 0.5),
          fontSize: 14,
        ),
        filled: true,
        fillColor: NeutralColors.background,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: NeutralColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: NeutralColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: PrimaryColors.defaultColor),
        ),
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}
