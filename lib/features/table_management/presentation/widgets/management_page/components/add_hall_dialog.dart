import 'package:flutter/material.dart';
import 'package:rms_design_system/rms_design_system.dart';
import '../../../cubit/table_editor_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddHallDialog extends StatelessWidget {
  const AddHallDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final cubit = context.read<TableEditorCubit>();

    return AlertDialog(
      backgroundColor: NeutralColors.surface,
      title: const Text('Add New Hall',
          style: TextStyle(color: NeutralColors.white)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            autofocus: true,
            style: const TextStyle(color: NeutralColors.white),
            decoration: const InputDecoration(
              labelText: 'Hall Name',
              hintText: 'e.g., Rooftop Patio',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            if (nameController.text.isNotEmpty) {
              final id = nameController.text
                  .toLowerCase()
                  .trim()
                  .replaceAll(RegExp(r'\s+'), '-');
              cubit.addHall(id, nameController.text);
              Navigator.pop(context);
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
