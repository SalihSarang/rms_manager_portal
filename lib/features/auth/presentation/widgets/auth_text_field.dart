import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

/// A custom text field styled for authentication forms.
///
/// Uses standard [TextFormField] internally with predefined design system styles.
class AuthTextField extends StatelessWidget {
  /// The text to display above the input field.
  final String label;

  /// The placeholder text to display inside the field.
  final String hintText;

  /// Whether the text should be obscured (e.g., for passwords).
  final bool obscureText;

  /// Callback when the text value changes.
  final ValueChanged<String> onChanged;

  /// Optional icon to display at the end of the field.
  final Widget? suffixIcon;

  /// Optional widget to display next to the [label].
  final Widget? labelSuffix;

  /// Optional validator function for form validation.
  final String? Function(String?)? validator;

  /// Creates an [AuthTextField].
  const AuthTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.onChanged,
    this.obscureText = false,
    this.suffixIcon,
    this.labelSuffix,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: TextColors.secondary,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            ?labelSuffix,
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          onChanged: onChanged,
          obscureText: obscureText,
          validator: validator,
          style: const TextStyle(color: TextColors.primary),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: TextColors.secondary.withValues(alpha: 0.5),
            ),
            filled: true,
            fillColor: NeutralColors.background,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
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
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
