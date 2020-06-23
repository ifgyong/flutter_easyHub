import 'package:flutter/material.dart';
import 'package:flutter_easyhub/animation/easy_fragment_rect.dart';
import 'dart:async';
import 'package:flutter_easyhub/flutter_easy_hub.dart';
import 'package:flutter_easyhub_example/page/newPage3.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterEasyHub(
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MyHomePage(title: 'Flutter Demo Home Page')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List list = [
    'hide all',
    'default hub',
    'msg',
    'hub',
    'hub default',
    'msg 多行',
    'error hub or info',
    'complate hub',
    'line',
    'circle  easy out easy in',
    'circle  head to tail',
    '矩形翻转 flipingRect',
    '心跳 beattingCircle ',
    '单个 singlebeattingCircle',
    '竖条 跳动 beatingRects',
    '圆圈追逐 rotatingCircles',
    '圆圈追逐 rotatingDeformedCircles',
    '跳动的圆圈 rotatingDeformedCirclesRow',
    '追逐的矩形 rotatingTwoRect',
    '圆圈追逐 rotatingTwoCircles',
    '折叠矩形 foldingRect',
    '摆钟',
    '波浪',
    '水球',
    '正方体解体合体😯',
    '旋转的魔球',
    '跳动的魔球',
    '闪烁的九饼',
    '掉落的小球',
    '沙漏',
    '跳动矩形',
    '游泳的小球',
    '跳动的虫子',
    '跳动的小球',
    '像下雨的小球',
    '翻转的线性菱形 仿新版头条哦',
    '线条进度条',
    '碎片化矩形',
  ];
  @override
  Widget build(BuildContext context) {
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FlutterEasyHub(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned.fill(
              child: getList(),
              bottom: bottomPadding + 100,
            ),
            Positioned(
              child: _maskStyleWidget(),
              left: 0,
              right: 0,
              bottom: 0,
              height: 100 + bottomPadding,
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget getList() {
    return CupertinoScrollbar(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Container(
              height: 45,
              margin: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
              color: Colors.black12,
              alignment: Alignment.center,
              child: Text(
                '${list[index]} ,idex:${index - 1}',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            onTap: () {
              show(index);
            },
          );
        },
        itemCount: list.length,
      ),
    );
  }

  Widget _maskStyleWidget() {
    return Container(
      color: Colors.white,
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('maskStyle'),
              CupertinoSegmentedControl<EasyHubMaskStyle>(
                selectedColor: Colors.blue,
                children: {
                  EasyHubMaskStyle.none: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text("none"),
                  ),
                  EasyHubMaskStyle.dark: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text("dark"),
                  ),
                  EasyHubMaskStyle.light: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text("light"),
                  ),
                  EasyHubMaskStyle.custom: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text("custom"),
                  )
                },
                onValueChanged: (value) {
                  EasyHub.instance.maskStyle = value;
                },
              )
            ],
          ),
          _styleWidget()
        ],
      ),
    );
  }

  Widget _styleWidget() {
    return Container(
      color: Colors.white,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('style'),
          CupertinoSegmentedControl<EasyHubStyle>(
            selectedColor: Colors.blue,
            children: {
              EasyHubStyle.dark: Padding(
                padding: EdgeInsets.all(5.0),
                child: Text("dark"),
              ),
              EasyHubStyle.light: Padding(
                padding: EdgeInsets.all(5.0),
                child: Text("light"),
              ),
              EasyHubStyle.custom: Padding(
                padding: EdgeInsets.all(5.0),
                child: Text("custom"),
              )
            },
            onValueChanged: (value) {
              EasyHub.instance.style = value;
            },
          )
        ],
      ),
    );
  }

  Timer t;
  double value = 0;
  int errorOrInfo = 0;
  void show(int index) async {
    await EasyHub.dismiss();
    EasyHub.instance.onTap = () {
      EasyHub.dismiss();
    };
////    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => NewPage()));

    switch (index - 1) {
      case -1:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => NewPage2(
                  title: 'demo',
                )));
        return;
        EasyHub.dismiss();
        break;
      case 0:
        EasyHub.instance.indicatorType = EasyHubIndicatorType.defaultType;
        EasyHub.instance.backgroundColor = Colors.black12;
        EasyHub.showMsg('多行\nfgyong.cn\n老师');
        break;
      case 1:
        EasyHub.instance.indicatorType = EasyHubIndicatorType.defaultType;
        EasyHub.showMsg(
          '单行哦 loading',
        );
        break;
      case 2:
        EasyHub.instance.indicatorType = EasyHubIndicatorType.defaultType;
        EasyHub.instance
          ..backgroundColor = Colors.white
          ..animationForegroundColor = AlwaysStoppedAnimation(Colors.red);
        EasyHub.showHub();
        break;
      case 3:
        EasyHub.instance.indicatorType = EasyHubIndicatorType.circularProgress;
        EasyHub.instance
          ..backgroundColor = Colors.black38
          ..animationForegroundColor = new AlwaysStoppedAnimation(Colors.white)
          ..animationBackgroundColor = Colors.white.withOpacity(0.5);
        EasyHub.show(
          '加载中。。',
        );
        break;
      case 4:
        EasyHub.instance.indicatorType = EasyHubIndicatorType.circularProgress;

        EasyHub.showMsg('fgyong blog'
            '公众号：fgyong的开发日记 公众号：fgyong的开发日记 公众号：fgyong的开发日记'
            '公众号：fgyong的开发日记 公众号：fgyong的开发日记 公众号：fgyong的开发日记');
        break;
      case 5:
        EasyHub.instance
          ..backgroundColor = Colors.greenAccent
          ..maskColor = Colors.red.withOpacity(0.5);

        errorOrInfo += 1;
        if (errorOrInfo % 2 == 0) {
          EasyHub.showErrorHub(
            '网络错误',
          );
        } else {
          EasyHub.showInfoHub(
            '网络错误',
          );
        }
        break;
      case 6:
        EasyHub.instance
          ..backgroundColor = Colors.black38
          ..iconForegroundColor = Colors.red;
        EasyHub.showCompleteHub('下载完成');
        break;
      case 7:
        EasyHub.instance.indicatorType = EasyHubIndicatorType.lineProgress;

        EasyHub.instance
          ..animationForegroundColor = new AlwaysStoppedAnimation(Colors.white)
          ..animationBackgroundColor = Colors.black38;
        EasyHub.show('正在下载。。。');

        break;
      case 8:
        EasyHub.instance.indicatorType =
            EasyHubIndicatorType.circularProgressEasyOutEasyIn;
        EasyHub.instance
          ..animationForegroundColor =
              new AlwaysStoppedAnimation(Colors.black.withOpacity(0.5))
          ..animationBackgroundColor = Colors.white;

        EasyHub.showHub();
        break;

      case 9:
        EasyHub.instance.indicatorType =
            EasyHubIndicatorType.circularProgressEasy;
        EasyHub.instance
          ..animationForegroundColor =
              new AlwaysStoppedAnimation(Colors.lightBlue)
          ..animationBackgroundColor = Colors.white;

        EasyHub.showHub();
        break;

      case 10:
        EasyHub.instance.indicatorType = EasyHubIndicatorType.singleFlipingRect;
        EasyHub.instance
          ..animationForegroundColor = new AlwaysStoppedAnimation(Colors.orange)
          ..animationBackgroundColor = Colors.white
          ..backgroundColor = Colors.white.withOpacity(0);

        EasyHub.showHub();
        break;
      //circleBeat
      case 11:
        EasyHub.instance.indicatorType = EasyHubIndicatorType.beattingCircle;
        EasyHub.instance
          ..animationForegroundColor =
              new AlwaysStoppedAnimation(Color.fromRGBO(1, 52, 255, 0.5))
          ..animationBackgroundColor = Colors.white
          ..backgroundColor = Colors.white;
        EasyHub.showHub();
        break;
      case 12:
        EasyHub.instance.indicatorType =
            EasyHubIndicatorType.singlebeattingCircle;
        EasyHub.instance
          ..animationForegroundColor =
              new AlwaysStoppedAnimation(Colors.orange.withOpacity(0.7))
          ..animationBackgroundColor = Colors.orangeAccent
          ..backgroundColor = Colors.white.withOpacity(0);

        EasyHub.showHub();
        break;
      case 13:
        EasyHub.instance.indicatorType = EasyHubIndicatorType.beatingRects;
        EasyHub.instance
          ..animationForegroundColor =
              new AlwaysStoppedAnimation(Colors.lightBlueAccent)
          ..animationBackgroundColor = Colors.orangeAccent
          ..backgroundColor = Colors.black.withOpacity(0.3);
        EasyHub.showHub();
        break;
      case 14:
        EasyHub.instance.indicatorType = EasyHubIndicatorType.rotatingCircles;
        EasyHub.instance
          ..animationForegroundColor =
              new AlwaysStoppedAnimation(Colors.lightBlueAccent)
          ..animationBackgroundColor = Colors.orangeAccent
          ..backgroundColor = Colors.white.withOpacity(0);

        EasyHub.showHub();
        break;
      case 15:
        EasyHub.instance.indicatorType =
            EasyHubIndicatorType.rotatingDeformedCircles;
        EasyHub.instance
          ..animationForegroundColor =
              new AlwaysStoppedAnimation(Colors.pinkAccent)
          ..animationBackgroundColor = Colors.orangeAccent
          ..backgroundColor = Colors.white.withOpacity(0);

        EasyHub.showHub();
        break;
      case 16:
        EasyHub.instance.indicatorType =
            EasyHubIndicatorType.rotatingDeformedCirclesRow;
        EasyHub.instance
          ..animationForegroundColor =
              new AlwaysStoppedAnimation(Colors.pinkAccent)
          ..animationBackgroundColor = Colors.orangeAccent
          ..backgroundColor = Colors.white.withOpacity(0);

        EasyHub.showHub();
        break;
      case 17:
        EasyHub.instance.indicatorType = EasyHubIndicatorType.rotatingTwoRect;
        EasyHub.instance
          ..animationForegroundColor =
              new AlwaysStoppedAnimation(Colors.lightBlueAccent)
          ..animationBackgroundColor = Colors.orangeAccent
          ..backgroundColor = Colors.white.withOpacity(0);

        EasyHub.showHub();
        break;
      case 18:
        EasyHub.instance.indicatorType =
            EasyHubIndicatorType.rotatingTwoCircles;
        EasyHub.instance
          ..animationForegroundColor =
              new AlwaysStoppedAnimation(Colors.greenAccent)
          ..animationBackgroundColor = Colors.orangeAccent
          ..backgroundColor = Colors.white.withOpacity(0);
        EasyHub.showHub();
        break;
      case 19:
        EasyHub.instance.indicatorType = EasyHubIndicatorType.foldingRect;
        EasyHub.instance
          ..animationForegroundColor = new AlwaysStoppedAnimation(Colors.orange)
          ..animationBackgroundColor = Colors.orangeAccent
          ..backgroundColor = Colors.white;
        EasyHub.showHub();
        break;
      case 20:
        EasyHub.instance.indicatorType = EasyHubIndicatorType.pendulumingBall;
        EasyHub.instance
          ..animationForegroundColor =
              new AlwaysStoppedAnimation(Colors.lightBlueAccent)
          ..animationBackgroundColor = Colors.orangeAccent
          ..backgroundColor = Colors.white;
        EasyHub.showHub();
        break;
      case 21:
        EasyHub.instance.indicatorType = EasyHubIndicatorType.waves;
        EasyHub.instance
          ..animationForegroundColor =
              new AlwaysStoppedAnimation(Colors.lightBlueAccent)
          ..animationBackgroundColor = Colors.orangeAccent
          ..backgroundColor = Colors.white;
        EasyHub.showHub();
        break;
      case 22: //💧
        EasyHub.instance.indicatorType = EasyHubIndicatorType.spitBubbles;
        EasyHub.instance
          ..animationForegroundColor =
              new AlwaysStoppedAnimation(Colors.lightBlueAccent)
          ..animationBackgroundColor = Colors.orangeAccent
          ..backgroundColor = Colors.white;
        EasyHub.showHub();
        break;
      case 23: //💧
        EasyHub.instance.indicatorType = EasyHubIndicatorType.movingCube;
        EasyHub.instance
          ..animationForegroundColor =
              new AlwaysStoppedAnimation(Colors.lightBlueAccent)
          ..animationBackgroundColor = Colors.orangeAccent
          ..backgroundColor = Colors.white;
        EasyHub.showHub();
        break;
      case 24: //旋转的魔球
        EasyHub.instance.indicatorType =
            EasyHubIndicatorType.rotatingTwoColorBall;
        EasyHub.instance
          ..animationForegroundColor =
              new AlwaysStoppedAnimation(Colors.lightBlueAccent)
          ..animationBackgroundColor = Colors.orangeAccent
          ..backgroundColor = Colors.white;
        EasyHub.showHub();
        break;
      case 25: //跳动的魔球
        EasyHub.instance.indicatorType = EasyHubIndicatorType.dancingBalls;
        EasyHub.instance
          ..animationForegroundColor =
              new AlwaysStoppedAnimation(Colors.lightBlueAccent)
          ..animationBackgroundColor = Colors.orangeAccent
          ..backgroundColor = Colors.white
          ..fontColor = Colors.black54;
        EasyHub.showHub();
        break;
      case 26: //跳动的九饼
        EasyHub.instance.indicatorType = EasyHubIndicatorType.flashingBalls;
        EasyHub.instance
          ..animationForegroundColor =
              new AlwaysStoppedAnimation(Colors.lightBlueAccent)
          ..animationBackgroundColor = Colors.orangeAccent
          ..backgroundColor = Colors.white;
        EasyHub.showHub();
        break;
      case 27: //掉落的小球
        EasyHub.instance.indicatorType = EasyHubIndicatorType.fallingBall;
        EasyHub.instance
          ..animationForegroundColor =
              new AlwaysStoppedAnimation(Colors.lightBlueAccent)
          ..animationBackgroundColor = Colors.orangeAccent
          ..backgroundColor = Colors.white
          ..maskStyle = EasyHubMaskStyle.none;
        EasyHub.showHub();
        break;
      case 28: //⏳
        EasyHub.instance.indicatorType = EasyHubIndicatorType.hourglass;
        EasyHub.instance
          ..animationForegroundColor =
              new AlwaysStoppedAnimation(Colors.lightBlueAccent)
          ..animationBackgroundColor = Colors.orangeAccent
          ..backgroundColor = Colors.white
          ..maskColor = Colors.black.withOpacity(0.5)
          ..maskStyle = EasyHubMaskStyle.light
          ..onTap = () {
            EasyHub.dismiss();
          };
        EasyHub.showHub();
        break;
      case 29: //跳动的矩形
        EasyHub.instance.indicatorType = EasyHubIndicatorType.dancingCube;
