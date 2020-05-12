import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EasySwimmingBall extends StatefulWidget {
  double radius; //小球半径
  /// 会游泳的小球
  /// 像蝌蚪一样
  /// double radius; //小球半径
  ///  更多信息见仓库：https://github.com/ifgyong/flutter_easyHub
  EasySwimmingBall({Key key, this.radius}) : super(key: key);
  _EasySwimmingBall createState() => _EasySwimmingBall();
}

class _EasySwimmingBall extends State<EasySwimmingBall>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  CurvedAnimation _curvedAnimation;
  int tag = 0;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1200),
        lowerBound: 0,
        upperBound: 1.0)
      ..addStatusListener((s) {
        if (s == AnimationStatus.completed) {
          _animationController.reset();
          _animationController.forward();
        } else if (s == AnimationStatus.dismissed) {
          tag += 1;
          tag %= 3;
          _animationController.reset();
          _animationController.forward();
        }
      })
      ..forward();
    _curvedAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double radius = widget.radius == null ? 15 : widget.radius,
        width = radius * 14;
    Color color2, color1, color3, color4;

    Color c1 = Colors.greenAccent;
    Color c2 = Colors.lightBlue;

    AnimatedBuilder builder = AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        List<Widget> list;
        double v = _animationController.value;
        double v1 = 1.0, v2 = 1.0, v3 = 1.0, v0 = 1.0;
//        tag = 3;
        switch (tag) {
          case 0:
            color1 = c1;
            color2 = c2;
            color3 = c2;
            color4 = c2;
            v0 = v;
            break;
          case 1:
            color1 = c1;
            color2 = c1;
            color3 = c2;
            color4 = c2;
            v1 = v;
            break;
          case 2:
            color1 = c1;
            color2 = c1;
            color3 = c1;
            color4 = c2;
            v2 = v;
            break;
          case 3:
            color1 = c1;
            color2 = c1;
            color3 = c1;
            color4 = c1;
            v3 = v;
            break;
        }

//        v = 1;

        double x2 = 0;
        if (v < 0.66) {
          x2 = radius * 4 * (v / 0.66) + tag * radius * 4;
        } else {
          x2 = radius * 4 + tag * radius * 4;
        }

        Positioned p1 = Positioned(
            left: 0,
            top: 0,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..setTranslationRaw(x2, 0, 0),
              child: CustomPaint(
                painter: _SwimmingBall(value: v, radius: radius),
                size: Size(radius * 2, radius * 2),
              ),
            ));

        Positioned p1_back = Positioned(
            left: 0,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..scale(v0),
              child: Container(
                width: radius * 2,
                height: radius * 2,
                child: ClipOval(
                  child: Container(
                    color: color1,
                  ),
                ),
              ),
            ));
        Positioned p2 = Positioned(
            left: (width - radius * 8) / 3.0 + radius * 2,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..scale(v1),
              child: Container(
                width: radius * 2,
                height: radius * 2,
                child: ClipOval(
                  child: Container(
                    color: color2,
                  ),
                ),
              ),
            ));
        Positioned p3 = Positioned(
            right: (width - radius * 8) / 3.0 + radius * 2,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..scale(v2),
              child: Container(
                width: radius * 2,
                height: radius * 2,
                child: ClipOval(
                  child: Container(
                    color: color3,
                  ),
                ),
              ),
            ));
        Positioned p4 = Positioned(
            right: 0,
            top: 0,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..scale(v3),
              child: Container(
                width: radius * 2,
                height: radius * 2,
                child: ClipOval(
                  child: Container(
                    color: color4,
                  ),
                ),
              ),
            ));
        list = [p1_back, p4, p3, p2, p1];
        return Container(
          width: width,
          height: width,
          margin: EdgeInsets.only(top: radius * 4),
//          color: Colors.lightGreen,
          child: Stack(
            children: list,
          ),
        );
      },
    );
    return builder;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class _SwimmingBall extends CustomPainter {
  Paint _paint;
  Paint _paint2;
  Path p = Path();
  double value = 0.0, radius = 0;

  _SwimmingBall({this.value, this.radius});
  @override
  void paint(Canvas canvas, Size size) {
    if (_paint == null) {
      _paint = Paint()
        ..color = Colors.lightBlue
        ..style = PaintingStyle.fill
        ..strokeWidth = 4.0;
    }
    if (_paint2 == null) {
      _paint2 = Paint()
        ..color = Colors.redAccent
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.0;
    }

    p.moveTo(size.width / 2, size.height / 2);
    Offset p1 = new Offset(size.width / 2, size.height / 2);

    double r_big = radius;
//    p.moveTo(0, size.height / 2);

    double r2 = r_big / 2;
    Offset p2;
    if (value < 0.3) {
      p2 = new Offset((1 - value / 0.3) * 2 * r2 - r2, p1.dy);
    } else if (value < 0.6) {
      p2 = new Offset((0) * 2 * r2 - r2, p1.dy);
    } else {
      p2 = new Offset(((value - 0.6) / 0.4) * 2 * r2 - r2, p1.dy);
    }

    p.addArc(Rect.fromCircle(center: p1, radius: r_big), 0, 2 * pi);
    p.addArc(Rect.fromCircle(center: p2, radius: r2), 0, 2 * pi);
    canvas.drawPath(p, _paint);
    p.reset();

    Offset p2_top = new Offset(p2.dx, size.height / 2 - r2);
    Offset p2_bottom = new Offset(p2.dx, size.height / 2 + r2);

    p.moveTo(p2_top.dx, p2_top.dy);
    p.lineTo(p1.dx, p1.dy - r_big);
    p.lineTo(p1.dx, p1.dy + r_big);
    p.lineTo(p2_bottom.dx, p2_bottom.dy);
    p.close();
    canvas.drawPath(p, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
