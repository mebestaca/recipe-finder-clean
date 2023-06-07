import 'package:flutter/cupertino.dart';

class CustomClipPath extends CustomClipper<Path> {

  final heightOffset = 100.0;
  final pivot = .5;

  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    final path = Path();

    path.lineTo(0, h - heightOffset);
    path.quadraticBezierTo(
        w * pivot,
        h,
        w,
        h - heightOffset
    );
    path.lineTo(w, 0);
    path.close();

    return path;

  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

}