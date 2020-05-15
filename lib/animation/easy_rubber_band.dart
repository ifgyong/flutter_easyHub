import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EasyRubberBand extends StatefulWidget {
  Color color; //跳绳和 球的颜色
  ///跳绳的小球
  ///Color color; //跳绳和 球的颜色
  ///  更多信息见仓库：https://github.com/ifgyong/flutter_easyHub
  EasyRubberBand({Key key, this.color}) : super(key: key);
  _EasyRubberBand createState() => _EasyRubberBand();
}

class _EasyRubberBand extends State<EasyRubberBand>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  CurvedAnimation _curvedAnimation;
  int tag = 0;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1600),
        lowerBound: 0,
        upperBound: 1.0)
      ..addStatusListener((s) {
        if (s == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (s == AnimationStatus.dismissed) {
          tag = tag + 1;
          tag = tag % 4;
          _animationController.reset();
          _animationController.forward();
          print(tag);
        }
      })
      ..forward();
    _curvedAnimation = CurvedAnimation(
        parent: _animationController, curve: Curves.easeInOutCirc);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = 10;
    AnimatedBuilder animatedBuilder = AnimatedBuilder(
      animation: _curvedAnimation,
      builder: (context, child) {
        double v = _curvedAnimation.value;
        double v2 = _animationController.value;
//        v2 = 1;
//        v = v2;
        CustomPaint p1 = CustomPaint(
          painter: _RubberBandPanter(
              value: v, y: width * 2.5, radius: width, color: widget.color),
//          size: Size(10, 50),
        );
        Positioned p = Positioned(
          child: Container(
//            color: Colors.redAccent,
            child: p1,
          ),
          left: 0,
          top: 0,
          right: 0,
          bottom: 0,
        );

        double rotate1 = v2 * pi * 1 / 8;

        Positioned p_left = Positioned(
            width: width,
            height: width,
            left: 0,
            top: width * 2,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..rotateZ(-pi * 1 / 4 + rotate1),
              child: CustomPaint(
                painter: _DrawRectPanter(color: widget.color),
                size: Size(width, width),
              ),
            ));
        Positioned p_right = Positioned(
            width: width,
            height: width,
            right: 0,
            top: width * 2,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..rotateZ(pi * 1 / 4 - rotate1),
              child: CustomPaint(
                painter: _DrawRectPanter(color: widget.color),
                size: Size(width, width),
              ),
            ));

        Stack stack = Stack(
          children: <Widget>[p, p_left, p_right],
        );
        return stack;
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

class _RubberBandPanter extends CustomPainter {
  Path path = Path();
  Paint _paint;
  Paint _paint2;

  double value = 0.0, y, radius = 10;
  Color color;

  _RubberBandPanter({this.value, this.color, this.y, this.radius});
  @override
  void paint(Canvas canvas, Size size) {
    if (_paint == null) {
      _paint = Paint()
        ..color = this.color == null ? Colors.lightBlue : this.color
        ..strokeWidth = 2.0
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;
    }

    if (_paint2 == null) {
      _paint2 = Paint()
        ..color = this.color == null ? Colors.lightBlue : this.color
        ..strokeWidth = 2.0
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..style = PaintingStyle.fill;
//          ..color = Colors.
    }

    double w = 10 * sin(pi / 4), y = this.y + 10 * tan(pi / 5 * value);

    double x2 = size.width - w * 2;

    path.moveTo(x2, y);

    Offset rightPoint = Offset(x2, y);
    Offset leftPoint = Offset(w * 2, y);
    Offset centerTop = Offset((rightPoint.dx + leftPoint.dx) / 2,
        (rightPoint.dy + leftPoint.dy) / 2 + value * 50 - 23);

    path.cubicTo(centerTop.dx, centerTop.dy, centerTop.dx, centerTop.dy,
        leftPoint.dx, leftPoint.dy);
    Offset centerBottom = Offset(
        (rightPoint.dx + leftPoint.dx) / 2, centerTop.dy + value * 20 - 35);
    canvas.drawPath(path, _paint);
    radius = radius == null ? 10 : radius;
    canvas.drawOval(
        Rect.fromCenter(
            center: centerBottom, width: radius * 2, height: radius * 2),
        _paint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class _DrawRectPanter extends CustomPainter {
  Path path = Path();
  Paint _paint;
  Color color;

  _DrawRectPanter({this.color});
  @override
  void paint(Canvas canvas, Size size) {
    if (_paint == null) {
      _paint = Paint()
        ..color = color == null ? Colors.lightBlue : color
        ..strokeWidth = 2.0
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;
    }
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    canvas.drawPath(path, _paint);

    canvas.drawPoints(
        PointMode.points, [Offset(size.width / 2, size.height / 2)], _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
