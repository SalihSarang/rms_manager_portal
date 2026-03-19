import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_design_system/rms_design_system.dart';
import 'package:manager_portal/core/di/injector.dart';
import 'package:manager_portal/features/table_management/presentation/bloc/table_editor_bloc/table_editor_bloc.dart';
import 'package:manager_portal/features/table_management/presentation/bloc/table_editor_bloc/table_editor_event.dart';
import 'package:manager_portal/features/table_management/presentation/bloc/table_editor_bloc/table_editor_state.dart';
import 'package:manager_portal/features/table_management/presentation/pages/table_layout_editor.dart';
import '../widgets/management_page/management_header.dart';
import '../widgets/management_page/hall_grid.dart';

/// The main management page for restaurant floor plans and tables.
///
/// This page allows users to:
///   View an overview of all halls and total table counts.
///   Create new halls (sections).
///   Navigate to a specific hall's layout editor or viewer.
///   Manage global table settings.
class TableManagementPage extends StatelessWidget {
  /// Creates a [TableManagementPage].
  const TableManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TableEditorBloc>()..add(TableEditorInit()),
      child: BlocListener<TableEditorBloc, TableEditorState>(
        listenWhen: (prev, curr) =>
            curr.error != null && prev.error != curr.error,
        listener: (context, state) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error!),
              backgroundColor: SemanticColors.error,
            ),
          );
        },
        child: BlocBuilder<TableEditorBloc, TableEditorState>(
          builder: (context, state) {
            if (state.isEditing || state.isViewing) {
              return TableLayoutEditorPage(
                readOnly: state.isViewing,
                onBack: () =>
                    context.read<TableEditorBloc>().add(TableEditorNavigationReset()),
                onEdit: () => context.read<TableEditorBloc>().add(const TableEditorEditModeSet(true)),
              );
            }

            return Scaffold(
              backgroundColor: NeutralColors.background,
              appBar: AppBar(
                backgroundColor: NeutralColors.surface,
                elevation: 0,
                centerTitle: false,
                title: const Text(
                  'Table Management',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 22,
                    color: NeutralColors.white,
                  ),
                ),
              ),
              body: state.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: PrimaryColors.defaultColor,
                      ),
                    )
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ManagementHeader(
                            hallCount: state.halls.length,
                            totalTables: state.allTables.length,
                          ),
                          const SizedBox(height: 48),
                          const Text(
                            'Floor Sections',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: NeutralColors.white,
                            ),
                          ),
                          const SizedBox(height: 24),
                          HallGrid(state: state),
                        ],
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}
