import 'package:flutter/material.dart';
import '../sidebar/sidebar.dart';
import 'editor_canvas_area.dart';
import 'editor_loading_overlay.dart';

class EditorMainLayout extends StatelessWidget {
  final bool readOnly;
  final TransformationController transformationController;
  final FocusNode focusNode;

  const EditorMainLayout({
    super.key,
    required this.readOnly,
    required this.transformationController,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          if (!readOnly) const Sidebar(),
          Expanded(
            child: Stack(
              children: [
                EditorCanvasArea(
                  readOnly: readOnly,
                  transformationController: transformationController,
                  focusNode: focusNode,
                ),
                const EditorLoadingOverlay(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
