import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EasyFoldingRect extends StatefulWidget {
  final Color color;
  final double width;

  ///折叠矩形动画
  /// Color 矩形颜色 最好加入半透明的元素，效果更好
  /// width 矩形直径
  EasyFoldingRect({Key key, this.color, this.width}) : super(key: key);
  _EasyFoldingRect createState() => _EasyFoldingRect();
}

class _EasyFoldingRect extends State<EasyFoldingRect>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1400),
        lowerBound: 0.0,
        upperBound: 4.0)
      ..addStatusListener((s) {
        if (s == AnimationStatus.completed) {
          _animationController
            ..reset()
            ..forward();
        } else if (s == AnimationStatus.dismissed) {
          _animationController
            ..reset()
            ..forward();
        } else if (s == AnimationStatus.forward) {
          this.isFold = !this.isFold;
        }
      })
      ..forward(from: 3.0); //从完整的矩形开始 变形
    super.initState();
  }

  double width = 30;
  bool isFold = true;
  double sj = 0.007;

  @override
  Widget build(BuildContext context) {
    sj = 0.007;
    if (widget.width != null) width = widget.width / 2.0;
    Matrix4 ts1 = Matrix4.identity()..setEntry(3, 2, sj);
    Matrix4 ts2 = Matrix4.identity()..setEntry(3, 2, sj);
    Matrix4 ts4 = Matrix4.identity()..setEntry(3, 2, sj);
    Matrix4 ts3 = Matrix4.identity()..setEntry(3, 2, sj);
    Matrix4 ts11 = Matrix4.identity();
    Matrix4 ts22 = Matrix4.identity();
    Matrix4 ts44 = Matrix4.identity();
    Matrix4 ts33 = Matrix4.identity();
    double width1 = width;
    double width2 = width;
    double width3 = width;
    double width4 = width;
    double width11 = width;
    double width22 = width;
    double width33 = width;
    double width44 = width;
    Color color = widget.color;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        double v = _animationController.value;
        double ops = 1 - (v - v.floor());
        Matrix4 defaultM = Matrix4.identity()
          ..scale(1.0)
          ..setEntry(3, 2, sj);
        Color defaultColor = color;
        if (color == null) {
          defaultColor = Colors.white;
        }
        Color opsColor = defaultColor.withOpacity(1);
        Color color1 = defaultColor;
        Color color2 = defaultColor;
        Color color3 = defaultColor;
        Color color4 = defaultColor;

        width11 = 0.0;
        width22 = 0.0;
        width33 = 0.0;
        width44 = 0.0;

        if (v <= 1.0) {
          ts1 = Matrix4.identity()..setEntry(3, 2, sj);
          ts1.rotateY(-v * pi);
          ts4 = defaultM;
          if (isFold) {
            width4 = width;
          } else {
            width4 = 0;
            width1 = width;
            width11 = width;
          }
          color1 = opsColor;
        } else if (v > 1.0 && v <= 2.0) {
          ts1 = defaultM;
          ts2 = Matrix4.identity()..setEntry(3, 2, sj);
          ts2.rotateX((v - 1) * pi);
          if (isFold) {
            width1 = 0;
          } else {
            width2 = width;
            width1 = width;
            width22 = width;
          }
          color2 = opsColor;
        } else if (v > 2.0 && v <= 3.0) {
          color3 = opsColor;
          ts2 = defaultM;

          ts3 = Matrix4.identity()..setEntry(3, 2, sj);
          ts3.rotateY((v - 2) * pi);
          if (isFold) {
            width2 = 0;
          } else {
            width3 = width;
            width2 = width;
            width33 = width;
          }
        } else if (v >= 3.0 && v <= 4.0) {
          color4 = opsColor;
          ts3 = defaultM;

          if (isFold) {
            width3 = 0;
            ts4 = Matrix4.identity()..setEntry(3, 2, sj);
            ts4.rotateX(-(v - 3) * pi);
          } else {
            width4 = width;
            width3 = width;
            width44 = width;
          }
        }
        List<Widget> list = List();
        Color colorbg = defaultColor;
        Positioned p1 = getPositioned(ts1, Alignment.centerRight,
            left: 0, top: 0, width: width1, color: color1);
        Positioned p2 = getPositioned(ts2, Alignment.bottomCenter,
            left: width, top: 0, width: width2, color: color2);

        Positioned p3 = getPositioned(ts3, Alignment.centerLeft,
            left: width, top: width, width: width3, color: color3);
        Positioned p4 = getPositioned(ts4, Alignment.topCenter,
            left: 0, top: width, width: width4, color: color4);
        Positioned p11 = getPositioned(
          ts11,
          Alignment.centerRight,
          left: 0,
          top: 0,
          width: width11,
          color: colorbg,
        );
        Positioned p22 = getPositioned(
          ts22,
          Alignment.bottomCenter,
          left: width,
          top: 0,
          width: width22,
          color: colorbg,
        );
        Positioned p33 = getPositioned(
          ts33,
          Alignment.centerLeft,
          left: width,
          top: width,
          width: width33,
          color: colorbg,
        );
        Positioned p44 = getPositioned(
          ts44,
          Alignment.topCenter,
          left: 0,
          top: width,
          width: width44,
          color: colorbg,
        );
        list.add(p11);
        list.add(p22);
        list.add(p33);
        list.add(p44);
        list.add(p1);
        list.add(p2);
        list.add(p3);
        list.add(p4);
        return Container(
          width: width * 2,
          height: width * 2,
          margin: EdgeInsets.only(left: 10, top: 10),
          child: Stack(
            children: list,
          ),
        );
      },
    );
  }

  Positioned getPositioned(Matrix4 ts, Alignment alignment,
      {@required double left,
      @required double top,
      @required double width,
      Color color,
      String text}) {
    return Positioned(
        left: left,
        top: top,
        width: width,
        height: width,
        child: Transform(
          transform: ts,
          alignment: alignment,
          child: Container(
            color: color == null ? Colors.lightBlueAccent : color,
          ),
        ));
  }
}
