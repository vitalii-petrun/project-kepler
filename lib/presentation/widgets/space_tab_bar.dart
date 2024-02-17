import 'package:flutter/material.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';

class SpaceTabBar extends StatelessWidget {
  final TabController controller;
  final List<Tab> tabs;

  const SpaceTabBar({required this.controller, required this.tabs, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.colorScheme.surface,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: context.theme.colorScheme.primary.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TabBar(
        controller: controller,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: context.theme.colorScheme.primary.withOpacity(0.1),
        ),
        labelColor: context.theme.colorScheme.onSurface,
        tabs: tabs,
      ),
    );
  }
}
