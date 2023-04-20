import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';

class SpaceDrawer extends StatelessWidget {
  const SpaceDrawer({super.key});

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
          ListTile(
            title: Text(context.l10n.settings),
            onTap: () => context.router.pushNamed('/settings'),
          ),
          ListTile(
            title: Text(context.l10n.favourite),
            onTap: () => context.router.pushNamed('/settings'),
          ),
          ListTile(
            title: Text(context.l10n.about),
            onTap: () {
              showAboutDialog(
                  context: context,
                  applicationName: 'Project Kepler',
                  applicationVersion: '1.0.0',
                  children: [
                    Text(context.l10n.appDescription),
                  ]);
            },
          ),
        ],
      ),
    );
  }
}
