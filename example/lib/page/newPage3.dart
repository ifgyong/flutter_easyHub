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

class _NewPage2 extends State<NewPage2> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      EasyHub.showMsg('msg');
      print('state:$context');
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build $context');
//    super.build(context);

    Stack s = Stack(
      children: <Widget>[
        Positioned.fill(
            child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                child: EasyFragmentingRect(
                  color: Colors.orange,
                  width: 120,
                ),
              ),
              TextButton(
                child: Text('push'),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => new NewPage2(
                            title: 'push',
                          )));
                },
              ),
              TextButton(
                child: Text('showError'),
                onPressed: () {
                  EasyHub.showErrorHub('error');
                },
              ),
              TextButton(
                child: Text('info'),
                onPressed: () {
                  EasyHub.showInfoHub('info');
                },
              ),
              TextButton(
                child: Text('complete'),
                onPressed: () {
                  EasyHub.showCompleteHub('status');
                  print('state:$context');
                },
              )
            ],
          ),
        ))
      ],
    );
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: WillPopScope(
            child: s,
            // ignore: missing_return
            onWillPop: () async {
              EasyHub.dismiss();
              return true;
            }),
      ),
    );
  }
}
