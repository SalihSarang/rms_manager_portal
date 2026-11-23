import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class PrimarySearchBar extends StatelessWidget {
  final String hintText;
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? textColor;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final VoidCallback? onClear;

  const PrimarySearchBar({
    super.key,
    this.hintText = 'Search...',
    this.width = 320,
    this.height = 44,
    this.padding = const EdgeInsets.symmetric(horizontal: 12),
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.backgroundColor,
    this.iconColor,
    this.textColor,
    this.onChanged,
    this.controller,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(color: textColor ?? TextColors.primary, fontSize: 13.5),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: TextColors.muted, fontSize: 13),
          filled: true,
          fillColor: backgroundColor ?? TextColors.primary,
          prefixIcon: Icon(Icons.search, color: iconColor ?? NeutralColors.icon, size: 20),
          suffixIcon: controller != null
              ? ValueListenableBuilder<TextEditingValue>(
                  valueListenable: controller!,
                  builder: (context, value, _) {
                    if (value.text.isEmpty) return const SizedBox.shrink();
                    return IconButton(
                      icon: const Icon(Icons.clear_rounded, color: NeutralColors.icon, size: 18),
                      tooltip: 'Clear search',
                      onPressed: onClear ?? () {
                        controller!.clear();
                        if (onChanged != null) onChanged!('');
                      },
                    );
                  },
                )
              : null,
          contentPadding: padding,
          border: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
