import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EasyDancingBall extends StatefulWidget {
  double radius; //小球半径 view 宽度是小球的11倍
  /// 跳动的小球 4个小球排成一排
  /// double radius; //小球半径
  ///  更多信息见仓库：https://github.com/ifgyong/flutter_easyHub
  EasyDancingBall({Key key, this.radius}) : super(key: key);
  _EasyDancingBall createState() => _EasyDancingBall();
}

class _EasyDancingBall extends State<EasyDancingBall>
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
          _animationController.reset();
          _animationController.forward();
        } else if (s == AnimationStatus.dismissed) {
          tag = tag + 1;
          tag = tag % 4;
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
        width = radius * 11;
    Color color1 = Color.fromRGBO(53, 152, 192, 1.0);
    Color color2 = Color.fromRGBO(209, 64, 62, 1.0);
    Color color3 = Colors.orange;
    Color color4 = Colors.green;
    Color c1 = Color.fromRGBO(53, 152, 192, 1.0);
    Color c2 = Color.fromRGBO(209, 64, 62, 1.0);
    Color c3 = Colors.orange;
    Color c4 = Colors.green;
    AnimatedBuilder builder = AnimatedBuilder(
      animation: _curvedAnimation,
      builder: (context, child) {
        List<Widget> list;
        double v = _curvedAnimation.value;
//        tag = 3;
        switch (tag) {
          case 0:
            color1 = c1;
            color2 = c2;
            color3 = c3;
            color4 = c4;
            break;
          case 1:
            color1 = c2;
            color2 = c3;
            color3 = c4;
            color4 = c1;
            break;
          case 2:
            color1 = c3;
            color2 = c4;
            color3 = c1;
            color4 = c2;
            break;
          case 3:
            color1 = c4;
            color2 = c1;
            color3 = c2;
            color4 = c3;
            break;
        }

//        v = 1;
// 0-->0.5 前半生 0.25 最大
// 0.5-->1 后半生 0.75 最小

//        double v2 = _curvedAnimation.value;

        double maxRadiusJump = radius * 3;
        double x1 = v * (width - radius * 2);

        double x2 = -maxRadiusJump, y2 = 0;
        double x3 = 0, y3 = 0;
        double x4 = 0, y4 = 0;
//        v = 0.0;
        if (v <= 0.33) {
          x2 = -radius * 3 * v / 0.33;
          y2 = -radius * 2 * sin(v / 0.33 * pi);
        } else if (v <= 0.66) {
          x3 = -radius * 3 * v / 0.33 + maxRadiusJump;
          y3 = radius * 2 * sin(v / 0.33 * pi);
        } else if (v <= 1) {
          x3 = -radius * 3;

          x4 = -radius * 3 * (v - 0.66) / 0.33;
          y4 = -radius * 2 * sin((v - 0.66) / 0.33 * pi);
        }

        Positioned p1 = Positioned(
            left: 0,
            top: 0,
            child: Transform(
              transform: Matrix4.identity()..setTranslationRaw(x1, 0, 0),
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
              transform: Matrix4.identity()..setTranslationRaw(x2, y2, 0),
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
              transform: Matrix4.identity()..setTranslationRaw(x3, y3, 0),
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
              transform: Matrix4.identity()..setTranslationRaw(x4, y4, 0),
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
        list = [p1, p2, p3, p4];
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
