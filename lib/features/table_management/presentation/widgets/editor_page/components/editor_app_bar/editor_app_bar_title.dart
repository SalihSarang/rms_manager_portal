import 'package:flutter/material.dart';
import 'package:rms_design_system/rms_design_system.dart';

class EditorAppBarTitle extends StatelessWidget {
  final bool readOnly;
  final VoidCallback onBack;

  const EditorAppBarTitle({
    super.key,
    required this.readOnly,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: onBack,
          icon: const Icon(Icons.arrow_back_rounded, color: NeutralColors.icon),
          tooltip: 'Back to Management',
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: PrimaryColors.defaultColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.grid_view_rounded,
            color: TextColors.primary,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: RmsAppBarTitle(readOnly ? 'Hall View' : 'Table Layout Editor'),
        ),
      ],
    );
  }
}
