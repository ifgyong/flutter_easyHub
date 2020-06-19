import 'package:flutter/material.dart';
import 'package:flutter_easyhub/easyHub.dart';
import 'package:flutter_easyhub/tool/config.dart';

class EasyHubTheme {
  /// color of mask
  static Color get maskColor {
    if (EasyHub.instance.maskStyle == EasyHubMaskStyle.custom &&
        EasyHub.instance.maskColor != null) {
      return EasyHub.instance.maskColor;
    } else if (EasyHub.instance.maskStyle == EasyHubMaskStyle.none) {
      return null;
    } else {
      return EasyHub.instance.maskStyle == EasyHubMaskStyle.light
          ? Colors.white.withOpacity(0.5)
          : Colors.black.withOpacity(0.5);
    }
  }

  /// default backgroundColor
  static Color get backgroundColor {
    if (EasyHub.instance.style == EasyHubStyle.custom) {
      return EasyHub.instance.backgroundColor ?? Colors.black45;
    }
    return EasyHub.instance.style == EasyHubStyle.light
        ? Colors.white
        : Colors.black45;
  }

  /// color of icon
  static Color get iconForegroundColor {
    if (EasyHub.instance.style == EasyHubStyle.custom &&
        EasyHub.instance.iconForegroundColor != null) {
      return EasyHub.instance.iconForegroundColor;
    }
    return EasyHub.instance.style == EasyHubStyle.dark
        ? Colors.white
        : Colors.black45;
  }

  /// used for [EasyHubStyle.custom]
  /// value for [EasyHub.instance.animationForegroundColor]
  static Color get hubDefaultForegroundColor {
    if (EasyHub.instance.style == EasyHubStyle.custom &&
        EasyHub.instance.animationForegroundColor != null) {
      return EasyHub.instance.animationForegroundColor.value;
    }
    return EasyHub.instance.style == EasyHubStyle.dark
        ? Colors.white
        : Colors.black45;
  }

  /// msg textStyle
  static TextStyle get textStyle {
    if (EasyHub.instance.style == EasyHubStyle.custom) {
      if (EasyHub.instance.textStyle != null) return EasyHub.instance.textStyle;
      return TextStyle(
          fontSize: 15,
          color: EasyHub.instance.fontColor == null ??
                  EasyHub.instance.style == EasyHubStyle.dark
              ? Colors.white
              : Colors.black54,
          decoration: TextDecoration.none);
    }
    return TextStyle(
        fontSize: 15,
        color: EasyHub.instance.style == EasyHubStyle.dark
            ? Colors.white
            : Colors.black54,
        decoration: TextDecoration.none);
  }

  static EdgeInsets get msgPadding {
    return EasyHub.instance.msgPadding;
  }

  static EdgeInsets get msgMargin {
    return EasyHub.instance.msgMargin;
  }

  /// default hub padding [padding]
  static EdgeInsets get hubPadding {
    return EdgeInsets.all(15);
  }
}
