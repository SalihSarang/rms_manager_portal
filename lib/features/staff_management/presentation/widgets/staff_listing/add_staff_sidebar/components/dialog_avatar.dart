import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class AddUserAvatar extends StatelessWidget {
  final double size;
  final VoidCallback? onTap;
  final ImageProvider? image;

  const AddUserAvatar({
    super.key,
    this.size = 80,
    this.onTap,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          clipBehavior: .none,
          children: [
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: NeutralColors.surface,
                border: Border.all(color: NeutralColors.border),
              ),
              child: ClipOval(
                child: image != null
                    ? Image(
                        image: image!,
                        fit: BoxFit.cover,
                        width: size,
                        height: size,
                        errorBuilder: (context, error, stackTrace) {
                          print('Avatar Image Load Error: $error');
                          return Center(
                            child: Icon(
                              Icons.error,
                              color: Colors.red,
                              size: size * 0.5,
                            ),
                          );
                        },
                      )
                    : Container(
                        width: size,
                        height: size,
                        color: NeutralColors.surface,
                        child: Center(
                          child: Icon(
                            Icons.person,
                            color: TextColors.inverse.withValues(alpha: 0.7),
                            size: size * 0.5,
                          ),
                        ),
                      ),
              ),
            ),

            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.all(size * 0.05),
                decoration: const BoxDecoration(
                  color: PrimaryColors.defaultColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: size * 0.18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
