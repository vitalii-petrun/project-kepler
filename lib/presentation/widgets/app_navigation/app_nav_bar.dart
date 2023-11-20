import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'active_tab_index_provider.dart';

class AppNavigationBar extends StatefulWidget {
  const AppNavigationBar({super.key});

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final activeTabNotifier = Provider.of<ActiveTabIndexProvider>(context);

    return NavigationBar(
      onDestinationSelected: (int index) {
        // Use TabsRouter to switch tabs
        final tabsRouter = AutoTabsRouter.of(context);
        if (tabsRouter.activeIndex != index) {
          tabsRouter.setActiveIndex(index);
        }
        activeTabNotifier.activeTabIndex = index;
      },
      selectedIndex: activeTabNotifier.activeTabIndex,
      destinations: const <NavigationDestination>[
        NavigationDestination(
          selectedIcon: Icon(Icons.home),
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.rocket_launch),
          icon: Icon(Icons.rocket_launch_outlined),
          label: 'Launches',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.settings),
          icon: Icon(Icons.settings_outlined),
          label: 'Settings',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.bookmark),
          icon: Icon(Icons.bookmark_border),
          label: 'Favorites',
        ),
      ],
    );
  }
}
