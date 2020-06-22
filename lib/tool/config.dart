//GlobalKey
enum EasyHubType {
  msg, //只有文字
  hub, //只有hub
  all, //都有
  custom, //自定义
}
enum EasyHubMaskStyle {
  dark, //蒙版黑色
  light, //蒙版亮色
  none, //无蒙版
  custom, //蒙版自定义颜色
}
enum EasyHubStyle {
  dark, //黑色
  light, //亮色
  custom, //自定义颜色
}
enum EasyHubIndicatorType {
  defaultType, //默认菊花转
  circularProgress, //有进度条的 系统
  circularProgressEasyOutEasyIn, //快进快出
  circularProgressEasy, //匀速
  lineProgress, //有进度条的 线条

  singleFlipingRect, //单个矩形翻转动画
  beatingRects, //竖条跳动
  beattingCircle, //心跳圆圈
  singlebeattingCircle, //心跳圆圈
  rotatingCircles, //圆圈追逐

  rotatingDeformedCircles, //圆圈追逐 变形哦

  rotatingDeformedCirclesRow, //一排三个圆圈跳动

  rotatingTwoRect, //两个矩形追逐
  rotatingTwoCircles, //两个圆追逐
  foldingRect, //折叠矩形
  fragmentRect, //碎片矩形
  pendulumingBall, //摆钟
  waves, //波浪
  spitBubbles, //水球 滴水
  movingCube, //正方体解体
  rotatingTwoColorBall, //旋转的魔球
  dancingBalls, //跳动的魔球
  flashingBalls, //跳动的九饼
  fallingBall, //掉落的小球
  hourglass, //沙漏
  dancingCube, //跳动的矩形
  swingingBall, //跳动的小球
  creepingBug, //跳动的虫子
  rubberBand, //跳绳小球
  rainCouplet, //像下雨般的小球
  flipDiamond, // 翻转的线条菱形
}
