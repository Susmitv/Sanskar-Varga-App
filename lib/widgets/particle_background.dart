import 'dart:math';
import 'package:flutter/material.dart';

class ParticleBackground extends StatefulWidget {
  const ParticleBackground({super.key});

  @override
  State<ParticleBackground> createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;
  final List<Particle> particles = [];
  final int particleCount = 35;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    for (int i = 0; i < particleCount; i++) {
      particles.add(Particle.random());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {

        for (var p in particles) {
          p.update();
        }

        return CustomPaint(
          painter: ParticlePainter(particles),
          size: Size.infinite,
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class Particle {
  late double x;
  late double y;
  late double radius;
  late double speed;
  late double dx;
  late double dy;

  Particle.random() {
    final rand = Random();

    x = rand.nextDouble();
    y = rand.nextDouble();

    radius = rand.nextDouble() * 3 + 1;
    speed = rand.nextDouble() * 0.0005 + 0.0002;

    dx = rand.nextDouble() * 2 - 1;
    dy = rand.nextDouble() * 2 - 1;
  }

  void update() {
    x += dx * speed;
    y += dy * speed;

    if (x < 0 || x > 1) dx = -dx;
    if (y < 0 || y > 1) dy = -dy;
  }
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;

  ParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {

    final paint = Paint()
      ..color = Colors.white.withOpacity(0.25)
      ..style = PaintingStyle.fill;

    for (var p in particles) {
      canvas.drawCircle(
        Offset(p.x * size.width, p.y * size.height),
        p.radius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
