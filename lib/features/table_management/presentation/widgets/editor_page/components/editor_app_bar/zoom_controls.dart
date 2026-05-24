import 'package:flutter/material.dart';
import 'package:rms_design_system/rms_design_system.dart';
import 'app_bar_icon_button.dart';

class ZoomControls extends StatelessWidget {
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;
  final bool isZoomOutEnabled;
  final int zoomPercent;

  const ZoomControls({
    super.key,
    required this.onZoomIn,
    required this.onZoomOut,
    required this.isZoomOutEnabled,
    required this.zoomPercent,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBarIconButton(
          icon: Icons.zoom_out_rounded,
          tooltip: 'Zoom Out',
          onPressed: onZoomOut,
          isEnabled: isZoomOutEnabled,
        ),
        SizedBox(
          width: 44,
          child: Text(
            '$zoomPercent%',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: NeutralColors.icon,
            ),
          ),
        ),
        AppBarIconButton(
          icon: Icons.zoom_in_rounded,
          tooltip: 'Zoom In',
          onPressed: onZoomIn,
        ),
      ],
    );
  }
}
