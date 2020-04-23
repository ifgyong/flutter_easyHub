# fluttereasyhub
![](https://badgen.net/github/license/micromatch/micromatch)
![](https://img.shields.io/pub/v/flutter_easyhub)

> 一个展示toast和加载动画的 packages

#### iOS
![](iOS.GIF)
#### android
![](android.GIF)

## easy use to use this package as a library


```


dependencies:
  flutter_easyhub: ^*.*.*

$ flutter pub get

import 'package:flutter_easyhub/flutter_easyhub.dart';

```
### 初始化
```
EasyHub.getInstance
 ..setBackgroundColor(Colors.black38)
 ..setCircleBackgroundColor(Colors.lightGreen)
 ..setValueColor(new AlwaysStoppedAnimation(Colors.black38));
```

OR

```

EasyHub hub = EasyHub(
   circlebackgroundColor: Colors.black38,
   circleValueColor: new AlwaysStoppedAnimation(Colors.teal),
   background: Colors.black38);
   // OR
 hub
   ..setParameter(
       background: Colors.black38,
       circleValueColor: new AlwaysStoppedAnimation(Colors.black38),
       circlebackgroundColor: Colors.lightGreen);
hub.show_hub(
   context: context, type: EasyHubType.EasyHub_msg, msg: 'loading');

// 隐藏
hub.dismiss_hub();
// OR
 EasyHub.dismiddAll();

```

### 隐藏所有
 
```
 EasyHub.dismiddAll();
```

### 展示文本
 
```

 EasyHub.show(context, 'loading');
```
 
### 展示HUB

```
 EasyHub.showHub(context);
 
```
### 展示文本 + hub

```
 EasyHub.showMsg(context, '加载文字展示');
```


### 展示错误

```
EasyHub.showErrorHub(context, '网络错误');
```
### 展示完成

```
EasyHub.showComplateHub(context, '下载完成');
```

### 具体使用例子

```
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyhub/flutter_easyhub.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
    'error hub',
    'complate hub',
    'line',
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
                '${list[index]}',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ));
      },
      itemCount: list.length,
    );
  }

  Timer t;
  void show(int index) {
    switch (index - 1) {
      case -1:
        EasyHub.dismiddAll();
        break;
      case 0:
        EasyHub.getInstance.indicatorType =
            EasyHubIndicatorType.EasyHubIndicator_default;
        EasyHub.show(context, '多行\nfgyong\n老师');
        break;
      case 1:
        EasyHub.getInstance.indicatorType =
            EasyHubIndicatorType.EasyHubIndicator_default;
        EasyHub.showMsg(context, '单行哦 loading');
        break;
      case 2:
        EasyHub.getInstance.indicatorType =
            EasyHubIndicatorType.EasyHubIndicator_default;
        EasyHub.showHub(context);
        break;
      case 3:
        EasyHub.getInstance.indicatorType =
            EasyHubIndicatorType.EasyHubIndicator_CircularProgress;
        EasyHub.show(context, 'fgyong 公众号\nfgyong开发日记');
        break;
      case 4:
        EasyHub.getInstance.indicatorType =
            EasyHubIndicatorType.EasyHubIndicator_CircularProgress;
        EasyHub.showMsg(
            context,
            'fgyong blog'
            '公众号：fgyong的开发日记 公众号：fgyong的开发日记 公众号：fgyong的开发日记'
            '公众号：fgyong的开发日记 公众号：fgyong的开发日记 公众号：fgyong的开发日记');
        break;
      case 5:
        EasyHub.showErrorHub(context, '网络错误');
        break;
      case 6:
        EasyHub.showComplateHub(context, '下载完成');

        break;
      case 7:
        EasyHub.getInstance.indicatorType =
            EasyHubIndicatorType.EasyHubIndicator_LineProgress;

        EasyHub.getInstance.setParameter(
            circleValueColor: new AlwaysStoppedAnimation(Colors.white),
            circlebackgroundColor: Colors.black38);
        EasyHub.show(context, 'fgyong\nwww.fgyong.cn');

        break;
    }
    Future.delayed(Duration(seconds: 2)).then((v) {
      EasyHub.dismiddAll();
    });
  }
}
```



