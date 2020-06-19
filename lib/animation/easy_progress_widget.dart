import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'easy_custom_painter.dart';

class EasyProgressWidget extends ProgressIndicator {
  final EasyCustomCirclePainterType type;

  /// 自定义进度条
  /// type 类型
  ///  更多信息见仓库：https://github.com/ifgyong/flutter_easyHub
  EasyProgressWidget(
      {Key key,
      double value,
      Color backgroundColor,
      Animation<Color> valueColor,
      String semanticsLabel,
      String semanticsValue,
      this.type})
      : super(
          key: key,
          value: value,
          backgroundColor: backgroundColor,
          valueColor: valueColor,
          semanticsLabel: semanticsLabel,
          semanticsValue: semanticsValue,
        );
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
      case EasyCustomCirclePainterType.custom:
        return animateBuildEasyInEasyOut(widget.type, valueChange: true);
        break;
      case EasyCustomCirclePainterType.progress:
        return animateBuildEasyInEasyOut(widget.type, valueChange: false);
        break;
      case EasyCustomCirclePainterType.startAndEnd:
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
            type == EasyCustomCirclePainterType.progress
                ? '${(val * 100).floorToDouble()} %'
                : '',
            style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.none,
                fontSize: 15),
          ),
        );
        Color fore =
            widget.valueColor == null ? Colors.blue : widget.valueColor.value;
        Color bgColor = widget.backgroundColor == null
            ? Colors.white
            : widget.backgroundColor;
        return new CustomPaint(
          size: Size(60, 60),
          foregroundPainter: EasyCustomCirclePainter(
              startAngle: startAngle,
              endAngle: sin(startAngle * pi),
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
