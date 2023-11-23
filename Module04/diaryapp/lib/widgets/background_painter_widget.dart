import 'package:flutter/material.dart';

class BackgroundPainterWidget extends CustomPainter {
  final bottomPadding = 48;
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path()
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height * 0.7) //65& on left
      ..lineTo(0, size.height * .4)
      ..lineTo(0, 0);

    Paint paint = Paint()..color = const Color.fromRGBO(46, 86, 180, 1);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
