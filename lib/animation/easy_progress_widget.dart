import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'easy_custom_painter.dart';

class EasyProgressWidget extends StatefulWidget {
  double value;
  Color backgroundColor;
  Color circlebackgroundColor;
  Color circleForegroundColor;
  EasyCustomCirclePainterType type;

  /// 自定义进度条
  /// value 值
  /// backgroundColor 背景
  /// circleForegroundColor 前景
  /// type 类型
  EasyProgressWidget(
      {Key key,
      this.value,
      this.circlebackgroundColor,
      this.circleForegroundColor,
      this.backgroundColor,
      @required this.type})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _EasyProgressWidget();
  }
}

class _EasyProgressWidget extends State<EasyProgressWidget>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case EasyCustomCirclePainterType.Easy_custom:
        return animateBuildEasyInEasyOut(widget.type, valueChange: true);
        break;
      case EasyCustomCirclePainterType.Easy_progeress:
        return animateBuildEasyInEasyOut(widget.type, valueChange: false);
        break;
      case EasyCustomCirclePainterType.Easy_startAndEnd:
        return animateBuildEasyInEasyOut(widget.type, valueChange: false);
        break;
      default:
        break;
    }
    return animateBuildEasyInEasyOut(widget.type, valueChange: false);
  }

  AnimationController _controller;
  double startAngle = 0, endAngle = 20;

  bool add = true;
  @override
  void initState() {
    super.initState();
    _controller =
        new AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..repeat();
  }

  Widget animateBuildEasyInEasyOut(EasyCustomCirclePainterType type,
      {bool valueChange}) {
    double val = widget.value;
    double addStart = 0.01, valueAdd = 0.02, speed = 0.015;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        if (val > 1) {
          add = false;
        } else if (val < 0) {
          add = true;
        }
        if (add) {
          val += valueAdd;
          startAngle += addStart;
        } else {
          startAngle += (addStart + speed);
          val -= (valueAdd / 2 + speed / 2);
        }
//        如果不改变value 则是固定长度大小
        if (valueChange == false) {
          val = widget.value;
        }
        Widget textWidget = Container(
          alignment: Alignment.center,
          width: 60,
          height: 60,
          child: Text(
            type == EasyCustomCirclePainterType.Easy_progeress
                ? '${(val * 100).floorToDouble()} %'
                : '',
            style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.none,
                fontSize: 15),
          ),
        );
        Color fore = widget.circleForegroundColor == null
            ? Colors.blue
            : widget.circleForegroundColor;
        Color bgColor = widget.circlebackgroundColor == null
            ? Colors.white
            : widget.circlebackgroundColor;
        return new CustomPaint(
          size: Size(60, 60),
          foregroundPainter: EasyCustomCirclePainter(
              startAngle: startAngle,
              endAndle: sin(startAngle * pi),
              foregroundColor: fore,
              backgroundColor: bgColor,
              type: type,
              startToEndAngle: 0.1,
              value: val),
          child: textWidget,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
