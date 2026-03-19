import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_design_system/rms_design_system.dart';
import '../../cubit/table_editor_cubit.dart';
import '../../cubit/table_editor_state.dart';
import 'components/hall_preview_card.dart';
import 'components/add_hall_dialog.dart';

/// A responsive grid of hall preview cards.
///
/// Automatically adds a "Add New Section" card at the end of the list.
class HallGrid extends StatelessWidget {
  /// The current state of the table editor.
  final TableEditorState state;

  /// Creates a [HallGrid].
  const HallGrid({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 400,
        mainAxisExtent: 340,
        crossAxisSpacing: 32,
        mainAxisSpacing: 32,
      ),
      itemCount: state.halls.length + 1,
      itemBuilder: (context, index) {
        if (index == state.halls.length) {
          return _AddNewHallCard(
            onTap: () => _showAddHallDialog(context),
          );
        }

        final hall = state.halls[index];
        final hallTables =
            state.allTables.where((t) => t.hallId == hall.id).toList();
        return HallPreviewCard(
          hall: hall,
          tables: hallTables,
          onTap: () {
            context.read<TableEditorCubit>().selectHall(hall);
          },
        );
      },
    );
  }

  /// Displays the dialog for creating a new restaurant hall.
  void _showAddHallDialog(BuildContext context) {
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

class _AddNewHallCard extends StatefulWidget {
  final VoidCallback onTap;
  const _AddNewHallCard({required this.onTap});

  @override
  State<_AddNewHallCard> createState() => _AddNewHallCardState();
}

class _AddNewHallCardState extends State<_AddNewHallCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: _isHovered
                ? PrimaryColors.defaultColor.withValues(alpha: 0.05)
                : NeutralColors.surface.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _isHovered
                  ? PrimaryColors.defaultColor.withValues(alpha: 0.5)
                  : NeutralColors.border,
              width: 1.5,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: PrimaryColors.defaultColor.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: _isHovered
                        ? [
                            PrimaryColors.defaultColor,
                            PrimaryColors.defaultColor
                                .withValues(alpha: 0.7),
                          ]
                        : [
                            PrimaryColors.defaultColor.withValues(alpha: 0.15),
                            PrimaryColors.defaultColor.withValues(alpha: 0.08),
                          ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: _isHovered
                      ? [
                          BoxShadow(
                            color: PrimaryColors.defaultColor
                                .withValues(alpha: 0.4),
                            blurRadius: 20,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : [],
                ),
                child: Icon(
                  Icons.add_rounded,
                  color: _isHovered
                      ? Colors.white
                      : PrimaryColors.defaultColor,
                  size: 30,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Add New Section',
                style: TextStyle(
                  color: NeutralColors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Create a new floor plan',
                style: TextStyle(
                  color: NeutralColors.white.withValues(alpha: 0.35),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
