// TextStyle? textStyle 里面颜色不起作用，但字号有用

// Color? foregroundColor
// Color? disabledForegroundColor
// ButtonLayerBuilder? foregroundBuilder 高级功能
// Color? overlayColor splash 颜色 和 高亮背景颜色。如果为空，从 foreground 生成一个。如果是 Colors.transparent，高亮状态/splash 都没了

// Color? backgroundColor
// Color? disabledBackgroundColor
// ButtonLayerBuilder? backgroundBuilder

// Color? iconColor
// Color? disabledIconColor
// double? iconSize
// IconAlignment? iconAlignment 图标在 前/后

// EdgeInsetsGeometry? padding 这不会造成内部空间
// Size? minimumSize 设置大小后，内部可能会存在空间，alignment 就有作用了
// Size? fixedSize
// Size? maximumSize
// AlignmentGeometry? alignment

// 这个控件的海拔，假设屏幕是地面，这个值是离屏幕的海拔
// 阴影在右下，下多一点。值越小则阴影越 实 明显，值越大阴影越 散 虚
// double? elevation
// Color? shadowColor 阴影颜色
// Color? surfaceTintColor M3 引入了一种新的方式来突显海拔，在背景前面蒙一层淡淡的颜色。AppBar 那边，如果设置纯绿色，会有一点淡淡的绿色在背景上
// 单独设置海拔无阴影（下面 Material 单独设置海拔就有阴影），加上背景色也不行。海拔和阴影颜色必须同时设置，且显示出来的阴影是胶囊形状的
// 另外 surfaceTintColor 真的在按钮背景的上面蒙了一层淡淡的颜色，海拔和它必须同时设置
//
//   Material(
//     elevation: 20.0,
//     // shadowColor: Colors.red,
//     surfaceTintColor: Colors.red,
//     child: Container(width: 100, height: 100, color: Colors.blue, child: Center(child: Text('Elevated'))),
//   )

// 定义边框，可以搞成一个圆形边框按钮
//   shape 里面也有 side 参数，但外面的优先级更高
// OutlinedBorder? shape
// BorderSide? side

// ================================================================================

// Duration? animationDuration

// VisualDensity? visualDensity
// MaterialTapTargetSize? tapTargetSize

// bool? enableFeedback

// InteractiveInkFeatureFactory? splashFactory

// MouseCursor? enabledMouseCursor
// MouseCursor? disabledMouseCursor
