import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyhub/animation/easy_beating_circle.dart';
import 'package:flutter_easyhub/animation/easy_beating_rects.dart';
import 'package:flutter_easyhub/animation/easy_creeping_bug.dart';
import 'package:flutter_easyhub/animation/easy_custom_painter.dart';
import 'package:flutter_easyhub/animation/easy_dancing_ball.dart';
import 'package:flutter_easyhub/animation/easy_dancing_cube.dart';
import 'package:flutter_easyhub/animation/easy_falling_ball.dart';
import 'package:flutter_easyhub/animation/easy_flashing_circles.dart';
import 'package:flutter_easyhub/animation/easy_flip_diamond.dart';
import 'package:flutter_easyhub/animation/easy_fliping_rect.dart';
import 'package:flutter_easyhub/animation/easy_folding_rect.dart';
import 'package:flutter_easyhub/animation/easy_hourglass_timer.dart';
import 'package:flutter_easyhub/animation/easy_moving_cube.dart';
import 'package:flutter_easyhub/animation/easy_pendulum_ball.dart';
import 'package:flutter_easyhub/animation/easy_progress_widget.dart';
import 'package:flutter_easyhub/animation/easy_rain_couplet.dart';
import 'package:flutter_easyhub/animation/easy_rotating_circles.dart';
import 'package:flutter_easyhub/animation/easy_rotating_two_circles.dart';
import 'package:flutter_easyhub/animation/easy_rotating_two_color_circles.dart';
import 'package:flutter_easyhub/animation/easy_rotating_two_rect.dart';
import 'package:flutter_easyhub/animation/easy_rubber_band.dart';
import 'package:flutter_easyhub/animation/easy_spit_bubbles.dart';
import 'package:flutter_easyhub/animation/easy_swimming_ball.dart';
import 'package:flutter_easyhub/animation/easy_waves.dart';
import 'package:flutter_easyhub/easy_hub.dart';

class MainHub extends StatefulWidget {
  Widget child;
  static EasyHub _easyHub;

  BuildContext context;
  OverlayEntry _entry;
  OverlayState _overlayState;
  List<OverlayEntry> _listAdd = [];
  List<Widget> _children = [];
  String msg = 'loading';
  TextStyle textStyle; //自定义
  bool needupdate = false; //下次需要更新
  EasyHubType _easyHubType;
  EasyHubIndicatorType indicatorType; //动画类型
//custom 中使用 错误或者完成图标
  Widget _customWidget;
  double textHeight;
  double height;
  double width;
  Color background;
  Color circlebackgroundColor; //动画 前景色
  Animation<Color> circleValueColor; //动画背景色
  double value; //进度条

  _MainHubState _state;
  MainHub({Key key, this.child}) : super(key: key);
  _MainHubState createState() {
    _state = _MainHubState();
    return _state;
  }

  void showHub(EasyHubIndicatorType indicatorType) {
    _state.updateView(indicatorType);
  }
}

