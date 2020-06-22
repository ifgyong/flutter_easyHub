import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyhub/animation/easy_fragment_rect.dart';
import 'package:flutter_easyhub/flutter_easy_hub.dart';

class NewPage2 extends StatefulWidget {
  NewPage2({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _NewPage2 createState() => _NewPage2();
}

class _NewPage2 extends State<NewPage2> with AutomaticKeepAliveClientMixin {
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
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                    child: Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      FlatButton(
                        child: EasyFragmentingRect(
                          color: Colors.orange,
                          width: 120,
                        ),
                      ),
                      FlatButton(
                        child: Text('push'),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => NewPage2(
                                    title: 'push',
                                  )));
                        },
                      ),
                      FlatButton(
                        child: Text('showError'),
                        onPressed: () {
                          EasyHub.showErrorHub('error');
                        },
                      ),
                      FlatButton(
                        child: Text('info'),
                        onPressed: () {
                          EasyHub.showInfoHub('info');
                        },
                      ),
                      FlatButton(
                        child: Text('complete'),
                        onPressed: () {
                          EasyHub.showCompleteHub('complete');
                        },
                      )
                    ],
                  ),
                ))
              ],
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

  @override
  bool get wantKeepAlive => true;
}
