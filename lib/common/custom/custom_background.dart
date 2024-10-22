import 'package:flutter/material.dart';

class DiagonalBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..style = PaintingStyle.fill;

    // Top blue part
    Path topPath = Path();
    topPath.lineTo(0, size.height * 0.6); // From top-left to a point on left
    topPath.lineTo(size.width, size.height * 0.4); // To a point on right
    topPath.lineTo(size.width, 0); // Back to the top-right corner
    topPath.close();

    //paint.color = Color(0xFF1E88E5); // Light blue color
    paint.color = Colors.white;
    canvas.drawPath(topPath, paint);

    // Bottom darker part
    Path bottomPath = Path();
    bottomPath.moveTo(
        0, size.height * 0.6); // Start from where the top part ended
    bottomPath.lineTo(
        size.width, size.height * 0.4); // Diagonal line to the other side
    bottomPath.lineTo(size.width, size.height); // Bottom-right corner
    bottomPath.lineTo(0, size.height); // Bottom-left corner
    bottomPath.close();

    //paint.color = Color(0xFF2E3A59); // Darker blue color
    paint.color = Colors.blue.withOpacity(0.2);
    canvas.drawPath(bottomPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
