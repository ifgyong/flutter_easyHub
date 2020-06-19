import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyhub/tool/Util.dart';
import 'package:flutter_easyhub/tool/easyHubTheme.dart';
import 'package:flutter_easyhub/widget/HubContainer.dart';
import 'tool/config.dart';

class EasyHub {
  static EasyHub _easyHub;

  /// used for  [_easyHubType] is [EasyHubType.custom]
  Widget _customWidget;

  BuildContext context;
  OverlayEntry _entry;

  /// msg of states ,used for [EasyHubType.all] and [EasyHubType.msg]

  String _msg;

  /// msg of padding ,used for [EasyHubType.all] and [EasyHubType.msg]
  /// default EdgeInsets.all(15)
  EdgeInsets msgPadding;

  /// msg of margin ,used for [EasyHubType.all] and [EasyHubType.msg]
  EdgeInsets msgMargin;

  ///  style of msg,used for [EasyHubStyle.custom]
  TextStyle textStyle;

  ///  color of msg font,used for [EasyHubStyle.custom]
  ///  if textStyle is not null, it is ignored
  Color fontColor;

  /// only used for [EasyHubStyle.custom]
  /// for call[showInfoHub]、[showCompleteHub]、[showErrorHub]
  Color iconForegroundColor;

  ///maskStyle. default [EasyHubMaskStyle.dark]
  EasyHubMaskStyle maskStyle;

  /// center view style
  /// default [EasyHubType.all]
  EasyHubStyle style;

  /// loading indicator type, default  [EasyHubType.all]
  EasyHubType _easyHubType;

  /// Animation type
  /// see detail in [EasyHubIndicatorType]
  /// when [EasyHubType] is [hub] or [all],it is available.
  /// default [EasyHubIndicatorType.circularProgressEasy]

  EasyHubIndicatorType indicatorType;

  /// color of Mask,only used for [EasyHubMaskStyle.custom]
  Color maskColor;

  ///color of  main View background
  /// used  for [EasyHubStyle.custom]
  Color backgroundColor;

  ///color of main animation background
  ///used for most of  [EasyHubIndicatorType]
  ///when animationWidget colors more than [two], ignored.
  Color animationBackgroundColor;

  /// main animation foreground color,type is [Animation<Color>]
  /// like[AlwaysStoppedAnimation]
  /// used for most of  [EasyHubIndicatorType]
  ///  when animationWidget colors more than [two], ignored.
  Animation<Color> animationForegroundColor;

  /// animation progress value [bounds] is [0...1]
  /// used for   [EasyHubIndicatorType.lineProgress]
  /// TODO - [EasyHubIndicatorType.waves]
  double progress; //进度条
  /// display duration of [showSuccess] [showErrorHub] [showCompleteHub], default 2000ms.
  Duration displayDuration;

  /// touch action
  /// you can set dismissed when touch
  /// ```dark
  /// EasyHub.instance.onTap = () {
  ///        EasyHub.dismiss();
  ///      };
  /// ```
  GestureTapCallback onTap;

  factory EasyHub() => _getInstance();

  static EasyHub get instance => _getInstance();

  static EasyHub _getInstance() {
    if (_easyHub == null) {
      _easyHub = EasyHub._internal();
    }
    return _easyHub;
  }

  EasyHub._internal() {
    maskStyle = EasyHubMaskStyle.dark;
    indicatorType = EasyHubIndicatorType.circularProgressEasy;
    msgPadding = EdgeInsets.all(15);
    displayDuration = Duration(seconds: 2);
    style = EasyHubStyle.light;
    maskStyle = EasyHubMaskStyle.dark;
  }
/*对外公布接口 展示 文字 和动画*/
  static void show(String msg, {Duration duration}) {
    EasyHub.instance._easyHubType = EasyHubType.all;
    EasyHub.instance._show(msg, duration: duration);
  }

  static void showProgress(String msg,
      {double value = 0.5, Duration duration}) {
//    assert(value >= 0 && value <= 1.0, 'progress outbounds,should be [0..1]');
    EasyHub.instance._easyHubType = EasyHubType.all;
    EasyHub.instance.progress = value;
    EasyHub.instance._show(msg, duration: duration);
  }

/*对外公布接口 展示 加载动画*/
  static void showHub({Duration duration}) {
    EasyHub.instance._showHub(duration: duration);
  }

/*展示错误 hub*/
  static void showErrorHub(String msg, {Duration duration}) {
    EasyHub.instance
        ._showError(msg, duration: duration ?? _getInstance().displayDuration);
  }

  /*展示完成 hub*/
  static void showCompleteHub(String msg, {Duration duration}) {
    EasyHub.instance._showComplate(msg,
        duration: duration ?? _getInstance().displayDuration);
  }

  /*展示完成 hub*/
  static void showInfoHub(String msg, {Duration duration}) {
    EasyHub.instance
        ._showInfo(msg, duration: duration ?? _getInstance().displayDuration);
  }

