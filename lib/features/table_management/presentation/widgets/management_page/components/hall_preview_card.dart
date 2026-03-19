import 'package:flutter/material.dart';
import 'package:rms_design_system/rms_design_system.dart';
import 'package:rms_shared_package/rms_shared_package.dart';
import 'hall_preview_card/components/hall_preview_area.dart';
import 'hall_preview_card/components/hall_preview_footer.dart';
import 'hall_preview_card/utils/hall_preview_utils.dart';

/// A card widget that displays a scaled-down preview of a [HallModel]'s layout.
class HallPreviewCard extends StatefulWidget {
  final HallModel hall;
  final List<TableModel> tables;
  final VoidCallback onTap;

  const HallPreviewCard({
    super.key,
    required this.hall,
    required this.tables,
    required this.onTap,
  });

  @override
  State<HallPreviewCard> createState() => _HallPreviewCardState();
}

class _HallPreviewCardState extends State<HallPreviewCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bbox = HallPreviewUtils.computeBoundingBox(widget.tables);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: NeutralColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _isHovered
                  ? PrimaryColors.defaultColor.withValues(alpha: 0.6)
                  : NeutralColors.border,
              width: _isHovered ? 1.5 : 1,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: PrimaryColors.defaultColor.withValues(alpha: 0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: NeutralColors.shadow.withValues(alpha: 0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              // ─── Preview Area ────────────────────────────────────
              Expanded(
                child: HallPreviewArea(
                  tables: widget.tables,
                  bbox: bbox,
                  isHovered: _isHovered,
                ),
              ),

              // Separator line
              Container(
                height: 1,
                color: _isHovered
                    ? PrimaryColors.defaultColor.withValues(alpha: 0.3)
                    : NeutralColors.border,
              ),

              // ─── Hall Info Footer ────────────────────────────────
              HallPreviewFooter(
                hall: widget.hall,
                tableCount: widget.tables.length,
                isHovered: _isHovered,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
