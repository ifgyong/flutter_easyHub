import 'package:flutter/material.dart';
import 'easy_hub.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
    'error hub',
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
    '水球'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: getList(),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget getList() {
    return new ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
            onTap: () {
              show(index);
            },
            child: Container(
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
            ));
      },
      itemCount: list.length,
    );
  }

  Timer t;
  void show(int index) {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (context) => NewPage(
              title: 'title',
            )));
    switch (index - 1) {
      case -1:
        EasyHub.dismiddAll();
        break;
      case 0:
        EasyHub.getInstance.indicatorType =
            EasyHubIndicatorType.EasyHubIndicator_default;
        EasyHub.getInstance.setParameter(
          background: Colors.black12,
        );
        EasyHub.show(context, '多行\nfgyong\n老师');
        break;
      case 1:
        EasyHub.getInstance.indicatorType =
            EasyHubIndicatorType.EasyHubIndicator_default;
        EasyHub.getInstance.setParameter(background: Colors.black12);

        EasyHub.showMsg(context, '单行哦 loading');
        break;
      case 2:
        EasyHub.getInstance.indicatorType =
            EasyHubIndicatorType.EasyHubIndicator_default;
        EasyHub.getInstance.setParameter(background: Colors.white);

        EasyHub.showHub(context);
        break;
      case 3:
        EasyHub.getInstance.indicatorType =
            EasyHubIndicatorType.EasyHubIndicator_CircularProgress;
        EasyHub.getInstance.setParameter(
            background: Colors.black38,
            circlebackgroundColor: Colors.white.withOpacity(0.5),
            circleValueColor: new AlwaysStoppedAnimation(Colors.white));

        EasyHub.show(context, '加载中。。');
        break;
      case 4:
        EasyHub.getInstance.indicatorType =
            EasyHubIndicatorType.EasyHubIndicator_CircularProgress;
        EasyHub.getInstance.setParameter(background: Colors.black38);

        EasyHub.showMsg(
            context,
            'fgyong blog'
            '公众号：fgyong的开发日记 公众号：fgyong的开发日记 公众号：fgyong的开发日记'
            '公众号：fgyong的开发日记 公众号：fgyong的开发日记 公众号：fgyong的开发日记');
        break;
      case 5:
        EasyHub.getInstance.setParameter(background: Colors.black38);
        EasyHub.getInstance.textStyle = TextStyle(
            fontSize: 15, color: Colors.white, decoration: TextDecoration.none);
        EasyHub.showErrorHub(context, '网络错误');
        break;
      case 6:
        EasyHub.getInstance.setParameter(background: Colors.black38);
        EasyHub.showComplateHub(context, '下载完成');

        break;
      case 7:
        EasyHub.getInstance.indicatorType =
            EasyHubIndicatorType.EasyHubIndicator_LineProgress;

        EasyHub.getInstance.setParameter(
            circleValueColor: new AlwaysStoppedAnimation(Colors.white),
            circlebackgroundColor: Colors.black38,
            background: Colors.black38);
        EasyHub.show(context, '正在下载。。。');

        break;
      case 8:
        EasyHub.getInstance.indicatorType =
            EasyHubIndicatorType.EasyHubIndicator_CircularProgressEasyOutEasyIn;

        EasyHub.getInstance.setParameter(
            circleValueColor: new AlwaysStoppedAnimation(Colors.white),
            circlebackgroundColor: Color.fromRGBO(180, 180, 180, 1));
        EasyHub.showHub(context);
        break;

      case 9:
        EasyHub.getInstance.indicatorType =
            EasyHubIndicatorType.EasyHubIndicator_CircularProgressEasy;
        EasyHub.getInstance.setParameter(
            circleValueColor: new AlwaysStoppedAnimation(Colors.lightBlue),
            circlebackgroundColor: Colors.white);

        EasyHub.showHub(context);
        break;

      case 10:
        EasyHub.getInstance.indicatorType =
            EasyHubIndicatorType.EasyHubIndicator_singleFlipingRect;
        EasyHub.getInstance.setParameter(
            circleValueColor: new AlwaysStoppedAnimation(Colors.lightBlue),
            circlebackgroundColor: Colors.white,
            background: Color.fromRGBO(0, 0, 0, 0));

        EasyHub.showHub(context);
        break;
      //EasyHubIndicator_circleBeat
      case 11:
        EasyHub.getInstance.indicatorType =
            EasyHubIndicatorType.EasyHubIndicator_beattingCircle;
        EasyHub.getInstance.setParameter(
            circleValueColor:
                new AlwaysStoppedAnimation(Color.fromRGBO(1, 52, 255, 0.5)),
            circlebackgroundColor: Colors.white,
            background: Color.fromRGBO(0, 0, 0, 0));

        EasyHub.showHub(
          context,
        );
        break;
      case 12:
        EasyHub.getInstance.indicatorType =
            EasyHubIndicatorType.EasyHubIndicator_singlebeattingCircle;
        EasyHub.getInstance.setParameter(
            circleValueColor:
                new AlwaysStoppedAnimation(Colors.orange.withOpacity(0.7)),
            circlebackgroundColor: Colors.orangeAccent,
            background: Color.fromRGBO(0, 0, 0, 0));
        EasyHub.showHub(context);
        break;
      case 13:
        EasyHub.getInstance.indicatorType =
            EasyHubIndicatorType.EasyHubIndicator_beatingRects;
        EasyHub.getInstance.setParameter(
            circleValueColor:
                new AlwaysStoppedAnimation(Colors.lightBlueAccent),
            circlebackgroundColor: Colors.orangeAccent,
            background: Color.fromRGBO(0, 0, 0, 0));
        EasyHub.showHub(context);
        break;
      case 14:
        EasyHub.getInstance.indicatorType =
            EasyHubIndicatorType.EasyHubIndicator_rotatingCircles;
        EasyHub.getInstance.setParameter(
            circleValueColor:
                new AlwaysStoppedAnimation(Colors.lightBlueAccent),
            circlebackgroundColor: Colors.orangeAccent,
            background: Color.fromRGBO(0, 0, 0, 0));
        EasyHub.showHub(context);
        break;
      case 15:
        EasyHub.getInstance.indicatorType =
            EasyHubIndicatorType.EasyHubIndicator_rotatingDeformedCircles;
        EasyHub.getInstance.setParameter(
            circleValueColor: new AlwaysStoppedAnimation(Colors.pinkAccent),
            background: Color.fromRGBO(0, 0, 0, 0));
        EasyHub.showHub(context);
        break;
      case 16:
        EasyHub.getInstance.indicatorType =
            EasyHubIndicatorType.EasyHubIndicator_rotatingDeformedCirclesRow;
        EasyHub.getInstance.setParameter(
            circleValueColor: new AlwaysStoppedAnimation(Colors.orangeAccent),
            background: Color.fromRGBO(0, 0, 0, 0));
        EasyHub.showHub(context);
        break;
      case 17:
        EasyHub.getInstance.indicatorType =
            EasyHubIndicatorType.EasyHubIndicator_rotatingTwoRect;
        EasyHub.getInstance.setParameter(
            circleValueColor:
                new AlwaysStoppedAnimation(Colors.lightBlueAccent),
            background: Color.fromRGBO(0, 0, 0, 0));
        EasyHub.showHub(context);
        break;
      case 18:
        EasyHub.getInstance.indicatorType =
            EasyHubIndicatorType.EasyHubIndicator_rotatingTwoCircles;
        EasyHub.getInstance.setParameter(
            circleValueColor:
                new AlwaysStoppedAnimation(Colors.lightBlueAccent),
            background: Color.fromRGBO(0, 0, 0, 0));
        EasyHub.showHub(context);
        break;
      case 19:
        EasyHub.getInstance.indicatorType =
            EasyHubIndicatorType.EasyHubIndicator_foldingRect;
        EasyHub.getInstance.setParameter(
            circleValueColor:
                new AlwaysStoppedAnimation(Colors.lightBlueAccent),
            background: Color.fromRGBO(0, 0, 0, 0));
        EasyHub.showHub(context);
        break;
      case 20:
        EasyHub.getInstance.indicatorType =
            EasyHubIndicatorType.EasyHubIndicator_swingingBall;
        EasyHub.getInstance.setParameter(
            circleValueColor:
                new AlwaysStoppedAnimation(Colors.lightBlueAccent),
            background: Color.fromRGBO(0, 0, 1, 0));
        EasyHub.showHub(context);
        break;
      case 21:
        EasyHub.getInstance.indicatorType =
            EasyHubIndicatorType.EasyHubIndicator_waves;
        EasyHub.getInstance.setParameter(
            circleValueColor: new AlwaysStoppedAnimation(Colors.lightBlue),
            background: Color.fromRGBO(0, 0, 1, 0));
        EasyHub.showHub(context);
        break;
      case 22: //💧
        EasyHub.getInstance.indicatorType =
            EasyHubIndicatorType.EasyHubIndicator_spitBubbles;
        EasyHub.getInstance.setParameter(
            circleValueColor: new AlwaysStoppedAnimation(Colors.lightBlue),
            background: Color.fromRGBO(0, 0, 1, 0));
        EasyHub.showHub(context);
        break;
    }

    Future.delayed(Duration(seconds: 25)).then((v) {
//      EasyHub.dismiddAll();
//      Navigator.of(context).pop();
    });
  }

  double v = 0;
}

class NewPage extends StatefulWidget {
  NewPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _NewPage createState() => _NewPage();
}

class _NewPage extends State<NewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WillPopScope(
          child: Container(
            color: Colors.white,
          ),
          // ignore: missing_return
          onWillPop: () async {
            EasyHub.dismiddAll();
            return true;
          }),
    );
  }
}
