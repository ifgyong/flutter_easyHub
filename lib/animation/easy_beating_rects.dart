import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EasyBeatingRects extends StatefulWidget {
  /// 跳动的矩形
  /// margin 间隔
  /// rectHeight 矩形高度
  /// rectWidth 矩形宽度
  ///  更多信息见仓库：https://github.com/ifgyong/flutter_easyHub
  EasyBeatingRects(
      {Key key, this.color, this.margin, this.rectHeight, this.rectWidth})
      : super(key: key);
  Color color;
  final double margin;
  final double rectWidth;
  final double rectHeight;

  _EasyBeatingRects createState() => _EasyBeatingRects();
}

class _EasyBeatingRects extends State<EasyBeatingRects>
    with SingleTickerProviderStateMixin {
  Color _color;
  AnimationController _animationController;
  @override
  void initState() {
    _color = widget.color;
    if (_color == null) {
      _color = Colors.orange;
    }
    _animationController = AnimationController(
        duration: Duration(seconds: 1),
        vsync: this,
        lowerBound: 0,
        upperBound: 1.0)
      ..repeat();
    super.initState();
  }

  double width = 6;
  double addValue = 0.01;
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        EdgeInsets margin =
            EdgeInsets.only(left: 2, right: 2, top: 2, bottom: 2);

        double defaultH = 20;
        if (widget.rectHeight != null) {
          defaultH = widget.rectHeight;
        }
        if (widget.rectWidth != null) {
          width = widget.rectWidth;
        }

        double h1 = defaultH,
            h2 = defaultH,
            h3 = defaultH,
            h4 = defaultH,
            h5 = defaultH;
        double value = _animationController.value;
        double duriton = 0.38; //周期
        double times = 1.5; //增长的高度倍数
        if (value < duriton) {
          if (value < duriton / 2) {
            //上升
            h1 = value * 2 / duriton * defaultH * times + defaultH;
          } else {
            //下降
            h1 = (-(value - duriton / 2) * 2 / duriton) * defaultH * times +
                (times + 1) * defaultH;
          }
        }
        if (value < duriton * 5 / 4 && value > duriton / 4) {
          if (value < (duriton / 2 + duriton / 4)) {
            //上升
            h2 = (value - duriton / 2) * 2 / duriton * defaultH * times +
                defaultH;
          } else {
            //下降
            h2 = (-(value - duriton * 3 / 4) / duriton) * defaultH * times +
                (times + 1) * defaultH;
          }
        }
//1.2--->1.4
        if (value < duriton * (1 + 1 / 2.0) && value > duriton / 2) {
          if (value < (duriton * (1 / 2 + 1 / 2))) {
            //上升
            h3 = (value - duriton * 1 / 2) * 2 / duriton * defaultH * times +
                defaultH;
          } else {
            //下降
            h3 = (-(value - duriton * 5 / 4) / duriton) * defaultH * times +
                (times + 1) * defaultH;
          }
        }
        if (value < duriton * (1 + 3 / 4.0) && value > duriton * 3 / 4) {
          if (value < (duriton * (1 / 2 + 3 / 4.0))) {
            //上升
            h4 = (value - duriton * 3.0 / 4) * 2 / duriton * defaultH * times +
                defaultH;
          } else {
            //下降
            h4 = (-(value - duriton * 5 / 4) / duriton) * defaultH * times +
                (times + 1) * defaultH;
          }
        }

        if (value < duriton * (1 + 1) && value > duriton * 1) {
          if (value < (duriton * (1 / 2 + 1))) {
            //上升
            h5 = (value - duriton * 1) * 2 / duriton * defaultH * times +
                defaultH;
          } else {
            //下降
            h5 = (-(value - duriton * 3 / 2) / duriton) * defaultH * times +
                (times + 1) * defaultH;
          }
        }
        return Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: margin,
                width: width,
                height: h1,
                color: _color,
              ),
              Container(
                margin: margin,
                width: width,
                height: h2,
                color: _color,
              ),
              Container(
                margin: margin,
                width: width,
                height: h3,
                color: _color,
              ),
              Container(
                margin: margin,
                width: width,
                height: h4,
                color: _color,
              ),
              Container(
                margin: margin,
                width: width,
                height: h5,
                color: _color,
              ),
            ],
          ),
        );
      },
    );
  }
}
