import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EasyBeattingCircles extends StatefulWidget {
  EasyBeattingCircles({Key key, this.color, this.single, this.radius})
      : super(key: key);
  Color color;
  bool single;
  double radius;

  /// 两个跳动的新
  /// single 是否单个
  /// color 颜色
  /// radius 半径
  _EasyBeattingCircles createState() => _EasyBeattingCircles();
}

class _EasyBeattingCircles extends State<EasyBeattingCircles>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
        duration: Duration(seconds: 1),
        lowerBound: 0.0,
        upperBound: 1.0,
        vsync: this)
      ..addStatusListener((state) {
        if (state == AnimationStatus.completed) {
          _animationController.reverse();
        }
        if (state == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      });

    _animationController.forward();
    super.initState();
  }

  double defaultRad = 30;
  @override
  Widget build(BuildContext context) {
    double defaultRadius = 30;
    if (widget.radius != null) defaultRadius = widget.radius;
    defaultRad = defaultRadius;
    return Container(
        width: defaultRadius * 2,
        height: defaultRadius * 2,
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            double line1 =
                sin(_animationController.value * pi / 2) * defaultRad;
            double line2;
            if (widget.single != null && widget.single == true) {
              line2 = null;
            } else {
              line2 = sin(pi / 2 + _animationController.value * pi / 2) *
                  defaultRad;
            }
            return new CustomPaint(
                painter: CirlceBeatPaintet(
                    size: Size(defaultRadius * 2, defaultRadius * 2),
                    circlerad: line1,
                    circlerad2: line2,
                    color: widget.color == null
                        ? Color.fromRGBO(255, 255, 255, 0.5)
                        : widget.color));
          },
        ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class CirlceBeatPaintet extends CustomPainter {
  CirlceBeatPaintet(
      {Key key,
      this.size,
      this.circlerad,
      this.circlerad2,
      @required this.color});
  final Size size;
  final Color color;
  double circlerad, circlerad2;
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint();
    paint.color = this.color == null ? Colors.orangeAccent[50] : color;
    paint.style = PaintingStyle.fill;

    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), circlerad, paint);
    if (circlerad2 != null) {
      canvas.drawCircle(
          Offset(size.width / 2, size.height / 2), circlerad2, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
