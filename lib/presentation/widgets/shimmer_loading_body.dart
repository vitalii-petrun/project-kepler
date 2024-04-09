import 'package:flutter/material.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';

import 'package:shimmer/shimmer.dart';

class ShimmerLoadingBody extends StatelessWidget {
  const ShimmerLoadingBody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const itemCount = 10;

    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: LaunchCardPlaceholder(),
        );
      },
    );
  }
}

final _placeHolderColor = Colors.grey[600];
const _periodDuration = Duration(milliseconds: 700);
final _baseColor = const Color.fromARGB(255, 27, 27, 27).withOpacity(0.5);
final _highlightColor = const Color.fromARGB(255, 31, 31, 31).withOpacity(0.75);
final _backgroundColor = Colors.grey[900];

class LaunchCardPlaceholder extends StatelessWidget {
  const LaunchCardPlaceholder({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 20,
          left: 10,
          child: Container(
            width: 190,
            height: 20,
            decoration: BoxDecoration(
              color: _placeHolderColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Positioned(
          top: 50,
          left: 10,
          child: Container(
            width: 240,
            height: 20,
            decoration: BoxDecoration(
              color: _placeHolderColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Positioned(
          top: 250,
          left: (context.screenWidth - 32) / 4,
          child: Container(
            width: 200,
            height: 40,
            decoration: BoxDecoration(
              color: _placeHolderColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Positioned(
          top: 250,
          left: (context.screenWidth - 32) / 4,
          child: Container(
            width: 200,
            height: 40,
            decoration: BoxDecoration(
              color: _placeHolderColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Positioned(
          bottom: 50,
          left: 10,
          child: Container(
            width: context.screenWidth - 32,
            height: 100,
            decoration: BoxDecoration(
              color: _placeHolderColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Container(
            width: 100,
            height: 20,
            decoration: BoxDecoration(
              color: _placeHolderColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Shimmer.fromColors(
          baseColor: _baseColor,
          period: _periodDuration,
          highlightColor: _highlightColor,
          child: Container(
            height: 500,
            decoration: BoxDecoration(
              color: _backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}

class CompactCardPlaceholder extends StatelessWidget {
  const CompactCardPlaceholder({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 20,
          left: 10,
          child: Container(
            width: 190,
            height: 20,
            decoration: BoxDecoration(
              color: _placeHolderColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Positioned(
          top: 50,
          left: 10,
          child: Container(
            width: 240,
            height: 20,
            decoration: BoxDecoration(
              color: _placeHolderColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Positioned(
          bottom: 50,
          left: 10,
          child: Container(
            width: 280,
            height: 130,
            decoration: BoxDecoration(
              color: _placeHolderColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Container(
            width: 100,
            height: 20,
            decoration: BoxDecoration(
              color: _placeHolderColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Shimmer.fromColors(
          baseColor: _baseColor,
          highlightColor: _highlightColor,
          period: _periodDuration,
          child: Container(
            height: 400,
            width: 300,
            decoration: BoxDecoration(
              color: _backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
