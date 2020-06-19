import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EasyFragmentingRect extends StatefulWidget {
  final double width;
  final Color color;

  /// 碎片矩形
  /// color 矩形颜色
  /// width 矩形宽度
  ///  更多信息见仓库：https://github.com/ifgyong/flutter_easyHub
  EasyFragmentingRect({Key key, this.color, this.width}) : super(key: key);
  _EasyFragmentingRect createState() => _EasyFragmentingRect();
}

class _EasyFragmentingRect extends State<EasyFragmentingRect>
    with SingleTickerProviderStateMixin {
  double width = 15;
  AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 2000),
        lowerBound: 0.0,
        upperBound: 1.0)
      ..repeat();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.width != null) {
      width = widget.width / 3.0;
    }
    Color color = Colors.lightBlueAccent;

    if (widget.color != null) {
      color = widget.color;
    }
    AnimatedBuilder animatedBuilder = AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        Matrix4 m1 = Matrix4.identity();
        Matrix4 m2 = Matrix4.identity();
        Matrix4 m3 = Matrix4.identity();
        Matrix4 m4 = Matrix4.identity();
        Matrix4 m5 = Matrix4.identity();
        Matrix4 m6 = Matrix4.identity();
        Matrix4 m7 = Matrix4.identity();
        Matrix4 m8 = Matrix4.identity();
        Matrix4 m9 = Matrix4.identity();
        double v = _animationController.value;
        double dur = 0.6;
        double dd = 2 / dur;
        // A 0--0.6
        // B 0.1 -- 0.7
        // C 0.2 -- 0.8
        // D 0.3 -- 0.9
        // E 0.4 -- 1.0

        if (v < dur) {
          if (v < dur / 2) {
            m1.scale((dur / 2 - v) * dd);
          } else {
            m1.scale((v - dur / 2) * dd);
          }
        }

        if (v > 0.1 && v < 0.7) {
          double v2 = v - 0.1;
          if (v2 < dur / 2) {
            m2.scale((dur / 2 - v2) * dd);
            m4.scale((dur / 2 - v2) * dd);
          } else {
            m2.scale((v2 - dur / 2) * dd);
            m4.scale((v2 - dur / 2) * dd);
          }
        }

        if (v > 0.2 && v < 0.8) {
          double v2 = v - 0.2;
          if (v2 < dur / 2) {
            m3.scale((dur / 2 - v2) * dd);
            m5.scale((dur / 2 - v2) * dd);
            m7.scale((dur / 2 - v2) * dd);
          } else {
            m3.scale((v2 - dur / 2) * dd);
            m5.scale((v2 - dur / 2) * dd);
            m7.scale((v2 - dur / 2) * dd);
          }
        }
        if (v > 0.3 && v < 0.9) {
          double v2 = v - 0.3;
          if (v2 < dur / 2) {
            m6.scale((dur / 2 - v2) * dd);
            m8.scale((dur / 2 - v2) * dd);
          } else {
            m6.scale((v2 - dur / 2) * dd);
            m8.scale((v2 - dur / 2) * dd);
          }
        }
        if (v > 0.4) {
          double v2 = v - 0.3;
          if (v2 < dur / 2) {
            m9.scale((dur / 2 - v2) * dd);
          } else if (v2 < dur) {
            m9.scale((v2 - dur / 2) * dd);
          }
        }

        List<Widget> list = List()
          ..add(getPosition(m1, 0, 0, width, color))
          ..add(getPosition(m2, 0, width, width, color))
          ..add(getPosition(m3, 0, width * 2, width, color))
          ..add(getPosition(m4, width, 0, width, color))
          ..add(getPosition(m5, width, width, width, color))
          ..add(getPosition(m6, width, width * 2, width, color))
          ..add(getPosition(m7, width * 2, 0, width, color))
          ..add(getPosition(m8, width * 2, width, width, color))
          ..add(getPosition(m9, width * 2, width * 2, width, color));

        return Container(
          width: width * 3,
          height: width * 3,
          child: Stack(
            children: list,
          ),
        );
      },
    );
    return Container(
      width: width * 3,
      height: width * 3,
      child: animatedBuilder,
      alignment: Alignment.center,
    );
  }

  Positioned getPosition(
      Matrix4 transform, double left, double top, double width, Color color) {
    Positioned ts = new Positioned(
      top: top,
      left: left,
      width: width,
      height: width,
      child: Transform(
        transform: transform,
        alignment: Alignment.center,
        child: Container(
          width: width,
          height: width,
          color: color,
        ),
      ),
    );
    return ts;
  }
}
