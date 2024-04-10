import 'package:flutter/material.dart';
import 'package:project_kepler/presentation/utils/ui_helpers.dart';

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          colors: [
            AppColors.quaternaryColor,
            AppColors.primaryColor,
            AppColors.secondaryColor,
            AppColors.tertiaryColor,
          ],
          stops: [0.0, 0.25, 0.5, 0.75],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcIn,
      child: const AnimatedGradientField(
        duration: Duration(seconds: 3),
      ),
    );
  }
}

class AnimatedGradientField extends StatefulWidget {
  final Duration duration;

  const AnimatedGradientField({Key? key, required this.duration})
      : super(key: key);

  @override
  AnimatedGradientFieldState createState() => AnimatedGradientFieldState();
}

class AnimatedGradientFieldState extends State<AnimatedGradientField>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.2, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width:
                    _animation.value * MediaQuery.of(context).size.width * 0.5,
                height: 16.0,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              const SizedBox(height: 4.0),
              Container(
                width:
                    _animation.value * MediaQuery.of(context).size.width * 0.7,
                height: 16.0,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              const SizedBox(height: 4.0),
              Container(
                width:
                    _animation.value * MediaQuery.of(context).size.width * 0.6,
                height: 16.0,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
