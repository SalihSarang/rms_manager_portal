import 'package:flutter/material.dart';
import 'package:manager_portal/core/widgets/rms_detail_app_bar.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class LegalDocumentViewer extends StatelessWidget {
  final String title;
  final String content;

  const LegalDocumentViewer({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeutralColors.background,
      appBar: RmsDetailAppBar(title: title),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              content,
              style: const TextStyle(
                color: TextColors.primary,
                fontSize: 14,
                height: 1.6,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
