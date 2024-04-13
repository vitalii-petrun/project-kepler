import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:project_kepler/presentation/cubits/authentication/authentication_cubit.dart';
import 'package:project_kepler/presentation/cubits/authentication/authentication_state.dart';

import '../widgets/log_out_button.dart';
import '../widgets/rounded_app_bar.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: RoundedAppBar(title: Text(context.l10n.profile)),
      body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
          listener: (context, state) {
        if (state is Unauthenticated) {
          context.router.replaceNamed("/login");
        }
      }, builder: (context, state) {
        if (state is Authenticated) {
          return _LoadedBody(user: state.user);
        } else if (state is Unauthenticated) {
          return Center(child: Text(context.l10n.unauthenticated));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}

class _LoadedBody extends StatelessWidget {
  final User user;

  const _LoadedBody({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          _ProfileCard(user: user),
          const SizedBox(height: 20),
          const LogoutButton(),
        ],
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final User user;

  const _ProfileCard({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: CachedNetworkImageProvider((user).photoURL!),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.displayName!,
                      style: context.theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      user.email!,
                      style: context.theme.textTheme.bodyLarge,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            _ProfileTile(
              icon: const Icon(Icons.home_outlined),
              title: context.l10n.home,
              onTap: () => context.router.pushNamed("/home"),
            ),
            _ProfileTile(
              icon: const Icon(Icons.favorite_outline),
              title: context.l10n.favourite,
              onTap: () => context.router.pushNamed("/favourites"),
            ),
            _ProfileTile(
              icon: const Icon(Icons.settings_outlined),
              title: context.l10n.settings,
              onTap: () => context.router.pushNamed("/settings"),
            ),
            _ProfileTile(
                icon: const Icon(Icons.person_outline_rounded),
                title: context.l10n.friends,
                onTap: () => context.router.pushNamed("/friends")),
          ],
        ),
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final String title;
  final Icon icon;
  final VoidCallback onTap;

  const _ProfileTile({
    required this.icon,
    required this.title,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(title),
      onTap: onTap,
    );
  }
}
