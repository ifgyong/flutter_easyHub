import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyhub/animation/easy_creeping_bug.dart';
import 'package:flutter_easyhub/animation/easy_dancing_ball.dart';
import 'package:flutter_easyhub/animation/easy_dancing_cube.dart';
import 'package:flutter_easyhub/animation/easy_falling_ball.dart';
import 'package:flutter_easyhub/animation/easy_flashing_circles.dart';
import 'package:flutter_easyhub/animation/easy_hourglass_timer.dart';
import 'package:flutter_easyhub/animation/easy_moving_cube.dart';
import 'package:flutter_easyhub/animation/easy_rotating_two_color_circles.dart';
import 'package:flutter_easyhub/animation/easy_rubber_band.dart';
import 'package:flutter_easyhub/animation/easy_spit_bubbles.dart';
import 'package:flutter_easyhub/animation/easy_pendulum_ball.dart';
import 'package:flutter_easyhub/animation/easy_swimming_ball.dart';
import 'package:flutter_easyhub/animation/easy_waves.dart';
import 'animation/easy_beating_rects.dart';
import 'animation/easy_fliping_rect.dart';
import 'animation/easy_folding_rect.dart';
import 'animation/easy_rotating_circles.dart';
import 'animation/easy_rotating_two_circles.dart';
import 'animation/easy_beating_circle.dart';
import 'animation/easy_custom_painter.dart';
import 'animation/easy_rotating_two_rect.dart';
import 'animation/easy_progress_widget.dart';

import 'animation/easy_custom_painter.dart';

//GlobalKey
enum EasyHubType {
  EasyHub_msg, //只有文字
  EasyHub_just, //只有hub
  EasyHub_all, //都有
  EasyHub_Custom, //自定义
}
enum EasyHubIndicatorType {
  EasyHubIndicator_default, //默认菊花转
  EasyHubIndicator_CircularProgress, //有进度条的 系统
//  EasyHubIndicator_CircularProgressWithText,
  EasyHubIndicator_CircularProgressEasyOutEasyIn, //快进快出
  EasyHubIndicator_CircularProgressEasy, //匀速
  EasyHubIndicator_LineProgress, //有进度条的 线条

  EasyHubIndicator_singleFlipingRect, //单个矩形翻转动画
  EasyHubIndicator_beatingRects, //竖条跳动
  EasyHubIndicator_beattingCircle, //心跳圆圈
  EasyHubIndicator_singlebeattingCircle, //心跳圆圈
  EasyHubIndicator_rotatingCircles, //圆圈追逐

  EasyHubIndicator_rotatingDeformedCircles, //圆圈追逐 变形哦

  EasyHubIndicator_rotatingDeformedCirclesRow, //一排三个圆圈跳动

  EasyHubIndicator_rotatingTwoRect, //两个矩形追逐
  EasyHubIndicator_rotatingTwoCircles, //两个圆追逐
  EasyHubIndicator_foldingRect, //折叠矩形
  EasyHubIndicator_pendulumingBall, //摆钟
  EasyHubIndicator_waves, //波浪
  EasyHubIndicator_spitBubbles, //水球 滴水
  EasyHubIndicator_movingCube, //正方体解体
  EasyHubIndicator_rotatingTwoColorBall, //旋转的魔球
  EasyHubIndicator_dancingBalls, //跳动的魔球
  EasyHubIndicator_flashingBalls, //跳动的九饼
  EasyHubIndicator_fallingBall, //掉落的小球
  EasyHubIndicator_hourglass, //沙漏
  EasyHubIndicator_dancingCube, //跳动的矩形
  EasyHubIndicator_swingingBall, //跳动的小球
  EasyHubIndicator_creepingBug, //跳动的虫子
  EasyHubIndicator_rubberBand, //跳绳小球

}

class EasyHub {
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

