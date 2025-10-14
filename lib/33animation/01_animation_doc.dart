// Animation<T>
// 主要的功能是保存动画的插值和状态
// 这是抽象类，只能用它的子类
// 注：
// 它和它的子类一起，定义了动画的 进度/曲线/状态
// 关于进度，时间是 x 轴，value 是 y 轴，时间肯定是匀速向前走的，期间 value 不一定是线性变化的，可能一会高一会低
// 反正用这个进度乘以后面真正动画的区间，就得到当前的位置

//   value
//   status
//   isAnimating
//   isCompleted
//   isDismissed
//   isForwardOrCompleted
//
//   addListener / removeListener
//   addStatusListener / removeStatusListener
//   drive
//
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
// Duration? duration
// Duration? reverseDuration
//
// double lowerBound = 0.0
// double upperBound = 1.0 传 2 能把 Tween 放大两倍
//
// AnimationBehavior animationBehavior = AnimationBehavior.normal 是 Accessibility 相关的
//
// required TickerProvider vsync

// 还有一堆方法，后面再研究

// --------------------------------------------------------------------------------

// CurvedAnimation

// 假设当前我有一个 Animation<T> 实例，一般是个 AnimationController，不过它是线性的，我要给它加上 动画曲线 或 返回曲线
// parent 参数就是我要修改的那个 Animation<T> 实例
// final Animation<double> animation = CurvedAnimation(parent: controller, curve: Curves.ease, reverseCurve: ...);

// ================================================================================

// Tween
// 唯一职责是定义从输入范围到输出范围的映射，输入范围通常是 [0.0,1.0]，参数的 begin/end 定义输出范围
