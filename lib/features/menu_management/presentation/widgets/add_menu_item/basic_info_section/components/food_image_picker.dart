import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_menu_item/add_menu_item_bloc.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

/// [FoodImagePicker] handles the selection and preview of food item images.
/// It supports picking new files and displaying existing network images,
/// providing visual feedback on the selection status.
class FoodImagePicker extends StatelessWidget {
  const FoodImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
    );
  }
}
