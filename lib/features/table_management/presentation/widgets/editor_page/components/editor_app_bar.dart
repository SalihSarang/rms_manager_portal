// components/editor_app_bar/editor_app_bar.dart
// The app bar for the table layout editor.
import 'package:flutter/material.dart';
import 'package:rms_design_system/rms_design_system.dart';
import 'editor_app_bar/editor_app_bar_title.dart';
import 'editor_app_bar/zoom_controls.dart';
import 'editor_app_bar/editor_actions_group.dart';
import 'editor_app_bar/toolbar_divider.dart';

/// A custom App Bar for the Table Layout Editor.
///
/// Provides controls for zooming, saving layouts, and navigating back.
class EditorAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Callback to zoom in the canvas.
  final VoidCallback onZoomIn;

  /// Callback to zoom out the canvas.
  final VoidCallback onZoomOut;

  /// Callback to navigate back to the overview.
  final VoidCallback onBack;

  /// Whether the editor is in read-only mode.
  final bool readOnly;

  /// Optional callback to switch to editing mode.
  final VoidCallback? onEdit;

  /// Whether zoom out is currently allowed.
  final bool isZoomOutEnabled;

  /// Current zoom percentage (e.g. 100 for 100%).
  final int zoomPercent;

  /// Creates an [EditorAppBar].
  const EditorAppBar({
    super.key,
    required this.onZoomIn,
    required this.onZoomOut,
    required this.onBack,
    this.isZoomOutEnabled = true,
    this.zoomPercent = 100,
    this.readOnly = false,
    this.onEdit,
  });

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: const BoxDecoration(
        color: NeutralColors.surface,
        border: Border(
          bottom: BorderSide(
            color: NeutralColors.border,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            EditorAppBarTitle(
              readOnly: readOnly,
              onBack: onBack,
            ),
            const Spacer(),
            const ToolbarDivider(),
            ZoomControls(
              onZoomIn: onZoomIn,
              onZoomOut: onZoomOut,
              isZoomOutEnabled: isZoomOutEnabled,
              zoomPercent: zoomPercent,
            ),
            const ToolbarDivider(),
            EditorActionsGroup(
              readOnly: readOnly,
              onEdit: onEdit,
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
