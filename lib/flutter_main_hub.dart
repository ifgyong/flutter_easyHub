import 'package:flutter/material.dart';
import 'package:flutter_easyhub/easyHub.dart';
import 'package:flutter_easyhub/flutter_easy_hub.dart';

class FlutterEasyHub extends StatefulWidget {
  /// should be [MaterialApp] or [CupertinoApp].
  /// make sure that loading can be displayed in front of all other widgets
  final Widget child;

  final TextDirection textDirection;

  const FlutterEasyHub({
    Key key,
    @required this.child,
    this.textDirection = TextDirection.ltr,
  }) : super(key: key);

  @override
  _FlutterEasyHubState createState() => _FlutterEasyHubState();
}

class _FlutterEasyHubState extends State<FlutterEasyHub> {
//  List<Positioned> list;

  @override
  void initState() {
//    list = new List();
//    list.add(Positioned.fill(
//      child: widget.child,
//    ));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

//  void ininsert(Widget widget) {
//    list.add(Positioned.fill(child: widget));
//  }

  void remote(Widget widget) {}
  @override
  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Stack(
//        fit: StackFit.expand,
//        children: list,
//      ),
//    );
    return Directionality(
      child: Overlay(
        initialEntries: [
          OverlayEntry(
            builder: (BuildContext _context) {
              EasyHub.instance.context = _context;
              return widget.child;
            },
          ),
        ],
      ),
      textDirection: widget.textDirection,
    );
  }
}
