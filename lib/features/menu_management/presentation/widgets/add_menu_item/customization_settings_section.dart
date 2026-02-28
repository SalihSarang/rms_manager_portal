import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_menu_item/add_menu_item_bloc.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class CustomizationAndSettingsSection extends StatelessWidget {
  const CustomizationAndSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: NeutralColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: NeutralColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Customization & Settings',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dietary Tags',
                      style: TextStyle(
                        color: TextColors.secondary.withValues(alpha: 0.7),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 12),
                    BlocBuilder<AddMenuItemBloc, AddMenuItemState>(
                      buildWhen: (p, c) => p.isVeg != c.isVeg,
                      builder: (context, state) {
                        return Row(
                          children: [
                            _buildDietaryTag(
                              label: 'Vegetarian',
                              isSelected: state.isVeg,
                              onTap: () {
                                context.read<AddMenuItemBloc>().add(
                                  IsVegChanged(true),
                                );
                              },
                            ),
                            const SizedBox(width: 12),
                            _buildDietaryTag(
                              label: 'Non-Vegetarian',
                              isSelected: !state.isVeg,
                              onTap: () {
                                context.read<AddMenuItemBloc>().add(
                                  IsVegChanged(false),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Visibility & Status',
                      style: TextStyle(
                        color: TextColors.secondary.withValues(alpha: 0.7),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 12),
                    BlocBuilder<AddMenuItemBloc, AddMenuItemState>(
                      buildWhen: (p, c) => p.isFeatured != c.isFeatured,
                      builder: (context, state) {
                        return _buildToggleRow(
                          label: 'Featured Item (Shows at top)',
                          value: state.isFeatured,
                          onChanged: (val) {
                            context.read<AddMenuItemBloc>().add(
                              IsFeaturedChanged(val),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<AddMenuItemBloc, AddMenuItemState>(
                      buildWhen: (p, c) => p.isCustomNotes != c.isCustomNotes,
                      builder: (context, state) {
                        return _buildToggleRow(
                          label: 'Allow Custom Notes',
                          value: state.isCustomNotes,
                          onChanged: (val) {
                            context.read<AddMenuItemBloc>().add(
                              IsCustomNotesChanged(val),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDietaryTag({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? null : NeutralColors.background,
          border: Border.all(
            color: isSelected
                ? PrimaryColors.defaultColor
                : NeutralColors.border,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected) ...[
              const Icon(
                Icons.circle,
                color: PrimaryColors.defaultColor,
                size: 8,
              ),
              const SizedBox(width: 8),
            ] else ...[
              const Icon(
                Icons.circle_outlined,
                color: TextColors.secondary,
                size: 8,
              ),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : TextColors.secondary,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleRow({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 13)),
        CupertinoSwitch(
          value: value,
          onChanged: onChanged,
          activeTrackColor: PrimaryColors.defaultColor,
          inactiveTrackColor: NeutralColors.background,
        ),
      ],
    );
  }
}
