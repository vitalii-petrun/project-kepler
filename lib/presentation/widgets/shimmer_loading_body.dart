import 'package:flutter/material.dart';
import 'package:project_kepler/presentation/widgets/shimmer.dart';

class ShimmerLoadingBody extends StatelessWidget {
  const ShimmerLoadingBody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Replace this with the number of placeholder items you want
    const itemCount = 10;

    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return const ShimmerLoading(
          isLoading: true,
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
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