//    ..animationForegroundColor =  颜色固定 无法设置颜色
//    new AlwaysStoppedAnimation(Colors.lightBlueAccent)
//    ..animationBackgroundColor = Colors.orangeAccent
        EasyHub.showHub();
        break;
      case 30: //游泳的小球
        EasyHub.instance.indicatorType = EasyHubIndicatorType.swingingBall;
        EasyHub.instance
          ..animationForegroundColor =
              new AlwaysStoppedAnimation(Colors.lightBlueAccent)
          ..animationBackgroundColor = Colors.orangeAccent
          ..backgroundColor = Colors.white;
        EasyHub.showHub();
        break;
      case 31: //跳动的 小虫子
        EasyHub.instance.indicatorType = EasyHubIndicatorType.creepingBug;
        EasyHub.instance
          ..animationForegroundColor =
              new AlwaysStoppedAnimation(Colors.lightBlueAccent)
          ..animationBackgroundColor = Colors.orangeAccent
          ..backgroundColor = Colors.white;
        EasyHub.showHub();
        break;
      case 32: //跳绳小球
        EasyHub.instance.indicatorType = EasyHubIndicatorType.rubberBand;
        EasyHub.instance
          ..animationForegroundColor =
              new AlwaysStoppedAnimation(Colors.lightBlueAccent)
          ..animationBackgroundColor = Colors.orangeAccent
          ..backgroundColor = Colors.white;
        EasyHub.showHub();
        break;
      case 33: //下雨
        EasyHub.instance.indicatorType = EasyHubIndicatorType.rainCouplet;
        EasyHub.instance
          ..animationForegroundColor =
              new AlwaysStoppedAnimation(Colors.lightBlueAccent)
          ..animationBackgroundColor = Colors.orangeAccent
          ..backgroundColor = Colors.white;
        EasyHub.showHub();
        break;
      case 34: //下雨
        EasyHub.instance.indicatorType = EasyHubIndicatorType.flipDiamond;
        EasyHub.instance
          ..animationForegroundColor =
              new AlwaysStoppedAnimation(Colors.lightBlueAccent)
          ..animationBackgroundColor = Colors.orangeAccent
          ..backgroundColor = Colors.white;
        EasyHub.showHub();
        break;
      case 35: //线条
        EasyHub.instance.indicatorType = EasyHubIndicatorType.lineProgress;
        EasyHub.instance
          ..animationForegroundColor =
              new AlwaysStoppedAnimation(Colors.lightBlueAccent)
          ..animationBackgroundColor = Colors.orangeAccent
          ..backgroundColor = Colors.white;
        v = 0;
        t = Timer.periodic(
            Duration(
              milliseconds: 50,
            ), (_t) {
          if (v >= 1.0) {
            t?.cancel();
            EasyHub.dismiss();
          } else {
            v += 0.01;
          }
          EasyHub.showProgress('${(v * 100).toStringAsFixed(2)}%', value: v);
        });
        break;
      case 36: //碎片化矩形
        EasyHub.instance.indicatorType = EasyHubIndicatorType.fragmentRect;
        EasyHub.instance
          ..animationForegroundColor = new AlwaysStoppedAnimation(Colors.black)
          ..animationBackgroundColor = Colors.white
          ..backgroundColor = Colors.white;
        EasyHub.showHub();
        break;
    }

