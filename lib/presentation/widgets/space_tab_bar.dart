import 'package:flutter/material.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:project_kepler/presentation/themes/app_theme_provider.dart';
import 'package:provider/provider.dart';

class SpaceTabBar extends StatelessWidget {
  final TabController controller;
  final List<Tab> tabs;

  const SpaceTabBar({required this.controller, required this.tabs, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeProvider>(
      builder: (context, themeProvider, child) {
        return Container(
          decoration: BoxDecoration(
            color: context.theme.colorScheme.surface,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(8),
          child: TabBar(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            controller: controller,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: themeProvider.themeMode == ThemeMode.light
                  ? context.theme.colorScheme.primary
                  : context.theme.colorScheme.secondary,
            ),
            labelColor: context.theme.colorScheme.onPrimary,
            tabs: tabs,
          ),
        );
      },
    );
  }
}

class SpaceTabBarItem extends StatelessWidget {
  final String label;

  const SpaceTabBarItem({required this.label, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Center(child: Text(label)),
    );
  }
}
