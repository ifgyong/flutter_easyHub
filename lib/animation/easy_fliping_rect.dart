import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EasyFlipingRect extends StatefulWidget {
  ///翻转的矩形
  /// 自定义颜色 和大小
  /// color 颜色
  /// size 翻转矩形大小
  ///  更多信息见仓库：https://github.com/ifgyong/flutter_easyHub
  EasyFlipingRect({Key key, this.color, this.size}) : super(key: key);
  final Color color;
  final Size size;
  _EasyFlipingRect createState() => _EasyFlipingRect();
}

class _EasyFlipingRect extends State<EasyFlipingRect>
    with SingleTickerProviderStateMixin {
  double x = 0, y = 0;
  AnimationController _animatedController;

  bool _changeX = false; //是否改变方向
  double rotation = pi / 30; //每次翻转的角度
  @override
  void initState() {
    _animatedController = new AnimationController(
        duration: Duration(seconds: 4),
        vsync: this,
        lowerBound: 0.0,
        upperBound: 15.0)
      ..addStatusListener((state) {
        if (state == AnimationStatus.completed) {
          _animatedController.reverse();
        } else if (state == AnimationStatus.dismissed) {
          _animatedController.forward();
        }
      })
      ..forward();

    super.initState();
  }

  @override
  void dispose() {
    _animatedController.dispose();
    super.dispose();
  }

  int _count = 0;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animatedController,
      builder: (context, child) {
        if (_changeX) {
          x -= rotation;
          if (x < -pi) {
            _count += 1;
            if (_count > 10) {
              _count = 0;
              x = 0;
            } else {
              x = -pi;
            }

            _changeX = false;
          }
        } else {
          y -= rotation;
          if (y < -pi) {
            _count += 1;
            if (_count > 10) {
              _count = 0;
              y = 0;
            } else {
              y = -pi;
            }
            _changeX = true;
          }
        }
        Matrix4 mat = Matrix4.identity()..setEntry(3, 2, 0.01);
        _changeX == true ? mat.rotateX(x) : mat.rotateY(y);
        double width = widget.size == null ? 60 : widget.size.width;
        double height = widget.size == null ? 60 : widget.size.height;
        return new Transform(
          transform: mat,
          alignment: Alignment.center,
          child: Container(
            width: width,
            height: height,
            color: widget.color == null ? Colors.orangeAccent : widget.color,
          ),
        );
      },
    );
  }
}
