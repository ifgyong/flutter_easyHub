import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyhub/animation/activityIndicator.dart';
import 'package:flutter_easyhub/animation/easy_beating_circle.dart';
import 'package:flutter_easyhub/animation/easy_beating_rects.dart';
import 'package:flutter_easyhub/animation/easy_creeping_bug.dart';
import 'package:flutter_easyhub/animation/easy_custom_painter.dart';
import 'package:flutter_easyhub/animation/easy_dancing_ball.dart';
import 'package:flutter_easyhub/animation/easy_dancing_cube.dart';
import 'package:flutter_easyhub/animation/easy_falling_ball.dart';
import 'package:flutter_easyhub/animation/easy_flashing_circles.dart';
import 'package:flutter_easyhub/animation/easy_flip_diamond.dart';
import 'package:flutter_easyhub/animation/easy_fliping_rect.dart';
import 'package:flutter_easyhub/animation/easy_folding_rect.dart';
import 'package:flutter_easyhub/animation/easy_fragment_rect.dart';
import 'package:flutter_easyhub/animation/easy_hourglass_timer.dart';
import 'package:flutter_easyhub/animation/easy_moving_cube.dart';
import 'package:flutter_easyhub/animation/easy_pendulum_ball.dart';
import 'package:flutter_easyhub/animation/easy_progress_widget.dart';
import 'package:flutter_easyhub/animation/easy_rain_couplet.dart';
import 'package:flutter_easyhub/animation/easy_rotating_circles.dart';
import 'package:flutter_easyhub/animation/easy_rotating_two_circles.dart';
import 'package:flutter_easyhub/animation/easy_rotating_two_color_circles.dart';
import 'package:flutter_easyhub/animation/easy_rotating_two_rect.dart';
import 'package:flutter_easyhub/animation/easy_rubber_band.dart';
import 'package:flutter_easyhub/animation/easy_spit_bubbles.dart';
import 'package:flutter_easyhub/animation/easy_swimming_ball.dart';
import 'package:flutter_easyhub/animation/easy_waves.dart';
import 'package:flutter_easyhub/tool/easyHubTheme.dart';
import 'config.dart';
import 'package:flutter_easyhub/easyHub.dart';

