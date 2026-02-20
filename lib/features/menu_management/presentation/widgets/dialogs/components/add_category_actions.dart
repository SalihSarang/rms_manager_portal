import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/core/widgets/buttons/primary_elevated_button.dart';
import 'package:manager_portal/core/widgets/buttons/primary_outlined_button.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/menu_management_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/menu_management_event.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/menu_management_state.dart';

class AddCategoryActions extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController categoryController;
  final bool showInMenu;

  const AddCategoryActions({
    super.key,
    required this.formKey,
    required this.categoryController,
    required this.showInMenu,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Cancel Button
        SizedBox(
          height: 48,
          child: PrimaryOutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            label: 'Cancel',
          ),
        ),
        const SizedBox(width: 16),

        BlocBuilder<MenuManagementBloc, MenuManagementState>(
          builder: (context, state) {
            final isSubmitting =
                state is CategoriesLoaded && state.isSubmitting;

            return SizedBox(
              height: 48,
              child: PrimaryElevatedButton(
                onPressed: isSubmitting
                    ? () {} // Disable when loading
                    : () {
                        if (formKey.currentState!.validate()) {
                          context.read<MenuManagementBloc>().add(
                            AddCategory(
                              name: categoryController.text.trim(),
                              isActive: showInMenu,
                            ),
                          );
                        }
                      },
                label: isSubmitting ? 'Saving...' : 'Save Category',
              ),
            );
          },
        ),
      ],
    );
  }
}
