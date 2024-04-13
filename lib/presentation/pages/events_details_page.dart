import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:project_kepler/domain/converters/event_converter.dart';
import 'package:project_kepler/domain/entities/event.dart';
import 'package:project_kepler/presentation/pages/ai_chat_page.dart';
import 'package:project_kepler/presentation/widgets/chat_fab.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/entities/expedition.dart';
import '../../domain/entities/spacestation.dart';
import '../../domain/entities/type.dart';
import '../widgets/info_badge.dart';

@RoutePage()
class EventsDetailsPage extends StatefulWidget {
  final Event event;
  final int eventId;

  const EventsDetailsPage(
      {Key? key,
      required this.event,
      @PathParam('eventId') required this.eventId})
      : super(key: key);

  @override
  State<EventsDetailsPage> createState() => _EventsDetailsPageState();
}

class _EventsDetailsPageState extends State<EventsDetailsPage> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> pageContext = {
      'event': EventEntityToDtoConverter().convert(widget.event).toJson(),
    };

    return Scaffold(
      floatingActionButton: ChatFAB(
        child: AIChat(pageContext: pageContext),
      ),
      body: _LoadedBody(event: widget.event),
    );
  }
}

class _LoadedBody extends StatefulWidget {
  final Event event;

  const _LoadedBody({
    required this.event,
    Key? key,
  }) : super(key: key);

  @override
  State<_LoadedBody> createState() => _LoadedBodyState();
}

class _LoadedBodyState extends State<_LoadedBody>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    const expandedHeight = 500.0;
    const collapsedHeight = 60.0;
    final theme = context.theme;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: expandedHeight,
          collapsedHeight: collapsedHeight,
          backgroundColor: theme.colorScheme.background,
          pinned: true,
          iconTheme: IconThemeData(
            color: context.theme.colorScheme.onBackground,
          ),
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            title: Text(
              widget.event.name,
              style:
                  theme.textTheme.headlineSmall!.copyWith(color: Colors.white),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            titlePadding: const EdgeInsets.only(
              left: 32,
              right: 36,
              bottom: 16,
            ),
            background: _EventImage(event: widget.event),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              _BodySection(
                description: widget.event.description,
                type: widget.event.type,
              ),
              _FooterSection(event: widget.event),
            ],
          ),
        ),
      ],
    );
  }
}

class _EventImage extends StatelessWidget {
  final Event event;

  const _EventImage({
    required this.event,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const expandedHeight = 500.0;
    const collapsedHeight = 70.0;
    final theme = context.theme;

    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: expandedHeight + collapsedHeight,
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter:
                    const ColorFilter.mode(Colors.black54, BlendMode.darken),
                image: CachedNetworkImageProvider(event.featureImage),
                fit: BoxFit.cover,
              ),
              color: theme.colorScheme.background,
            ),
          ),
        ),
      ],
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
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: InfoBadge(eventType: eventType),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(18),
          margin: const EdgeInsets.symmetric(horizontal: 12),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              context.l10n.eventDetails,
              style: context.theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            _EventDetailsRow(
              title: context.l10n.date,
              value: DateFormat.yMMMd().format(event.date.toLocal()),
            ),
            const SizedBox(height: 16),
            _EventDetailsRow(
              title: context.l10n.location,
              value: event.location,
            ),
            const SizedBox(height: 16),
            _EventDetailsRow(
              title: context.l10n.type,
              value: event.type.name,
            ),
            const SizedBox(height: 32),
            if (event.videoUrl != null) _WatchLiveButton(event),
            const SizedBox(height: 16),
            _NewsUrlButton(newsUrl: event.newsUrl),
            const SizedBox(height: 16),
            // if (event.launches.isNotEmpty)
            //   _LaunchesList(launches: event.launches),
            const SizedBox(height: 16),
            if (event.expeditions.isNotEmpty)
              _ExpeditionsList(expeditions: event.expeditions),
            const SizedBox(height: 16),
            if (event.spaceStations.isNotEmpty)
              _SpaceStationsList(spaceStations: event.spaceStations),
            const SizedBox(height: 560),
          ],
        ),
      ),
    );
  }
}

class _WatchLiveButton extends StatelessWidget {
  final Event event;
  const _WatchLiveButton(this.event, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => launchUrl(
          Uri.parse(event.videoUrl ?? ''),
          mode: LaunchMode.externalApplication,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.play_arrow,
              size: 30,
            ),
            const SizedBox(width: 10),
            Text(context.l10n.watchLive,
                style: context.theme.textTheme.titleMedium?.copyWith(
                  color: context.theme.colorScheme.onPrimary,
                )),
          ],
        ),
      ),
    );
  }
}

class _EventDetailsRow extends StatelessWidget {
  final String title;
  final String value;

  const _EventDetailsRow({
    required this.title,
    required this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.theme.textTheme.titleMedium?.copyWith(fontSize: 20),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: context.theme.textTheme.bodyLarge?.copyWith(fontSize: 16),
        ),
      ],
    );
  }
}

class _NewsUrlButton extends StatelessWidget {
  final String? newsUrl;

  const _NewsUrlButton({required this.newsUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (newsUrl == null || newsUrl!.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => launchUrl(Uri.parse(newsUrl!)),
        style: ElevatedButton.styleFrom(
          backgroundColor: context.theme.colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
        ),
        child: Text(context.l10n.readMore),
      ),
    );
  }
}

// class _LaunchesList extends StatelessWidget {
//   final List<Launch> launches;

//   const _LaunchesList({required this.launches, Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           context.l10n.launches,
//           style: context.theme.textTheme.titleMedium,
//         ),
//         const SizedBox(height: 8),
//         Column(
//           children: launches.map((launch) {
//             return LaunchCard(launch: launch);
//           }).toList(),
//         ),
//       ],
//     );
//   }
// }

class _ExpeditionsList extends StatelessWidget {
  final List<Expedition> expeditions;

  const _ExpeditionsList({required this.expeditions, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.expeditions,
          style: context.theme.textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Column(
          children: expeditions.map((expedition) {
            return Text(expedition.name);
          }).toList(),
        ),
      ],
    );
  }
}

class _SpaceStationsList extends StatelessWidget {
  final List<SpaceStation> spaceStations;

  const _SpaceStationsList({required this.spaceStations, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.spaceStations,
          style: context.theme.textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Column(
          children: spaceStations.map((spaceStation) {
            return Text(spaceStation.name);
          }).toList(),
        ),
      ],
    );
  }
}
