import 'package:flutter/cupertino.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/status_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class CategoryVisibilitySwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CategoryVisibilitySwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'You want to show this category in menu',
          style: TextStyle(color: TextColors.inverse, fontSize: 16),
        ),
        Transform.scale(
          scale: 0.9,
          child: CupertinoSwitch(
            value: value,
            activeTrackColor: StatusColors.ready,
            inactiveTrackColor: NeutralColors.background,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
