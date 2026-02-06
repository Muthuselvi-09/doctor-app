import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double borderRadius;
  final double blur;
  final Alignment? begin;
  final Alignment? end;

  const GlassCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.borderRadius = 20,
    this.blur = 20,
    this.begin,
    this.end,
  });

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      width: width ?? double.infinity,
      height: height ?? 200,
      borderRadius: borderRadius,
      blur: blur,
      alignment: Alignment.bottomCenter,
      border: 2,
      linearGradient: LinearGradient(
        begin: begin ?? Alignment.topLeft,
        end: end ?? Alignment.bottomRight,
        colors: [
          // ignore: deprecated_member_use
          Colors.white.withOpacity(0.1),
          // ignore: deprecated_member_use
          Colors.white.withOpacity(0.05),
        ],
        stops: const [0.1, 1],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          // ignore: deprecated_member_use
          Colors.white.withOpacity(0.5),
          // ignore: deprecated_member_use
          Colors.white.withOpacity(0.2),
        ],
      ),
      child: child,
    );
  }
}
