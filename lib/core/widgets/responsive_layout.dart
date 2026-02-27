import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;
  final double tabletBreakpoint;
  final double desktopBreakpoint;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
    this.tabletBreakpoint = 600,
    this.desktopBreakpoint = 1200,
  });

  // Breakpoint helpers

  static bool isMobile(BuildContext context, {double breakpoint = 600}) =>
      MediaQuery.of(context).size.width < breakpoint;

  static bool isTablet(
    BuildContext context, {
    double tabletBreakpoint = 600,
    double desktopBreakpoint = 1200,
  }) {
    final w = MediaQuery.of(context).size.width;
    return w >= tabletBreakpoint && w < desktopBreakpoint;
  }

  static bool isDesktop(BuildContext context, {double breakpoint = 1200}) =>
      MediaQuery.of(context).size.width >= breakpoint;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        if (w >= desktopBreakpoint) {
          return desktop;
        } else if (w >= tabletBreakpoint) {
          return tablet ?? desktop;
        } else {
          return mobile;
        }
      },
    );
  }
}
