import 'package:flutter/material.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    required this.mobile,
    required this.desktop,
    this.tablet,
    Key? key,
  }) : super(key: key);

  static bool isMobile(BuildContext context) => context.screenWidth < 850;

  static bool isTablet(BuildContext context) =>
      context.screenWidth < 1100 && context.screenWidth >= 850;

  static bool isDesktop(BuildContext context) => context.screenWidth >= 1100;

  @override
  Widget build(BuildContext context) {
    if (context.screenWidth >= 1100) {
      return desktop;
    } else if (context.screenWidth >= 850 && tablet != null) {
      return tablet as Widget;
    } else {
      return mobile;
    }
  }
}
