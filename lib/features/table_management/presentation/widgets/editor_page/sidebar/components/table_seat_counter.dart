import 'package:flutter/material.dart';
import 'package:rms_design_system/rms_design_system.dart';
import 'package:rms_shared_package/rms_shared_package.dart';
import 'package:manager_portal/features/table_management/presentation/bloc/table_editor_bloc.dart';
import 'package:manager_portal/features/table_management/presentation/bloc/table_editor_event.dart';

class TableSeatCounter extends StatelessWidget {
  final TableModel table;
  final TableEditorBloc bloc;

  const TableSeatCounter({
    super.key,
    required this.table,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: NeutralColors.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: NeutralColors.border),
        ),
        child: Row(
          children: [
            const Icon(Icons.chair_rounded, size: 16, color: NeutralColors.icon),
            const SizedBox(width: 10),
            const Text(
              'Seats',
              style: TextStyle(
                  fontSize: 13,
                  color: NeutralColors.icon,
                  fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            _SeatButton(
              icon: Icons.remove_rounded,
              onPressed: table.seats > 1
                  ? () => bloc.add(TableEditorTableSeatsUpdated(table.seats - 1))
                  : null,
            ),
            const SizedBox(width: 12),
            Text(
              '${table.seats}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: NeutralColors.white,
              ),
            ),
            const SizedBox(width: 12),
            _SeatButton(
              icon: Icons.add_rounded,
              onPressed: () => bloc.add(TableEditorTableSeatsUpdated(table.seats + 1)),
            ),
          ],
        ),
      ),
    );
  }
}

class _SeatButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const _SeatButton({required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: enabled
              ? PrimaryColors.defaultColor.withValues(alpha: 0.2)
              : NeutralColors.border.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 16,
          color: enabled ? PrimaryColors.defaultColor : NeutralColors.icon,
        ),
      ),
    );
  }
}
