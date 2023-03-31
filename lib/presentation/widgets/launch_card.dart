import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:project_kepler/presentation/navigation/app_router.dart';

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
    return GestureDetector(
      onTap: () =>
          context.router.push(LaunchDetailsRoute(launchId: widget.launch.id)),
      child: Container(
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
              _HeaderSection(
                launchName: widget.launch.name,
                padLocation: widget.launch.pad.location.name,
                launchServiceProvider: widget.launch.launchServiceProvider.name,
              ),
              _ImageSection(image: widget.launch.image),
              _TimerSection(
                  net: widget.launch.net,
                  launchStatus: widget.launch.status.name),
              const SizedBox(height: 8),
              _BodySection(
                  missionDescription: widget.launch.mission?.description),
              const SizedBox(height: 8),
              const _FooterSection(),
              const SizedBox(height: 8),
            ],
          ),
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

class _TimerSection extends StatefulWidget {
  final String net;
  final String launchStatus;

  const _TimerSection({
    required this.net,
    required this.launchStatus,
    Key? key,
  }) : super(key: key);

  @override
  State<_TimerSection> createState() => _TimerSectionState();
}

class _TimerSectionState extends State<_TimerSection> {
  late Timer _timer;
  late Duration _duration;

  void calculateDurationBeforeLaunch(DateTime launchTimestamp) {
    _duration = launchTimestamp.difference(DateTime.now());
    _duration = _duration.isNegative ? Duration.zero : _duration;
  }

  void initTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_duration.inSeconds == 0) {
        _timer.cancel();
      } else {
        setState(() => _duration -= const Duration(seconds: 1));
      }
    });
  }

  @override
  void initState() {
    super.initState();

    final launchTimestamp = DateTime.parse(widget.net);
    calculateDurationBeforeLaunch(launchTimestamp);

    initTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final days = _duration.inDays;
    final hours = _duration.inHours.remainder(24);
    final minutes = _duration.inMinutes.remainder(60);
    final seconds = _duration.inSeconds.remainder(60);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: _DividerWithStatusChip(
              launchStatus: LaunchStatus.fromString(widget.launchStatus)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CountdownItem(number: days, label: context.l10n.days),
            const _CountdownItemsDivider(),
            _CountdownItem(number: hours, label: context.l10n.hours),
            const _CountdownItemsDivider(),
            _CountdownItem(number: minutes, label: context.l10n.minutes),
            const _CountdownItemsDivider(),
            _CountdownItem(number: seconds, label: context.l10n.seconds),
          ],
        ),
      ],
    );
  }
}

class _CountdownItem extends StatelessWidget {
  final int number;
  final String label;

  const _CountdownItem({
    required this.number,
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      child: Column(
        children: [
          Text(
            number.toString().padLeft(2, '0'),
            style: context.theme.textTheme.headlineMedium,
          ),
          Text(label.toUpperCase()),
        ],
      ),
    );
  }
}

class _CountdownItemsDivider extends StatelessWidget {
  const _CountdownItemsDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      ":",
      style: context.theme.textTheme.headlineMedium,
    );
  }
}

enum LaunchStatus {
  goForLaunch("Go For Launch"),
  toBeConfirmed("To Be Confirmed"),
  toBeDetermined("To Be Determined"),
  successfulLaunch("Successful Launch"),
  launchFailure("Launch Failure");

  final String value;
  const LaunchStatus(this.value);

  static LaunchStatus fromString(String launchStatus) {
    switch (launchStatus) {
      case "Go For Launch":
        return LaunchStatus.goForLaunch;
      case "To Be Confirmed":
        return LaunchStatus.toBeConfirmed;
      case "To Be Determined":
        return LaunchStatus.toBeDetermined;
      case "Successful Launch":
        return LaunchStatus.successfulLaunch;
      case "Launch Failure":
        return LaunchStatus.launchFailure;
      default:
        return LaunchStatus.toBeDetermined;
    }
  }
}

class _DividerWithStatusChip extends StatelessWidget {
  final LaunchStatus launchStatus;

  const _DividerWithStatusChip({
    required this.launchStatus,
    Key? key,
  }) : super(key: key);

  Color get _chipColorByStatus {
    switch (launchStatus) {
      case LaunchStatus.successfulLaunch:
        return Colors.green;
      case LaunchStatus.launchFailure:
        return Colors.red;
      case LaunchStatus.goForLaunch:
        return Colors.greenAccent;
      case LaunchStatus.toBeConfirmed:
        return Colors.grey;
      case LaunchStatus.toBeDetermined:
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const Divider(),
        Positioned(
          top: -8,
          left: 0,
          right: 0,
          child: Chip(
            backgroundColor: _chipColorByStatus,
            label: Text(launchStatus.value,
                style: context.theme.textTheme.titleLarge),
          ),
        ),
      ],
    );
  }
}

class _FooterSection extends StatelessWidget {
  const _FooterSection({Key? key}) : super(key: key);

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
              onTap: () {},
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
