import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_design_system/rms_design_system.dart';
import 'package:manager_portal/features/table_management/presentation/bloc/table_editor_bloc/table_editor_bloc.dart';
import 'package:manager_portal/features/table_management/presentation/bloc/table_editor_bloc/table_editor_state.dart';

class EditorLoadingOverlay extends StatelessWidget {
  const EditorLoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TableEditorBloc, TableEditorState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: PrimaryColors.defaultColor),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
