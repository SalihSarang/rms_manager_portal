import 'package:flutter/material.dart';
import 'package:rms_design_system/rms_design_system.dart';
import 'package:rms_shared_package/rms_shared_package.dart';
import '../../../painters/dot_grid_painter.dart';
import '../../table_widget.dart';

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

  /// Computes the tight bounding box around all tables with padding.
  Rect _computeBoundingBox() {
    if (widget.tables.isEmpty) return const Rect.fromLTWH(0, 0, 400, 300);

    double minX = double.infinity, minY = double.infinity;
    double maxX = double.negativeInfinity, maxY = double.negativeInfinity;

    for (final t in widget.tables) {
      if (t.x < minX) minX = t.x;
      if (t.y < minY) minY = t.y;
      if (t.x + t.width > maxX) maxX = t.x + t.width;
      if (t.y + t.height > maxY) maxY = t.y + t.height;
    }

    const padding = 60.0;
    return Rect.fromLTWH(
      minX - padding,
      minY - padding,
      (maxX - minX) + padding * 2,
      (maxY - minY) + padding * 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bbox = _computeBoundingBox();
    final hasNoTables = widget.tables.isEmpty;

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
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          clipBehavior: Clip.antiAlias,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(
              children: [
                // ─── Preview Area ────────────────────────────────────
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Background
                      Container(color: NeutralColors.background),

                      // Table preview or empty state
                      hasNoTables
                          ? _EmptyPreview()
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
                                              color: NeutralColors.border),
                                        ),
                                      ),
                                      ...widget.tables.map((table) => Positioned(
                                            left: table.x - bbox.left,
                                            top: table.y - bbox.top,
                                            child: TableWidget(
                                              table: table,
                                              isPreview: true,
                                            ),
                                          )),
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
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 9, vertical: 4),
                            decoration: BoxDecoration(
                              color: NeutralColors.surface.withValues(alpha: 0.9),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: NeutralColors.border),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.table_restaurant_rounded,
                                    size: 11, color: PrimaryColors.defaultColor),
                                const SizedBox(width: 4),
                                Text(
                                  '${widget.tables.length}',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: NeutralColors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      // Hover overlay "Open Editor" hint
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: _isHovered ? 1.0 : 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                PrimaryColors.defaultColor.withValues(alpha: 0.15),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Separator line
                Container(
                  height: 1,
                  color: _isHovered
                      ? PrimaryColors.defaultColor.withValues(alpha: 0.3)
                      : NeutralColors.border,
                ),

                // ─── Hall Info ───────────────────────────────────────
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: const BoxDecoration(
                    color: NeutralColors.surface,
                  ),
                  child: Row(
                    children: [
                      // Hall icon
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: PrimaryColors.defaultColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.grid_view_rounded,
                          size: 16,
                          color: PrimaryColors.defaultColor,
                        ),
                      ),
                      const SizedBox(width: 10),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.hall.name,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: NeutralColors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              hasNoTables
                                  ? 'Tap to add tables'
                                  : '${widget.tables.length} ${widget.tables.length == 1 ? "table" : "tables"}',
                              style: TextStyle(
                                fontSize: 12,
                                color: hasNoTables
                                    ? PrimaryColors.defaultColor
                                    : NeutralColors.icon,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Arrow
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: _isHovered
                              ? PrimaryColors.defaultColor
                              : PrimaryColors.defaultColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          color: _isHovered
                              ? Colors.white
                              : PrimaryColors.defaultColor,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: PrimaryColors.defaultColor.withValues(alpha: 0.06),
            shape: BoxShape.circle,
            border: Border.all(
              color: PrimaryColors.defaultColor.withValues(alpha: 0.18),
              width: 1.5,
            ),
          ),
          child: const Icon(
            Icons.table_restaurant_rounded,
            color: PrimaryColors.defaultColor,
            size: 30,
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'No tables yet',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: NeutralColors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Tap to open the editor',
          style: TextStyle(
            fontSize: 11,
            color: NeutralColors.white.withValues(alpha: 0.35),
          ),
        ),
      ],
    );
  }
}
