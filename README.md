# flutter_easyhub
![](https://badgen.net/github/license/micromatch/micromatch)
![](https://img.shields.io/pub/v/flutter_easyhub)

> 一个纯粹的flutter，支持android和iOS，没有一点原生代码，更简单的loading动画，现有20多种动画，支持自定义前景色和背景色，支持动画大小调整。

## 效果展示

### 详细动画

<!--|动画种类|效果|
|:--:|:--:|
|EasyHubIndicator_default|![](http://blog.fgyong.cn/15881531447.GIF) |
|EasyHubIndicator_CircularProgress|![](http://blog.fgyong.cn/158815327673.GIF) |
|showErrorHub|![](http://blog.fgyong.cn/158815333758.PNG) |
|showComplateHub|![](http://blog.fgyong.cn/158815337030.PNG) |
|EasyHubIndicator_LineProgress|![](http://blog.fgyong.cn/158815342172.GIF) |
|EasyHubIndicator_CircularProgressEasyOutEasyIn|![](http://blog.fgyong.cn/158815348244.GIF) |
|EasyHubIndicator_CircularProgressEasy|![](http://blog.fgyong.cn/158815353678.GIF) |
|EasyHubIndicator_singleFlipingRect|![](http://blog.fgyong.cn/158815359123.GIF) |
|EasyHubIndicator_beattingCircle|![](http://blog.fgyong.cn/15881537979.GIF) |
|EasyHubIndicator_singlebeattingCircle|![](http://blog.fgyong.cn/158815385940.GIF) |
|EasyHubIndicator_beatingRects|![](http://blog.fgyong.cn/158815397265.GIF)|
|EasyHubIndicator_rotatingCircles|![](http://blog.fgyong.cn/158815401292.GIF) |
|EasyHubIndicator_rotatingDeformedCircles|![](http://blog.fgyong.cn/158815406042.GIF) |
|EasyHubIndicator_rotatingDeformedCirclesRow|![](http://blog.fgyong.cn/158815411087.GIF) |
|EasyHubIndicator_rotatingTwoRect|![](http://blog.fgyong.cn/15881541753.GIF) |
|EasyHubIndicator_rotatingTwoCircles|![](http://blog.fgyong.cn/158815421527.GIF) |
|EasyHubIndicator_foldingRect|![](http://blog.fgyong.cn/158815425129.GIF) |
|EasyHubIndicator_swingingBall|![](http://blog.fgyong.cn/158823236312.GIF)|
|EasyHubIndicator_waves|![](http://blog.fgyong.cn/158874617749.GIF)|
|EasyHubIndicator_spitBubbles|![](http://blog.fgyong.cn/158884280749.GIF)|
|EasyHubIndicator_movingCube|![](http://blog.fgyong.cn/15889160117.GIF)|
|EasyHubIndicator_rotatingTwoColorBall|![](http://blog.fgyong.cn/158892703673.GIF)|-->




|![](http://blog.fgyong.cn/15881531447.GIF) default |![](http://blog.fgyong.cn/158815327673.GIF) CircularProgress|![](http://blog.fgyong.cn/158815333758.PNG) showErrorHub| ![](http://blog.fgyong.cn/158815337030.PNG) showComplateHub |![](http://blog.fgyong.cn/158815342172.GIF) LineProgress |
|:-:|:-:|:-:|:-:|:-:|
|![](http://blog.fgyong.cn/158815348244.GIF) CircularProgressEasyOutEasyIn |![](http://blog.fgyong.cn/158815353678.GIF) CircularProgressEasy |![](http://blog.fgyong.cn/158815359123.GIF) singleFlipingRect |![](http://blog.fgyong.cn/15881537979.GIF) beattingCircle |![](http://blog.fgyong.cn/158815385940.GIF) singlebeattingCircle |
![](http://blog.fgyong.cn/158815397265.GIF) beatingRects |![](http://blog.fgyong.cn/158815401292.GIF) rotatingCircles |![](http://blog.fgyong.cn/158815406042.GIF) rotatingDeformedCircles |![](http://blog.fgyong.cn/15881541753.GIF) rotatingTwoRect |![](http://blog.fgyong.cn/158815421527.GIF) rotatingTwoCircles |
|![](http://blog.fgyong.cn/158815425129.GIF) foldingRect |![](http://blog.fgyong.cn/158823236312.GIF) swingingBall |![](http://blog.fgyong.cn/158874617749.GIF) waves |![](http://blog.fgyong.cn/158884280749.GIF) spitBubbles |![](http://blog.fgyong.cn/15889160117.GIF) movingCube |
|![](http://blog.fgyong.cn/158892703673.GIF) rotatingTwoColorBall |![](http://blog.fgyong.cn/158900155158.GIF) dancingBalls|![](http://blog.fgyong.cn/158900524872.GIF) flashingBalls|






### 温馨提示 -->想看完整效果最好克隆本地直接运行,效果更佳!!
## easy use to use this package as a library

```
dependencies:
    flutter_easyhub: ^0.2.6

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
### 0.2.6 2020.05.09
> 添加正方体移动效果
> 添加魔球旋转效果
> 添加跳舞的4个小球效果

### 0.2.3 2020.05.07
> 添加水滴

### 0.2.2 2020.05.06
> 添加波浪动画

### 0.2.1 2020.04.29
> 添加钟摆动画，支持自定义球状半径和颜色

### 0.2.0 2020.04.29
> 添加多种动画

### [0.0.5 -- 0.1.1] 2020.04.24
> 更新备注和read me


### [0.0.3 -- 0.0.4] 2020.04.23
> 1. 增加菊花转,适配android 和iOS
> 2.增加错误和完成显示效果
> 3. 增加实例消失函数

### [0.0.2] 2020.04.21
> 优化文字动画分别展示
> 增加隐藏所有hub

### [0.0.1] 2020.04.20
> 添加浮窗，支持文字、进度条



