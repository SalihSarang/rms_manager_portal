import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_menu_item/add_menu_item_bloc.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

/// [FoodDescriptionInput] provides a multiline editor for adding food details.
/// It syncs descriptive text to the [AddMenuItemBloc].
class FoodDescriptionInput extends StatefulWidget {
  const FoodDescriptionInput({super.key});

  @override
  State<FoodDescriptionInput> createState() => _FoodDescriptionInputState();
}

class _FoodDescriptionInputState extends State<FoodDescriptionInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final bloc = context.read<AddMenuItemBloc>();
    _controller = TextEditingController(text: bloc.state.description);
    _controller.addListener(() {
      bloc.add(DescriptionChanged(_controller.text));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(color: NeutralColors.white, fontSize: 14),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _controller,
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
      ],
    );
  }
}
