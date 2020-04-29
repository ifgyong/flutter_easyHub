import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum EasyWalkDirection {
  top,
  right,
  bottom,
  left,
}

class EasyRotatingTwoRect extends StatefulWidget {
  final List<Color> colors;
  final double width;

  /// 追逐的矩形
  /// List 矩形的颜色 最好设置2个颜色
  /// width 矩形宽度
  EasyRotatingTwoRect({Key key, this.colors, this.width}) : super(key: key);
  _EasyRotatingTwoRect createState() => _EasyRotatingTwoRect();
}

class _EasyRotatingTwoRect extends State<EasyRotatingTwoRect>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 600),
        lowerBound: 0.5,
        upperBound: 1.0)
      ..addStatusListener((state) {
        if (state == AnimationStatus.completed) {
          Future.delayed(Duration(milliseconds: 0)).then((_) {
            _animationController.reverse();
          });
        }
        if (state == AnimationStatus.dismissed) {
          _animationController.forward();
        }
        ;
      })
      ..forward();
    super.initState();
  }

  bool stop = false;
  double top1 = 0, left1 = 0;
  double top2 = 0, left2 = 30;
  EasyWalkDirection d1 = EasyWalkDirection.right;
  EasyWalkDirection d2 = EasyWalkDirection.bottom;

  double maxXY = 30.0;

  void update() {
    if (stop) {
      _animationController.stop();
      Future.delayed(Duration(milliseconds: 200)).then((_) {
        _animationController.reverse();
        stop = false;
      });
      return;
    }
    List ret1 = updateData(d1, top1, left1);
    d1 = ret1[0];
    top1 = ret1[1];
    left1 = ret1[2];
    List ret2 = updateData(d2, top2, left2);
    d2 = ret2[0];
    top2 = ret2[1];
    left2 = ret2[2];
  }

  List updateData(EasyWalkDirection d, double top, double left) {
    double v = _animationController.value * 2;
    maxXY = widget.width == null ? 30 : widget.width * 3.0 / 4.0;
    switch (d) {
      case EasyWalkDirection.top:
        left = 0;
        top = maxXY * (v - 1); //[2-->1]
        if (top <= 0) {
          top = 0;
          d = EasyWalkDirection.right;
          stop = true;
        }
        break;
      case EasyWalkDirection.right:
        top = 0;
        left = maxXY * (v - 1); //[1-->2]
        if (left >= maxXY) {
          d = EasyWalkDirection.bottom;
          stop = true;
        }
        break;
      case EasyWalkDirection.bottom:
        left = maxXY;
        top = maxXY * (2 - v); //[2 --> 1]
        if (top >= maxXY) {
          d = EasyWalkDirection.left;
          stop = true;
        }
        break;
      case EasyWalkDirection.left:
        top = maxXY;
        left = maxXY * (2 - v); //[1-->2]
        if (left == 0) {
          stop = true;

          d = EasyWalkDirection.top;
        }
        break;
    }
    List list = List()..add(d)..add(top)..add(left);
    return list;
  }

  @override
  Widget build(BuildContext context) {
    double wd = widget.width == null ? 40 : widget.width;
    return Container(
      width: wd,
      height: wd,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          double anlge = pi * _animationController.value;
          Matrix4 m1 = Matrix4.rotationZ(anlge);
          m1.setTranslationRaw(left1, top1, 0);
          m1.scale(_animationController.value);

          Matrix4 m2 = Matrix4.rotationZ(anlge);
          m2.setTranslationRaw(left2, top2, 0);
          m2.scale(_animationController.value);

          Color color1 = Colors.lightGreen;
          if (widget.colors != null && widget.colors.length > 0) {
            color1 = widget.colors[0];
          }
          Color color2 = Colors.lightGreen;
          if (widget.colors != null && widget.colors.length > 1) {
            color2 = widget.colors[1];
          }

          List<Widget> list = List();
          update();
          double width = 12;
          if (widget.width != null) {
            width = widget.width / 4.0;
          }
          Positioned ts = new Positioned(
            top: 0,
            left: 0,
            width: width,
            height: width,
            child: Transform(
              transform: m1,
              alignment: Alignment.center,
              child: Container(
                width: width,
                height: width,
                color: color1,
              ),
            ),
          );
          list.add(ts);
          Positioned ts2 = new Positioned(
            top: 0,
            left: 0,
            width: width,
            height: width,
            child: Transform(
              transform: m2,
              alignment: Alignment.center,
              child: Container(
                width: width,
                height: width,
                color: color2,
              ),
            ),
          );
          list.add(ts2);

          return Stack(
            children: list,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
