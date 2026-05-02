import 'package:flutter/material.dart';
import 'editor_canvas.dart';

class EditorViewport extends StatelessWidget {
  final TransformationController transformationController;
  final FocusNode focusNode;
  final bool readOnly;
  final Function(Size) onViewportSizeChanged;

  const EditorViewport({
    super.key,
    required this.transformationController,
    required this.focusNode,
    required this.readOnly,
    required this.onViewportSizeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: !readOnly,
      focusNode: focusNode,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size = Size(constraints.maxWidth, constraints.maxHeight);
          // Using microtask to avoid building while reporting size change
          Future.microtask(() => onViewportSizeChanged(size));

          return EditorCanvas(
            transformationController: transformationController,
            focusNode: focusNode,
            readOnly: readOnly,
          );
        },
      ),
    );
  }
}
