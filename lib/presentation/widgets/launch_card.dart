import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:project_kepler/presentation/cubits/favourite_launches_page/favourite_launches_page_cubit.dart';
import 'package:project_kepler/presentation/navigation/app_router.dart';
import 'package:project_kepler/presentation/widgets/countdown_timer.dart';

import '../../domain/entities/launch.dart';
import '../cubits/favourite_launches_page/favourite_launches_page_state.dart';
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
                  LaunchDetailsRoute(launchId: widget.launch.id),
                );
              },
              child: _HeaderSection(
                launchName: widget.launch.name,
                padLocation: widget.launch.pad.location.name,
                date: widget.launch.net,
                launchServiceProvider: widget.launch.launchServiceProvider.name,
              ),
            ),
            _ImageSection(image: widget.launch.image ?? ""),
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
            style: textTheme.titleLarge?.copyWith(
              color: colorScheme.onPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.location_on, size: 16),
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
              const Icon(Icons.business, size: 16),
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
              const Icon(Icons.date_range, size: 16),
              const SizedBox(width: 4),
              Text(
                DateFormat.yMMMd().format(DateTime.parse(date)),
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

  const _FooterSection({
    required this.launch,
    Key? key,
  }) : super(key: key);

  static bool _checkIfFavourite(Launch launch, List<Launch> launches) {
    bool isFavourite = false;

    for (Launch savedLaunch in launches) {
      if (savedLaunch.id == launch.id) {
        isFavourite = true;
      }
    }

    return isFavourite;
  }

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
            BlocBuilder<FavoriteLaunchesPageCubit, FavouriteLaunchesPageState>(
              builder: (context, state) {
                if (state is FavouriteLaunchesLoaded) {
                  bool isFavorite = _checkIfFavourite(launch, state.launches);

                  return _AnimatedHeartButton(
                    launch: launch,
                    isFavourite: isFavorite,
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

class _AnimatedHeartButton extends StatefulWidget {
  final Launch launch;
  final bool isFavourite;

  const _AnimatedHeartButton({
    required this.launch,
    required this.isFavourite,
    Key? key,
  }) : super(key: key);

  @override
  State<_AnimatedHeartButton> createState() => _AnimatedHeartButtonState();
}

class _AnimatedHeartButtonState extends State<_AnimatedHeartButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      duration: const Duration(milliseconds: 200), vsync: this, value: 1.0);

  late bool _isFavourite;

  @override
  void initState() {
    super.initState();

    _isFavourite = widget.isFavourite;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _isFavourite = widget.isFavourite;
    return BlocBuilder<FavoriteLaunchesPageCubit, FavouriteLaunchesPageState>(
      builder: (context, state) {
        return IconButton(
          onPressed: () {
            FavoriteLaunchesPageCubit cubit =
                context.read<FavoriteLaunchesPageCubit>();

            if (widget.isFavourite) {
              cubit.removeFavouriteLaunch(widget.launch.id);
            } else {
              cubit.setFavouriteLaunch(widget.launch);
            }

            setState(() => _isFavourite = !_isFavourite);
            _controller.reverse().then((value) => _controller.forward());
          },
          icon: ScaleTransition(
            scale: Tween(begin: 0.6, end: 1.0).animate(
                CurvedAnimation(parent: _controller, curve: Curves.easeOut)),
            child: _isFavourite
                ? Icon(
                    Icons.favorite,
                    size: 30,
                    color: context.theme.colorScheme.error,
                  )
                : const Icon(
                    Icons.favorite_border,
                    size: 30,
                  ),
          ),
        );
      },
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
        color: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      child: Text(
        missionDescription == "?"
            ? context.l10n.noDescriptionProvided
            : missionDescription!,
        style: context.theme.textTheme.bodyLarge?.copyWith(fontSize: 16),
        textAlign: TextAlign.justify,
        maxLines: isCompact ? 3 : 6,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