  EasyHub(
      {this.circleValueColor,
      this.circlebackgroundColor,
      this.background}); // => _getInstance();
  static EasyHub get getInstance {
    return _getInstance();
  }

  static EasyHub _getInstance() {
    if (_easyHub == null) {
      _easyHub = new EasyHub();
    }
    return _easyHub;
  }

  EasyHub setBackgroundColor(Color color) {
    if (color != null) this.background = color;
    return this;
  }

  EasyHub setCircleBackgroundColor(Color color) {
    if (color != null) this.circlebackgroundColor = color;
    return this;
  }

  EasyHub setValueColor(Animation<Color> color) {
    if (Color != null) this.circleValueColor = color;
    return this;
  }

  EasyHub _setValue(double value) {
    if (value != null) {
      this.value = value;

      print('$value');
    }
    return this;
  }

  EasyHub setParameter(
      {Color background,
      Color circlebackgroundColor,
      Animation<Color> circleValueColor,
      double value}) {
    this
      ..setValueColor(circleValueColor)
      ..setCircleBackgroundColor(circlebackgroundColor)
      ..setBackgroundColor(background)
      .._setValue(value);
  }

/*初始化*/
  EasyHub._initernal() {
//    _easyHub = EasyHub();
//    return _easyHub;
  }
/*对外公布接口 消失*/
  static void dismiss() {
    EasyHub.getInstance._dismiss();
  }

  void dismiss_hub() {
    this._dismiss();
  }

  void _dismiss() {
    if (_easyHub._listAdd.contains(_entry) && _entry != null) {
      _entry?.remove();
      _easyHub._listAdd.remove(_entry);
    }
  }

  static void dismiddAll() {
    for (int i = 0; i < EasyHub.getInstance._listAdd.length; i++) {
      EasyHub.getInstance._listAdd[i].remove();
    }
    EasyHub.getInstance._listAdd.clear();
  }

/*对外公布接口 展示 纯文字*/
  static void show(BuildContext context, String msg) {
    EasyHub.getInstance.needupdate = true;
    EasyHub.getInstance._easyHubType = EasyHubType.EasyHub_all;
    EasyHub.getInstance._show(msg, context);
  }

  static void showCircleProgress(BuildContext context, String msg) {
    EasyHub.getInstance.needupdate = true;
    EasyHub.getInstance._easyHubType = EasyHubType.EasyHub_all;
    EasyHub.getInstance._show(msg, context);
  }

  /*对外公布接口 展示 纯文字*/
  static void showiOS(BuildContext context, String msg) {
    EasyHub.getInstance.needupdate = true;
    EasyHub.getInstance._easyHubType = EasyHubType.EasyHub_all;
    EasyHub.getInstance._show(msg, context);
  }

/*对外公布接口 展示 加载动画*/
  static void showHub(BuildContext context) {
    EasyHub.getInstance._showHub(context);
  }

/*展示错误 hub*/
  static void showErrorHub(BuildContext context, String msg) {
    EasyHub.getInstance._showError(msg, context);
  }

  /*展示完成 hub*/
  static void showComplateHub(BuildContext context, String msg) {
    EasyHub.getInstance._showComplate(msg, context);
  }

  /*对外公布接口 展示 加载文本*/
  static void showMsg(
    BuildContext context,
    String msg,
  ) {
    assert(context != null, 'easy Hub context is null');
    EasyHub.getInstance._showMsg(msg, context);
  }

/*
* 实例方法 展示
* */
  void show_hub(
      {String msg,
      @required BuildContext context,
      @required EasyHubType type}) {
    this._easyHubType = type;
    this.needupdate = true;

    switch (type) {
      case EasyHubType.EasyHub_all:
        assert(msg != null, 'msg is null');
        this._show(msg, context);
        break;
      case EasyHubType.EasyHub_just:
        this._showHub(context);
        break;
      case EasyHubType.EasyHub_msg:
        assert(msg != null, 'msg is null');
        this._showMsg(msg, context);
        break;
      case EasyHubType.EasyHub_Custom: //自定义
        assert(msg != null, 'msg is null');
        this._showError(msg, context);
        break;
    }
  }

