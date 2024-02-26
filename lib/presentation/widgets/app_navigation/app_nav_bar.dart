import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:project_kepler/core/extensions/build_context_ext.dart';

class AppNavigationBar extends StatefulWidget {
  final TabsRouter tabsRouter;
  const AppNavigationBar({Key? key, required this.tabsRouter})
      : super(key: key);

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: (int index) {
        if (widget.tabsRouter.activeIndex != index) {
          widget.tabsRouter.setActiveIndex(index);
        }
      },
      selectedIndex: widget.tabsRouter.activeIndex,
      destinations: <NavigationDestination>[
        NavigationDestination(
          selectedIcon: const Icon(Icons.home),
          icon: const Icon(Icons.home_outlined),
          label: context.l10n.home,
        ),
        // NavigationDestination(
        //   selectedIcon: const Icon(Icons.auto_awesome),
        //   icon: const Icon(Icons.auto_awesome_outlined),
        //   label: context.l10n.ai,
        // ),
        NavigationDestination(
          selectedIcon: const Icon(Icons.rocket_launch),
          icon: const Icon(Icons.rocket_launch_outlined),
          label: context.l10n.launches,
        ),
        NavigationDestination(
          selectedIcon: const Icon(Icons.settings),
          icon: const Icon(Icons.settings_outlined),
          label: context.l10n.settings,
        ),
        NavigationDestination(
          selectedIcon: const Icon(Icons.bookmark),
          icon: const Icon(Icons.bookmark_border),
          label: context.l10n.favs,
        ),
      ],
    );
  }
}
