import 'package:flutter/material.dart';

class RoundedAppBar extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.blueAccent
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, size.height * 0.38, 0, size.height * 0.50);
    path.cubicTo(0, size.height * 0.74, size.width * 0.25, size.height,
        size.width * 0.50, size.height);
    path.cubicTo(size.width * 0.75, size.height * 1.00, size.width * 1.00,
        size.height * 0.74, size.width, size.height * 0.50);
    path.quadraticBezierTo(size.width, size.height * 0.38, size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
