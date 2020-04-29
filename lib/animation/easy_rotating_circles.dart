import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EasyRotatingCircles extends StatefulWidget {
  final Color color;
  bool isSmaller;
  bool isLine;

  /// color cirlce 颜色
  /// isSmaller 是否随着转圈而变小
  /// isLine 是否是线性的
  EasyRotatingCircles({Key key, this.color, this.isSmaller, this.isLine})
      : super(key: key);
  _EasyRotatingCircles createState() => _EasyRotatingCircles();
}

class _EasyRotatingCircles extends State<EasyRotatingCircles>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
        duration: Duration(seconds: 1),
        vsync: this,
        lowerBound: 0.0,
        upperBound: 2.0)
      ..repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color color = widget.color == null ? Colors.white : widget.color;
    bool line = widget.isLine == true ? true : false;
    bool isSmaller = widget.isSmaller == true ? true : false;

    AnimatedBuilder an = AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        EasyCirclePaint paint = EasyCirclePaint(
          foregroundColor: color,
          line: line,
          isSmaller: isSmaller,
          offsetCircle: _animationController.value * pi,
        );
        return new CustomPaint(
          painter: paint,
        );
      },
    );
    return Container(
      child: an,
      width: 40,
      height: 40,
    );
  }
}

class EasyCirclePaint extends CustomPainter {
  Color foregroundColor;
  bool isSmaller; //越来越小
  bool line; //线装
  Paint _paint;
  double offsetCircle; //偏移角度
  EasyCirclePaint(
      {this.foregroundColor, this.offsetCircle, this.line, this.isSmaller});

  void init() {
    if (_paint == null) {
      _paint = new Paint();
      _paint.style = PaintingStyle.fill;
      _paint.color = this.foregroundColor == null
          ? Colors.redAccent
          : this.foregroundColor;
    }
  }

  static int radSize = 200, radSize2 = 100, radSize3 = 0;
  int step = 10;
  double sizeLast = 400;
  static bool add = true, add2 = true, add3 = true;
  void updateData() {
    if (add) {
      radSize += step;
    } else {
      radSize -= step;
    }
    if (radSize >= sizeLast) {
      add = false;
    } else if (radSize < 0) {
      add = true;
    }
  }

  void updateData2() {
    if (add2) {
      radSize2 += step;
    } else {
      radSize2 -= step;
    }
    if (radSize2 >= sizeLast) {
      add2 = false;
    } else if (radSize2 < 0) {
      add2 = true;
    }
  }

  void updateData3() {
    if (add3) {
      radSize3 += step;
    } else {
      radSize3 -= step;
    }
    if (radSize3 >= sizeLast) {
      add3 = false;
    } else if (radSize3 < 0) {
      add3 = true;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    init();
    Size defaultSize = size;
    if (size == null) {
      defaultSize = Size(40, 40);
    }

    if (foregroundColor != null) {
      _paint.color = foregroundColor;
    } else {
      _paint.color = Colors.lightBlueAccent;
    }
    Offset offset = Offset(defaultSize.width / 2, defaultSize.height / 2);
    double radius = 5, bigRadius = offset.dx - 2;

    double startangle = offsetCircle, dis = pi / 5;
    if (line) {
      //线装
      radius = 7;
      updateData();
      updateData2();
      updateData3();
      canvas.drawCircle(
          Offset(0, offset.dy), radius * (radSize / sizeLast), _paint);
      canvas.drawCircle(
          Offset(offset.dx, offset.dy), radius * (radSize2 / sizeLast), _paint);
      canvas.drawCircle(Offset(offset.dx * 2, offset.dy),
          radius * (radSize3 / sizeLast), _paint);
    } else {
      if (isSmaller == true) {
        for (int i = 0; i < 8; i++) {
          radius = 5;
          if (i > 3) {
            // 4 5 6 7
            radius = radius * (8.0 - i) / 5.0;
          } else if (i < 3) {
            // 1 2 3
            radius = radius * (i + 1.0) / 5.0;
          }
          canvas.drawCircle(
              Offset((1 - cos(dis * i + startangle)) * bigRadius,
                  (1 - sin(dis * i + startangle)) * bigRadius),
              radius,
              _paint);
        }
      } else {
        for (int i = 0; i < 7; i++) {
          _paint.color = _paint.color.withOpacity(1.0 / 6.0 * i);
          canvas.drawCircle(
              Offset((1 - cos(dis * i + startangle)) * bigRadius,
                  (1 - sin(dis * i + startangle)) * bigRadius),
              radius,
              _paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(EasyCirclePaint oldDelegate) {
    return true;
  }
}
