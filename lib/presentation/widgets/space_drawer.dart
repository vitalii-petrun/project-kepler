import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:provider/provider.dart';

import '../blocs/authentication/authentication_cubit.dart';
import '../blocs/authentication/authentication_state.dart';
import 'app_navigation/active_tab_index_provider.dart';

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
    final authenticationCubit = context.read<AuthenticationCubit>();

    User? currentUser;

    if (authenticationCubit.state is Authenticated) {
      currentUser = (authenticationCubit.state as Authenticated).user;
    }
    const logoBackgroundColor = Color(0xFF352E32);
    final activeTabNotifier =
        Provider.of<ActiveTabIndexProvider>(context, listen: false);
    final tabsRouter = AutoTabsRouter.of(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: logoBackgroundColor),
            child: currentUser != null
                ? _buildUserHeader(currentUser)
                : Image.asset('assets/logo.png'),
          ),
          const SizedBox(height: 10),
          _DrawerTile(
              icon: const Icon(Icons.home, size: 30),
              title: context.l10n.home,
              onTap: () {
                if (tabsRouter.activeIndex != 0) {
                  tabsRouter.setActiveIndex(0);
                }
                activeTabNotifier.activeTabIndex = 0;
              }),
          const SizedBox(height: 10),
          _DrawerTile(
              icon: const Icon(Icons.rocket_launch_rounded, size: 30),
              title: context.l10n.launches,
              onTap: () {
                if (tabsRouter.activeIndex != 1) {
                  tabsRouter.setActiveIndex(1);
                }
                activeTabNotifier.activeTabIndex = 1;
              }),
          const SizedBox(height: 10),
          _DrawerTile(
              icon: const Icon(Icons.settings, size: 30),
              title: context.l10n.settings,
              onTap: () {
                if (tabsRouter.activeIndex != 2) {
                  tabsRouter.setActiveIndex(2);
                }
                activeTabNotifier.activeTabIndex = 2;
              }),
          const SizedBox(height: 10),
          _DrawerTile(
              icon: const Icon(Icons.favorite, size: 30),
              title: context.l10n.favourite,
              onTap: () {
                if (tabsRouter.activeIndex != 3) {
                  tabsRouter.setActiveIndex(3);
                }
                activeTabNotifier.activeTabIndex = 3;
              }),
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

Widget _buildUserHeader(User user) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(user.photoURL ?? ''),
      ),
      const SizedBox(height: 10),
      Text(
        user.displayName ?? 'User Name',
        style: const TextStyle(color: Colors.white),
      ),
      const SizedBox(height: 10),
      Text(
        user.email ?? 'User Email',
        style: const TextStyle(color: Colors.white),
      ),
    ],
  );
}
