import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EasySplitBubbles extends StatefulWidget {
  final bool alwaysChangeDir; //总是调换方向
  final Color color; //圆球颜色
  final double radius; //半径
  /// 💧掉落效果 支持随机方向
  /// bool alwaysChangeDir; 总是调换方向
  ///  更多信息见仓库：https://github.com/ifgyong/flutter_easyHub
  EasySplitBubbles({Key key, this.alwaysChangeDir, this.color, this.radius})
      : super(key: key);
  _EasySplitBubbles createState() => _EasySplitBubbles();
}

class _EasySplitBubbles extends State<EasySplitBubbles>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  CurvedAnimation _curvedAnimation;

  double stratrAngle;
  @override
  void initState() {
    stratrAngle = 0.5;
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 1),
        lowerBound: 0,
        upperBound: 1.0)
      ..addStatusListener((s) {
        if (s == AnimationStatus.completed) {
          if (widget.alwaysChangeDir == true) {
            stratrAngle = Random().nextDouble();
            setState(() {});
          }

          _animationController.reset();
          _animationController.forward();
        } else if (s == AnimationStatus.dismissed) {
          if (widget.alwaysChangeDir == true) {
            stratrAngle = Random().nextDouble();
            setState(() {});
          }
          _animationController.reset();
          _animationController.forward();
        }
      })
      ..forward();
    _curvedAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInCirc);
    _animation = new Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_curvedAnimation);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AnimatedBuilder builder = AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Container(
            child: CustomPaint(
              painter: EasySpitBubblesPainter(
                radius: widget.radius == null ? 15 : widget.radius,
                value: _animation.value,
                color: widget.color,
              ),
            ),
            width: 60,
            height: 60,
          );
        });
    return Transform.rotate(
      angle: 2 * pi * this.stratrAngle,
      child: builder,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class EasySpitBubblesPainter extends CustomPainter {
  double radius;
  double value; //移动偏移量
  Color color; //圆球颜色
//  Color sdColor; //水滴颜色

  EasySpitBubblesPainter({Key key, this.radius, this.value, this.color});

  Paint _paint;
  Paint _paintCircle;
  Path _path = Path();
  @override
  void paint(Canvas canvas, Size size) {
    if (_paint == null) {
      _paint = Paint()
        ..color = this.color == null ? Colors.lightBlueAccent : this.color
        ..style = PaintingStyle.fill
        ..strokeWidth = 4.0;
    }
    if (_paintCircle == null) {
      _paintCircle = Paint()
        ..color = this.color == null ? Colors.lightBlueAccent : this.color
        ..style = PaintingStyle.fill
        ..strokeWidth = 2.0;
    }
    if (size == null) {
      size = Size(100, 100);
    }

    _path.addArc(Rect.fromLTWH(0, 0, size.width, size.height), 0, pi * 2);
    canvas.clipPath(_path); //
    //圆圈半径
    double r = this.radius == null ? 15 : this.radius;
    //倾斜一个角度
    // 45 °
    double qx = 0.5 * pi;
    double r2 = r / 2.0;

    Offset pr1 = Offset(size.width / 2, size.height / 2);
    _path.reset();
    canvas.save();
    canvas.restore();

//    double disTwoCircle = 20;
    double disTwoCircle = this.value == null ? 50 : this.value * 200;

    double x1 = pr1.dx + (cos(qx) * disTwoCircle) + r2 * (cos(qx));
    double y1 = pr1.dy - disTwoCircle * sin(qx) - (r2 * sin(qx));

    Offset p2r = Offset(x1, y1);
    double twoCircleDis =
        sqrt(pow(pr1.dx - p2r.dx, 2) + pow(pr1.dy - p2r.dy, 2)); //两个球心距离

    canvas.drawCircle(pr1, r, _paint); //绘画2个圆圈
    canvas.drawCircle(p2r, r2, _paint);
    //贝塞尔取消的控制点的 位移
    double dis = (twoCircleDis - r - r2) / r2 * r2;

    double c1x = twoCircleDis * 2;
    //角 x
    double x = asin(r / c1x);
    // 夹角
    double nowDown = qx;
    while (nowDown > pi / 2) {
      nowDown -= pi / 2;
    }
    double lastJ = pi / 2 - x - nowDown;

//大圆的切线点
    Offset p1 = Offset(pr1.dx - r * cos(x), pr1.dy - r * sin(x));
//    小圆切线点
    Offset p3;
    // 中间斜线的 中心
    Offset halfCenter, p1center;
    if (qx == 0.5 * pi) {
      p1 = Offset(pr1.dx - r, pr1.dy);
      p3 = Offset(p2r.dx - r2, p2r.dy);

      halfCenter = Offset((p1.dx + p3.dx) * 0.5, (p1.dy + p3.dy) * 0.5);
      if (dis < 0) dis = 0;
      p1center = Offset(halfCenter.dx + dis, halfCenter.dy);
    } else if (qx >= 0 && qx <= 0.5 * pi) {
      p1 = Offset(pr1.dx - r * cos(lastJ), pr1.dy - r * sin(lastJ));
      p3 = Offset(p2r.dx - r2 * cos(lastJ), p2r.dy - (r2 * sin(lastJ)));

      // 中间斜线的 中心
      double minCos = cos(lastJ) > 0 ? cos(lastJ) : -cos(lastJ);
      double minSin = sin(lastJ) > 0 ? sin(lastJ) : -sin(lastJ);
      halfCenter = Offset((p1.dx + p3.dx) * 0.5, (p1.dy + p3.dy) * 0.5);
      p1center =
          Offset(halfCenter.dx + dis * minCos, halfCenter.dy - minSin * dis);
    } else if (qx <= 1.0 * pi) {
      p1 = Offset(pr1.dx - r * cos(lastJ), pr1.dy + r * sin(lastJ));
      p3 = Offset(p2r.dx - r2 * cos(lastJ), p2r.dy + (r2 * sin(lastJ)));
      // 中间斜线的 中心
      halfCenter = Offset((p1.dx + p3.dx) * 0.5, (p1.dy + p3.dy) * 0.5);
      double min = cos(lastJ) < 0 ? 0 : cos(lastJ);
      double minSin = sin(lastJ) < 0 ? 0 : sin(lastJ);
      p1center =
          Offset(halfCenter.dx + dis * min, halfCenter.dy - dis * minSin);
    } else if (qx <= 1.5 * pi) {
      p1 = Offset(pr1.dx - r * cos(lastJ), pr1.dy - r * sin(lastJ));
      p3 = Offset(p2r.dx - r2 * cos(lastJ), p2r.dy - (r2 * sin(lastJ)));
      // 中间斜线的 中心
      halfCenter = Offset((p1.dx + p3.dx) * 0.5, (p1.dy + p3.dy) * 0.5);
      double min = cos(lastJ) < 0 ? 0 : cos(lastJ);
      double minSin = sin(lastJ) < 0 ? 0 : sin(lastJ);
      p1center =
          Offset(halfCenter.dx + dis * min, halfCenter.dy + dis * minSin);
    } else if (qx <= 2 * pi) {
      p1 = Offset(pr1.dx - r * cos(lastJ), pr1.dy + r * sin(lastJ));
      p3 = Offset(p2r.dx - r2 * cos(lastJ), p2r.dy + (r2 * sin(lastJ)));
      // 中间斜线的 中心
      halfCenter = Offset((p1.dx + p3.dx) * 0.5, (p1.dy + p3.dy) * 0.5);
      double min = cos(lastJ) < 0 ? 0 : cos(lastJ);
      double minSin = sin(lastJ) < 0 ? 0 : sin(lastJ);
      p1center =
          Offset(halfCenter.dx + dis * min, halfCenter.dy - dis * minSin);
    }

    _path.moveTo(p1.dx, p1.dy);
    //贝塞尔曲线 从p1到p3，控制点是 p1_center
    _path.cubicTo(
        p1center.dx, p1center.dy, p1center.dx, p1center.dy, p3.dx, p3.dy);

    Offset p11 = Offset(pr1.dx + r * cos(x), pr1.dy - r * sin(x));
    Offset p33;
    // 中间斜线的 中心
    Offset half2Center;
    Offset p2Center; //右边斜线的中间的点
    if (qx == 0.5 * pi) {
      p11 = Offset(pr1.dx + r, pr1.dy);
      p33 = Offset(p2r.dx + r2, p2r.dy);
      // 中间斜线的 中心
//      double minCos = cos(lastJ) > 0 ? cos(lastJ) : -cos(lastJ);
//      double minSin = sin(lastJ) > 0 ? sin(lastJ) : -sin(lastJ);

      half2Center = Offset((p11.dx + p33.dx) * 0.5, (p11.dy + p33.dy) * 0.5);
      p2Center = Offset(half2Center.dx - dis, half2Center.dy);
    } else if (qx >= 0 && qx <= 0.5 * pi) {
      p11 = Offset(pr1.dx + r * cos(lastJ), pr1.dy + r * sin(lastJ));
      p33 = Offset(p2r.dx + r2 * cos(lastJ), p2r.dy + (r2 * sin(lastJ)));
      // 中间斜线的 中心
      double minCos = cos(lastJ) > 0 ? cos(lastJ) : -cos(lastJ);
      double minSin = sin(lastJ) > 0 ? sin(lastJ) : -sin(lastJ);

      half2Center = Offset((p11.dx + p33.dx) * 0.5, (p11.dy + p33.dy) * 0.5);
      p2Center =
          Offset(half2Center.dx - dis * minCos, half2Center.dy - minSin * dis);
    } else if (qx <= 1 * pi) {
      p11 = Offset(pr1.dx + r * cos(lastJ), pr1.dy - r * sin(lastJ));
      p33 = Offset(p2r.dx + r2 * cos(lastJ), p2r.dy - (r2 * sin(lastJ)));
      // 中间斜线的 中心
      double minCos = cos(lastJ) > 0 ? cos(lastJ) : 0;
      double minSin = sin(lastJ) > 0 ? sin(lastJ) : 0;

      half2Center = Offset((p11.dx + p33.dx) * 0.5, (p11.dy + p33.dy) * 0.5);
      p2Center =
          Offset(half2Center.dx - dis * minCos, half2Center.dy + minSin * dis);
    } else if (qx <= 1.5 * pi) {
      p11 = Offset(pr1.dx + r * cos(lastJ), pr1.dy + r * sin(lastJ));
      p33 = Offset(p2r.dx + r2 * cos(lastJ), p2r.dy + (r2 * sin(lastJ)));
      // 中间斜线的 中心
      double minCos = cos(lastJ) > 0 ? cos(lastJ) : 0;
      double minSin = sin(lastJ) > 0 ? sin(lastJ) : 0;

      half2Center = Offset((p11.dx + p33.dx) * 0.5, (p11.dy + p33.dy) * 0.5);
      p2Center =
          Offset(half2Center.dx - dis * minCos, half2Center.dy + minSin * dis);
    } else if (qx <= 2 * pi) {
      p11 = Offset(pr1.dx + r * cos(lastJ), pr1.dy - r * sin(lastJ));
      p33 = Offset(p2r.dx + r2 * cos(lastJ), p2r.dy - (r2 * sin(lastJ)));
      // 中间斜线的 中心
      double minCos = cos(lastJ) > 0 ? cos(lastJ) : 0;
      double minSin = sin(lastJ) > 0 ? sin(lastJ) : 0;

      half2Center = Offset((p11.dx + p33.dx) * 0.5, (p11.dy + p33.dy) * 0.5);
      p2Center =
          Offset(half2Center.dx - dis * minCos, half2Center.dy + minSin * dis);
    }

    _path.lineTo(p33.dx, p33.dy);
    if (p2Center.dx < p1center.dx) return; //交叉则取消
//贝塞尔曲线 从p33到p11，控制点是 p2_center
    _path.cubicTo(
        p2Center.dx, p2Center.dy, p2Center.dx, p2Center.dy, p11.dx, p11.dy);
    _path.moveTo(p11.dx, p11.dy);
    _path.lineTo(p1.dx, p1.dy);

    _path.close();

    canvas.drawPath(_path, _paintCircle);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
