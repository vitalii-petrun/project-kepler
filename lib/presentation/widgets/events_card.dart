import 'package:flutter/material.dart';

import 'package:intl/intl.dart'; // For date formatting

import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:project_kepler/domain/entities/event.dart';
import 'package:project_kepler/domain/entities/type.dart';
import 'package:project_kepler/presentation/widgets/info_badge.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({
    required this.event,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Column(
          children: [
            _HeaderSection(
              eventName: event.name,
              eventDate: DateFormat('MMMM d, yyyy').format(event.date),
              eventType: event.type.name,
            ),
            _ImageSection(image: event.featureImage),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _BodySection(
                  description: event.description, type: event.type),
            ),
            const SizedBox(height: 8),
            _FooterSection(event: event),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  final String eventName;
  final String eventDate;
  final String eventType;

  const _HeaderSection({
    required this.eventName,
    required this.eventDate,
    required this.eventType,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = context.theme.textTheme;
    ColorScheme colorScheme = context.theme.colorScheme;

    return Container(
      decoration: BoxDecoration(color: colorScheme.primary),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            eventName,
            style: textTheme.titleLarge?.copyWith(
              color: colorScheme.onPrimary,
            ),
          ),
          Text(
            eventDate,
            style: textTheme.bodyLarge?.copyWith(color: colorScheme.onPrimary),
          ),
        ],
      ),
    );
  }
}

class _ImageSection extends StatelessWidget {
  final String image;
  const _ImageSection({required this.image, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 21 / 8,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(image),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class _BodySection extends StatelessWidget {
  final String description;
  final TypeEntity type;

  const _BodySection({
    required this.description,
    required this.type,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? eventType = type.name;

    return Column(
      children: [
        InfoBadge(eventType: eventType),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            description.isEmpty
                ? context.l10n.noDescriptionProvided
                : description,
            style: context.theme.textTheme.bodyLarge?.copyWith(fontSize: 16),
            textAlign: TextAlign.justify,
            maxLines: 6,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _FooterSection extends StatelessWidget {
  final Event event;

  const _FooterSection({
    required this.event,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.theme.cardColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                // Your navigation logic here, adjust based on your app's setup
                // AutoRouter.of(context)
                //     .push(EventDetailsRoute(eventId: event.id)); // Adjust this
              },
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    const Icon(Icons.explore),
                    const SizedBox(width: 8),
                    Text(context.l10n.explore),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
