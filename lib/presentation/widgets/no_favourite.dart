import 'package:flutter/material.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';

class NoFavourite extends StatelessWidget {
  const NoFavourite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: 200,
              child: Icon(
                Icons.not_interested_rounded,
                size: 150,
                color: context.theme.colorScheme.secondary,
              )),
          const SizedBox(height: 20),
          Text(
            context.l10n.noFavs,
            style: context.theme.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