  void _showHub(BuildContext context) {
    this._easyHubType = EasyHubType.EasyHub_just;
    this.needupdate = true;
    _show('', context);
  }

  void _showMsg(String msg, BuildContext context) {
    assert(context != null, 'easy Hub context is null');
    EasyHub.getInstance._easyHubType = EasyHubType.EasyHub_msg;
    EasyHub.getInstance.needupdate = true;
    _show(msg, context);
  }

//展示自定义widget
  void _showCustom(String msg, BuildContext context, Widget container) {
    assert(context != null, 'easy Hub context is null');
    EasyHub.getInstance._easyHubType = EasyHubType.EasyHub_Custom;
    EasyHub.getInstance.needupdate = true;
    this._customWidget = container;
    _show(msg, context);
  }

//  展示错误 信息
  void _showError(String msg, BuildContext context) {
    Widget widget = Container(
      width: 30,
      height: 20,
      margin: EdgeInsets.only(top: 10),
      child: Image.asset('images/error_w.png'),
    );
    this._showCustom(msg, context, widget);
  }

  //  展示错误 信息
  void _showComplate(String msg, BuildContext context) {
    Widget widget = Container(
      width: 30,
      height: 20,
      margin: EdgeInsets.only(top: 10),
      child: Image.asset('images/complate_w.png'),
    );
    this._showCustom(msg, context, widget);
  }

  void _show(String msg, BuildContext context) {
    if (_overlayState == null) {
      _overlayState = Overlay.of(context);
    }
    if (this._easyHubType == EasyHubType.EasyHub_msg ||
        this._easyHubType == EasyHubType.EasyHub_all ||
        this._easyHubType == EasyHubType.EasyHub_Custom) {
      this.msg = msg;
    }
    if (this.indicatorType == null) {
      this.indicatorType = EasyHubIndicatorType.EasyHubIndicator_default;
    }

    //是否需要更新
    if (needupdate == true) {
//      _entry?.remove();
      this.updateView(context);
      _entry = null;
      needupdate = false;
    }

    if (_entry == null) {
      _entry = getLayer(context);
    }

    if (_easyHub._listAdd.contains(_entry) == false) {
      _overlayState.insert(_entry);
      _easyHub._listAdd.add(_entry);
    } else {
      _entry.remove();
      _easyHub._listAdd.remove(_entry);
      _overlayState.insert(_entry);
      _easyHub._listAdd.add(_entry);
    }
  }

  Color _defaultbgColor = Colors.black38;

