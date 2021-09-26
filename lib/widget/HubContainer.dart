import 'package:flutter/material.dart';
import 'package:flutter_easyhub/flutter_easy_hub.dart';
import 'package:flutter_easyhub/tool/easyHubTheme.dart';

// ignore: must_be_immutable
class HubContainer extends StatefulWidget {
  final Widget left;
  final Widget top;
  final Widget right;
  final Widget bottom;

  final Widget center;
  bool show;

  /// display animation duration, default duration is [300ms]
  Duration showHubDuration = Duration(milliseconds: 300);

  /// hide animation duration, default duration is [300ms]
  Duration hideHubDuration = Duration(milliseconds: 300);

  /// display animation curve, default curve is [Curves.linear]
  Curve showHubCurve = Curves.linear;

  /// hide animation curve, default curve is [Curves.linear]

  Curve hideHubCurve = Curves.linear;
  HubContainer(
      {Key key,
      this.left,
      this.right,
      this.top,
      this.bottom,
      this.center,
      this.show = true,
      this.hideHubCurve,
      this.hideHubDuration,
      this.showHubCurve,
      this.showHubDuration})
      : super(key: key);
  HubContainerState createState() => HubContainerState();
}

class HubContainerState extends State<HubContainer> {
  bool firstInsert = true;
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    List<Widget> list = new List();
    if (widget.center != null) list.add(widget.center);
    if (widget.bottom != null) list.add(widget.bottom);
    Positioned p1;
    double op = 0.0;
    if (firstInsert == true) {
      firstInsert = false;
      op = 0.0;
      Future.delayed(Duration(milliseconds: 0), () async {
        if (mounted) {
          setState(() {});
        }
      });
    } else {
      op = 1.0;
    }
    if (widget.show != true) {
      op = 0.0;
    }
    if (EasyHub.instance.maskStyle != EasyHubMaskStyle.none) {
      p1 = Positioned.fill(
          child: AnimatedOpacity(
        duration: widget.show == true
            ? widget.showHubDuration
            : widget.hideHubDuration,
        curve: widget.show == true ? widget.showHubCurve : widget.hideHubCurve,
        opacity: op,
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

  void pop(VoidCallback callback) {
    if (mounted) {
      setState(() {
        widget.show = false;
      });
      Future.delayed(Duration(milliseconds: 300), () => callback());
    }
  }

//  void dismiss(Completer completer) {
//    Duration _animationDuration = const Duration(milliseconds: 300);
//    Future.delayed(_animationDuration, () {
//      completer.complete();
//    });
//  }
}
