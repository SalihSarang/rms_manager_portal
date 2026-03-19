import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/table_management/presentation/bloc/table_editor_bloc.dart';
import 'package:manager_portal/features/table_management/presentation/bloc/table_editor_event.dart';
import 'package:manager_portal/features/table_management/presentation/bloc/table_editor_state.dart';
import 'components/hall_preview_card.dart';
import 'hall_grid/components/add_new_hall_card.dart';
import 'hall_grid/utils/hall_grid_utils.dart';

/// A responsive grid of hall preview cards.
class HallGrid extends StatelessWidget {
  /// The current state of the table editor.
  final TableEditorState state;

  /// Creates a [HallGrid].
  const HallGrid({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 400,
        mainAxisExtent: 340,
        crossAxisSpacing: 32,
        mainAxisSpacing: 32,
      ),
      itemCount: state.halls.length + 1,
      itemBuilder: (context, index) {
        if (index == state.halls.length) {
          return AddNewHallCard(
            onTap: () => HallGridUtils.showAddHallDialog(context),
          );
        }

        final hall = state.halls[index];
        final hallTables = state.allTables
            .where((t) => t.hallId == hall.id)
            .toList();
            
        return HallPreviewCard(
          hall: hall,
          tables: hallTables,
          onTap: () {
            context.read<TableEditorBloc>().add(TableEditorHallSelected(hall));
          },
        );
      },
    );
  }
}
