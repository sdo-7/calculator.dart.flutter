import 'package:flutter/material.dart';
import '../theme.dart';

class MenuIcon extends StatelessWidget {
  const MenuIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _Painter(AppTheme.current.menuIconColor),
    );
  }
}

class _Painter extends CustomPainter {
  const _Painter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    const left = -0.3;
    const right = 0.5;

    final path = Path()
      ..addLine(size, left, right, 1.0, 1.0)
      ..addLine(size, left, right, size.height / 2 - 0.85 + 1, 1.0)
      ..addLine(size, left, right, size.height - 1.9 + 1, 1.1);

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_Painter that) => false;
}

extension on Path {
  void addLine(
    Size size,
    double left,
    double right,
    double top,
    double bot,
  ) {
    this
      ..moveTo(left, top)
      ..lineTo(size.width + right, top)
      ..lineTo(size.width + right, top + bot)
      ..lineTo(left, top + bot)
      ..close();
  }
}
