import 'package:flutter/material.dart';
import 'package:rms_design_system/rms_design_system.dart';

/// A card widget used in the hall grid to trigger the creation of a new hall/section.
///
/// Features a dashed-style border (conceptually) and an animated plus icon that
/// reacts to hover states with a glowing effect and primary color transitions.
class AddNewHallCard extends StatefulWidget {
  /// Callback triggered when the card is tapped.
  final VoidCallback onTap;

  /// Creates an [AddNewHallCard].
  const AddNewHallCard({super.key, required this.onTap});

  @override
  State<AddNewHallCard> createState() => _AddNewHallCardState();
}

class _AddNewHallCardState extends State<AddNewHallCard> {
  /// Internal state to track if the mouse is hovering over the card.
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            // Background color slightly tints when hovered
            color: _isHovered
                ? PrimaryColors.defaultColor.withValues(alpha: 0.05)
                : NeutralColors.surface.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(20),
            // Border becomes more pronounced on hover
            border: Border.all(
              color: _isHovered
                  ? PrimaryColors.defaultColor.withValues(alpha: 0.5)
                  : NeutralColors.border,
              width: 1.5,
            ),
            // Glow effect on hover
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: PrimaryColors.defaultColor.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Animated Plus Icon
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: _isHovered
                        ? [
                            PrimaryColors.defaultColor,
                            PrimaryColors.defaultColor.withValues(alpha: 0.7),
                          ]
                        : [
                            PrimaryColors.defaultColor.withValues(alpha: 0.15),
                            PrimaryColors.defaultColor.withValues(alpha: 0.08),
                          ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: _isHovered
                      ? [
                          BoxShadow(
                            color: PrimaryColors.defaultColor.withValues(
                              alpha: 0.4,
                            ),
                            blurRadius: 20,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : [],
                ),
                child: Icon(
                  Icons.add_rounded,
                  color: _isHovered
                      ? NeutralColors.white
                      : PrimaryColors.defaultColor,
                  size: 30,
                ),
              ),
              const SizedBox(height: 18),

              /// Label
              const Text(
                'Add New Section',
                style: TextStyle(
                  color: NeutralColors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 6),

              /// Sublabel
              Text(
                'Create a new floor plan',
                style: TextStyle(
                  color: NeutralColors.white.withValues(alpha: 0.35),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
