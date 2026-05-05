import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';

class EditProfileAvatar extends StatelessWidget {
  final String initialName;

  const EditProfileAvatar({super.key, required this.initialName});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: PrimaryColors.defaultColor,
          child: Text(
            initialName.isNotEmpty ? initialName[0].toUpperCase() : 'M',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: PrimaryColors.defaultColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
          ),
        ),
      ],
    );
  }
}
