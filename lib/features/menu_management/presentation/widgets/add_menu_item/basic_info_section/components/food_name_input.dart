import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/core/widgets/inputs/primary_text_field.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_menu_item/add_menu_item_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/utils/validators.dart';
import 'package:rms_design_system/app_colors/semantic_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

/// [FoodNameInput] is a stateful text field for entering and validating the food's name.
/// It synchronizes the input with the [AddMenuItemBloc] on every change.
class FoodNameInput extends StatefulWidget {
  const FoodNameInput({super.key});

  @override
  State<FoodNameInput> createState() => _FoodNameInputState();
}

class _FoodNameInputState extends State<FoodNameInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final bloc = context.read<AddMenuItemBloc>();
    _controller = TextEditingController(text: bloc.state.name);
    _controller.addListener(() {
      bloc.add(NameChanged(_controller.text));
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
        RichText(
          text: const TextSpan(
            text: 'Food Name ',
            style: TextStyle(color: TextColors.primary, fontSize: 14),
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
          controller: _controller,
          hintText: 'e.g. Classic Margherita Pizza',
          validator: MenuValidators
              .validatePortionName, // Reusing validator logic for menu items too
        ),
      ],
    );
  }
}
