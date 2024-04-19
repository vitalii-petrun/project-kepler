import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';

import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:project_kepler/domain/entities/event.dart';
import 'package:project_kepler/presentation/cubits/authentication/authentication_cubit.dart';
import 'package:project_kepler/presentation/cubits/authentication/authentication_state.dart';
import 'package:project_kepler/presentation/cubits/favourites_page/favourite_events_cubit.dart';
import 'package:project_kepler/presentation/cubits/favourites_page/favourite_events_state.dart';
import 'package:project_kepler/presentation/utils/ui_helpers.dart';
import 'package:project_kepler/presentation/widgets/animated_heart_button.dart';
import 'package:project_kepler/presentation/widgets/info_badge.dart';

import '../navigation/app_router.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final int eventId;

  const EventCard({
    required this.event,
    required this.eventId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: _BodySection(event: event),
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
      decoration: BoxDecoration(
        color: context.theme.brightness == Brightness.dark
            ? AppColors.eventCardColor.withOpacity(0.2)
            : AppColors.eventCardColor.withOpacity(0.8),
      ),
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
            image: CachedNetworkImageProvider(image),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class _BodySection extends StatelessWidget {
  final Event event;

  const _BodySection({
    required this.event,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? eventType = event.type.name;

    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.location_pin,
                color: context.theme.colorScheme.onSurface),
            const SizedBox(width: 4),
            Text(
              event.location,
              style: context.theme.textTheme.bodyLarge,
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(Icons.access_time_filled_rounded,
                color: context.theme.colorScheme.onSurface),
            const SizedBox(width: 4),
            Text(
              "${DateFormat('EEEE, MMMM d').format(event.date)} ${context.l10n.at} ${DateFormat('HH:mm').format(event.date)}",
              style: context.theme.textTheme.bodyLarge,
            ),
          ],
        ),
        const SizedBox(height: 8),
        InfoBadge(eventType: eventType),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: context.theme.colorScheme.secondary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            event.description.isEmpty
                ? context.l10n.noDescriptionProvided
                : event.description,
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
              onTap: () => context.router
                  .push(EventsDetailsRoute(eventId: event.id, event: event)),
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
            BlocBuilder<FavouriteEventsCubit, FavouriteEventsState>(
              builder: (context, state) {
                if (context.watch<AuthenticationCubit>().state
                    is! Authenticated) {
                  return const SizedBox();
                } else if (state is FavouriteEventsLoaded) {
                  bool isFavorite = state.events.any((e) => e.id == event.id);

                  return AnimatedHeartButton<Event>(
                    item: event,
                    isFavourite: isFavorite,
                    onToggleFavourite: (event) => context
                        .read<FavouriteEventsCubit>()
                        .toggleFavouriteEvent(event),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
