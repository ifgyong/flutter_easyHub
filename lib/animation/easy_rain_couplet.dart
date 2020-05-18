import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EasyRainCouplet extends StatefulWidget {
  Color color; //圆球颜色
  double cycle; //周期 默认0.15  取值范围0--1.0
  /// 💧掉落效果 支持随机方向
  /// double cycle; //周期 默认0.15  取值范围0--1.0
  ///  更多信息见仓库：https://github.com/ifgyong/flutter_easyHub
  EasyRainCouplet({Key key, this.color, this.cycle}) : super(key: key);
  _EasyRainCouplet2 createState() => _EasyRainCouplet2();
}

class _EasyRainCouplet2 extends State<EasyRainCouplet>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  CurvedAnimation _curvedAnimation;
  bool _change = false;
  @override
  void initState() {
    _change = false;
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 2),
        lowerBound: 0.0,
        upperBound: 1.0)
      ..addStatusListener((s) {
        if (s == AnimationStatus.completed) {
          _animationController.reset();
          _animationController.forward();
        } else if (s == AnimationStatus.dismissed) {
          _change = _change ? false : true;
          _animationController.reset();
          _animationController.forward();
        }
      });
    _animationController.forward();
    _curvedAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.slowMiddle);
    _animation = new Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_curvedAnimation);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double dis = 0.2 * pi;

    AnimatedBuilder builder = AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          if (widget.cycle != null && widget.cycle > 0 && widget.cycle <= 1.0) {
            dis = widget.cycle;
          }
          double v = _animationController.value;

          double v1 = sin(v * 2 * pi);
          double v2 = sin(v * 2 * pi + dis);

          double v3 = sin(v * 2 * pi + dis * 2);
          double v4 = sin(v * 2 * pi + dis * 3);
          double v5 = sin(v * 2 * pi + dis * 4);

          double v6 = sin(v * 2 * pi + dis * 5);

          Container c1 = getContainer(v1, v1 > 0 ? 1 * pi : 0);
          Container c2 = getContainer(v2, v2 > 0 ? 1 * pi : 0);
          Container c3 = getContainer(v3, v3 > 0 ? 1 * pi : 0);
          Container c4 = getContainer(v4, v4 > 0 ? 1 * pi : 0);
          Container c5 = getContainer(v5, v5 > 0 ? 1 * pi : 0);
          Container c6 = getContainer(v6, v6 > 0 ? 1 * pi : 0);
          return Container(
              width: 162,
              alignment: Alignment.center,
              height: 80,
              child: Row(
                children: <Widget>[c1, c2, c3, c4, c5, c6],
              ));
        });

    return Container(child: builder);
  }

  Container getContainer(double v, double truns) {
    v = v.abs();

    Container c3 = Container(
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..setRotationZ(truns),
        child: CustomPaint(
          painter: EasyRainCoupletPainter(
            radius: 6,
            value: v,
            color: widget.color,
          ),
        ),
      ),
      width: 150 / 6.0,
      height: 100,
    );
    return c3;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class EasyRainCoupletPainter extends CustomPainter {
  double radius;
  double value; //移动偏移量
  Color color; //圆球颜色

  EasyRainCoupletPainter({Key key, this.radius, this.value, this.color});

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

    Offset p_r1 = Offset(size.width / 2, size.height / 2);
    _path.reset();
    canvas.save();
    canvas.restore();
    double disTwoCircle = this.value == null ? 30 : (this.value * 30.0);
    double x1 = p_r1.dx + (cos(qx) * disTwoCircle) + r2 * (cos(qx));
    double y1 = p_r1.dy - disTwoCircle * sin(qx) - (r2 * sin(qx));

    Offset p2_r = Offset(x1, y1);
    double twoCircleDis =
        sqrt(pow(p_r1.dx - p2_r.dx, 2) + pow(p_r1.dy - p2_r.dy, 2)); //两个球心距离

    canvas.drawCircle(p_r1, r, _paint); //绘画2个圆圈
    canvas.drawCircle(p2_r, r2, _paint);
    //贝塞尔取消的控制点的 位移
    double dis = (twoCircleDis - r - r2) / r2 * r2;

    double c1_x = twoCircleDis * 2;
    //角 x
    double x = asin(r / c1_x);
    // 夹角
    double now_down = qx;
    while (now_down > pi / 2) {
      now_down -= pi / 2;
    }
    double lastJ = pi / 2 - x - now_down;

//大圆的切线点
    Offset p1 = Offset(p_r1.dx - r * cos(x), p_r1.dy - r * sin(x));
//    小圆切线点
    Offset p3;
    // 中间斜线的 中心
    Offset half_center, p1_center;
    if (qx == 0.5 * pi) {
      p1 = Offset(p_r1.dx - r, p_r1.dy);
      p3 = Offset(p2_r.dx - r2, p2_r.dy);

      half_center = Offset((p1.dx + p3.dx) * 0.5, (p1.dy + p3.dy) * 0.5);
      if (dis < 0) dis = 0;
      p1_center = Offset(half_center.dx + dis, half_center.dy);
    } else if (qx >= 0 && qx <= 0.5 * pi) {
      p1 = Offset(p_r1.dx - r * cos(lastJ), p_r1.dy - r * sin(lastJ));
      p3 = Offset(p2_r.dx - r2 * cos(lastJ), p2_r.dy - (r2 * sin(lastJ)));

      // 中间斜线的 中心
      double minCos = cos(lastJ) > 0 ? cos(lastJ) : -cos(lastJ);
      double minSin = sin(lastJ) > 0 ? sin(lastJ) : -sin(lastJ);
      half_center = Offset((p1.dx + p3.dx) * 0.5, (p1.dy + p3.dy) * 0.5);
      p1_center =
          Offset(half_center.dx + dis * minCos, half_center.dy - minSin * dis);
    } else if (qx <= 1.0 * pi) {
      p1 = Offset(p_r1.dx - r * cos(lastJ), p_r1.dy + r * sin(lastJ));
      p3 = Offset(p2_r.dx - r2 * cos(lastJ), p2_r.dy + (r2 * sin(lastJ)));
      // 中间斜线的 中心
      half_center = Offset((p1.dx + p3.dx) * 0.5, (p1.dy + p3.dy) * 0.5);
      double min = cos(lastJ) < 0 ? 0 : cos(lastJ);
      double minSin = sin(lastJ) < 0 ? 0 : sin(lastJ);
      p1_center =
          Offset(half_center.dx + dis * min, half_center.dy - dis * minSin);
    } else if (qx <= 1.5 * pi) {
      p1 = Offset(p_r1.dx - r * cos(lastJ), p_r1.dy - r * sin(lastJ));
      p3 = Offset(p2_r.dx - r2 * cos(lastJ), p2_r.dy - (r2 * sin(lastJ)));
      // 中间斜线的 中心
      half_center = Offset((p1.dx + p3.dx) * 0.5, (p1.dy + p3.dy) * 0.5);
      double min = cos(lastJ) < 0 ? 0 : cos(lastJ);
      double minSin = sin(lastJ) < 0 ? 0 : sin(lastJ);
      p1_center =
          Offset(half_center.dx + dis * min, half_center.dy + dis * minSin);
    } else if (qx <= 2 * pi) {
      p1 = Offset(p_r1.dx - r * cos(lastJ), p_r1.dy + r * sin(lastJ));
      p3 = Offset(p2_r.dx - r2 * cos(lastJ), p2_r.dy + (r2 * sin(lastJ)));
      // 中间斜线的 中心
      half_center = Offset((p1.dx + p3.dx) * 0.5, (p1.dy + p3.dy) * 0.5);
      double min = cos(lastJ) < 0 ? 0 : cos(lastJ);
      double minSin = sin(lastJ) < 0 ? 0 : sin(lastJ);
      p1_center =
          Offset(half_center.dx + dis * min, half_center.dy - dis * minSin);
    }

    _path.moveTo(p1.dx, p1.dy);
    //贝塞尔曲线 从p1到p3，控制点是 p1_center
    _path.cubicTo(
        p1_center.dx, p1_center.dy, p1_center.dx, p1_center.dy, p3.dx, p3.dy);

    Offset p11 = Offset(p_r1.dx + r * cos(x), p_r1.dy - r * sin(x));
    Offset p33;
    // 中间斜线的 中心
    Offset half2_center;
    Offset p2_center; //右边斜线的中间的点
    if (qx == 0.5 * pi) {
      p11 = Offset(p_r1.dx + r, p_r1.dy);
      p33 = Offset(p2_r.dx + r2, p2_r.dy);
      // 中间斜线的 中心
      double minCos = cos(lastJ) > 0 ? cos(lastJ) : -cos(lastJ);
      double minSin = sin(lastJ) > 0 ? sin(lastJ) : -sin(lastJ);

      half2_center = Offset((p11.dx + p33.dx) * 0.5, (p11.dy + p33.dy) * 0.5);
      p2_center = Offset(half2_center.dx - dis, half2_center.dy);
    } else if (qx >= 0 && qx <= 0.5 * pi) {
      p11 = Offset(p_r1.dx + r * cos(lastJ), p_r1.dy + r * sin(lastJ));
      p33 = Offset(p2_r.dx + r2 * cos(lastJ), p2_r.dy + (r2 * sin(lastJ)));
      // 中间斜线的 中心
      double minCos = cos(lastJ) > 0 ? cos(lastJ) : -cos(lastJ);
      double minSin = sin(lastJ) > 0 ? sin(lastJ) : -sin(lastJ);

      half2_center = Offset((p11.dx + p33.dx) * 0.5, (p11.dy + p33.dy) * 0.5);
      p2_center = Offset(
          half2_center.dx - dis * minCos, half2_center.dy - minSin * dis);
    } else if (qx <= 1 * pi) {
      p11 = Offset(p_r1.dx + r * cos(lastJ), p_r1.dy - r * sin(lastJ));
      p33 = Offset(p2_r.dx + r2 * cos(lastJ), p2_r.dy - (r2 * sin(lastJ)));
      // 中间斜线的 中心
      double minCos = cos(lastJ) > 0 ? cos(lastJ) : 0;
      double minSin = sin(lastJ) > 0 ? sin(lastJ) : 0;

      half2_center = Offset((p11.dx + p33.dx) * 0.5, (p11.dy + p33.dy) * 0.5);
      p2_center = Offset(
          half2_center.dx - dis * minCos, half2_center.dy + minSin * dis);
    } else if (qx <= 1.5 * pi) {
      p11 = Offset(p_r1.dx + r * cos(lastJ), p_r1.dy + r * sin(lastJ));
      p33 = Offset(p2_r.dx + r2 * cos(lastJ), p2_r.dy + (r2 * sin(lastJ)));
      // 中间斜线的 中心
      double minCos = cos(lastJ) > 0 ? cos(lastJ) : 0;
      double minSin = sin(lastJ) > 0 ? sin(lastJ) : 0;

      half2_center = Offset((p11.dx + p33.dx) * 0.5, (p11.dy + p33.dy) * 0.5);
      p2_center = Offset(
          half2_center.dx - dis * minCos, half2_center.dy + minSin * dis);
    } else if (qx <= 2 * pi) {
      p11 = Offset(p_r1.dx + r * cos(lastJ), p_r1.dy - r * sin(lastJ));
      p33 = Offset(p2_r.dx + r2 * cos(lastJ), p2_r.dy - (r2 * sin(lastJ)));
      // 中间斜线的 中心
      double minCos = cos(lastJ) > 0 ? cos(lastJ) : 0;
      double minSin = sin(lastJ) > 0 ? sin(lastJ) : 0;

      half2_center = Offset((p11.dx + p33.dx) * 0.5, (p11.dy + p33.dy) * 0.5);
      p2_center = Offset(
          half2_center.dx - dis * minCos, half2_center.dy + minSin * dis);
    }

    _path.lineTo(p33.dx, p33.dy);
    if (p2_center.dx < p1_center.dx) return; //交叉则取消
//贝塞尔曲线 从p33到p11，控制点是 p2_center
    _path.cubicTo(
        p2_center.dx, p2_center.dy, p2_center.dx, p2_center.dy, p11.dx, p11.dy);
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
