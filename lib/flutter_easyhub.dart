import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//GlobalKey
enum EasyHubType {
  EasyHub_msg, //只有文字
  EasyHub_just, //只有hub
  EasyHub_all, //都有
  EasyHub_Custom, //自定义
}
enum EasyHubIndicatorType {
  EasyHubIndicator_default, //默认菊花转
  EasyHubIndicator_CircularProgress, //有进度条的 原型
  EasyHubIndicator_LineProgress, //有进度条的 线条
}

class EasyHub with ChangeNotifier {
  static EasyHub _easyHub;

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
      notifyListeners(); //fresh UI

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
//          value: Provider.of<EasyHub>(context, listen: false).value,
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