  /*对外公布接口 展示 加载文本*/
  static void showMsg(String msg, {Duration duration}) {
    EasyHub.instance._showMsg(msg);
    if (duration != null) EasyHub.instance._dismiss(delay: duration);
  }

  //展示自定义widget
  static void showCustom(Widget custom, {Duration duration}) {
    EasyHub.instance._showCustom(null, custom, duration: duration);
  }

/*对外公布接口 消失*/
  static Future<void> dismiss(
      {Duration delay = const Duration(milliseconds: 0)}) async {
    return EasyHub.instance._dismiss(delay: delay);
  }

  Future<void> _dismiss(
      {Duration delay = const Duration(milliseconds: 0)}) async {
    await Future.delayed(delay);
    EasyHub.instance._clear();
    return;
  }

  void _showHub({Duration duration}) {
    this._easyHubType = EasyHubType.hub;
    _show('', duration: duration);
  }

  void _showMsg(String msg, {Duration duration}) {
    assert(context != null, 'easy Hub context is null');
    EasyHub.instance._easyHubType = EasyHubType.msg;
    _show(msg, duration: duration);
  }

//展示自定义widget
  void _showCustom(String msg, Widget custom, {Duration duration}) {
    EasyHub.instance._easyHubType = EasyHubType.custom;
    this._customWidget = custom;
    _show(msg, duration: duration);
  }

//  展示错误 信息
  void _showError(String msg, {Duration duration}) {
    Widget widget = Container(
      width: 30,
      height: 30,
      margin: EdgeInsets.only(top: 10),
      child: Icon(
        Icons.clear,
        color: EasyHubTheme.iconForegroundColor,
      ),
    );
    this._showCustom(msg, widget, duration: duration);
  }

  //  展示完成 信息
  void _showComplate(String msg, {Duration duration}) {
    Widget widget = Container(
      width: 30,
      height: 20,
      margin: EdgeInsets.only(top: 10),
      child: Icon(
        Icons.check,
        color: EasyHubTheme.iconForegroundColor,
      ),
    );
    _showCustom(msg, widget, duration: duration);
  }

  //  展示完成 信息
  void _showInfo(String msg, {Duration duration}) {
    Widget widget = Container(
      width: 30,
      height: 20,
      margin: EdgeInsets.only(top: 10),
      child: Icon(
        Icons.info_outline,
        color: EasyHubTheme.iconForegroundColor,
      ),
    );
    _showCustom(msg, widget, duration: duration);
  }

  void _show(String msg, {Duration duration}) {
    Widget centerWidget, bottomWidget;
    switch (_easyHubType) {
      case EasyHubType.msg:
        this._msg = msg;
        Text _text = Text(this._msg.length > 0 ? this._msg : '',
            style: EasyHubTheme.textStyle);
        bottomWidget = Container(
          padding: EasyHubTheme.msgPadding,
          margin: EasyHubTheme.msgMargin,
          child: _text,
        );
        break;
      case EasyHubType.hub:
        centerWidget = Tool.getIndicatorWidget(indicatorType,
            circleBackgroundColor: _getInstance().animationBackgroundColor,
            circleValueColor: _getInstance().animationForegroundColor);
        break;
      case EasyHubType.all:
        this._msg = msg;
        Text _text = Text(this._msg.length > 0 ? this._msg : '',
            style: EasyHubTheme.textStyle);
        bottomWidget = Container(
          padding: EasyHubTheme.msgPadding,
          margin: EasyHubTheme.msgMargin,
          child: _text,
        );
        centerWidget = Tool.getIndicatorWidget(indicatorType,
            progress: _getInstance().progress,
            circleBackgroundColor: _getInstance().animationBackgroundColor,
            circleValueColor: _getInstance().animationForegroundColor);
        break;
      case EasyHubType.custom:
        if (msg != null) {
          Text _text =
              Text(msg.length > 0 ? msg : '', style: EasyHubTheme.textStyle);
          bottomWidget = Container(
            padding: EasyHubTheme.msgPadding,
            margin: EasyHubTheme.msgMargin,
            child: _text,
          );
        }
        centerWidget = _getInstance()._customWidget;
        break;
    }
    _getInstance()._clear();

    OverlayEntry overlayEntry =
        _getEntry(center: centerWidget, bottom: bottomWidget);

    Overlay.of(_getInstance().context).insert(overlayEntry);
    _getInstance()._entry = overlayEntry;
  }

  OverlayEntry _getEntry({
    Widget left,
    Widget center,
    Widget right,
    Widget bottom,
  }) {
    return OverlayEntry(builder: (BuildContext con) {
      return GestureDetector(
        child: HubContainer(
          center: center,
          left: left,
          right: right,
          bottom: bottom,
        ),
        onTap: EasyHub.instance.onTap,
      );
    });
  }

  void _clear() {
    if (_getInstance()._entry != null) {
      _getInstance()._entry?.remove();
      _getInstance()._entry = null;
    }
  }
}
