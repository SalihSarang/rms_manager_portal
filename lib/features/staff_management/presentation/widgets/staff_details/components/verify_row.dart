import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/semantic_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class StaffDetailsVerifyRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isEmpty;
  final Color? valueColor;

  const StaffDetailsVerifyRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.isEmpty,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Icon(icon, size: 16, color: TextColors.secondary),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: TextColors.secondary,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  isEmpty ? '— not set —' : value,
                  style: TextStyle(
                    color: isEmpty
                        ? SemanticColors.error
                        : (valueColor ?? TextColors.inverse),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            isEmpty ? Icons.cancel_outlined : Icons.check_circle_outline,
            size: 18,
            color: isEmpty ? SemanticColors.error : SemanticColors.success,
          ),
        ],
      ),
    );
  }
}
