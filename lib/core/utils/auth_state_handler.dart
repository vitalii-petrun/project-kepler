import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/core/global.dart';
import 'package:project_kepler/presentation/cubits/authentication/authentication_cubit.dart';
import 'package:project_kepler/presentation/cubits/authentication/authentication_state.dart';
import 'package:project_kepler/presentation/cubits/favourite_launches_page/favourite_launches_page_cubit.dart';

class AuthStateHandler extends StatelessWidget {
  final Widget child;
  const AuthStateHandler({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is Authenticated) {
          logger.d('User is authenticated');
          context.read<FavoriteLaunchesPageCubit>().setUserId();
        } else if (state is Unauthenticated) {
          context.read<FavoriteLaunchesPageCubit>().clearUserId();
        }
      },
      child: child,
    );
  }
}
