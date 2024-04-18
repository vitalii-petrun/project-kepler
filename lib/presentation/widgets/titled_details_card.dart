import 'package:flutter/material.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';

class TitledDetailsCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;

  const TitledDetailsCard({
    required this.child,
    required this.title,
    this.subtitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              color: context.theme.colorScheme.secondary,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  title,
                  style: context.theme.textTheme.titleLarge
                      ?.copyWith(color: context.theme.colorScheme.onPrimary),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: child,
          ),
        ],
      ),
    );
  }
}
