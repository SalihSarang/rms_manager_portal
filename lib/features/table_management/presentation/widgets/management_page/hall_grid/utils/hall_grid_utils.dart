import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/table_management/presentation/bloc/table_editor_bloc.dart';
import '../../components/add_hall_dialog.dart';

class HallGridUtils {
  /// Displays the dialog for creating a new restaurant hall.
  static void showAddHallDialog(BuildContext context) {
    final bloc = context.read<TableEditorBloc>();
    showDialog(
      context: context,
      builder: (context) => BlocProvider.value(
        value: bloc,
        child: const AddHallDialog(),
      ),
    );
  }
}
