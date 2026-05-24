import 'package:flutter/material.dart';

class OverviewLoadingView extends StatelessWidget {
  const OverviewLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