class _MainHubState extends State<MainHub> {
  bool _show = true;
  @override
  Widget build(BuildContext context) {
    List<Widget> _list = new List();
    _list.add(Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      top: 0,
      child: widget.child,
    ));
    if (_show) {
      _list.add(Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        top: 0,
        child: Column(
          children: _children,
        ),
      ));
    }
    ;
    return Container(
      child: Stack(
        children: _list,
      ),
    );
  }

  Color _defaultbgColor = Colors.black38;
  List<Widget> _children = new List();
  EasyHubIndicatorType indicatorType;
  void updateView(EasyHubIndicatorType indicatorType) {
//    Size _size = MediaQuery.of(context).size;
    if (_children == null) {
      _children = List();
    }
    _children.clear();
//    if (this.msg == null) {
//      this.msg = 'text is null';
//    }

    Widget _indicator;
    Color styleColor = Colors.white;
//    final ee_hub = Provider.of<EasyHub>(context, listen: false).value;
    if (widget.background != null) _defaultbgColor = widget.background;
    Color circlebackgroundColor = widget.circlebackgroundColor;
    Color circleValueColor = widget.circleValueColor.value;
    switch (indicatorType) {
      case EasyHubIndicatorType.EasyHubIndicator_default:
        _indicator = CupertinoActivityIndicator(
          radius: 20,
        );
        _defaultbgColor = Color.fromRGBO(235, 235, 235, 1);

        styleColor = Colors.black38;
        break;
      case EasyHubIndicatorType.EasyHubIndicator_CircularProgress:
        _indicator = CircularProgressIndicator(
          backgroundColor: widget.circlebackgroundColor,
          valueColor: widget.circleValueColor,
//          value: Provider.of<EasyHub>(context, listen: false).value,
        );
        _defaultbgColor = Colors.black38;
        if (widget.background != null) _defaultbgColor = widget.background;

        break;
      case EasyHubIndicatorType.EasyHubIndicator_LineProgress:
        _defaultbgColor = Colors.black38;
        if (widget.background != null) _defaultbgColor = widget.background;
        _indicator = LinearProgressIndicator(
          backgroundColor: circlebackgroundColor,
          valueColor: widget.circleValueColor,
        );
        break;
      case EasyHubIndicatorType.EasyHubIndicator_CircularProgressEasyOutEasyIn:
        _indicator = EasyProgressWidget(
          value: 0.2,
          circlebackgroundColor: circlebackgroundColor,
          circleForegroundColor: circleValueColor,
          type: EasyCustomCirclePainterType.Easy_custom,
        );
        break;
      case EasyHubIndicatorType.EasyHubIndicator_CircularProgressEasy:
        _indicator = EasyProgressWidget(
          circlebackgroundColor: circlebackgroundColor,
          circleForegroundColor: circleValueColor,
          type: EasyCustomCirclePainterType.Easy_startAndEnd,
          value: 0.2,
        );
        break;
      case EasyHubIndicatorType.EasyHubIndicator_singleFlipingRect:
        _indicator = EasyFlipingRect(
          color: circleValueColor,
        );
        break;
      case EasyHubIndicatorType.EasyHubIndicator_beattingCircle:
        _indicator = EasyBeattingCircles(
          color: circleValueColor,
          single: false,
        );
        break;
      case EasyHubIndicatorType.EasyHubIndicator_singlebeattingCircle:
        _indicator = EasyBeattingCircles(
          color: circleValueColor,
          single: true,
          radius: 30,
        );
        break;
      case EasyHubIndicatorType.EasyHubIndicator_beatingRects:
        _indicator = EasyBeatingRects(
          color: circleValueColor,
        );
        break;
      case EasyHubIndicatorType.EasyHubIndicator_rotatingCircles:
        _indicator = EasyRotatingCircles(
          color: circleValueColor,
        );
        break;
      case EasyHubIndicatorType.EasyHubIndicator_rotatingDeformedCircles: //有大有小
        _indicator =
            EasyRotatingCircles(color: circleValueColor, isSmaller: true);
        break;
      case EasyHubIndicatorType
          .EasyHubIndicator_rotatingDeformedCirclesRow: //有大有小
        _indicator = EasyRotatingCircles(
          color: circleValueColor,
          isSmaller: true,
          isLine: true,
        );
        break;
      case EasyHubIndicatorType.EasyHubIndicator_foldingRect:
        _indicator = EasyFoldingRect(
          width: 45,
          color: circleValueColor,
        );
        break;
      case EasyHubIndicatorType.EasyHubIndicator_rotatingTwoCircles:
        _indicator = EasyRotatingCircle(
          radius: 45,
          color: circleValueColor,
        );
        break;
      case EasyHubIndicatorType.EasyHubIndicator_rotatingTwoRect:
        _indicator = EasyRotatingTwoRect(
          width: 50,
          colors: [circleValueColor, circleValueColor],
        );
        break;
      case EasyHubIndicatorType.EasyHubIndicator_pendulumingBall:
        _indicator = Container(
          child: EasyPendulumBall(
            color: Colors.amber.withOpacity(0.8),
            colors: [Colors.blueGrey, Colors.red, Colors.lightGreen],
            radius: 5,
          ),
        );
        break;
      case EasyHubIndicatorType.EasyHubIndicator_waves:
        _indicator = EasyWaving(
          radius: 30,
          isHidenProgress: true,
        );
        break;
      case EasyHubIndicatorType.EasyHubIndicator_spitBubbles: //水球滴水
        _indicator = EasySplitBubbles(
          radius: 15,
        );
        break;
      case EasyHubIndicatorType.EasyHubIndicator_movingCube: //水球滴水
        _indicator = EasyMovingCube(
          width: 15,
        );
        break;
      case EasyHubIndicatorType.EasyHubIndicator_rotatingTwoColorBall: //旋转的魔球
        _indicator = EasyRotatingTwoColorCircles(
          radius: 15,
        );
        break;
      case EasyHubIndicatorType.EasyHubIndicator_dancingBalls: //跳动的魔球
        _indicator = EasyDancingBall(
          radius: 10,
        );
        break;
      case EasyHubIndicatorType.EasyHubIndicator_flashingBalls: //跳动的九饼
        _indicator = EasyFlashCircles(
          radius: 10,
          color: EasyHub.getInstance.circleValueColor == null
              ? Colors.pinkAccent
              : EasyHub.getInstance.circleValueColor.value,
        );
        break;
      case EasyHubIndicatorType.EasyHubIndicator_fallingBall: //掉落的小球
        _indicator = EasyFallingBall(
          radius: 10,
          color: EasyHub.getInstance.circleValueColor == null
              ? Colors.orange
              : EasyHub.getInstance.circleValueColor.value,
        );
        break;
      case EasyHubIndicatorType.EasyHubIndicator_hourglass: //沙漏
        _indicator = EasyHourglassTimer(
          width: 60,
          color: EasyHub.getInstance.circleValueColor == null
              ? Colors.orange
              : EasyHub.getInstance.circleValueColor.value,
        );
        break;

      case EasyHubIndicatorType.EasyHubIndicator_dancingCube: //矩形跳舞
        _indicator = EasyDancingCube(
          radius: 12,
        );
        break;

      case EasyHubIndicatorType.EasyHubIndicator_swingingBall: //有用的蝌蚪
        _indicator = EasySwimmingBall(
          radius: 8,
        );
        break;

      case EasyHubIndicatorType.EasyHubIndicator_creepingBug: //跳动的虫子
        _indicator = EasyCreepingBug(
          radius: 30,
        );
        break;
      case EasyHubIndicatorType.EasyHubIndicator_rubberBand: //跳动的虫子
        _indicator = Container(
          width: 100,
          height: 100,
          child: EasyRubberBand(
            color: EasyHub.getInstance.circleValueColor == null
                ? Colors.orange
                : EasyHub.getInstance.circleValueColor.value,
          ),
        );
        break;
      case EasyHubIndicatorType.EasyHubIndicator_rainCouplet:
        _indicator = EasyRainCouplet(
            color: EasyHub.getInstance.circleValueColor == null
                ? Colors.orange
                : EasyHub.getInstance.circleValueColor.value);
        break;
      case EasyHubIndicatorType.EasyHubIndicator_flipDiamond:
        _indicator = EasyFlipDiamond(
            color: EasyHub.getInstance.circleValueColor == null
                ? Colors.orange
                : EasyHub.getInstance.circleValueColor.value);
        break;
    }
    Text _text = Text(
//      this.msg.length > 0 ? this.msg : '',
      'msg',
      style: widget.textStyle == null
          ? TextStyle(
              fontSize: 15, color: styleColor, decoration: TextDecoration.none)
          : widget.textStyle,
    );
    switch (widget._easyHubType) {
      case EasyHubType.EasyHub_msg:
        _children.add(Container(
          margin: EdgeInsets.all(15),
          child: _text,
        ));
        break;
      case EasyHubType.EasyHub_all:
        _children
            .add(Container(padding: EdgeInsets.all(15), child: _indicator));
        _children.add(Container(
          padding: EdgeInsets.all(10),
          child: _text,
        ));
        break;
      case EasyHubType.EasyHub_just:
        _children
            .add(Container(padding: EdgeInsets.all(15), child: _indicator));

        break;
      case EasyHubType.EasyHub_Custom:
//        _children.add(_customWidget);
        _children.add(Container(
          padding: EdgeInsets.all(10),
          child: _text,
        ));
        break;
    }
  }
}
