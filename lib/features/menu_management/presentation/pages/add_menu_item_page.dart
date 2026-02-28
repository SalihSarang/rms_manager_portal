import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/core/di/injector.dart';
import 'package:manager_portal/core/utils/image_picker_service/feature_specific_usecase/food_img_picker.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_category/add_category_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_category/add_category_event.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_menu_item/add_menu_item_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/add_menu_item/add_item_bottom_action_bar.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/add_menu_item/addons_pricing_section.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/add_menu_item/basic_info_section.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/add_menu_item/customization_settings_section.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/add_menu_item/portions_pricing_section.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class AddMenuItemPage extends StatelessWidget {
  const AddMenuItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddMenuItemBloc(
            foodImgPickerUsecase: getIt<FoodImgPickerUsecase>(),
          ),
        ),
        BlocProvider(
          create: (context) => getIt<AddCategoryBloc>()..add(LoadCategories()),
        ),
      ],
      child: Scaffold(
        backgroundColor: NeutralColors.background,
        appBar: AppBar(
          backgroundColor: NeutralColors.background,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(color: NeutralColors.border, height: 1.0),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(32),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 900),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Add New Food Item",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Configure basic details, portions, and customization settings for your menu.",
                          style: TextStyle(
                            color: TextColors.secondary.withValues(alpha: 0.7),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 32),
                        const BasicInfoSection(),
                        const SizedBox(height: 16),
                        const PortionsAndPricingSection(),
                        const SizedBox(height: 16),
                        const AddOnsAndPricingSection(),
                        const SizedBox(height: 16),
                        const CustomizationAndSettingsSection(),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const AddItemBottomActionBar(),
          ],
        ),
      ),
    );
  }
}
