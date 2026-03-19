// components/editor_app_bar.dart
// The app bar for the table layout editor.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_design_system/rms_design_system.dart';
import '../../../cubit/table_editor_cubit.dart';

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
    final cubit = context.read<TableEditorCubit>();

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
            IconButton(
              onPressed: onBack,
              icon: const Icon(Icons.arrow_back_rounded, color: NeutralColors.icon),
              tooltip: 'Back to Management',
            ),
            const SizedBox(width: 8),
            // Logo
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: PrimaryColors.defaultColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.grid_view_rounded,
                  color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                readOnly ? 'Hall View' : 'Table Layout Editor',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: NeutralColors.white,
                  letterSpacing: 0.3,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Spacer(),

            _ToolbarDivider(),
            _AppBarIconButton(
              icon: Icons.zoom_out_rounded,
              tooltip: 'Zoom Out',
              onPressed: onZoomOut,
              isEnabled: isZoomOutEnabled,
            ),
            // Zoom percentage label
            SizedBox(
              width: 44,
              child: Text(
                '$zoomPercent%',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: NeutralColors.icon,
                ),
              ),
            ),
            _AppBarIconButton(
              icon: Icons.zoom_in_rounded,
              tooltip: 'Zoom In',
              onPressed: onZoomIn,
            ),
            
            if (!readOnly) ...[
              _ToolbarDivider(),
              // Save button
              _buildActionButton(
                context,
                icon: Icons.save_alt_rounded,
                label: 'Save',
                onTap: () {
                  final state = cubit.state;
                  debugPrint('Tables: ${state.tables.length}');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.white, size: 18),
                          SizedBox(width: 8),
                          Text('Layout saved!'),
                        ],
                      ),
                      backgroundColor: PrimaryColors.defaultColor,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                },
              ),
            ] else if (onEdit != null) ...[
              _ToolbarDivider(),
              _buildActionButton(
                context,
                icon: Icons.edit_location_alt_rounded,
                label: 'Edit Layout',
                onTap: onEdit!,
              ),
            ],
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: PrimaryColors.defaultColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: PrimaryColors.defaultColor.withValues(alpha: 0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Icon(icon, color: Colors.white, size: 18),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Reusable toolbar sub-widgets ─────────────────────────────────────────────

class _AppBarIconButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;
  final bool isEnabled;

  const _AppBarIconButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: isEnabled ? tooltip : 'Minimum zoom reached',
      child: GestureDetector(
        onTap: isEnabled ? onPressed : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            size: 20,
            color: isEnabled
                ? NeutralColors.icon
                : NeutralColors.icon.withValues(alpha: 0.3),
          ),
        ),
      ),
    );
  }
}

class _ToolbarDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      color: NeutralColors.border,
    );
  }
}
