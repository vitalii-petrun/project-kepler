import 'package:flutter/material.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/no_connection_icon.png',
          colorBlendMode: BlendMode.srcIn,
          color: context.theme.colorScheme.primary,
          height: 100,
        ),
        const SizedBox(height: 20),
        Text(
          context.l10n.offline,
          style: context.theme.textTheme.titleMedium,
        ),
      ],
    );
  }
}
