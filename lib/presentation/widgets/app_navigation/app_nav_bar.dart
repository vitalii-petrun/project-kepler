import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
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
      destinations: <NavigationDestination>[
        NavigationDestination(
          selectedIcon: const Icon(Icons.home),
          icon: const Icon(Icons.home_outlined),
          label: context.l10n.home,
        ),
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
