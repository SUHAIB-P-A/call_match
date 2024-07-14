import 'package:flutter/material.dart';

class CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double curveHeight = 70.0; // Increased curve height

    // Start from the bottom left
    path.lineTo(0, 0);

    // Top left corner curve
    var firstControlPoint = Offset(0, size.height);
    var firstEndPoint = Offset(curveHeight, size.height - curveHeight);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    // Straight line to top right corner
    path.lineTo(size.width - curveHeight, size.height - curveHeight);

    // Top right corner curve
    var secondControlPoint = Offset(size.width, size.height);
    var secondEndPoint = Offset(size.width, size.height - curveHeight);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    // Line to bottom right
    path.lineTo(size.width, size.height);

    // Line to bottom left
    path.lineTo(0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
