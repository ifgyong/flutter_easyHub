import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EasyPendulumBall extends StatefulWidget {
  final double radius; //小球半径
  final Color color; //默认颜色 单色
  final List<Color> colors; // 渐变色 如果stops 有值必须和colors长度相等
  final List<double> stops; //shader 的 每个颜色的范围 ，每个值在0.0和1.0之间
  /// 钟摆的小球
  /// double radius; //小球半径
  /// Color color; //默认颜色 单色
  /// List<Color> colors; // 渐变色 如果stops 有值必须和colors长度相等
  /// List<double> stops; //shader 的 每个颜色的范围 ，每个值在0.0和1.0之间
  ///  更多信息见仓库：https://github.com/ifgyong/flutter_easyHub

  EasyPendulumBall({Key key, this.radius, this.color, this.colors, this.stops})
      : super(key: key);
  _EasyPendulumBall createState() => _EasyPendulumBall();
}

class _EasyPendulumBall extends State<EasyPendulumBall>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  CurvedAnimation _curvedAnimation;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1000),
        lowerBound: 0,
        upperBound: 1.0)
      ..addStatusListener((s) {
        if (s == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (s == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      })
      ..forward();
    _curvedAnimation = new CurvedAnimation(
        parent: _animationController, curve: Curves.easeInOut);
    _animation = new Tween(begin: 0.0, end: 1.0).animate(_curvedAnimation);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double radius = widget.radius == null ? 8 : widget.radius;

    AnimatedBuilder builder = AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: EasySwingingBallPainter(
              color: widget.color == null ? Colors.lightBlue : widget.color,
              radius: radius,
              value: _animation.value,
              colors: widget.colors,
              stops: widget.stops),
          size: Size(20, 20),
        );
      },
    );
    return Container(
//      color: Colors.lightBlue,
      width: radius * 28,
      height: radius * 6,
      child: builder,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animation = null;
    _curvedAnimation = null;
    _animationController = null;
    super.dispose();
  }
}

class EasySwingingBallPainter extends CustomPainter {
  Paint _paint;
  Color color; //有colors 则无效
  final List<Color> colors; // 渐变色 如果stops 有值必须和colors长度相等
  final List<double> stops; //shader 的 每个颜色的范围 ，每个值在0.0和1.0之间
  double radius;
  double value;
  EasySwingingBallPainter(
      {this.color, this.radius, this.value, this.stops, this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    if (_paint == null) {
      _paint = Paint();
      _paint.style = PaintingStyle.fill;
      _paint.color = color == null ? Colors.black12 : color;
    }
    double y = radius * 5, x = radius * 14;
    Gradient gradient;
    if (colors != null) {
      gradient = LinearGradient(colors: colors, stops: stops);
      _paint.shader =
          gradient.createShader(Rect.fromLTWH(0, 0, radius * 28, radius * 6));
    }

    double x1 = x - radius * 3;
    double x2 = x - radius;
    double x3 = x + radius;
    double x4 = x + radius * 3;

    double xl = (x - radius * 5);
    double yl = y;
    if (value < 0.5) {
      value *= 0.75;
      value += 0.125; // 0.175-->0.5
      xl -= (radius * 5) * cos(value * pi);
      yl *= sin(pi * value);
    }
    double xr = (x + radius * 5);
    double yr = y;
    if (value >= 0.5) {
      value -= 0.5;
      value *= 0.75; //0π--0.375π
      //0.5 -- 0.875
      xr += (radius * 5) * sin((value + 0.125) * pi);
//弧度结束的 0.5π--0.875π
      yr *= sin((value + 0.5) * pi);
    }
    canvas.drawCircle(Offset(x1, y), radius, _paint);
    canvas.drawCircle(Offset(x2, y), radius, _paint);
    canvas.drawCircle(Offset(x3, y), radius, _paint);
    canvas.drawCircle(Offset(x4, y), radius, _paint);
    canvas.drawCircle(Offset(xl, yl), radius, _paint);
    canvas.drawCircle(Offset(xr, yr), radius, _paint);
  }

  @override
  bool shouldRepaint(EasySwingingBallPainter oldDelegate) {
    return this.value != oldDelegate.value;
  }
}
