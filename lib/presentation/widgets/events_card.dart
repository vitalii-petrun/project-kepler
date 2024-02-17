import 'package:flutter/material.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';

import '../../domain/entities/event.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({
    required this.event,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event.name,
            style: context.theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {},
            child: Text(context.l10n.explore),
          ),
        ],
      ),
    );
  }
}
