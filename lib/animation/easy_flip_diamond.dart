import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EasyFlipDiamond extends StatefulWidget {
  Color color; //颜色
  Size size; //大小
  ///翻转的 线条菱形
  /// Size size; //大小
  /// Color color; //颜色
  ///  更多信息见仓库：https://github.com/ifgyong/flutter_easyHub

  EasyFlipDiamond({Key key, this.color, this.size}) : super();
  _EasyFlipDiamond createState() => _EasyFlipDiamond();
}

class _EasyFlipDiamond extends State<EasyFlipDiamond>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
        duration: Duration(milliseconds: 1000),
        vsync: this,
        lowerBound: 0,
        upperBound: 2)
      ..addStatusListener((s) {})
      ..repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AnimatedBuilder animatedBuilder = AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          width: widget.size == null ? 30 : widget.size.width,
          height: widget.size == null ? 15 : widget.size.height,
          child: CustomPaint(
            painter: _FlipDiamondCustomPainter(
                value: _animationController.value, color: widget.color),
          ),
        );
      },
    );
    return animatedBuilder;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class _FlipDiamondCustomPainter extends CustomPainter {
  double value = 0;
  Color color; //颜色

  _FlipDiamondCustomPainter({this.value, this.color});

  Path path = Path();
  Paint _paint;
  @override
  void paint(Canvas canvas, Size size) {
    if (_paint == null) {
      _paint = Paint()
        ..color = this.color == null ? Colors.red : this.color
        ..strokeWidth = size.width / 20
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;
    }

    double dis = size.height / 10;
    double x1 = 0, y1 = dis;
    double x4 = 0, y4 = size.height;
    double x2 = size.width, y2 = 0;

    double x3 = size.width, y3 = (size.height - dis);

    if (value < 1.0) {
      x2 = size.width;
      y2 = (size.height - dis) * value;

      x3 = size.width;
      y3 = (size.height - dis) * (1 - value);
    } else {
      x2 = size.width;
      y2 = (size.height - dis) * (sin(pi / 2));

      x3 = size.width;
      y3 = (size.height - dis) * (1 + sin(pi / 2 + pi));
      value -= 1;

      x1 = 0;
      y1 = dis + (size.height - dis) * value;

      x4 = 0;
      y4 = size.height - (size.height - dis) * (value);
    }

    path.moveTo(x1, y1);
    path.lineTo(x2, y2);
    path.lineTo(x3, y3);
    path.lineTo(x4, y4);
    path.lineTo(x1, y1);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