//    Future.delayed(Duration(seconds: 2)).then((v) {
////      Navigator.of(context).pop();
//    });
  }

  double v = 0;
}

//void _display() {
//  EasyHub.show('loading');
//  EasyHub.show('loading', duration: Duration(seconds: 2));
//
//  ///toast 2s later dismiss
//  EasyHub.showInfoHub('network miss');
//
//  ///default 2s
//  EasyHub.showMsg('download success');
//
//  ///default 2s
//  EasyHub.showErrorHub('An error occurred');
//
//  ///default 2s
//  EasyHub.showCompleteHub('done');
//
//  /// only hub without msg
//  /// when you did call EasyHub.dismiss(),it is dismissed;
//  EasyHub.showHub();
//
//  ///dismiss
//  EasyHub.dismiss();
//
//  /// custom your widget
//  EasyHub.showCustom(Container(
//    child: Text('my test'),
//  ));
//}

class NewPage extends StatefulWidget {
  NewPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _NewPage createState() => _NewPage();
}

class _NewPage extends State<NewPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WillPopScope(
          child: FlutterEasyHub(
            child: Container(
              color: Colors.white,
              child: FlatButton(
                child: EasyFragmentingRect(
                  color: Colors.orange,
                  width: 120,
                ),
                onPressed: () {
                  _show();
                },
              ),
            ),
          ),
          // ignore: missing_return
          onWillPop: () async {
            EasyHub.dismiss();
            return true;
          }),
    );
  }

  void _show() {
    EasyHub.instance.indicatorType = EasyHubIndicatorType.fragmentRect;
    EasyHub.instance
      ..animationForegroundColor = new AlwaysStoppedAnimation(Colors.black)
      ..animationBackgroundColor = Colors.white
      ..backgroundColor = Colors.white;
    EasyHub.showHub();
  }
}
