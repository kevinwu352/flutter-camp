// ScrollBehavior.getScrollPhysics 根据平台返回不同的 ScrollPhysics，所以 ScrollPhysics 基本不用自己传

// ================================================================================

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
