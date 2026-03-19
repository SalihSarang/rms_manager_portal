import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_design_system/rms_design_system.dart';
import '../../../../bloc/table_editor_bloc.dart';
import '../../../../bloc/table_editor_state.dart';

class LibraryHeader extends StatelessWidget {
  const LibraryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 6),
      child: BlocBuilder<TableEditorBloc, TableEditorState>(
        buildWhen: (p, c) => p.tables.length != c.tables.length,
        builder: (context, state) {
          return Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [TableColors.rectangular, TableColors.round],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.table_restaurant_rounded,
                  size: 16,
                  color: NeutralColors.white,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Table Library',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: NeutralColors.white,
                  letterSpacing: 0.2,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: PrimaryColors.defaultColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: PrimaryColors.defaultColor.withValues(alpha: 0.25),
                  ),
                ),
                child: Text(
                  '${state.tables.length} on canvas',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: PrimaryColors.defaultColor,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