class Tool {
  /// 根据类型获取动画
  static Widget getIndicatorWidget(EasyHubIndicatorType indicatorType,
      {Color circleBackgroundColor,
      Animation<Color> circleValueColor,
      double progress,
      Key key}) {
    Widget _indicator;
    switch (indicatorType) {
      case EasyHubIndicatorType.defaultType:
        _indicator = EasyCupertinoActivityIndicator(
          radius: 20,
          valueColor: EasyHubTheme.hubDefaultForegroundColor,
        );

        break;
      case EasyHubIndicatorType.circularProgress:
        _indicator = CircularProgressIndicator(
          backgroundColor: circleBackgroundColor,
          valueColor: circleValueColor,
        );

        break;
      case EasyHubIndicatorType.lineProgress:
        _indicator = LinearProgressIndicator(
          key: key,
          backgroundColor: circleBackgroundColor,
          valueColor: circleValueColor,
          value: progress,
        );
        break;
      case EasyHubIndicatorType.circularProgressEasyOutEasyIn:
        _indicator = EasyProgressWidget(
          value: 0.2,
          backgroundColor: circleBackgroundColor,
          valueColor: circleValueColor,
          type: EasyCustomCirclePainterType.custom,
        );
        break;
      case EasyHubIndicatorType.circularProgressEasy:
        _indicator = EasyProgressWidget(
          backgroundColor: circleBackgroundColor,
          valueColor: circleValueColor,
          type: EasyCustomCirclePainterType.startAndEnd,
          value: progress ?? 0.2,
        );
        break;
      case EasyHubIndicatorType.singleFlipingRect:
        _indicator = EasyFlipingRect(
          color: circleValueColor?.value,
        );
        break;
      case EasyHubIndicatorType.beattingCircle:
        _indicator = EasyBeattingCircles(
          color: circleValueColor?.value,
          single: false,
        );
        break;
      case EasyHubIndicatorType.singlebeattingCircle:
        _indicator = EasyBeattingCircles(
          color: circleValueColor?.value,
          single: true,
          radius: 30,
        );
        break;
      case EasyHubIndicatorType.beatingRects:
        _indicator = EasyBeatingRects(
          color: circleValueColor?.value,
        );
        return Container(
          padding: EasyHubTheme.hubPadding,
          child: _indicator,
          height: 80,
          width: 80,
        );
        break;
      case EasyHubIndicatorType.rotatingCircles:
        _indicator = EasyRotatingCircles(
          color: circleValueColor?.value,
        );
        break;
      case EasyHubIndicatorType.rotatingDeformedCircles: //有大有小
        _indicator = EasyRotatingCircles(
            color: circleValueColor?.value, isSmaller: true);
        break;
      case EasyHubIndicatorType.rotatingDeformedCirclesRow: //有大有小
        _indicator = EasyRotatingCircles(
          color: circleValueColor?.value,
          isSmaller: true,
          isLine: true,
        );
        break;
      case EasyHubIndicatorType.foldingRect:
        _indicator = EasyFoldingRect(
          width: 45,
          color: circleValueColor?.value,
        );
        break;
      case EasyHubIndicatorType.rotatingTwoCircles:
        _indicator = EasyRotatingCircle(
          radius: 45,
          color: circleValueColor?.value,
        );
        break;
      case EasyHubIndicatorType.rotatingTwoRect:
        _indicator = EasyRotatingTwoRect(
          width: 50,
          colors: [circleValueColor?.value, circleValueColor?.value],
        );
        break;
      case EasyHubIndicatorType.pendulumingBall:
        _indicator = Container(
          child: EasyPendulumBall(
            color: Colors.amber.withOpacity(0.8),
            colors: [Colors.blueGrey, Colors.red, Colors.lightGreen],
            radius: 5,
          ),
        );
        break;
      case EasyHubIndicatorType.waves:
        _indicator = EasyWaving(
          radius: 30,
          isHidenProgress: true,
          progress: progress ?? 0.5,
        );
        break;
      case EasyHubIndicatorType.spitBubbles: //水球滴水
        _indicator = EasySplitBubbles(
          radius: 15,
        );
        break;
      case EasyHubIndicatorType.movingCube: //水球滴水
        _indicator = EasyMovingCube(
          width: 15,
        );
        break;
      case EasyHubIndicatorType.rotatingTwoColorBall: //旋转的魔球
        _indicator = EasyRotatingTwoColorCircles(
          radius: 15,
        );
        break;
      case EasyHubIndicatorType.dancingBalls: //跳动的魔球

        _indicator = Container(
            width: 121,
            height: 100,
            child: EasyDancingBall(
              radius: 11,
            ));
        break;
      case EasyHubIndicatorType.flashingBalls: //跳动的九饼
        _indicator = EasyFlashCircles(
          radius: 10,
          color: EasyHub.instance.animationForegroundColor == null
              ? Colors.pinkAccent
              : EasyHub.instance.animationForegroundColor.value,
        );
        break;
      case EasyHubIndicatorType.fallingBall: //掉落的小球
        _indicator = EasyFallingBall(
          radius: 10,
          color: EasyHub.instance.animationForegroundColor == null
              ? Colors.orange
              : EasyHub.instance.animationForegroundColor.value,
        );
        break;
      case EasyHubIndicatorType.hourglass: //沙漏
        _indicator = EasyHourglassTimer(
          width: 60,
          color: EasyHub.instance.animationForegroundColor == null
              ? Colors.orange
              : EasyHub.instance.animationForegroundColor.value,
        );
        break;

      case EasyHubIndicatorType.dancingCube: //矩形跳舞
        _indicator = Container(
            width: 121,
            height: 100,
            child: EasyDancingCube(
              radius: 11,
            ));
        break;

      case EasyHubIndicatorType.swingingBall: //有用的蝌蚪
        _indicator = Container(
            width: 120,
            height: 80,
            child: EasySwimmingBall(
              radius: 8,
            ));
        break;

      case EasyHubIndicatorType.creepingBug: //跳动的虫子
        _indicator = EasyCreepingBug(
          radius: 30,
        );
        break;
      case EasyHubIndicatorType.rubberBand: //跳动的虫子
        _indicator = Container(
          width: 100,
          height: 80,
          child: EasyRubberBand(
            color: EasyHub.instance.animationForegroundColor == null
                ? Colors.orange
                : EasyHub.instance.animationForegroundColor.value,
          ),
        );
        break;
      case EasyHubIndicatorType.rainCouplet:
        _indicator = EasyRainCouplet(
            color: EasyHub.instance.animationForegroundColor == null
                ? Colors.orange
                : EasyHub.instance.animationForegroundColor.value);
        break;
      case EasyHubIndicatorType.flipDiamond:
        _indicator = EasyFlipDiamond(
            color: EasyHub.instance.animationForegroundColor == null
                ? Colors.orange
                : EasyHub.instance.animationForegroundColor.value);
        break;
      case EasyHubIndicatorType.fragmentRect:
        _indicator = EasyFragmentingRect(
            color: EasyHub.instance.animationForegroundColor == null
                ? Colors.orange
                : EasyHub.instance.animationForegroundColor.value);
        break;
    }

    return Container(
      padding: EasyHubTheme.hubPadding,
      child: _indicator,
    );
  }
}
