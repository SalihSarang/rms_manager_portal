import 'package:rms_shared_package/models/menu_models/category_model/category_model.dart';
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
  final bool isEditing;
  final CategoryModel? categoryToEdit;

  const AddCategoryActions({
    super.key,
    required this.formKey,
    required this.categoryController,
    required this.showInMenu,
    this.isEditing = false,
    this.categoryToEdit,
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
                          if (isEditing && categoryToEdit != null) {
                            context.read<MenuManagementBloc>().add(
                              EditCategory(
                                category: categoryToEdit!.copyWith(
                                  name: categoryController.text.trim(),
                                  isActive: showInMenu,
                                ),
                              ),
                            );
                          } else {
                            context.read<MenuManagementBloc>().add(
                              AddCategory(
                                name: categoryController.text.trim(),
                                isActive: showInMenu,
                              ),
                            );
                          }
                        }
                      },
                label: isSubmitting
                    ? 'Saving...'
                    : (isEditing ? 'Save Changes' : 'Save Category'),
              ),
            );
          },
        ),
      ],
    );
  }
}
