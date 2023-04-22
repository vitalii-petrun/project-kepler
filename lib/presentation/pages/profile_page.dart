import 'package:auto_route/annotations.dart';
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
                CircleAvatar(
                  radius: 80,
                  /*   backgroundImage: AssetImage('assets/profile_picture.png'), */
                  backgroundImage: NetworkImage((state.user).photoURL!),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      context.l10n.name,
                      style: context.theme.textTheme.titleLarge,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      (state.user).displayName!,
                      style: context.theme.textTheme.titleLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      context.l10n.email,
                      style: context.theme.textTheme.titleLarge,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      (state.user).email!,
                      style: context.theme.textTheme.titleLarge,
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.theme.colorScheme.error,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                  onPressed: () {
                    context.read<AuthenticationCubit>().signOut();
                  },
                  child: Text(context.l10n.logout),
                ),
              ],
            ),
          );
        } else if (state is Uninitialized) {
          return Center(
            child: Text("Uninitialized"),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
