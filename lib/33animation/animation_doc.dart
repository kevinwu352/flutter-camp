// REVIEW

// iOS Animation
// animation.timingFunction = curve
// animation.duration
// animation.fromValue?
// animation.toValue?
// animation.repeatCount
// animation.autoreverse

// Flutter 动画的核心原理：
// Animation<T> 表示一个根据时间变化的值，区间 0-1，这个值表示进度
// Animatable<T> 表示一个区间，主要子类是 Tween
// 将 0-1 区间的动画 Animation<T> 通过 Animatable<T> 放大，并输出目标区间，再赋给界面上的视图，期间可以修改动画曲线

// ================================================================================

// Animation<T>
// 主要的功能是保存动画的插值和状态
// 这是抽象类，只能用它的子类
// 注：
//   它和它的子类一起，定义了动画的 进度/曲线/状态
//   关于进度，时间是 x 轴，value 是 y 轴，时间肯定是匀速向前走的，期间 value 不一定是线性变化的，可能一会高一会低
//   反正用这个进度乘以后面真正动画的区间，就得到当前的位置

// value
// status
// isAnimating
// isCompleted
// isDismissed
// isForwardOrCompleted
//
// addListener / removeListener
// addStatusListener / removeStatusListener
// drive

// CurvedAnimation
// AnimationController
//
// AlwaysStoppedAnimation
// CompoundAnimation
// ProxyAnimation
// ReverseAnimation
// TrainHoppingAnimation

// --------------------------------------------------------------------------------

// AnimationController

// double? value 初始值，如果传 0.5，相当于动画已进行一半，剩下的动画只需要 duration/2 的时间
//   设置 value 会停止当前动画
// Duration? duration
// Duration? reverseDuration
//
// double lowerBound = 0.0 上下限能超过 1，但下限不能大于上限
// double upperBound = 1.0 传 2 能把 Tween 放大两倍
//
// AnimationBehavior animationBehavior = AnimationBehavior.normal 是 Accessibility 相关的
//
// required TickerProvider vsync

// repeat 会开始动画
//   bool reverse 如果是 true，动画会自动回滚
//   int? count 不传则一直动。回滚也算一次
//   Duration? period 优先级高于 controller 的 duration
//   double? min max 优先级高于 controller 的 lowerBound/upperBound
// forward 和 repeat 一样，都会从当前状态开始做动画
//   from
// 这俩随便调用，不用先暂停什么的
// 如果现在是 repeat，调 forward 会做完这圈，然后停止
// 如果是 forward，直接调 repeat，会重复动画下去
//
// stop() 停在当前进度
// reset() 内部将 value = 0，因为设置 value 会调用 stop，所以动画也会停止

// --------------------------------------------------------------------------------

// CurvedAnimation

// 假设当前我有一个 Animation<T> 实例，一般是个 AnimationController，不过它是线性的，我要给它加上 动画曲线 或 返回曲线
// parent 参数就是我要修改的那个 Animation<T> 实例
// final Animation<double> animation = CurvedAnimation(parent: controller, curve: Curves.ease, reverseCurve: ...);

// ================================================================================

// Animatable<T>
// 以 Animation<T> 作为输入，输出 T
// 主要子类是 Tween

// 将源动画 Animation<double> 转换成目标动画 Animation<T>
// Animation<T> animate(Animation<double> parent)
//
// 获取源动画当前的值，将此值转换成此区间对应的值，内部实现是直接调用 transform 方法
// T evaluate(Animation<double> animation)
// 不从源动画拿当前值，这里随便传一个值，将值转换
// T transform(double t)
//
// 将两个 tween 串联在一起，比分别使用效率高，避免产生中间 Animation 对象
// Animatable<T> chain(Animatable<double> parent)

// Tween
// CurveTween
// TweenSequence

// --------------------------------------------------------------------------------

// Tween
// 唯一职责是定义从输入范围到输出范围的映射，输入范围通常是 [0.0,1.0]，参数的 begin/end 定义输出范围
// 它不存储任何状态，它只相当于定义了一个转换算法，至于当前值是什么，主要看 Animation<double> 当前走到哪一步了
// 它有很多子类 SizeTween/IntTween/ColorTween

// 普通数值类型如何线性变化比较简单，反正就是一个乘法，但像 Color 这些类型就不能 color*value 了
// 所以很多支持做动画的数据类型就得自己提供线性变化的方法，也就是 lerp，这是静态方法
// 比如 ColorTween 内部就仅仅是调用 Color.lerp 来实现自己的成员 lerp 方法

// --------------------------------------------------------------------------------

// CurveTween
// 带曲线的区间，用于和正常区间串联，给正常区间增加曲线

// --------------------------------------------------------------------------------

// SingleTickerProviderStateMixin 单个 AnimationController 时用
// TickerProviderStateMixin 多个 AnimationController 时用
