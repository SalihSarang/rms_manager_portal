import 'package:flutter/material.dart';
import 'package:rms_design_system/rms_design_system.dart';

class AddNewHallCard extends StatefulWidget {
  final VoidCallback onTap;
  const AddNewHallCard({super.key, required this.onTap});

  @override
  State<AddNewHallCard> createState() => _AddNewHallCardState();
}

class _AddNewHallCardState extends State<AddNewHallCard> {
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
            color: _isHovered
                ? PrimaryColors.defaultColor.withValues(alpha: 0.05)
                : NeutralColors.surface.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _isHovered
                  ? PrimaryColors.defaultColor.withValues(alpha: 0.5)
                  : NeutralColors.border,
              width: 1.5,
            ),
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
              const Text(
                'Add New Section',
                style: TextStyle(
                  color: NeutralColors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 6),
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
