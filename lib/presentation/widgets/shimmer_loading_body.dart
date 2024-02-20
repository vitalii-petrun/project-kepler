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
            width: 100,
            height: 20,
            color: Colors.grey[800],
          ),
        ),
        Positioned(
          top: 40,
          left: 10,
          child: Container(
            width: 200,
            height: 20,
            color: Colors.grey[800],
          ),
        ),
        Positioned(
          top: 250,
          left: (context.screenWidth - 32) / 4,
          child: Container(
            width: 200,
            height: 40,
            color: Colors.grey[800],
          ),
        ),
        Positioned(
          bottom: 50,
          left: 10,
          child: Container(
            width: context.screenWidth - 32,
            height: 100,
            color: Colors.grey[800],
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Container(
            width: 100,
            height: 20,
            color: Colors.grey[800],
          ),
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey[700]!.withOpacity(0.3),
          highlightColor: Colors.grey[800]!.withOpacity(0.3),
          child: Container(
            height: 500,
            decoration: BoxDecoration(
              color: Colors.grey[900],
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
            width: 100,
            height: 20,
            color: Colors.grey[800],
          ),
        ),
        Positioned(
          top: 40,
          left: 10,
          child: Container(
            width: 200,
            height: 20,
            color: Colors.grey[800],
          ),
        ),
        Positioned(
          bottom: 50,
          left: 10,
          child: Container(
            width: 280,
            height: 100,
            color: Colors.grey[800],
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Container(
            width: 100,
            height: 20,
            color: Colors.grey[800],
          ),
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey[700]!.withOpacity(0.3),
          highlightColor: Colors.grey[800]!.withOpacity(0.3),
          child: Container(
            height: 400,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.grey[700],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
