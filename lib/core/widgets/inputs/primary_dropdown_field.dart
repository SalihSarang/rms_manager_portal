import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class PrimaryDropdownField<T> extends StatelessWidget {
  final T? initialValue;
  final List<DropdownMenuItem<T>> items;
  final String hintText;
  final ValueChanged<T?>? onChanged;
  final FormFieldValidator<T>? validator;

  const PrimaryDropdownField({
    super.key,
    required this.initialValue,
    required this.items,
    required this.hintText,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: initialValue,
      items: items,
      onChanged: onChanged,
      validator: validator,
      style: const TextStyle(color: TextColors.primary),
      dropdownColor: NeutralColors.surface,
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: TextColors.secondary,
      ),
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
    );
  }
}
