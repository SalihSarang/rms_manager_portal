import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/core/di/injector.dart';
import 'package:manager_portal/features/table_management/presentation/bloc/table_management_bloc.dart';
import 'package:manager_portal/features/table_management/presentation/widgets/table_list_view.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

/// A page for managing the restaurant's table layout.
///
/// This screen allows managers to visualize, add, and arrange tables.
class TableManagementPage extends StatelessWidget {
  /// Creates a [TableManagementPage].
  const TableManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TableManagementBloc>()..add(LoadTables()),
      child: Scaffold(
        backgroundColor: NeutralColors.background,
        appBar: AppBar(
          backgroundColor: NeutralColors.background,
          elevation: 0,
          title: const Text(
            'Table Management',
            style: TextStyle(
              color: TextColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 24),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text('Add Table'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B71FE),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: BlocBuilder<TableManagementBloc, TableManagementState>(
          builder: (context, state) {
            if (state is TableManagementLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TableManagementLoaded) {
              return TableListView(tables: state.tables);
            } else if (state is TableManagementError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
