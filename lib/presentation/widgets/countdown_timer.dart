import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';

class CountdownTimer extends StatefulWidget {
  final String net;
  final String launchStatus;

  const CountdownTimer({
    required this.net,
    required this.launchStatus,
    Key? key,
  }) : super(key: key);

  @override
  State<CountdownTimer> createState() => CountdownTimerState();
}

class CountdownTimerState extends State<CountdownTimer> {
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
        _DividerWithStatusChip(
            launchStatus: LaunchStatus.fromString(widget.launchStatus)),
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
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          child: Divider(color: Color.fromARGB(255, 83, 83, 83)),
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
      width: 70,
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
  goForLaunch("Go for Launch"),
  toBeConfirmed("To Be Confirmed"),
  toBeDetermined("To Be Determined"),
  successfulLaunch("Successful Launch"),
  launchFailure("Launch Failure");

  final String value;
  const LaunchStatus(this.value);

  static LaunchStatus fromString(String launchStatus) {
    switch (launchStatus) {
      case "Go for Launch":
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
        return const Color(0xFF00C853);
      case LaunchStatus.launchFailure:
        return const Color(0xFFFF0000);
      case LaunchStatus.goForLaunch:
        return const Color(0xFFc8fad5);
      case LaunchStatus.toBeConfirmed:
        return const Color(0xFFCCCCCC);
      case LaunchStatus.toBeDetermined:
        return const Color(0xFFCCCCCC);
      default:
        return const Color(0xFFCCCCCC);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const Divider(),
          Positioned(
            top: -8,
            left: 0,
            right: 0,
            child: Chip(
              backgroundColor: _chipColorByStatus,
              labelPadding: const EdgeInsets.symmetric(horizontal: 18),
              label: Text(
                launchStatus.value,
                style: context.theme.textTheme.titleLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
