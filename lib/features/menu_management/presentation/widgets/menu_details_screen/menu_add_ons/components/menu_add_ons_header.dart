import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class MenuAddOnsHeader extends StatelessWidget {
  const MenuAddOnsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Expanded(flex: 3, child: _HeaderText(text: 'Add-on Name')),
          Expanded(flex: 1, child: _HeaderText(text: 'Count')),
          Expanded(flex: 1, child: _HeaderText(text: 'Unit')),
          Expanded(flex: 1, child: _HeaderText(text: 'Price')),
        ],
      ),
    );
  }
}

class _HeaderText extends StatelessWidget {
  final String text;
  const _HeaderText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: TextColors.secondary,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );
  }
}
