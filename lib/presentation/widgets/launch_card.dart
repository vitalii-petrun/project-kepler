import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';

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
            _HeaderSection(
              launchName: widget.launch.name,
              padLocation: widget.launch.pad.location.name,
              launchServiceProvider: widget.launch.launchServiceProvider.name,
            ),
            _ImageSection(image: widget.launch.image),
            _TimerSection(
                net: widget.launch.net,
                launchStatus: widget.launch.status.name),
            SizedBox(height: 8),
            _BodySection(
                missionDescription: widget.launch.mission?.description),
            SizedBox(height: 8),
            _FooterSection(),
            SizedBox(height: 8),
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
            style: textTheme.headline6?.copyWith(color: colorScheme.onPrimary),
          ),
          Text(
            padLocation,
            style: textTheme.bodyText1?.copyWith(color: colorScheme.onPrimary),
          ),
          Text(
            launchServiceProvider,
            style: textTheme.bodyText2?.copyWith(color: colorScheme.onPrimary),
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
        )));
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

  @override
  void initState() {
    super.initState();
    final launchTimestamp = DateTime.parse(widget.net);
    _duration = launchTimestamp.difference(DateTime.now());
    _duration = _duration.isNegative ? Duration.zero : _duration;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_duration.inSeconds == 0) {
        _timer.cancel();
      } else {
        setState(() {
          _duration -= Duration(seconds: 1);
        });
      }
    });
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
          child: _DividerWithStatusChip(launchStatus: widget.launchStatus),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CountdownItem(number: days, label: context.l10n.days),
            _CountdownItemsDivider(),
            _CountdownItem(number: hours, label: context.l10n.hours),
            _CountdownItemsDivider(),
            _CountdownItem(number: minutes, label: context.l10n.minutes),
            _CountdownItemsDivider(),
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

class _DividerWithStatusChip extends StatelessWidget {
  final String launchStatus;

  const _DividerWithStatusChip({
    required this.launchStatus,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Divider(),
        Positioned(
          top: -8,
          left: 0,
          right: 0,
          child: Chip(
              label:
                  Text(launchStatus, style: context.theme.textTheme.headline6)),
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
                    Icon(Icons.explore),
                    SizedBox(width: 8),
                    Text(context.l10n.explore),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.live_tv),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.share),
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
