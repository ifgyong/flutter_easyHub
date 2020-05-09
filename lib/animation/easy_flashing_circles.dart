import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EasyFlashCircles extends StatefulWidget {
  Color color; //小球的颜色
  double radius; //小球半径
  /// 闪烁的9饼
  /// Color color;//小球的颜色
  /// double radius;//小球半径
  ///  更多信息见仓库：https://github.com/ifgyong/flutter_easyHub
  EasyFlashCircles({Key key, this.radius, this.color}) : super(key: key);
  _EasyFlashCircles createState() => _EasyFlashCircles();
}

class _EasyFlashCircles extends State<EasyFlashCircles>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  int tag = -1;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1000),
        lowerBound: 0,
        upperBound: 3.0)
      ..addStatusListener((s) {
        if (s == AnimationStatus.completed) {
          _animationController.reset();
          _animationController.forward();
        } else if (s == AnimationStatus.dismissed) {
          _animationController.reset();
          _animationController.forward();
        }
      })
      ..forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = widget.radius == null ? 60.0 : widget.radius * 8,
        radius = width / 8.0;
    Color color = widget.color == null ? Colors.pinkAccent : widget.color;
    List<Widget> list = List();

    AnimatedBuilder builder = AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          if (_animationController.value.floor() != tag) {
            tag = _animationController.value.floor().toInt();
            list.clear();
            for (int i = 0; i < 9; i++) {
              double r1 = Random().nextInt(10) % 10 / 10.0;
              r1 = r1 < 0.2 ? 0.2 : r1;
              Positioned p1 = positioned(i, color.withOpacity(r1), radius);
              list.add(p1);
            }
          }
          return Container(
            width: width,
            height: width,
            child: Stack(
              children: list,
            ),
          );
        });
    return builder;
  }

  Positioned positioned(int index, Color color, double radius) {
    Positioned p1 = Positioned(
      left: (index % 3) * 3 * radius,
      top: (index / 3).toInt() * 3 * radius,
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
    return p1;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
