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
        Brightness systemBrightness = MediaQuery.of(context).platformBrightness;
        return Container(
          decoration: BoxDecoration(
            color: themeProvider.themeMode == ThemeMode.dark ||
                    (themeProvider.themeMode == ThemeMode.system &&
                        systemBrightness == Brightness.dark)
                ? context.theme.colorScheme.surface
                : context.theme.colorScheme.primary,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: context.theme.colorScheme.primary.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: TabBar(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            controller: controller,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: context.theme.colorScheme.primary.withOpacity(0.1),
            ),
            labelColor: context.theme.colorScheme.onPrimary,
            tabs: tabs,
          ),
        );
      },
    );
  }
}
