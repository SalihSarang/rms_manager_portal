import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/cubit/menu_details_cubit.dart';
import 'package:manager_portal/features/menu_management/presentation/cubit/menu_details_state.dart';
import '../widgets/menu_details_screen/menu_details_app_bar.dart';
import '../widgets/menu_details_screen/menu_details_body.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/semantic_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/models/menu_models/food_model/food_model.dart';

class MenuDetailsScreen extends StatelessWidget {
  final FoodModel foodItem;

  const MenuDetailsScreen({super.key, required this.foodItem});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MenuDetailsCubit()..loadDetails(foodItem),
      child: Scaffold(
        backgroundColor: NeutralColors.background,
        appBar: const MenuDetailsAppBar(),
        body: BlocBuilder<MenuDetailsCubit, MenuDetailsState>(
          builder: (context, state) {
            if (state is MenuDetailsLoading) {
              return const Center(
                child: CircularProgressIndicator(color: TextColors.inverse),
              );
            } else if (state is MenuDetailsLoaded) {
              return MenuDetailsBody(item: state.foodItem);
            } else if (state is MenuDetailsError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(
                    color: SemanticColors.error,
                    fontSize: 16,
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
