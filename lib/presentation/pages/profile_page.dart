import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:project_kepler/presentation/blocs/authentication/authentication_cubit.dart';
import 'package:project_kepler/presentation/blocs/authentication/authentication_state.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.profile),
      ),
      body: BlocBuilder<AuthenticationCubit, AutheticationState>(
          builder: (context, state) {
        if (state is Authenticated) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                _ProfileCard(user: state.user),
                const SizedBox(height: 20),
                const _LogoutButton(),
              ],
            ),
          );
        } else if (state is Unauthenticated) {
          return Center(child: Text(context.l10n.unauthenticated));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
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
                  radius: 45,
                  backgroundImage: NetworkImage((user).photoURL!),
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
            const _FavouriteLaunchesButton(),
          ],
        ),
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: context.theme.colorScheme.error,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      onPressed: () {
        context.read<AuthenticationCubit>().signOut();
      },
      child: Text(context.l10n.logout),
    );
  }
}

class _FavouriteLaunchesButton extends StatelessWidget {
  const _FavouriteLaunchesButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      leading: const Icon(Icons.favorite_outline),
      title: Text(context.l10n.favourite),
      onTap: () {
        context.router.pushNamed("/favourite");
      },
    );
  }
}
