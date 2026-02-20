import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class CategorySidebarHeader extends StatelessWidget {
  const CategorySidebarHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: Text(
        'Categories',
        style: TextStyle(
          color: TextColors.inverse,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
