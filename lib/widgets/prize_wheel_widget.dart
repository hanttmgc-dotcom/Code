import 'package:flutter/material.dart';
import 'dart:math';
import '../models/prize.dart';

class PrizeWheelWidget extends StatefulWidget {
  final List<Prize> prizes;
  final StreamController<int> controller;

  const PrizeWheelWidget({
    required this.prizes,
    required this.controller,
  });

  @override
  State<PrizeWheelWidget> createState() => _PrizeWheelWidgetState();
}

class _PrizeWheelWidgetState extends State<PrizeWheelWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  double _currentRotation = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    );

    widget.controller.stream.listen((selectedIndex) {
      _spinToIndex(selectedIndex);
    });
  }

  void _spinToIndex(int index) {
    final segmentAngle = 360 / widget.prizes.length;
    final targetRotation = (index * segmentAngle) + 180;
    final rotations = 5 + (targetRotation / 360);

    _rotationAnimation = Tween<double>(
      begin: _currentRotation,
      end: _currentRotation + (rotations * 360),
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward(from: 0).then((_) {
      setState(() {
        _currentRotation = _rotationAnimation.value;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Wheel
        AnimatedBuilder(
          animation: _rotationAnimation,
          builder: (context, child) {
            return Transform.rotate(
              angle: (_rotationAnimation.value * pi) / 180,
              child: CustomPaint(
                painter: WheelPainter(prizes: widget.prizes),
                size: Size(300, 300),
              ),
            );
          },
        ),
        // Center circle
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
              ),
            ],
          ),
          child: Center(
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.star,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
        ),
        // Pointer
        Positioned(
          top: 0,
          child: CustomPaint(
            painter: PointerPainter(),
            size: Size(40, 30),
          ),
        ),
      ],
    );
  }
}

class WheelPainter extends CustomPainter {
  final List<Prize> prizes;

  WheelPainter({required this.prizes});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final paint = Paint()..style = PaintingStyle.fill;
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    final segmentAngle = 360 / prizes.length;

    for (int i = 0; i < prizes.length; i++) {
      final startAngle = (i * segmentAngle) * pi / 180;
      final sweepAngle = segmentAngle * pi / 180;

      // Draw segment
      paint.color = Color(prizes[i].color);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );

      // Draw border
      paint.color = Colors.white;
      paint.style = PaintingStyle.stroke;
      paint.strokeWidth = 3;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );

      // Draw text
      final angle = startAngle + sweepAngle / 2;
      final textRadius = radius * 0.6;
      final textX = center.dx + textRadius * cos(angle);
      final textY = center.dy + textRadius * sin(angle);

      textPainter.text = TextSpan(
        text: prizes[i].name,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(textX - textPainter.width / 2, textY - textPainter.height / 2),
      );
    }
  }

  @override
  bool shouldRepaint(WheelPainter oldDelegate) => false;
}

class PointerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(PointerPainter oldDelegate) => false;
}
