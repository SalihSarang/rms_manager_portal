import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';

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
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextField(
        onChanged: onChanged,
        style: TextStyle(color: textColor),
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: backgroundColor ?? NeutralColors.white,
          prefixIcon: Icon(Icons.search, color: iconColor),
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
