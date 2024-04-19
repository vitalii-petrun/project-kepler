import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:project_kepler/presentation/navigation/app_router.dart';

import '../cubits/authentication/authentication_cubit.dart';
import '../cubits/authentication/authentication_state.dart';
import '../widgets/google_sign_in_button.dart';
import '../widgets/rounded_app_bar.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: RoundedAppBar(title: Text(context.l10n.login)),
      body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is Authenticated) {
            context.router.replaceAll([const ProfileRoute()]);
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
                  child: Lottie.asset(
                    'assets/lottie/rocket.json',
                    height: 300,
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
