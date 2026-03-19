// components/sidebar/library_card.dart
// A single draggable table template item in the sidebar library.
import 'package:flutter/material.dart';
import 'package:rms_design_system/rms_design_system.dart';
import 'package:rms_shared_package/rms_shared_package.dart';
import 'components/library_card_preview_new.dart';
import 'components/library_card_info.dart';
import 'components/library_card_drag_handle.dart';

class LibraryCard extends StatefulWidget {
  final String name;
  final TableShape shape;
  final int seats;
  final Color accentColor;

  const LibraryCard({
    super.key,
    required this.name,
    required this.shape,
    required this.seats,
    required this.accentColor,
  });

  @override
  State<LibraryCard> createState() => _LibraryCardState();
}

class _LibraryCardState extends State<LibraryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final template = TableModel(
      id: 'template',
      name: widget.name,
      x: 0,
      y: 0,
      width: widget.shape == TableShape.circle ? 72 : 88,
      height: widget.shape == TableShape.circle ? 72 : 72,
      hallId: 'default',
      seats: widget.seats,
      shape: widget.shape,
    );

    return Draggable<TableModel>(
      data: template,
      feedback: Material(
        color: Colors.transparent,
        child: Opacity(
          opacity: 0.85,
          child: Container(
            // Minimal container to prevent size issues while dragging
            child: widget.shape == TableShape.circle
                ? Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: widget.accentColor.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                      border: Border.all(color: widget.accentColor),
                    ),
                  )
                : Container(
                    width: 88,
                    height: 72,
                    decoration: BoxDecoration(
                      color: widget.accentColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: widget.accentColor),
                    ),
                  ),
          ),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.3,
        child: _CardLayout(
          template: template,
          seats: widget.seats,
          accentColor: widget.accentColor,
          isHovered: false,
        ),
      ),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: _CardLayout(
          template: template,
          seats: widget.seats,
          accentColor: widget.accentColor,
          isHovered: _isHovered,
        ),
      ),
    );
  }
}

class _CardLayout extends StatelessWidget {
  final TableModel template;
  final int seats;
  final Color accentColor;
  final bool isHovered;

  const _CardLayout({
    required this.template,
    required this.seats,
    required this.accentColor,
    required this.isHovered,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isHovered
            ? accentColor.withValues(alpha: 0.08)
            : NeutralColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isHovered
              ? accentColor.withValues(alpha: 0.5)
              : NeutralColors.border,
          width: isHovered ? 1.5 : 1,
        ),
        boxShadow: isHovered
            ? [
                BoxShadow(
                  color: accentColor.withValues(alpha: 0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            LibraryCardPreviewFix(template: template, accentColor: accentColor),
            const SizedBox(width: 12),
            LibraryCardInfo(
              template: template,
              seats: seats,
              accentColor: accentColor,
            ),
            LibraryCardDragHandle(
              isHovered: isHovered,
              accentColor: accentColor,
            ),
          ],
        ),
      ),
    );
  }
}
