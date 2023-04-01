import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:project_kepler/presentation/navigation/app_router.dart';
import 'package:project_kepler/presentation/widgets/countdown_timer.dart';

import '../../domain/entities/launch.dart';

class LaunchCard extends StatefulWidget {
  final Launch launch;

  const LaunchCard({
    required this.launch,
    Key? key,
  }) : super(key: key);

  @override
  State<LaunchCard> createState() => _LaunchCardState();
}

class _LaunchCardState extends State<LaunchCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(8),
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
        borderRadius: BorderRadius.circular(8),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => context.router
                  .push(LaunchDetailsRoute(launchId: widget.launch.id)),
              child: _HeaderSection(
                launchName: widget.launch.name,
                padLocation: widget.launch.pad.location.name,
                launchServiceProvider: widget.launch.launchServiceProvider.name,
              ),
            ),
            _ImageSection(image: widget.launch.image),
            CountdownTimer(
                net: widget.launch.net,
                launchStatus: widget.launch.status.name),
            const SizedBox(height: 8),
            _BodySection(
                missionDescription: widget.launch.mission?.description),
            const SizedBox(height: 8),
            _FooterSection(launch: widget.launch),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  final String launchName;
  final String padLocation;
  final String launchServiceProvider;

  const _HeaderSection({
    required this.launchName,
    required this.padLocation,
    required this.launchServiceProvider,
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
            launchName,
            style: textTheme.titleLarge?.copyWith(color: colorScheme.onPrimary),
          ),
          Text(
            padLocation,
            style: textTheme.bodyLarge?.copyWith(color: colorScheme.onPrimary),
          ),
          Text(
            launchServiceProvider,
            style: textTheme.bodyMedium?.copyWith(color: colorScheme.onPrimary),
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

class _FooterSection extends StatelessWidget {
  final Launch launch;
  const _FooterSection({required this.launch, Key? key}) : super(key: key);

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
              onTap: () =>
                  context.router.push(LaunchDetailsRoute(launchId: launch.id)),
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
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.live_tv),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.share),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BodySection extends StatelessWidget {
  final String? missionDescription;

  const _BodySection({
    required this.missionDescription,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 8),
      child: Text(
        missionDescription ?? context.l10n.noDescriptionProvided,
        textAlign: TextAlign.justify,
      ),
    );
  }
}
