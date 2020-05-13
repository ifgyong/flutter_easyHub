import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EasyCreepingBug extends StatefulWidget {
  double radius; //小球半径
  List<Color> colors; //颜色 只能3个颜色

  /// 跳动的虫子
  /// double radius; //小球半径
  /// Color color;//颜色
  ///  更多信息见仓库：https://github.com/ifgyong/flutter_easyHub

  EasyCreepingBug({Key key, this.radius, this.colors}) : super(key: key);
  _EasyCreepingBug createState() => _EasyCreepingBug();
}

class _EasyCreepingBug extends State<EasyCreepingBug>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  int tag = 0;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1200),
        lowerBound: 0,
        upperBound: 1.0)
      ..addStatusListener((s) {
        if (s == AnimationStatus.completed) {
          _animationController.reset();
          _animationController.forward();
        } else if (s == AnimationStatus.dismissed) {
          tag += 1;
          tag %= 2;
          _animationController.reset();
          _animationController.forward();
        }
      })
      ..forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double radius = widget.radius == null ? 50 : widget.radius;
    AnimatedBuilder animatedBuilder = AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            width: radius * 2,
            height: radius * 2,
            child: CustomPaint(
              painter: _CreepingBugPainter(
                  value: _animationController.value,
                  tag: tag,
                  colors: widget.colors),
              size: Size(radius * 2, radius * 2),
            ),
          );
        });
    return animatedBuilder;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class _CreepingBugPainter extends CustomPainter {
  double value;
  int tag;
  Path p = Path();
  Paint _paint;
  Paint _paint2;
  Paint _paint3;
  List<Color> colors;
  _CreepingBugPainter({this.value, this.tag, this.colors});
  @override
  void paint(Canvas canvas, Size size) {
    Color c1 = this.colors == null || this.colors.length != 3
        ? Colors.orange
        : this.colors[0];
    Color c2 = this.colors == null || this.colors.length != 3
        ? Colors.redAccent
        : this.colors[0];
    Color c3 = this.colors == null || this.colors.length != 3
        ? Colors.lightBlue
        : this.colors[0];

    if (_paint == null) {
      _paint = Paint()
        ..color = c1
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 8.0;
    }
    if (_paint2 == null) {
      _paint2 = Paint()
        ..color = c2
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 8.0;
    }

    if (_paint3 == null) {
      _paint3 = Paint()
        ..color = c3
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 8.0;
    }
    if (tag == 0) {
      _paint.color = c1;
      _paint3.color = c3;
    } else {
      _paint.color = c3;
      _paint3.color = c1;
    }

    Rect rect = Rect.fromLTWH(
        -size.width * value + size.width / 2, 0, size.width, size.height);
    if (value > 0.5) {
      // 0.0 --> 1.0
      double start = (value - 0.5) * 2 * pi + pi;
      double dis = (1 - value) * 2 * pi / 3;
      canvas.drawArc(rect, start, dis, false, _paint);
      canvas.drawArc(rect, start + dis, dis, false, _paint2);
      canvas.drawArc(rect, start + 2 * dis, dis, false, _paint3);
    } else {
      double start1 = pi, dis = (value * 2) * pi / 3;
      canvas.drawArc(rect, start1, dis, false, _paint);
      canvas.drawArc(rect, start1 + dis, dis, false, _paint2);
      canvas.drawArc(rect, start1 + 2 * dis, dis, false, _paint3);
    }
  }

  @override
  bool shouldRepaint(_CreepingBugPainter oldDelegate) {
    return oldDelegate.value != this.value;
  }
}
