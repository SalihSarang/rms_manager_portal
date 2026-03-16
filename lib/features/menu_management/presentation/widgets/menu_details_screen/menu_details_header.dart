import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/semantic_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/models/menu_models/food_model/food_model.dart';

class MenuDetailsHeader extends StatelessWidget {
  final FoodModel item;

  const MenuDetailsHeader({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image Container
        Container(
          width: 280,
          height: 280,
          decoration: BoxDecoration(
            color: NeutralColors.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: NeutralColors.border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 24,
                offset: const Offset(0, 12),
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
              ? const Center(
                  child: Icon(
                    Icons.restaurant_menu,
                    size: 80,
                    color: TextColors.secondary,
                  ),
                )
              : null,
        ),
        const SizedBox(width: 40),
        
        // Information Section
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and Availability
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      item.name,
                      style: const TextStyle(
                        color: TextColors.inverse,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  _buildAvailabilityBadge(),
                ],
              ),
              const SizedBox(height: 12),
              
              // Category
              Text(
                item.category.name.toUpperCase(),
                style: TextStyle(
                  color: TextColors.secondary.withValues(alpha: 0.8),
                  fontSize: 14,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 32),
              
              // Tags
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildTag(
                    item.isVeg ? 'Vegetarian' : 'Non-Vegetarian',
                    item.isVeg ? SemanticColors.success : SemanticColors.error,
                    Icons.eco_rounded,
                  ),
                  if (item.isFeatured)
                    _buildTag(
                      'Featured',
                      SemanticColors.warning,
                      Icons.star_rounded,
                    ),
                  if (item.isCustomNotes)
                    _buildTag(
                      'Custom Notes',
                      SemanticColors.info,
                      Icons.edit_note_rounded,
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAvailabilityBadge() {
    final color = item.isAvailable ? SemanticColors.success : SemanticColors.error;
    final text = item.isAvailable ? 'Available' : 'Sold Out';
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String label, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
