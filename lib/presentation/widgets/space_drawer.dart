import 'package:flutter/material.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';

class SpaceDrawer extends StatelessWidget {
  const SpaceDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text('Space Launches'),
            decoration:
                BoxDecoration(color: Theme.of(context).colorScheme.primary),
          ),
          ListTile(
            title: Text(context.l10n.settings),
            onTap: () => Navigator.pushNamed(context, '/settings'),
          ),
          ListTile(
            title: Text(context.l10n.about),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
