import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/cubit/menu_details_cubit.dart';
import 'package:manager_portal/features/menu_management/presentation/cubit/menu_details_state.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/semantic_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/models/menu_models/food_model/food_model.dart';
import 'package:rms_shared_package/models/menu_models/portions_and_price/portions_and_price.dart';
import 'package:rms_shared_package/models/menu_models/add_ons_model/add_ons_model.dart';

class MenuDetailsTestScreen extends StatelessWidget {
  final FoodModel foodItem;

  const MenuDetailsTestScreen({super.key, required this.foodItem});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MenuDetailsCubit()..loadDetails(foodItem),
      child: Scaffold(
        backgroundColor: NeutralColors.background,
        appBar: AppBar(
          backgroundColor: NeutralColors.background,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: TextColors.inverse,
              size: 20,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(color: NeutralColors.border, height: 1.0),
          ),
        ),
        body: BlocBuilder<MenuDetailsCubit, MenuDetailsState>(
          builder: (context, state) {
            if (state is MenuDetailsLoading) {
              return const Center(
                child: CircularProgressIndicator(color: TextColors.inverse),
              );
            } else if (state is MenuDetailsLoaded) {
              return _buildDetails(context, state.foodItem);
            } else if (state is MenuDetailsError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: SemanticColors.error),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildDetails(BuildContext context, FoodModel item) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section (Hero)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      color: NeutralColors.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: NeutralColors.border),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                      image: item.imageUrl.isNotEmpty
                          ? DecorationImage(
                              image: NetworkImage(item.imageUrl),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: item.imageUrl.isEmpty
                        ? const Icon(
                            Icons.restaurant_menu,
                            size: 64,
                            color: TextColors.secondary,
                          )
                        : null,
                  ),
                  const SizedBox(width: 32),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                item.name,
                                style: const TextStyle(
                                  color: TextColors.inverse,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  height: 1.2,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: item.isAvailable
                                    ? SemanticColors.success.withValues(
                                        alpha: 0.1,
                                      )
                                    : SemanticColors.error.withValues(
                                        alpha: 0.1,
                                      ),
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color: item.isAvailable
                                      ? SemanticColors.success.withValues(
                                          alpha: 0.3,
                                        )
                                      : SemanticColors.error.withValues(
                                          alpha: 0.3,
                                        ),
                                ),
                              ),
                              child: Text(
                                item.isAvailable ? 'Available' : 'Sold Out',
                                style: TextStyle(
                                  color: item.isAvailable
                                      ? SemanticColors.success
                                      : SemanticColors.error,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          item.category.name.toUpperCase(),
                          style: const TextStyle(
                            color: TextColors.secondary,
                            fontSize: 14,
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            _buildTag(
                              item.isVeg ? 'Vegetarian' : 'Non-Vegetarian',
                              item.isVeg
                                  ? SemanticColors.success
                                  : SemanticColors.error,
                              Icons.eco_outlined,
                            ),
                            if (item.isFeatured)
                              _buildTag(
                                'Featured',
                                SemanticColors.warning,
                                Icons.star_border,
                              ),
                            if (item.isCustomNotes)
                              _buildTag(
                                'Custom Notes',
                                NeutralColors.white,
                                Icons.note_alt_outlined,
                              ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        const Text(
                          'Description',
                          style: TextStyle(
                            color: TextColors.inverse,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          item.description,
                          style: const TextStyle(
                            color: TextColors.secondary,
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 48),

              // Layout for Tables
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Portions & Pricing',
                          style: TextStyle(
                            color: TextColors.inverse,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildPortionsTable(item.portions),
                      ],
                    ),
                  ),
                  if (item.addOns.isNotEmpty) ...[
                    const SizedBox(width: 32),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Add-ons',
                            style: TextStyle(
                              color: TextColors.inverse,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildAddOnsTable(item.addOns),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTag(String label, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        border: Border.all(color: color.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPortionsTable(List<PortionAndPrice> portions) {
    if (portions.isEmpty) {
      return const Text(
        "No portions added.",
        style: TextStyle(color: TextColors.secondary),
      );
    }
    return Container(
      decoration: BoxDecoration(
        color: NeutralColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: NeutralColors.border),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: portions.length,
        separatorBuilder: (context, index) =>
            const Divider(color: NeutralColors.border, height: 1),
        itemBuilder: (context, index) {
          final p = portions[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  p.name,
                  style: const TextStyle(
                    color: TextColors.inverse,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '\$${p.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: TextColors.inverse,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAddOnsTable(List<AddOnsModel> addOns) {
    return Container(
      decoration: BoxDecoration(
        color: NeutralColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: NeutralColors.border),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: addOns.length,
        separatorBuilder: (context, index) =>
            const Divider(color: NeutralColors.border, height: 1),
        itemBuilder: (context, index) {
          final a = addOns[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  a.name,
                  style: const TextStyle(
                    color: TextColors.inverse,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '+\$${a.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: TextColors.inverse,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
