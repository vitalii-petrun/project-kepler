import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:project_kepler/core/di/locator.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:project_kepler/core/global.dart';
import 'package:project_kepler/l10n/locale_provider.dart';
import 'package:project_kepler/presentation/cubits/authentication/authentication_cubit.dart';
import 'package:project_kepler/presentation/cubits/authentication/authentication_state.dart';
import 'package:project_kepler/presentation/cubits/favourites_page/favourite_launches_cubit.dart';
import 'package:project_kepler/presentation/navigation/app_router.dart';
import 'package:project_kepler/presentation/widgets/animated_heart_button.dart';
import 'package:project_kepler/presentation/widgets/countdown_timer.dart';

import '../../domain/entities/launch.dart';
import '../cubits/favourites_page/favourite_launches_state.dart';
import '../utils/ui_helpers.dart';

class LaunchCard extends StatefulWidget {
  final Launch launch;
  final bool isCompact;

  const LaunchCard({
    required this.launch,
    this.isCompact = false,
    Key? key,
  }) : super(key: key);

  factory LaunchCard.compact({required Launch launch}) {
    return LaunchCard(
      launch: launch,
      isCompact: true,
    );
  }

  @override
  State<LaunchCard> createState() => _LaunchCardState();
}

class _LaunchCardState extends State<LaunchCard> {
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
        borderRadius: BorderRadius.circular(8),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                AutoRouter.of(context).push(
                  LaunchDetailsRoute(
                      launchId: widget.launch.id, launch: widget.launch),
                );
              },
              child: _HeaderSection(
                launchName: widget.launch.name,
                padLocation: widget.launch.pad.location.name,
                date: widget.launch.net,
                launchServiceProvider: widget.launch.launchServiceProvider.name,
              ),
            ),
            // The image used as default is a SpaceX Falcon 9 image.
            _ImageSection(
                image: widget.launch.image ??
                    "https://spacelaunchnow-prod-east.nyc3.digitaloceanspaces.com/media/images/falcon_9_image_20230807133459.jpeg"),
            const SizedBox(height: 8),
            if (widget.isCompact)
              CountdownTimer.compact(
                net: widget.launch.net,
                launchStatus: widget.launch.status.name,
              )
            else
              CountdownTimer(
                net: widget.launch.net,
                launchStatus: widget.launch.status.name,
              ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: widget.isCompact
                  ? _BodySection.compact(
                      missionDescription:
                          widget.launch.mission?.description ?? "?")
                  : _BodySection(
                      missionDescription: widget.launch.mission?.description),
            ),
            if (!widget.isCompact) const SizedBox(height: 8),
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
  final String date;

  const _HeaderSection({
    required this.launchName,
    required this.padLocation,
    required this.date,
    required this.launchServiceProvider,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = context.theme.textTheme;
    ColorScheme colorScheme = context.theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: context.theme.brightness == Brightness.dark
            ? AppColors.launchCardColor.withOpacity(0.2)
            : AppColors.launchCardColor.withOpacity(0.8),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            launchName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: textTheme.titleLarge?.copyWith(
              color: colorScheme.onPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.location_on, size: 16, color: Colors.white),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  padLocation,
                  style: textTheme.bodyLarge
                      ?.copyWith(color: colorScheme.onPrimary),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.business, size: 16, color: Colors.white),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  launchServiceProvider,
                  style: textTheme.bodyMedium
                      ?.copyWith(color: colorScheme.onPrimary),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.date_range, size: 16, color: Colors.white),
              const SizedBox(width: 4),
              Text(
                DateFormat.yMMMd(locator<LocaleProvider>().currentLocale)
                    .format(DateTime.parse(date)),
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onPrimary,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
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

class _FooterSection extends StatelessWidget {
  final Launch launch;

  const _FooterSection({
    required this.launch,
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
              onTap: () => context.router.push(
                  LaunchDetailsRoute(launchId: launch.id, launch: launch)),
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
            BlocConsumer<FavoriteLaunchesCubit, FavouriteLaunchesState>(
              listener: (context, state) {
                if (launch.id == "67152d83-c689-4cff-8330-b42c166049c9") {
                  logger.d(
                      '[LISTENER] 67152d83-c689-4cff-8330-b42c166049c9 TRIGGERED');
                }
              },
              builder: (context, state) {
                if (context.watch<AuthenticationCubit>().state
                    is! Authenticated) {
                  return const SizedBox();
                } else if (state is FavouriteLaunchesLoaded) {
                  bool isFavorite = context
                      .read<FavoriteLaunchesCubit>()
                      .checkIfFavourite(launch);
                  if (launch.id == "67152d83-c689-4cff-8330-b42c166049c9") {
                    logger.d(
                        '[LAUNCH CARD REBUILD] ${launch.id} isFavorite: $isFavorite');
                  }
                  return AnimatedHeartButton<Launch>(
                    item: launch,
                    isFavourite: isFavorite,
                    onToggleFavourite: (launch) => context
                        .read<FavoriteLaunchesCubit>()
                        .toggleFavouriteLaunch(launch),
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

class _BodySection extends StatelessWidget {
  final String? missionDescription;
  final bool isCompact;

  const _BodySection({
    required this.missionDescription,
    this.isCompact = false,
    Key? key,
  }) : super(key: key);

  factory _BodySection.compact({required String missionDescription}) {
    return _BodySection(
      missionDescription: missionDescription,
      isCompact: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.theme.colorScheme.secondary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      child: Text(
        missionDescription == "?"
            ? context.l10n.noDescriptionProvided
            : missionDescription ?? context.l10n.noDescriptionProvided,
        style: context.theme.textTheme.bodyLarge?.copyWith(fontSize: 16),
        textAlign: TextAlign.justify,
        maxLines: isCompact ? 3 : 6,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
