import 'package:flutter/material.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/sidebar/components/category_sidebar_header.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';

class CategoriesSidebar extends StatelessWidget {
  const CategoriesSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: NeutralColors.surface,
        border: const Border(right: BorderSide(color: NeutralColors.border)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CategorySidebarHeader(),
          Expanded(
            child: ListView(
              children: const [
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'No categories loaded.',
                      style: TextStyle(color: Colors.white54),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
