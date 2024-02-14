import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';

import '../cubits/authentication/authentication_cubit.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  static _handleSignOutTap(BuildContext context) async {
    final AuthenticationCubit authentication =
        context.read<AuthenticationCubit>();
    authentication.signOut();
  }

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
      onPressed: () => _handleSignOutTap(context),
      child: Text(context.l10n.logout),
    );
  }
}
