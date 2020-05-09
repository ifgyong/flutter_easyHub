import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EasyFallingBall extends StatefulWidget {
  Color color; //小球的颜色
  double radius; //小球半径
  /// 掉落的小球
  /// Color color;//小球的颜色
  /// double radius;//小球半径
  ///  更多信息见仓库：https://github.com/ifgyong/flutter_easyHub
  EasyFallingBall({Key key, this.radius, this.color}) : super(key: key);
  _EasyFallingBall createState() => _EasyFallingBall();
}

class _EasyFallingBall extends State<EasyFallingBall>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  CurvedAnimation _curvedAnimation;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 1),
        lowerBound: 0,
        upperBound: 1.0)
      ..addStatusListener((s) {
        if (s == AnimationStatus.completed) {
          _animationController.reset();
          _animationController.forward();
        } else if (s == AnimationStatus.dismissed) {
          _animationController.reset();
          _animationController.forward();
        }
      })
      ..repeat(reverse: false, min: 0, max: 1.0, period: Duration(seconds: 1));
    _curvedAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.bounceOut);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double radius = widget.radius == null ? 10 : widget.radius;
    Color color = widget.color == null ? Colors.orange : widget.color;

    AnimatedBuilder animatedBuilder = AnimatedBuilder(
      animation: _curvedAnimation,
      builder: (context, child) {
        double v = _curvedAnimation.value;

        List<Widget> list = List();
        Positioned p1 = Positioned(
          left: _animationController.value * radius * 11 - radius,
          top: v * radius * 10 - 2 * radius,
          child: Container(
            width: radius * 2,
            height: radius * 2,
            child: ClipOval(
              child: Container(
                color: color,
              ),
            ),
          ),
        );
        Positioned p1_shadow = Positioned(
          left: _animationController.value * radius * 11 - radius,
          bottom: -radius * 1.5,
          child: Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(0.45 * pi)
              ..scale(v),
            child: Container(
              width: radius * 2,
              height: radius * 2,
              child: ClipOval(
                child: Container(
                  color: Colors.black26,
                ),
              ),
            ),
          ),
        );

        list.add(p1_shadow);
        list.add(p1);
        return Stack(
          children: list,
        );
      },
    );
    return Container(
      width: radius * 10,
      height: radius * 10,
      child: animatedBuilder,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
