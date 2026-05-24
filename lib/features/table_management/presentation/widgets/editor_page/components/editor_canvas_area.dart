import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/table_management/presentation/bloc/table_editor_bloc/table_editor_bloc.dart';
import 'package:manager_portal/features/table_management/presentation/bloc/table_editor_bloc/table_editor_event.dart';
import 'editor_main_canvas.dart';

class EditorCanvasArea extends StatelessWidget {
  final bool readOnly;
  final TransformationController transformationController;
  final FocusNode focusNode;

  const EditorCanvasArea({
    super.key,
    required this.readOnly,
    required this.transformationController,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return EditorMainCanvas(
      readOnly: readOnly,
      transformationController: transformationController,
      focusNode: focusNode,
      onViewportSizeChanged: (size) {
        context.read<TableEditorBloc>().add(
          TableEditorViewportSizeUpdated(size),
        );
      },
    );
  }
}
