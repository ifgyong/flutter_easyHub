import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EasyMovingCube extends StatefulWidget {
  double width; //正方形边长
  Color topColor; //正方体顶部颜色
  Color leftColor; //正方体侧边颜色

  ///   移动的散列正方体
  ///   double width; //正方形边长
  ///   Color topColor; //正方体顶部颜色
  ///  Color leftColor; //正方体侧边颜色
  ///  动画效果 http://blog.fgyong.cn/15889160117.GIF
  ///  仓库：https://github.com/ifgyong/flutter_easyHub
  EasyMovingCube({Key key, this.width, this.topColor, this.leftColor})
      : super(key: key);
  _EasyMovingCube createState() => _EasyMovingCube();
}

class _EasyMovingCube extends State<EasyMovingCube>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

//  CurvedAnimation _curvedAnimation;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 700),
        lowerBound: 0,
        upperBound: 1.0)
      ..repeat();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = widget.width == null ? 40 : widget.width;

    AnimatedBuilder builder = AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        double value = _animationController.value;
        Positioned positioned1 = getCube(width, 0,
            value: value,
            topColor: widget.topColor,
            leftColor: widget.leftColor);
        Positioned positioned2 = getCube(width, 1,
            value: value,
            topColor: widget.topColor,
            leftColor: widget.leftColor);
        Positioned positioned3 = getCube(width, 2,
            value: value,
            topColor: widget.topColor,
            leftColor: widget.leftColor);
        Positioned positioned4 = getCube(width, 3,
            value: value,
            topColor: widget.topColor,
            leftColor: widget.leftColor);

        return Container(
          alignment: Alignment.center,
          width: width * 3,
          height: width * 4,
//          color: Colors.white,
          child: Stack(
            children: [positioned1, positioned2, positioned3, positioned4],
          ),
        );
      },
    );
    return builder;
  }

  Positioned getCube(
    double width,
    int index, {
    double pad,
    double value,
    Color topColor,
    Color leftColor,
  }) {
    List<Widget> list1 = new List();
    double height = width * 0.4;
    pad = pad == null ? 0 : pad;
    value = value == null ? 0 : value;

    double toLeft = 0.0;
    bool now_to_left = true;
    if (value <= 0.5) {
      toLeft = value * 2;
      now_to_left = true;
    } else {
      now_to_left = false;
      toLeft = (value - 0.5) * 2;
    }
//    toLeft = 0.5;  调试数据
//    now_to_left = true; //是否正在向左上运动
    double left, top, x = 0, y = 0;
    double dx = toLeft, dy = 0.5 * toLeft;

    switch (index) {
      case 0:
        left = 0;
        top = 0;
        if (now_to_left) {
          x = width * dx;
          y = 0;
        } else {
          x = width + height * dx;
          y = height * dx;
        }

        break;
      case 1:
        left = pad;
        top = pad;
        if (now_to_left) {
          x = 0;
          y = 0;
        } else {
          x = height * dx;
          y = height * dx;
        }
        x += width * (1) + height;
        y += height;
        break;
      case 2:
        left = 0;
        top = pad;
        if (now_to_left) {
          x = 0;
          y = 0;
        } else {
          x = -height * dx;
          y = -height * dx;
        }
        x += height;
        y += height;
        break;
      case 3:
        left = pad;
        top = pad;
        if (now_to_left) {
          //向左移动
          x = -width * dx;
          y = 0;
        } else {
          y = -height * dx;
          x = -width - height * dx;
        }
        x += (width + height * 2);
        y += (height + height);
        break;
    }
    topColor = topColor == null ? Color.fromRGBO(254, 208, 61, 1) : topColor;
    leftColor = leftColor == null ? Color.fromRGBO(222, 146, 34, 1) : leftColor;

    Transform ts1 = Transform(
      transform: Matrix4.skewX(0.25 * pi)..setTranslationRaw(x, y, 0),
      child: Container(
        width: width,
        height: height,
        color: topColor,
        alignment: Alignment.center,
//        child: Text('$index'),
      ),
    );
    list1.add(ts1);
    Transform ts1_back = Transform(
      transform: Matrix4.skewX(0.25 * pi)
        ..setTranslationRaw(x, y + width * 3, 0),
      child: Container(
        width: width,
        height: height,
        color: Color.fromRGBO(211, 211, 211, 1),
      ),
    );
    list1.add(ts1_back);
    Transform ts1_left = Transform(
      transform: Matrix4.skewY(0.25 * pi)..setTranslationRaw(x, y, 0),
      child: Container(
        width: height,
        height: width,
        color: leftColor,
      ),
    );
    list1.add(ts1_left);
    Transform ts1_font = Transform(
      transform: Matrix4.identity()..setTranslationRaw(x, y, 0),
      child: Container(
        margin: EdgeInsets.only(left: height, top: height),
        width: width,
        height: width,
        color: leftColor,
      ),
    );
    list1.add(ts1_font);

    Positioned positioned1 = Positioned(
      child: Stack(
        children: list1,
      ),
      left: left,
      top: top,
    );
    return positioned1;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
