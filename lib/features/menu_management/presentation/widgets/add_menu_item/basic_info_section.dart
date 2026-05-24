import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/core/widgets/inputs/primary_text_field.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_category/add_category_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_category/add_category_state.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_menu_item/add_menu_item_bloc.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_design_system/app_colors/semantic_colors.dart';

class BasicInfoSection extends StatefulWidget {
  const BasicInfoSection({super.key});

  @override
  State<BasicInfoSection> createState() => _BasicInfoSectionState();
}

class _BasicInfoSectionState extends State<BasicInfoSection> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final bloc = context.read<AddMenuItemBloc>();
    _nameController.text = bloc.state.name;
    _descriptionController.text = bloc.state.description;

    _nameController.addListener(() {
      bloc.add(NameChanged(_nameController.text));
    });
    _descriptionController.addListener(() {
      bloc.add(DescriptionChanged(_descriptionController.text));
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: NeutralColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: NeutralColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Basic Information',
            style: TextStyle(
              color: NeutralColors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                        text: 'Food Name ',
                        style: TextStyle(
                          color: NeutralColors.white,
                          fontSize: 14,
                        ),
                        children: [
                          TextSpan(
                            text: '*',
                            style: TextStyle(color: SemanticColors.error),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    PrimaryTextField(
                      controller: _nameController,
                      hintText: 'e.g. Classic Margherita Pizza',
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Category',
                      style: TextStyle(
                        color: NeutralColors.white,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    BlocBuilder<AddCategoryBloc, AddCategoryState>(
                      builder: (context, catState) {
                        final categories = (catState is CategoriesLoaded)
                            ? catState.categories
                            : [];

                        return BlocBuilder<AddMenuItemBloc, AddMenuItemState>(
                          buildWhen: (previous, current) =>
                              previous.category != current.category,
                          builder: (context, state) {
                            return DropdownButtonFormField<String>(
                              initialValue: state.category?.id,
                              dropdownColor: NeutralColors.surface,
                              style: const TextStyle(color: TextColors.inverse),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: NeutralColors.background,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: NeutralColors.border,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: NeutralColors.border,
                                  ),
                                ),
                              ),
                              hint: Text(
                                catState is MenuLoading
                                    ? 'Loading categories...'
                                    : 'Select Category',
                                style: TextStyle(
                                  color: TextColors.secondary.withValues(
                                    alpha: 0.5,
                                  ),
                                ),
                              ),
                              items: categories.map<DropdownMenuItem<String>>((
                                cat,
                              ) {
                                return DropdownMenuItem<String>(
                                  value: cat.id,
                                  child: Text(cat.name),
                                );
                              }).toList(),
                              onChanged: (val) {
                                if (val != null) {
                                  final selectedCat = categories.firstWhere(
                                    (element) => element.id == val,
                                  );
                                  context.read<AddMenuItemBloc>().add(
                                    CategoryChanged(selectedCat),
                                  );
                                }
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Description',
            style: TextStyle(color: NeutralColors.white, fontSize: 14),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _descriptionController,
            maxLines: 4,
            style: const TextStyle(color: TextColors.inverse),
            decoration: InputDecoration(
              hintText: 'Describe the ingredients, taste, and allergens...',
              hintStyle: TextStyle(
                color: TextColors.secondary.withValues(alpha: 0.5),
                fontSize: 14,
              ),
              filled: true,
              fillColor: NeutralColors.background,
              contentPadding: const EdgeInsets.all(16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: NeutralColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: NeutralColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: PrimaryColors.defaultColor),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Food Image',
            style: TextStyle(color: NeutralColors.white, fontSize: 14),
          ),
          const SizedBox(height: 8),
          BlocBuilder<AddMenuItemBloc, AddMenuItemState>(
            buildWhen: (previous, current) =>
                previous.pickedImage != current.pickedImage ||
                previous.imageUrl != current.imageUrl,
            builder: (context, state) {
              final hasImage =
                  state.pickedImage != null || state.imageUrl.isNotEmpty;

              ImageProvider? imageProvider;
              if (state.pickedImage != null) {
                imageProvider = kIsWeb
                    ? NetworkImage(state.pickedImage!.path)
                    : FileImage(File(state.pickedImage!.path)) as ImageProvider;
              } else if (state.imageUrl.isNotEmpty) {
                imageProvider = NetworkImage(state.imageUrl);
              }

              return GestureDetector(
                onTap: () {
                  context.read<AddMenuItemBloc>().add(PickFoodImage());
                },
                child: Container(
                  width: double.infinity,
                  height: 160,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: NeutralColors.background,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: NeutralColors.border, width: 1),
                    image: hasImage && imageProvider != null
                        ? DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              NeutralColors.shadow.withValues(alpha: 0.3),
                              BlendMode.darken,
                            ),
                          )
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        hasImage
                            ? Icons.edit_outlined
                            : Icons.cloud_upload_outlined,
                        color: NeutralColors.white,
                        size: 32,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        state.pickedImage != null
                            ? 'Selected: ${state.pickedImage!.name}'
                            : hasImage
                            ? 'Click to change image'
                            : 'Click to upload or drag and drop',
                        style: const TextStyle(
                          color: NeutralColors.white,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'PNG, JPG or WEBP (MAX. 5MB)',
                        style: TextStyle(
                          color: TextColors.secondary.withValues(alpha: 0.7),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
