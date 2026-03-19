import 'package:flutter/material.dart';

import '../widgets/editor_page/table_layout_editor_ui.dart';

/// Root page of the Table Layout Editor.
class TableLayoutEditorPage extends StatelessWidget {
  final VoidCallback onBack;
  final bool readOnly;
  final VoidCallback? onEdit;

  const TableLayoutEditorPage({
    super.key,
    required this.onBack,
    this.readOnly = false,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return TableLayoutEditorUI(
      onBack: onBack,
      readOnly: readOnly,
      onEdit: onEdit,
    );
  }
}
