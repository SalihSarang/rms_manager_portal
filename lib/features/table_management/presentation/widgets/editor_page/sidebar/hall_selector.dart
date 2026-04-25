// components/sidebar/hall_selector.dart
// Dropdown widget to pick the active hall.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_design_system/rms_design_system.dart';
import 'package:rms_shared_package/rms_shared_package.dart';
import 'package:manager_portal/features/table_management/presentation/bloc/table_editor_bloc/table_editor_bloc.dart';
import 'package:manager_portal/features/table_management/presentation/bloc/table_editor_bloc/table_editor_event.dart';
import 'package:manager_portal/features/table_management/presentation/bloc/table_editor_bloc/table_editor_state.dart';

class HallSelector extends StatelessWidget {
  const HallSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TableEditorBloc>();
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'VENUE SECTION',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: NeutralColors.icon,
              letterSpacing: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          BlocBuilder<TableEditorBloc, TableEditorState>(
            buildWhen: (p, c) =>
                p.halls != c.halls || p.selectedHall != c.selectedHall,
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
                decoration: BoxDecoration(
                  color: NeutralColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: NeutralColors.border),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<HallModel>(
                    value: state.selectedHall,
                    isExpanded: true,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: PrimaryColors.defaultColor,
                      size: 20,
                    ),
                    dropdownColor: NeutralColors.surface,
                    style: const TextStyle(
                      color: TextColors.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    items: state.halls.map((hall) {
                      return DropdownMenuItem<HallModel>(
                        value: hall,
                        child: Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: PrimaryColors.defaultColor,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(hall.name),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (hall) {
                      if (hall != null) bloc.add(TableEditorHallSelected(hall));
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
