import 'package:flutter/material.dart';
import 'package:rms_design_system/rms_design_system.dart';
import 'package:rms_shared_package/rms_shared_package.dart';
import 'package:manager_portal/features/table_management/presentation/widgets/table_widget.dart';

class LibraryCardPreviewFix extends StatelessWidget {
  final TableModel template;
  final Color accentColor;

  const LibraryCardPreviewFix({
    super.key,
    required this.template,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 52,
      decoration: BoxDecoration(
        color: NeutralColors.background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.2),
        ),
      ),
      child: Center(
        child: FittedBox(
          fit: BoxFit.contain,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: TableWidget(table: template, isPreview: false),
          ),
        ),
      ),
    );
  }
}
