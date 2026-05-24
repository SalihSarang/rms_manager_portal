import 'package:flutter/material.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/menu_details_screen/menu_details_header/components/menu_details_header_image.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/menu_details_screen/menu_details_header/components/menu_details_header_info.dart';
import 'package:rms_shared_package/models/menu_models/food_model/food_model.dart';

class MenuDetailsHeader extends StatelessWidget {
  final FoodModel item;

  const MenuDetailsHeader({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Image (Left)
        MenuDetailsHeaderImage(imageUrl: item.imageUrl),

        const SizedBox(width: 40),

        // Header Information (Right)
        Expanded(child: MenuDetailsHeaderInfo(item: item)),
      ],
    );
  }
}
