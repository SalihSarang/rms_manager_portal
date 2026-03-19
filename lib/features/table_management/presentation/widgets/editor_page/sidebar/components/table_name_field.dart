import 'package:flutter/material.dart';
import 'package:rms_design_system/rms_design_system.dart';
import 'package:rms_shared_package/rms_shared_package.dart';
import '../../../../cubit/table_editor_cubit.dart';

class TableNameField extends StatefulWidget {
  final TableModel table;
  final TableEditorCubit cubit;

  const TableNameField({
    super.key,
    required this.table,
    required this.cubit,
  });

  @override
  State<TableNameField> createState() => _TableNameFieldState();
}

class _TableNameFieldState extends State<TableNameField> {
  late TextEditingController _nameController;
  late FocusNode _nameFocusNode;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.table.name);
    _nameFocusNode = FocusNode();
    _nameFocusNode.addListener(_onNameFocusLost);
  }

  @override
  void didUpdateWidget(TableNameField old) {
    super.didUpdateWidget(old);
    if (old.table.id != widget.table.id) {
      _nameController.text = widget.table.name;
    }
  }

  void _onNameFocusLost() {
    if (!_nameFocusNode.hasFocus) {
      _submitName();
    }
  }

  void _submitName() {
    final newName = _nameController.text.trim();
    if (newName.isNotEmpty && newName != widget.table.name) {
      widget.cubit.renameTable(widget.table.id, newName);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameFocusNode.removeListener(_onNameFocusLost);
    _nameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      child: Container(
        decoration: BoxDecoration(
          color: NeutralColors.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: NeutralColors.border),
        ),
        child: TextField(
          controller: _nameController,
          focusNode: _nameFocusNode,
          style: const TextStyle(
            color: NeutralColors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.edit_rounded,
              size: 15,
              color: NeutralColors.icon,
            ),
            hintText: 'Table name',
            hintStyle: TextStyle(
              color: NeutralColors.icon,
              fontSize: 13,
            ),
          ),
          onSubmitted: (value) => _submitName(),
        ),
      ),
    );
  }
}
