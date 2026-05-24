import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class MenuDetailsHeaderImage extends StatelessWidget {
  final String imageUrl;

  const MenuDetailsHeaderImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 280,
      decoration: BoxDecoration(
        color: NeutralColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: NeutralColors.border),
        boxShadow: [
          BoxShadow(
            color: NeutralColors.shadow.withValues(alpha: 0.15),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
        image: imageUrl.isNotEmpty
            ? DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover)
            : null,
      ),
      child: imageUrl.isEmpty
          ? const Center(
              child: Icon(
                Icons.restaurant_menu,
                size: 80,
                color: TextColors.secondary,
              ),
            )
          : null,
    );
  }
}
