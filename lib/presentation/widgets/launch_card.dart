import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';

class LaunchCard extends StatefulWidget {
  final String net;
  final String image;
  final String launchName;
  final String padLocation;
  final String launchStatus;
  final String launchServiceProvider;
  final String? missionDescription;

  const LaunchCard({
    required this.net,
    required this.image,
    required this.launchName,
    required this.padLocation,
    required this.launchStatus,
    required this.launchServiceProvider,
    required this.missionDescription,
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
              launchName: widget.launchName,
              padLocation: widget.padLocation,
              launchServiceProvider: widget.launchServiceProvider,
            ),
            _ImageSection(image: widget.image),
            _TimerSection(net: widget.net, launchStatus: widget.launchStatus),
            _BodySection(missionDescription: widget.missionDescription),
            _FooterSection()
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.launchStatus,
          style: TextStyle(fontSize: 32),
        ),
        Text(
          DateFormat('dd MMMM yyyy HH:mm').format(DateTime.parse(widget.net)),
          style: TextStyle(fontSize: 32),
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
