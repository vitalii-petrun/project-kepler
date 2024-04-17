import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:project_kepler/presentation/utils/ui_helpers.dart';
import 'package:animate_gradient/animate_gradient.dart';

class PresentFunctionButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final String route;
  final bool isAnimated;

  const PresentFunctionButton({
    required this.title,
    required this.icon,
    required this.route,
    this.isAnimated = false,
    Key? key,
  }) : super(key: key);

  factory PresentFunctionButton.animated({
    required String title,
    required IconData icon,
    required String route,
  }) {
    return PresentFunctionButton(
      title: title,
      icon: icon,
      route: route,
      isAnimated: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isAnimated) {
      return _AnimatedWrapper(
          child: _Button(
        title: title,
        icon: icon,
        route: route,
        isAnimated: isAnimated,
      ));
    } else {
      return _Button(
        title: title,
        icon: icon,
        route: route,
        isAnimated: isAnimated,
      );
    }
  }
}

class _AnimatedWrapper extends StatelessWidget {
  final Widget child;

  const _AnimatedWrapper({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: AnimateGradient(
        duration: const Duration(seconds: 4),
        primaryBegin: Alignment.topLeft,
        primaryEnd: Alignment.bottomLeft,
        secondaryBegin: Alignment.bottomLeft,
        secondaryEnd: Alignment.topRight,
        primaryColors: [
          darkenColor(AppColors.aiChatBubbleColor),
          darkenColor(AppColors.spaceTitleColor),
        ],
        secondaryColors: [
          darkenColor(AppColors.presentFunction4),
          darkenColor(AppColors.presentFunction2),
        ],
        child: child,
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final String title;
  final IconData icon;
  final String route;
  final bool isAnimated;

  const _Button({
    required this.title,
    required this.icon,
    required this.route,
    required this.isAnimated,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: isAnimated
            ? Colors.transparent
            : context.theme.brightness == Brightness.dark
                ? AppColors.primaryColor.withOpacity(0.3)
                : AppColors.primaryColor.withOpacity(0.8),
      ),
      child: TextButton(
        onPressed: () => context.router.pushNamed(route),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 26,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: context.theme.textTheme.titleMedium
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
