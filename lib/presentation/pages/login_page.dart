import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';

import '../blocs/authentication/authentication_cubit.dart';
import '../blocs/authentication/authentication_state.dart';
import '../widgets/google_sign_in_button.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.login),
      ),
      body: BlocConsumer<AuthenticationCubit, AutheticationState>(
        listener: (context, state) {
          if (state is Authenticated) {
            context.router.replaceNamed("/profile");
          }
        },
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/logo.png',
                    height: 200,
                  ),
                ),
                const SizedBox(height: 20),
                const GoogleSignInButton(),
              ],
            ),
          );
        },
      ),
    );
  }
}
