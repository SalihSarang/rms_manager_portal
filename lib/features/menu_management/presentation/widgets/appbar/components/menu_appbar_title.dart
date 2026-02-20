import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class MenuAppbarTitle extends StatelessWidget {
  final double titleSize;

  const MenuAppbarTitle({super.key, required this.titleSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Menu Management',
      style: TextStyle(
        fontSize: titleSize,
        fontWeight: FontWeight.w600,
        color: TextColors.inverse,
      ),
    );
  }
}
