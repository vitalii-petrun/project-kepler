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
        if (index == 0) {
          context.router.replaceNamed('/home');
        }
        if (index == 1) {
          context.router.replaceNamed('/launches');
        }
        if (index == 2) {
          context.router.replaceNamed('/settings');
        }
        if (index == 3) {
          context.router.replaceNamed('/favourites');
        }
        setState(() {
          _selectedIndex = index;
        });
      },
      selectedIndex: _selectedIndex,
      destinations: const <NavigationDestination>[
        NavigationDestination(
          selectedIcon: Icon(Icons.person),
          icon: Icon(Icons.person_outline),
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
