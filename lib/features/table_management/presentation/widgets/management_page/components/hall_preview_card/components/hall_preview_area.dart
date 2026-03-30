import 'package:flutter/material.dart';
import 'package:rms_design_system/rms_design_system.dart';
import 'package:rms_shared_package/rms_shared_package.dart';
import '../../../../../painters/dot_grid_painter.dart';
import '../../../../table_widget.dart';
import 'empty_preview.dart';
import 'hall_preview_badge.dart';

class HallPreviewArea extends StatelessWidget {
  final List<TableModel> tables;
  final Rect bbox;
  final bool isHovered;

  const HallPreviewArea({
    super.key,
    required this.tables,
    required this.bbox,
    required this.isHovered,
  });

  @override
  Widget build(BuildContext context) {
    final hasNoTables = tables.isEmpty;

    return Stack(
      fit: StackFit.expand,
      children: [
        // Background
        Container(color: NeutralColors.background),

        // Table preview or empty state
        hasNoTables
            ? const EmptyPreview()
            : Padding(
                padding: const EdgeInsets.all(14),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: SizedBox(
                    width: bbox.width,
                    height: bbox.height,
                    child: Stack(
                      children: [
                        const Positioned.fill(
                          child: CustomPaint(
                            painter: DotGridPainter(
                              color: NeutralColors.border,
                            ),
                          ),
                        ),
                        ...tables.map(
                          (table) => Positioned(
                            left: table.x - bbox.left,
                            top: table.y - bbox.top,
                            child: TableWidget(
                              table: table,
                              isPreview: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

        // Table count badge (top-right)
        if (!hasNoTables)
          Positioned(
            top: 12,
            right: 12,
            child: HallPreviewBadge(tableCount: tables.length),
          ),

        // Hover overlay "Open Editor" hint
        AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: isHovered ? 1.0 : 0.0,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  NeutralColors.transparent,
                  PrimaryColors.defaultColor.withValues(
                    alpha: 0.15,
                  ),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
