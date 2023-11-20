import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class AppNavigationBar extends StatefulWidget {
  const AppNavigationBar({super.key});

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: (int index) {
        // Use TabsRouter to switch tabs
        final tabsRouter = AutoTabsRouter.of(context);
        if (tabsRouter.activeIndex != index) {
          tabsRouter.setActiveIndex(index);
        }
        setState(() {
          _selectedIndex = index;
        });
      },
      selectedIndex: _selectedIndex,
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
