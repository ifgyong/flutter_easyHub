import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EasyHourglassTimer extends StatefulWidget {
  double width; //
  Color color;

  /// ⌛效果
  /// double width; 宽度
  /// Color color; 颜色
  ///  更多信息见仓库：https://github.com/ifgyong/flutter_easyHub
  EasyHourglassTimer({Key key, this.width, this.color}) : super(key: key);
  _EasyHourglassTimer createState() => _EasyHourglassTimer();
}

class _EasyHourglassTimer extends State<EasyHourglassTimer>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 1),
        lowerBound: 0,
        upperBound: 2.4)
      ..addStatusListener((s) {
        if (s == AnimationStatus.completed) {
          _animationController.reset();
          _animationController.forward();
        } else if (s == AnimationStatus.dismissed) {
          _animationController.reset();
          _animationController.forward();
        }
      })
      ..repeat(
          reverse: false, min: 0.0, max: 2.4, period: Duration(seconds: 6));

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double wd = widget.width == null ? 60 : widget.width;

    AnimatedBuilder animatedBuilder = AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        double ro = _animationController.value;
        double value = _animationController.value;

        if (ro >= 1.0 && ro < 1.2) {
          value = 1.0;
          ro = sin((ro - 1.0) * 5 * pi / 2) * pi;
        } else if (ro >= 1.2 && ro < 2.2) {
          value = ro - 1.2;
          ro = 0;
        } else if (ro >= 2.2 && ro <= 2.4) {
          ro = sin((ro - 2.2) * 5 * pi / 2) * pi;
          value = 0.0;
        } else {
          value = ro;
          ro = 0.0;
        }
//        value = 0.6;
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()..rotateZ(ro),
          child: CustomPaint(
            painter: _HourglassTimerPainter(value: value),
            size: Size(wd, wd),
          ),
        );
      },
    );

    return Container(
      width: wd,
      height: wd,
      child: animatedBuilder,
    );
  }
}

class _HourglassTimerPainter extends CustomPainter {
  double value; //进度条
  Paint _paint;
  Paint _paint2;
  Paint _paint3;
  Path p = Path();
  Color color;
  _HourglassTimerPainter({this.value, this.color});
  @override
  void paint(Canvas canvas, Size size) {
    Color cl = this.color == null ? Colors.blueGrey : this.color;
    if (_paint == null) {
      _paint = Paint()
        ..color = cl
        ..strokeWidth = 4.0
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;
    }
    if (_paint2 == null) {
      _paint2 = Paint()
        ..color = cl
        ..strokeWidth = 4.0
        ..style = PaintingStyle.fill;
    }
    if (_paint3 == null) {
      _paint3 = Paint()
        ..color = cl
        ..strokeWidth = 4.0
        ..style = PaintingStyle.stroke;
    }
    bool isdown = true;
//    if (value > 1.0) {
//      isdown = false;
//      value -= 1.2;
////      canvas.rotate(pi);
//    } else if (value > 2.2) {
//      value = 0;
//    }
    double wd = size == null ? 60 : size.width;
    Offset p1 = Offset(0, 0);
    Offset p2 = Offset(wd, 0);

    canvas.drawLine(p1, p2, _paint);
    Offset p3 = Offset(0, wd);
    Offset p4 = Offset(wd, wd);

    canvas.drawLine(p3, p4, _paint);
    canvas.drawLine(p1, p4, _paint);
    canvas.drawLine(p2, p3, _paint);
//    value = 0.0;
    //画 沙土
    Offset p1_1 = Offset(wd * value / 2, wd * value / 2);
    Offset center = Offset(wd / 2, wd / 2);
    Offset p1_2 = Offset(wd - wd * value / 2, wd * (value) / 2);

    //上边的三角
    p.moveTo(p1_1.dx, p1_1.dy);
    p.lineTo(center.dx, center.dy);
    p.lineTo(p1_2.dx, p1_2.dy);
    p.lineTo(p1_1.dx, p1_1.dy);
    canvas.drawPath(p, _paint2);

    p.reset();
    //中间的竖线
    if (value > 0) {
      p.moveTo(center.dx, center.dy);
      Offset center2 = Offset(wd / 2, wd);
      p.lineTo(center2.dx, center2.dy);
      canvas.drawPath(p, _paint3);
      //画下边的三角形
      p.reset();
      Offset p2_1 = Offset(wd / 2 - wd / 2 * value, wd);
      Offset p2_2 = Offset(wd / 2 + wd / 2 * value, wd);
      Offset p2_top = Offset(wd / 2, wd - value * wd / 2);

      p.moveTo(p2_top.dx, p2_top.dy);
      p.lineTo(p2_1.dx, p2_1.dy);
      p.lineTo(p2_2.dx, p2_2.dy);
      p.lineTo(p2_top.dx, p2_top.dy);
      canvas.drawPath(p, _paint2);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
