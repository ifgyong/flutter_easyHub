import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum EasyCustomCirclePainterType {
  Easy_custom, //自定义进度 开始 结束弧度 和文字
  Easy_progeress, //进度条
  Easy_startAndEnd, //开始和结束都移动
}

class EasyCustomCirclePainter extends CustomPainter {
  double value;
  double startAngle;
  double endAndle;
  Color backgroundColor;
  Color foregroundColor;

  EasyCustomCirclePainterType type;

  double startToEndAngle; //只有在 start and end 才个管用

  Paint _paint; //前景
  Paint _paintBack; //背景

  EasyCustomCirclePainter(
      {@required this.startAngle,
      @required this.endAndle,
      this.backgroundColor,
      this.foregroundColor,
      this.value,
      this.type,
      this.startToEndAngle});

  void init() {
    if (_paint == null) {
      _paint = new Paint();
      _paint.style = PaintingStyle.stroke;
      _paint.strokeCap = StrokeCap.round;
      _paint.strokeWidth = 8.0;
    }
    if (_paintBack == null) {
      _paintBack = bgPaint();
    }
    _paint.color =
        this.foregroundColor == null ? Colors.redAccent : this.foregroundColor;
    if (this.backgroundColor != null) {
      this.backgroundColor = this.backgroundColor;
    }
    _paintBack.color = this.backgroundColor;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double start = pi * 2 * startAngle;
    double end = pi / 10 * 2;
    init();

    Size defaultSize = size;
    if (size == null) {
      defaultSize = Size(100, 100);
    }

    switch (type) {
      case EasyCustomCirclePainterType.Easy_custom:
        start = pi * 2 * startAngle;

        assert(value != null, 'value is null');
        end = pi * 2 * value; //开始和结束都有的
        break;
      case EasyCustomCirclePainterType.Easy_progeress: // done
        assert(value != null, 'value is null');

        start = pi * 2 * 0.25;
        end = pi * 2 * value;
        break;
      case EasyCustomCirclePainterType.Easy_startAndEnd: //done
        assert(startAngle != null, 'startAngle is null');

        start = pi * 2 * startAngle;
        end = pi / 10 * 2;
        if (this.startToEndAngle != null &&
            startToEndAngle > 0 &&
            startToEndAngle <= 1) {
          end = pi * 2 * startToEndAngle;
        }
        break;
    }
    canvas.drawArc(Rect.fromLTWH(0, 0, defaultSize.width, defaultSize.height),
        start, pi * 2, false, _paintBack);
    canvas.drawArc(Rect.fromLTWH(0, 0, defaultSize.width, defaultSize.height),
        start, end, false, _paint);
  }

  Paint bgPaint() {
    Paint paint = new Paint()
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    return paint;
  }

  @override
  bool shouldRepaint(EasyCustomCirclePainter oldDelegate) {
    bool repain = startAngle != oldDelegate.startAngle ||
        endAndle != oldDelegate.endAndle ||
        value != oldDelegate.value;
    return repain;
  }
}
