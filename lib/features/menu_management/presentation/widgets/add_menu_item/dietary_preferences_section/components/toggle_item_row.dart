import 'package:flutter/cupertino.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';

/// [ToggleItemRow] is a reusable row containing a label and a [CupertinoSwitch].
/// It is used for binary settings like "Featured" or "Custom Notes".
class ToggleItemRow extends StatelessWidget {
  /// The descriptive text for the toggle action.
  final String label;

  /// The current boolean state of the switch.
  final bool value;

  /// Triggered when the user flips the switch.
  final ValueChanged<bool> onChanged;

  const ToggleItemRow({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: NeutralColors.white, fontSize: 13),
        ),
        CupertinoSwitch(
          value: value,
          onChanged: onChanged,
          activeTrackColor: PrimaryColors.defaultColor,
          inactiveTrackColor: NeutralColors.background,
        ),
      ],
    );
  }
}
