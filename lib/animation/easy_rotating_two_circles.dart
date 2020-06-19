import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EasyRotatingCircle extends StatefulWidget {
  final Color color;
  final double radius;

  /// 追踪的两个圆
  /// color 颜色
  /// radius 半径
  ///  更多信息见仓库：https://github.com/ifgyong/flutter_easyHub
  EasyRotatingCircle({Key key, this.color, this.radius}) : super(key: key);
  _EasyRotatingCircle createState() => _EasyRotatingCircle();
}

class _EasyRotatingCircle extends State<EasyRotatingCircle>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1300))
          ..addStatusListener((s) {
            if (s == AnimationStatus.completed) {
              _animationController..reverse();
            } else if (s == AnimationStatus.dismissed) {
              _animationController
                ..reset()
                ..forward();
            }
          })
          ..repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          width: 60,
          height: 60,
          child: CustomPaint(
            painter: TwoCircle(
                value: (_animationController.value),
                color: widget.color,
                radius: widget.radius == null ? 60 : widget.radius),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class TwoCircle extends CustomPainter {
  Paint _paint;
  Color color;
  double radius;
  double value;
  TwoCircle({@required this.value, this.color, this.radius});
  @override
  void paint(Canvas canvas, Size size) {
    if (_paint == null) {
      _paint = Paint()
        ..color = (color == null ? Colors.white : color)
        ..style = PaintingStyle.fill;
    }

    double subRadius = radius / 4;
    double v1;
    if (value <= 0.5) {
      v1 = value * 2;
    } else {
      v1 = (1 - value) * 2;
    }
    canvas.drawCircle(
        Offset(2 * subRadius + subRadius * sin(value * pi * 2),
            2 * subRadius - subRadius * cos(value * pi * 2)),
        subRadius * v1,
        _paint);

    double v2 = (value + 0.25);
    double v3 = 1 - v1;
    canvas.drawCircle(
        Offset(2 * subRadius + subRadius * sin(v2 * pi * 2),
            2 * subRadius - subRadius * cos(v2 * pi * 2)),
        subRadius * v3,
        _paint);
//    canvas.drawCircle(Offset(radius, radius), radius, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
