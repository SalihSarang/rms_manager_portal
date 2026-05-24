import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_design_system/rms_design_system.dart';
import 'package:manager_portal/core/di/injector.dart';
import 'package:manager_portal/features/table_management/presentation/bloc/table_editor_bloc/table_editor_bloc.dart';
import 'package:manager_portal/features/table_management/presentation/bloc/table_editor_bloc/table_editor_event.dart';
import 'package:manager_portal/features/table_management/presentation/bloc/table_editor_bloc/table_editor_state.dart';
import 'package:manager_portal/features/table_management/presentation/pages/table_layout_editor.dart';
import '../widgets/management_page/table_management_app_bar.dart';
import '../widgets/management_page/table_management_loading_view.dart';
import '../widgets/management_page/table_management_loaded_view.dart';

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
          RmsSnackbar.show(
            context,
            message: state.error!,
            type: RmsSnackbarType.error,
          );
        },
        child: BlocBuilder<TableEditorBloc, TableEditorState>(
          builder: (context, state) {
            if (state.isEditing || state.isViewing) {
              return TableLayoutEditorPage(
                readOnly: state.isViewing,
                onBack: () => context.read<TableEditorBloc>().add(
                  TableEditorNavigationReset(),
                ),
                onEdit: () => context.read<TableEditorBloc>().add(
                  const TableEditorEditModeSet(true),
                ),
              );
            }

            return Scaffold(
              backgroundColor: NeutralColors.background,
              appBar: const TableManagementAppBar(),
              body: state.isLoading
                  ? const TableManagementLoadingView()
                  : TableManagementLoadedView(state: state),
            );
          },
        ),
      ),
    );
  }
}
