import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class ActivityTitle extends StatelessWidget {
  const ActivityTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 20),
          child: Text('Activity', style: TextStyle(color: TextColors.inverse)),
        ),
        Container(
          height: 1,
          width: double.infinity,
          color: NeutralColors.border,
        ),
      ],
    );
  }
}
