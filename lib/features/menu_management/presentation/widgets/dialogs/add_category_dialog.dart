import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/menu_management_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/menu_management_state.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/dialogs/components/add_category_actions.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/dialogs/components/add_category_header.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/dialogs/components/category_name_field.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/dialogs/components/category_visibility_switch.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/semantic_colors.dart';

class AddCategoryDialog extends StatefulWidget {
  const AddCategoryDialog({super.key});

  @override
  State<AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  final TextEditingController _categoryController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showInMenu = true;

  @override
  void dispose() {
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: NeutralColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: NeutralColors.border),
      ),
      child: BlocListener<MenuManagementBloc, MenuManagementState>(
        listenWhen: (previous, current) {
          if (previous is CategoriesLoaded && current is CategoriesLoaded) {
            // Only listen when we transition from submitting to not submitting
            return previous.isSubmitting == true &&
                current.isSubmitting == false;
          }
          return false;
        },
        listener: (context, state) {
          if (state is CategoriesLoaded) {
            if (state.submissionError != null) {
              // Show error
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.submissionError!),
                  backgroundColor: SemanticColors.error,
                ),
              );
            } else {
              // Success, close dialog
              Navigator.of(context).pop();
            }
          }
        },
        child: Container(
          width: 500,
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AddCategoryHeader(),
                const SizedBox(height: 32),
                CategoryNameField(controller: _categoryController),
                const SizedBox(height: 32),
                CategoryVisibilitySwitch(
                  value: _showInMenu,
                  onChanged: (value) {
                    setState(() {
                      _showInMenu = value;
                    });
                  },
                ),
                const SizedBox(height: 40),
                AddCategoryActions(
                  formKey: _formKey,
                  categoryController: _categoryController,
                  showInMenu: _showInMenu,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
