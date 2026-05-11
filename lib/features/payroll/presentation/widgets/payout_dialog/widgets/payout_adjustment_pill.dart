import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class PayoutAdjustmentPill extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final ValueChanged<String> onChanged;

  const PayoutAdjustmentPill({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 12, color: color),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: TextColors.secondary.withValues(alpha: 0.6),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          TextField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: onChanged,
            style: const TextStyle(
              color: TextColors.primary,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
            decoration: InputDecoration(
              isDense: true,
              hintText: '₹0.00',
              hintStyle: TextStyle(
                color: TextColors.secondary.withValues(alpha: 0.2),
                fontSize: 18,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
            ),
          ),
        ],
      ),
    );
  }
}
