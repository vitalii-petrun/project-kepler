import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:provider/provider.dart';

import '../cubits/authentication/authentication_cubit.dart';
import '../cubits/authentication/authentication_state.dart';

class SpaceDrawer extends StatelessWidget {
  const SpaceDrawer({Key? key}) : super(key: key);

  static _showAppInfo(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationIcon: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
            height: 80, width: 80, child: Image.asset('assets/logo.png')),
      ),
      applicationName: 'Project Kepler',
      applicationVersion: '2.0.1',
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(context.l10n.appDescription),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final authenticationCubit = context.read<AuthenticationCubit>();

    User? currentUser;

    if (authenticationCubit.state is Authenticated) {
      currentUser = (authenticationCubit.state as Authenticated).user;
    }
    const logoBackgroundColor = Color(0xFF352E32);

    final tabsRouter = AutoTabsRouter.of(context);

    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      backgroundColor: context.theme.colorScheme.surface,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                  color: logoBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  )),
              child: currentUser != null
                  ? _buildUserHeader(currentUser)
                  : Image.asset('assets/logo.png'),
            ),
            const SizedBox(height: 10),
            _DrawerTile(
              icon: const Icon(Icons.rocket_launch_rounded, size: 30),
              title: context.l10n.launches,
              onTap: () {
                Navigator.pop(context);
                if (tabsRouter.activeIndex != 1) {
                  tabsRouter.setActiveIndex(1);
                }
              },
            ),
            const SizedBox(height: 10),
            _DrawerTile(
              icon: const Icon(Icons.favorite_rounded, size: 30),
              title: context.l10n.favourite,
              onTap: () {
                Navigator.pop(context);
                if (tabsRouter.activeIndex != 3) {
                  tabsRouter.setActiveIndex(3);
                }
              },
            ),
            const SizedBox(height: 10),
            _DrawerTile(
              icon: const Icon(Icons.newspaper_rounded, size: 30),
              title: context.l10n.news,
              onTap: () {
                Navigator.pop(context);
                context.router.pushNamed('/news');
              },
            ),
            const SizedBox(height: 10),
            _DrawerTile(
              icon: const Icon(Icons.settings_rounded, size: 30),
              title: context.l10n.settings,
              onTap: () {
                Navigator.pop(context);
                if (tabsRouter.activeIndex != 2) {
                  tabsRouter.setActiveIndex(2);
                }
              },
            ),
            const SizedBox(height: 5),
            const Divider(color: Colors.black45),
            const SizedBox(height: 5),
            _DrawerTile(
              icon: const Icon(Icons.info, size: 30),
              title: context.l10n.about,
              onTap: () => _showAppInfo(context),
            ),
          ],
        ),
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
        padding: const EdgeInsets.only(left: 20, top: 12, bottom: 12),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 14),
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
