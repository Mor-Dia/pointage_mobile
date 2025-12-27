
import 'package:flutter/material.dart';
import 'package:pointage_mobile/constant.dart';

class AnimatedGestureButton extends StatefulWidget {
  final Widget child;
  final bool animate;
  const AnimatedGestureButton({super.key, required this.child, this.animate=false});

  @override
  _AnimatedGestureButtonState createState() => _AnimatedGestureButtonState();
}

class _AnimatedGestureButtonState extends State<AnimatedGestureButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    if(widget.animate){
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: widget.animate ? GestureBorderPainter(_animation) : null,
      child: widget.child,
    );
  }
}

class GestureBorderPainter extends CustomPainter {
  final Animation<double> animation;

  GestureBorderPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = secondColor
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(16),
      ));

    final pathMetrics = path.computeMetrics().toList();
    if (pathMetrics.isNotEmpty) {
      final metric = pathMetrics.first;
      final length = metric.length;
      final start = animation.value * length;
      final end = start + 25; // Longueur du trait jaune
      canvas.drawPath(
        metric.extractPath(start % length, end % length),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