  void updateView(BuildContext context) {
//    Size _size = MediaQuery.of(context).size;
    if (_children == null) {
      _children = List();
    }
    _children.clear();
    if (this.msg == null) {
      this.msg = 'text is null';
    }

    Widget _indicator;
    Color styleColor = Colors.white;
//    final ee_hub = Provider.of<EasyHub>(context, listen: false).value;

    switch (indicatorType) {
      case EasyHubIndicatorType.EasyHubIndicator_default:
        _indicator = CupertinoActivityIndicator(
          radius: 20,
        );
        if (this.background == null) {
          _defaultbgColor = Color.fromRGBO(235, 235, 235, 1);
        }
        styleColor = Colors.black38;
        break;
      case EasyHubIndicatorType.EasyHubIndicator_CircularProgress:
        _indicator = CircularProgressIndicator(
          backgroundColor: circlebackgroundColor,
          valueColor: circleValueColor,
//          value: Provider.of<EasyHub>(context, listen: false).value,
        );
        _defaultbgColor = Colors.black38;
        if (this.background != null) _defaultbgColor = this.background;

        break;
      case EasyHubIndicatorType.EasyHubIndicator_LineProgress:
        _defaultbgColor = Colors.black38;
        if (this.background != null) _defaultbgColor = this.background;
        _indicator = LinearProgressIndicator(
          backgroundColor: circlebackgroundColor,
          valueColor: circleValueColor,
        );
        break;
      case EasyHubIndicatorType.EasyHubIndicator_CircularProgressEasyOutEasyIn:
        _indicator = EasyProgressWidget(
          value: 0.2,
          circlebackgroundColor: this.circlebackgroundColor,
          circleForegroundColor: circleValueColor?.value,
          type: EasyCustomCirclePainterType.Easy_custom,
        );
        break;
      case EasyHubIndicatorType.EasyHubIndicator_CircularProgressEasy:
        _indicator = EasyProgressWidget(
          circlebackgroundColor: this.circlebackgroundColor,
          circleForegroundColor: circleValueColor?.value,
          type: EasyCustomCirclePainterType.Easy_startAndEnd,
          value: 0.2,
        );
        break;
      case EasyHubIndicatorType.EasyHubIndicator_singleFlipingRect:
        _indicator = EasyFlipingRect(
          color: circleValueColor?.value,
        );
        break;
      case EasyHubIndicatorType.EasyHubIndicator_beattingCircle:
        _indicator = EasyBeattingCircles(
          color: this.circleValueColor?.value,
          single: false,
        );
        break;
      case EasyHubIndicatorType.EasyHubIndicator_singlebeattingCircle:
        _indicator = EasyBeattingCircles(
          color: this.circleValueColor?.value,
          single: true,
          radius: 30,
        );
        break;
      case EasyHubIndicatorType.EasyHubIndicator_beatingRects:
        _indicator = EasyBeatingRects(
          color: this.circleValueColor?.value,
        );
        break;
      case EasyHubIndicatorType.EasyHubIndicator_rotatingCircles:
        _indicator = EasyRotatingCircles(
          color: this.circleValueColor?.value,
        );
        break;
      case EasyHubIndicatorType.EasyHubIndicator_rotatingDeformedCircles: //有大有小
        _indicator = EasyRotatingCircles(
            color: this.circleValueColor?.value, isSmaller: true);
        break;
      case EasyHubIndicatorType
          .EasyHubIndicator_rotatingDeformedCirclesRow: //有大有小
        _indicator = EasyRotatingCircles(
          color: this.circleValueColor?.value,
          isSmaller: true,
          isLine: true,
        );
        break;
      case EasyHubIndicatorType.EasyHubIndicator_foldingRect:
        _indicator = EasyFoldingRect(
          width: 45,
          color: this.circleValueColor?.value,
        );
        break;
      case EasyHubIndicatorType.EasyHubIndicator_rotatingTwoCircles:
        _indicator = EasyRotatingCircle(
          radius: 45,
          color: this.circleValueColor?.value,
        );
        break;
      case EasyHubIndicatorType.EasyHubIndicator_rotatingTwoRect:
        _indicator = EasyRotatingTwoRect(
          width: 50,
          colors: [this.circleValueColor?.value, this.circleValueColor?.value],
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
    }
    Text _text = Text(
      this.msg.length > 0 ? this.msg : '',
      style: textStyle == null
          ? TextStyle(
              fontSize: 15, color: styleColor, decoration: TextDecoration.none)
          : textStyle,
    );
    switch (_easyHubType) {
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
        _children.add(_customWidget);
        _children.add(Container(
          padding: EdgeInsets.all(10),
          child: _text,
        ));
        break;
    }
  }

  OverlayEntry getLayer(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    Color color = this.background != null ? this.background : _defaultbgColor;

    return new OverlayEntry(
//        maintainState: true,
        builder: (BuildContext con) {
      return Align(
          child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Container(
          color: color,
          constraints: BoxConstraints(
              minHeight: 60,
              minWidth: 50,
              maxWidth: _size.width - 40,
              maxHeight: _size.height - 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: _children,
          ),
        ),
      ));
    });
  }
}
