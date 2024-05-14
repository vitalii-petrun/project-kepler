import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_kepler/core/extensions/build_context_ext.dart';
import 'package:project_kepler/core/global.dart';

class AnimatedHeartButton<T> extends StatefulWidget {
  final T item;
  final bool isFavourite;
  final Function(T) onToggleFavourite;

  const AnimatedHeartButton({
    Key? key,
    required this.item,
    required this.isFavourite,
    required this.onToggleFavourite,
  }) : super(key: key);

  @override
  State<AnimatedHeartButton<T>> createState() => _AnimatedHeartButtonState<T>();
}

class _AnimatedHeartButtonState<T> extends State<AnimatedHeartButton<T>>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late bool _isFavourite;
  List<Particle> particles = [];

  @override
  void initState() {
    super.initState();
    logger
        .d("[AnimatedHeartButton] received isFavourite: ${widget.isFavourite}");
    _isFavourite = widget.isFavourite;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..addListener(updateParticles);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });

    _controller.addListener(() {
      setState(() {
        // Cause widget to repaint
        for (var particle in particles) {
          particle.move();
        }
        particles.removeWhere(
            (particle) => particle.radius < 0.1); // Remove dead particles
      });
    });
  }

  void updateParticles() {
    if (!_controller.isAnimating) {
      // Only update particles if the animation is still running
      setState(() {
        for (var particle in particles) {
          particle.move();
        }

        particles.removeWhere(
            (particle) => particle.radius < 0.1 || particle.position.dy > 100);
      });
    } else if (_controller.isCompleted) {
      particles.clear(); // Clear particles only when the animation completes
    }
  }

  void generateParticles() {
    Random random = Random();
    particles = List.generate(30, (index) {
      final rad =
          2.0 + random.nextDouble() * 3; // Random radius between 2.0 and 5.0
      final angle = random.nextDouble() * 2 * pi; // Random angle for dispersion
      final speed = random.nextDouble() * 2; // Random speed between 0.0 and 3.0
      final velocity = Offset(
        cos(angle) * speed, // Horizontal velocity
        sin(angle) * speed, // Vertical velocity
      );
      return Particle(
        position: const Offset(20, 7), // Start near the heart icon
        radius: rad,
        color: const Color.fromARGB(255, 243, 103, 22)
            .withOpacity(1 - rad / 5), // Fade based on size
        velocity: velocity,
        gravity: 0.02, // Slightly stronger gravity
        decay: 0.95, // Quick decay for fast fading
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    _isFavourite = widget.isFavourite;
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: const Size(30, 30),
          painter: ParticlePainter(particles: particles),
        ),
        IconButton(
          onPressed: () {
            setState(() => _isFavourite = !_isFavourite);
            _controller.forward(from: 0);
            generateParticles();
            widget.onToggleFavourite(widget.item);
          },
          icon: Icon(
            _isFavourite ? Icons.favorite : Icons.favorite_border,
            size: 30,
            color: _isFavourite ? context.theme.colorScheme.error : null,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Particle {
  Offset position;
  double radius;
  Color color;
  Offset velocity;
  double gravity;
  double decay;

  Particle({
    required this.position,
    required this.radius,
    required this.color,
    required this.velocity,
    this.gravity = 0.1,
    this.decay = 0.98,
  });

  void move() {
    velocity = velocity.translate(0, gravity); // Apply gravity effect
    position = position.translate(velocity.dx, velocity.dy);
    radius *= decay; // Apply decay to shrink particles
  }
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;

  ParticlePainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      var paint = Paint()..color = particle.color;
      canvas.drawCircle(particle.position, particle.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
