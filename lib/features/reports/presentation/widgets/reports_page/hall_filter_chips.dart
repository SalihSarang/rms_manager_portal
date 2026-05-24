import 'package:flutter/material.dart';
import 'package:rms_shared_package/models/table_models/hall_model.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class HallFilterChips extends StatelessWidget {
  final List<HallModel> halls;
  final String? selectedHallId;
  final Function(String?) onHallSelected;

  const HallFilterChips({
    super.key,
    required this.halls,
    required this.selectedHallId,
    required this.onHallSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        FilterChip(
          label: const Text('All Halls'),
          selected: selectedHallId == null,
          onSelected: (selected) {
            if (selected) onHallSelected(null);
          },
          selectedColor: PrimaryColors.defaultColor.withValues(alpha: 0.2),
          checkmarkColor: PrimaryColors.defaultColor,
          labelStyle: TextStyle(
            color: selectedHallId == null
                ? PrimaryColors.defaultColor
                : TextColors.secondary,
            fontWeight: selectedHallId == null
                ? FontWeight.bold
                : FontWeight.normal,
          ),
          backgroundColor: NeutralColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: selectedHallId == null
                  ? PrimaryColors.defaultColor
                  : NeutralColors.border,
            ),
          ),
        ),
        ...halls.map((hall) {
          final isSelected = selectedHallId == hall.id;
          return FilterChip(
            label: Text(hall.name),
            selected: isSelected,
            onSelected: (selected) {
              onHallSelected(selected ? hall.id : null);
            },
            selectedColor: PrimaryColors.defaultColor.withValues(alpha: 0.2),
            checkmarkColor: PrimaryColors.defaultColor,
            labelStyle: TextStyle(
              color: isSelected
                  ? PrimaryColors.defaultColor
                  : TextColors.secondary,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
            backgroundColor: NeutralColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: isSelected
                    ? PrimaryColors.defaultColor
                    : NeutralColors.border,
              ),
            ),
          );
        }),
      ],
    );
  }
}
