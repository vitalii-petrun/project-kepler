import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';

class SpaceDrawer extends StatelessWidget {
  const SpaceDrawer({super.key});

  static _showAppInfo(BuildContext context) {
    showAboutDialog(
        context: context,
        applicationName: 'Project Kepler',
        applicationVersion: '1.0.0',
        children: [
          Text(context.l10n.appDescription),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    const logoBackgroundColor = Color(0xFF352E32);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: logoBackgroundColor),
            child: Image.asset('assets/logo.png'),
          ),
          const SizedBox(height: 10),
          _DrawerTile(
            icon: const Icon(Icons.home, size: 30),
            title: context.l10n.home,
            onTap: () => context.router.pushNamed('/home'),
          ),
          const SizedBox(height: 10),
          _DrawerTile(
            icon: const Icon(Icons.rocket_launch_rounded, size: 30),
            title: context.l10n.launches,
            onTap: () => context.router.pushNamed('/launches'),
          ),
          const SizedBox(height: 10),
          _DrawerTile(
            icon: const Icon(Icons.settings, size: 30),
            title: context.l10n.settings,
            onTap: () => context.router.pushNamed('/settings'),
          ),
          const SizedBox(height: 10),
          _DrawerTile(
            icon: const Icon(Icons.favorite, size: 30),
            title: context.l10n.favourite,
            onTap: () => context.router.pushNamed('/favourites'),
          ),
          const SizedBox(height: 10),
          _DrawerTile(
            icon: const Icon(Icons.info, size: 30),
            title: context.l10n.about,
            onTap: () => _showAppInfo(context),
          ),
        ],
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  final String title;
  final Icon icon;
  final VoidCallback onTap;

  const _DrawerTile({
    required this.title,
    required this.icon,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 10),
            Text(title, style: context.theme.textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
