// REVIEW

// Scrollable 主要通过对手势的处理来实现滑动效果
// Viewport 提供的是一个 视窗 的作用，也就是列表所在的可视区域大小
// Sliver 主要是用于在 Viewport 里面布局和渲染内容

// 三者占用的空间是重合的
// Sliver 父组件为 Viewport，Viewport 的父组件为 Scrollable

// 布局流程
// Scrollable 监听到用户滑动行为后，根据最新的滑动偏移构建 Viewport
// Viewport 将当前视口信息和配置信息通过 SliverConstraints 传递给 Sliver
// Sliver 中对子组件（RenderBox）按需进行构建和布局，然后确认自身的位置、绘制等信息，保存在 geometry 中（一个 SliverGeometry 对象）

// Widget 树中会有一个默认的 PrimaryScrollController，如果可滚动控件没传 controller 且 primary = true（默认），就使用全局的
// Scaffold 正是使用此来实现 iOS 上点击状态栏回到顶部

// Scrollbar 把子包起来就有滚动条了。内容少时，就算可滚动，也不会有滚动条

// ================================================================================

// ScrollBehavior.getScrollPhysics 根据平台返回不同的 ScrollPhysics，所以 ScrollPhysics 基本不用自己传

// ScrollPhysics 决定 滑到边界时的行为 和 停止滑动后的行为
//
// BouncingScrollPhysics
//   滑动到边界后可以继续拉，iOS 上的效果
//   内容少时不会滑动，可以这样 BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics())
// ClampingScrollPhysics
//   滑动到边界后不可继续拉，Android 上的效果
//   内容少时不会滑动，加上 parent 也不会滑
//   超界时没有那个弧线，怎么加？
//
// AlwaysScrollableScrollPhysics
// NeverScrollableScrollPhysics 不让用户滑动，目的是只让代码滑？
//
// PageScrollPhysics
//   给 PageView 用的，只停留在页面边界上，不能骑在页面中间
//   滑动到边界后可以继续拉，iOS 上的效果
//   内容少时不会滑动，可以这样 PageScrollPhysics(parent: AlwaysScrollableScrollPhysics())
//
// CarouselScrollPhysics 给 CarouselView 用的，自己用会崩，不研究
//
// FixedExtentScrollPhysics
//   制作那种日期滚轮用的，精准停留在某项上，ListWheelScrollView
//   只能配合 FixedExtentScrollController 使用
//
// RangeMaintainingScrollPhysics
//   文档太长，不知干嘛的

// ================================================================================

// ScrollController.keepScrollOffset 当值为 false 时，到底何时才会回滚到初始位置？

// 一个 ScrollController 可以给多个滚动视图用，它的 positions 数组保存了相应的 ScrollPosition
// ScrollController 的 animateTo/jumpTo 方法是调用 ScrollPosition 的同名方法来实现的

// ScrollController.attach/detach 到底是个什么样的操作，贴上了有何作用？没看懂

// 书上说：滚动控件先调用 controller.createScrollPosition 创建 position，然后再调用 attach 把 position 注册到 controller 中
// 然后 animateTo/jumpTo 才起作用。滚动控件销毁时调用 detach

// 两种方式接收滚动事件
//   1) ScrollController
//     controller.addListener(...)
//   2) NotificationListener，它的回调里面返回 true 时，滚动通知不会沿着链条向上传递，相当于吞掉了通知
//     NotificationListener(onNotification: (notification) { return true; }, child: ...)
// 区别是：一个要关联后才能接收，一个是只要位于上层树中就能接收。另外收到通知后，从里面获得的信息也不一样

// ================================================================================

// SingleChildScrollView 不会懒加载，所以，如果超出屏幕的内容太多，性能比较差，应该改用 ListView
//   reverse 用于做聊天那种窗口，创建后直接显示最后一行
//   keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag 拖动时关闭键盘

// SingleChildScrollView 是单个子元素，它并未使用 RenderSliver，而是在 performLayout 时直接调整子的 offset 来达到滑动效果
// 收到 紧300
//   无子，尺寸随紧
//   有子，尺寸随紧，但子收到 紧300 松0-inf
// 收到 松100-200
//   无子，尺寸尽量小 100
//   有子，尺寸尽量小 100，但子收到 松100-200 松0-inf
// 收到 无限0-inf
//   无子，尺寸尽量小 0
//   有子，尺寸随子，子可能非常大，子收到 0-inf
// return OverflowBox(
//   // minWidth: 300,
//   // maxWidth: 300,
//   // minHeight: 300,
//   // maxHeight: 300,
//   minWidth: 100,
//   maxWidth: 200,
//   minHeight: 100,
//   maxHeight: 200,
//   // minWidth: 0,
//   // maxWidth: double.infinity,
//   // minHeight: 0,
//   // maxHeight: double.infinity,
//   // child: SingleChildScrollView(),
//   child: SingleChildScrollView(child: Text('a', style: TextStyle(fontSize: 200))),
// );

// ================================================================================

// CustomScrollView 组件提供公共的 Scrollable 和 Viewport，然后它的 slivers 参数接受一个 Sliver 数组

// ================================================================================

// DraggableScrollableSheet 底部显示的 sheet，先显示一部分，拖动能显示更多部分，内部能滚动，拖完才能滚动
