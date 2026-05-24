import 'package:flutter/material.dart';
import 'package:manager_portal/features/table_management/presentation/widgets/editor_page/utils/editor_shortcuts.dart';
import 'package:manager_portal/features/table_management/presentation/widgets/editor_page/components/editor_viewport.dart';

class EditorMainCanvas extends StatelessWidget {
  final bool readOnly;
  final TransformationController transformationController;
  final FocusNode focusNode;
  final Function(Size) onViewportSizeChanged;

  const EditorMainCanvas({
    super.key,
    required this.readOnly,
    required this.transformationController,
    required this.focusNode,
    required this.onViewportSizeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: CallbackShortcuts(
        bindings: readOnly ? {} : EditorShortcuts.getBindings(context),
        child: EditorViewport(
          transformationController: transformationController,
          focusNode: focusNode,
          readOnly: readOnly,
          onViewportSizeChanged: onViewportSizeChanged,
        ),
      ),
    );
  }
}
