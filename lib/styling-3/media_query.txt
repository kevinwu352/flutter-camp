

MediaQuery 里有三类数据
  viewInsets ： 被系统用户界面完全遮挡的部分大小，简单来说就是键盘高度
  padding ： 简单来说就是状态栏和底部安全区域，但是 bottom 会因为键盘弹出变成 0
  viewPadding  ：和 padding 一样，但是 bottom 部分不会发生改变
原始
  viewInsets: .zero
  padding: {0, 47, 0, 34}
  viewPadding: {0, 47, 0, 34}
键盘弹出
  viewInsets: {0, 0, 0, 336}
  padding: {0, 47, 0, 0}
  viewPadding: {0, 47, 0, 34}

MediaQueryData 有这些构造参数，下面四个可能是新加的
Size size = Size.zero,
double devicePixelRatio = 1.0,
TextScaler textScaler = _kUnspecifiedTextScaler,
Brightness platformBrightness = Brightness.light,
EdgeInsets padding = EdgeInsets.zero,
EdgeInsets viewInsets = EdgeInsets.zero,
EdgeInsets systemGestureInsets = EdgeInsets.zero,
EdgeInsets viewPadding = EdgeInsets.zero,
bool alwaysUse24HourFormat = false,
bool accessibleNavigation = false,
bool invertColors = false,
bool highContrast = false,
bool disableAnimations = false,
bool boldText = false,
NavigationMode navigationMode = NavigationMode.traditional,
  bool onOffSwitchLabels = false,
  DeviceGestureSettings gestureSettings = const DeviceGestureSettings(touchSlop: kTouchSlop),
  List<DisplayFeature> displayFeatures = const <ui.DisplayFeature>[],
  bool supportsShowingSystemContextMenu = false

devicePixelRatio表示的是一个物理像素代表多少个逻辑像素。devicePixelRatio并不要求是整数，比如在Nexus 6中，这个devicePixelRatio=3.5。

接下来是textScaleFactor，表示一个逻辑像素能够表示多少个字体像素。或者你可以将其理解为字体的放大程度。比如textScaleFactor=1.5，那么它的意思是呈现出来的字体要比给定的字体大50%。

然后是platformBrightness，表示的是设备的明亮程度。最常见的比如说明亮模式或者黑暗模式等。

padding表示的是被系统UI所部分遮罩,并不能完全看见的部分，通常是系统状态栏，比如iphone中的刘海等。
viewInsets指的是被系统UI所完全遮罩的部分，比如说我们在进行键盘输入的时候，会弹起键盘界面。
viewPadding表示的是被系统UI所部分遮罩,并不能完全看见的部分，通常是系统状态栏，比如iphone中的刘海等。

哇喔，看起来padding和viewPadding是一样的，那么事实是否如此呢？
这两者通常情况下是一样的，只有在出现键盘输入界面的时候两者就会发生不同。
简单来说，viewPadding是固定的，它的大小不会随键盘的显示而发生变化，Padding是可变化的，当键盘弹起，系统状态栏被遮罩的时候，它的bottom值就是0。

systemGestureInsets是一个特殊的手势区域，在这个区域里面只能识别部分的手势指令，而不能识别所有的手势指令，所以需要这样的一个属性。

alwaysUse24HourFormat表示是否使用24小时的时间格式。

accessibleNavigation表示用户是否使用了一些accessibility服务来和应用进行交互。