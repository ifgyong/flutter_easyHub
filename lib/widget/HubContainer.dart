import 'package:flutter/material.dart';
import 'package:flutter_easyhub/flutter_easy_hub.dart';
import 'package:flutter_easyhub/tool/easyHubTheme.dart';

class HubContainer extends StatefulWidget {
  final Widget left;
  final Widget top;
  final Widget right;
  final Widget bottom;

  final Widget center;

  HubContainer(
      {Key key, this.left, this.right, this.top, this.bottom, this.center})
      : super(key: key);
  _HubContainerState createState() => _HubContainerState();
}

class _HubContainerState extends State<HubContainer> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    List<Widget> list = new List();
    if (widget.center != null) list.add(widget.center);
    if (widget.bottom != null) list.add(widget.bottom);
    Positioned p1;
    if (EasyHub.instance.maskStyle != EasyHubMaskStyle.none) {
      p1 = Positioned.fill(
          child: Container(
        color: EasyHubTheme.maskColor,
        alignment: Alignment.center,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Container(
            color: EasyHubTheme.backgroundColor,
            constraints: BoxConstraints(
                minHeight: 60,
                minWidth: 50,
                maxWidth: _size.width - 40,
                maxHeight: _size.height - 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: list,
            ),
          ),
        ),
      ));
    } else {
      p1 = Positioned.fill(
          child: Container(
        alignment: Alignment.center,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Container(
            color: EasyHubTheme.backgroundColor,
            constraints: BoxConstraints(
                minHeight: 60,
                minWidth: 50,
                maxWidth: _size.width - 40,
                maxHeight: _size.height - 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: list,
            ),
          ),
        ),
      ));
    }
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[p1],
    );
  }

//  void dismiss(Completer completer) {
//    Duration _animationDuration = const Duration(milliseconds: 300);
//    Future.delayed(_animationDuration, () {
//      completer.complete();
//    });
//  }
}
