import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../cubit/table_editor_cubit.dart';
import '../../components/add_hall_dialog.dart';

class HallGridUtils {
  /// Displays the dialog for creating a new restaurant hall.
  static void showAddHallDialog(BuildContext context) {
    final cubit = context.read<TableEditorCubit>();
    showDialog(
      context: context,
      builder: (context) => BlocProvider.value(
        value: cubit,
        child: const AddHallDialog(),
      ),
    );
  }
}
