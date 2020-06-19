import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EasyRotatingTwoColorCircles extends StatefulWidget {
  /// 球体颜色1
  final Color color1;

  /// 球体颜色2
  final Color color2;

  /// 球体半径
  final double radius;

  /// 旋转的魔球
  /// Color color1; //球体颜色1
  ///  Color color2; //球体颜色2
  ///  double radius; //球体半径
  ///  更多信息见仓库：https://github.com/ifgyong/flutter_easyHub
  EasyRotatingTwoColorCircles({Key key, this.color1, this.color2, this.radius})
      : super(key: key);
  _EasyRotatingTwoColorCircles createState() => _EasyRotatingTwoColorCircles();
}

class _EasyRotatingTwoColorCircles extends State<EasyRotatingTwoColorCircles>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  CurvedAnimation _curvedAnimation;
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
          _animationController.forward();
        }
      })
      ..repeat();
    _curvedAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double radius = widget.radius == null ? 30 : widget.radius,
        width = radius * 6;
    Color color1 = widget.color1 == null
        ? Color.fromRGBO(53, 152, 192, 1.0)
        : widget.color1;
    Color color2 = widget.color2 == null
        ? Color.fromRGBO(209, 64, 62, 1.0)
        : widget.color2;

    AnimatedBuilder builder = AnimatedBuilder(
      animation: _curvedAnimation,
      builder: (context, child) {
        List<Widget> list;
        double v = _animationController.value;
//        v = 0.72;
        double ts1 = sin(v * 2 * pi) / 4 + 1;
// 0-->0.5 前半生 0.25 最大
// 0.5-->1 后半生 0.75 最小
        double v2 = _curvedAnimation.value;
        double sp = v2 <= 0.5 ? (v2 * 2) : (1 - v2) * 2;
        double y = radius * (1.25 - ts1);

        Positioned p1 = Positioned(
            left: 0,
            top: 0,
            child: Transform(
              transform: Matrix4.identity()
                ..setTranslationRaw((width - radius * 2) * sp, y, 0)
                ..scale(ts1),
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

        Positioned p1back = Positioned(
            left: 0,
            top: radius * 4,
            child: Transform(
              transform: Matrix4.identity()
                ..setTranslationRaw((width - radius * 2) * sp, -y, 0)
                ..scale(ts1)
                ..rotateX(pi * 0.45),
              child: Container(
                width: radius * 2,
                height: radius * 2,
                child: ClipOval(
                  child: Container(
                    color: Color.fromRGBO(211, 211, 211, 1),
                  ),
                ),
              ),
            ));
        double ts2 = -sin(v * 2 * pi) / 4 + 1;
        double x2, y2;
        if (v == 0) {
          x2 = 0;
          y2 = 0;
        } else {
          x2 = -(width - radius * 2) * sp;
          y2 = radius * (1.25 - ts2);
        }
        Positioned p2 = Positioned(
            right: 0,
            child: Transform(
              transform: Matrix4.identity()
                ..setTranslationRaw(x2, y2, 0)
                ..scale(ts2),
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
        Positioned p2back = Positioned(
            right: 0,
            top: radius * 4,
            child: Transform(
              transform: Matrix4.identity()
                ..setTranslationRaw(x2, -y2, 0)
                ..scale(ts2)
                ..setEntry(3, 2, 0.001)
                ..rotateX(pi * 0.45),
              child: Container(
                width: radius * 2,
                height: radius * 2,
                child: ClipOval(
                  child: Container(
                    color: Color.fromRGBO(211, 211, 211, 1),
                  ),
                ),
              ),
            ));
        if (v >= 0.5) {
          list = [p1, p2, p1back, p2back];
        } else {
          list = [p2, p1, p1back, p2back];
        }
        return Container(
          width: width,
          height: width,
//          color: Colors.lightGreen,
          child: Stack(
            children: list,
          ),
        );
      },
    );
    return builder;
  }

  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
