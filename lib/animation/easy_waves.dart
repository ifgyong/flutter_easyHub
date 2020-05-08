import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EasyWaving extends StatefulWidget {
  double progress; //设置就显示，默认0.5
  Text text; //进度数字 自定义
  bool isHidenProgress; //隐藏文字
  double radius; //圆圈半径
  Color color; //波浪颜色
  Color circleColor; //圆圆颜色
  /// 大波浪
  /// double progress; //设置就显示，默认0.5
  ///  Text text; //进度数字 自定义
  ///  bool isHidenProgress;//隐藏文字
  ///  Color color; //波浪颜色
  ///  Color circleColor; //圆圆颜色
  ///  更多信息见仓库：https://github.com/ifgyong/flutter_easyHub
  EasyWaving(
      {Key key,
      this.progress,
      this.text,
      this.circleColor,
      this.color,
      this.radius,
      this.isHidenProgress})
      : super(key: key);
  _EasyWaving createState() => _EasyWaving();
}

class _EasyWaving extends State<EasyWaving>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 80),
        lowerBound: 0,
        upperBound: 10000.0)
      ..repeat();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double radius = widget.radius == null ? 60 : widget.radius * 2;

    AnimatedBuilder builder = AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        List<Widget> list = List();
        Positioned positioned = Positioned(
            left: 0,
            top: 0,
            width: radius,
            height: radius,
            child: CustomPaint(
              painter: EasyWavingPainter(
                  color: widget.color,
                  circleColor: widget.circleColor,
                  radius: radius,
                  value: _animationController.value,
                  progress: widget.progress == null ? 0.5 : widget.progress),
            ));
        list.add(positioned);
        if (widget.text == null) {
          if (widget.isHidenProgress != true) {
            Positioned text = Positioned(
                child: Container(
              alignment: Alignment.center,
              child: Text(
                '${(widget.progress == null ? 50.0 : (widget.progress > 1.0 ? 100.0 : widget.progress * 100)).toStringAsFixed(2)}%',
                style: TextStyle(fontSize: 13, decoration: TextDecoration.none),
              ),
            ));
            list.add(text);
          }
        } else {
          if (widget.isHidenProgress != true) {
            Positioned text = Positioned(
                child: Container(
              alignment: Alignment.center,
              child: widget.text,
            ));
            list.add(text);
          }
        }
        return Container(
          width: radius,
          height: radius,
          child: Stack(
            children: list,
          ),
        );
      },
    );
    return Container(width: radius, height: radius, child: builder);
  }

  @override
  void dispose() {
    _animationController.stop(canceled: true);
    _animationController.dispose();
    super.dispose();
  }
}

class EasyWavingPainter extends CustomPainter {
  double radius;
  double value; //移动偏移量
  double progress; //进度 0.0--1.0之间
  double waveHeight;
  Color color; //波浪颜色
  Color circleColor; //圆圈颜色
  EasyWavingPainter(
      {Key key,
      @required this.progress,
      this.radius,
      this.value,
      this.waveHeight,
      this.color,
      this.circleColor});

  Paint _paint;
  Paint _paintCircle;
  Path _path = Path();
  @override
  void paint(Canvas canvas, Size size) {
    if (_paint == null) {
      _paint = Paint()
        ..color = this.color == null
            ? Colors.lightBlueAccent.withOpacity(0.8)
            : this.color
        ..style = PaintingStyle.fill
        ..strokeWidth = 2.0;
    }
    if (_paintCircle == null) {
      _paintCircle = Paint()
        ..color =
            this.circleColor == null ? Colors.lightBlueAccent : this.circleColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;
    }
    if (size == null) {
      size = Size(100, 100);
    }

    _path.addArc(Rect.fromLTWH(0, 0, size.width, size.height), 0, 360);
    canvas.clipPath(_path); //
    //圆圈
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), radius / 2.0, _paintCircle);
    _path.reset();
    _path.moveTo(0.0, size.height / 2);
    canvas.save();
    canvas.restore();
    int count = 100000;
    //浪高
    double waveHeight =
        this.waveHeight == null ? this.radius / 120.0 * 3.5 : this.waveHeight;
    double pro = this.progress == null ? 0.4 : 1 - this.progress; //进度
    double dis = 0.08 / (this.radius / 80.0); //波浪的半径计算得出的
    for (double i = 0.0, j = 0; i < count; i++) {
      j += dis;
      double x = i + this.value * radius / 200 - count + size.width;
      double y = size.height * pro + (sin(j) * waveHeight);
      _path.lineTo(x, y);
    }
    _path.lineTo(size.width, size.height);
    _path.lineTo(0, size.height);
    _path.lineTo(0, 0);
    _path.close();
    canvas.drawPath(_path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
