// REVIEW

// 一般规律
// XXX 创建控件
//   Divider({Key? key, double? height, double? thickness, double? indent, double? endIndent, Color? color, BorderRadiusGeometry? radius})
// XXXTheme 指定样式，样式传递给子
//   DividerTheme({Key? key, required DividerThemeData data, required Widget child})
// XXXThemeData 指定样式的具体内容
//   DividerThemeData({Color? color, double? space, double? thickness, double? indent, double? endIndent, BorderRadiusGeometry? radius})

// 一般规律
// EdgeInsetsGeometry 抽象基类
//   EdgeInsets
//   EdgeInsetsDirectional start/end 之类的，根据系统 left to right / right to left 来决定
// AlignmentGeometry 抽象基类
//   Alignment
//   AlignmentDirectional
// BorderRadiusGeometry 抽象基类
//   BorderRadius
//   BorderRadiusDirectional

// ================================================================================

// 一种撑大 Scaffold.body 的方式
// ConstrainedBox(
//   constraints: BoxConstraints.expand(),
//   child:
// )

// 生成固定数量的视图
// List.generate(10, (i) => Text(''))

// ================================================================================

// Placeholder 默认占满父空间，如果父是无限的则用 fallback size

// Divider / VerticalDivider
//   color / thickness / endIndent

// Tooltip 参数 message，给子提供提示

// Card 圆角带阴影那种卡片

// CircleAvatar 圆形头像，能显示图片或字母
//   Stack(
//     alignment: Alignment(0.6, 0.6),
//     children: [
//       CircleAvatar(backgroundImage: AssetImage("assets/images/jessica.jpg"), radius: 100),
//       Container(
//         decoration: BoxDecoration(color: Colors.black45),
//         child: Text('Jessica', style: TextStyle(fontSize: 20, color: Colors.white)),
//       ),
//     ],
//   )

// CarouselView 比较花哨，用到再研究吧
// Flow 比较花哨，能做弹出一堆按钮的按钮。接收一个 delegate，它里面控制子元素的显示，能加个 animation，让这个控制过程是有动画的
//   性能好；灵活，完全自己定义布局；但使用复杂，很少用

// LayoutBuilder 可以根据父传过来的约束决定显示 一列/两列。可以根据设备的尺寸来实现响应式布局
// 通常用于父约束子的尺寸，而父不依赖于子的固有尺寸
//   我的理解是，父把约束传给子，子选择显示一列两列，然后把尺寸反馈给父，父紧贴子的尺寸
//   这最终结果用的不是子的固有尺寸，而是子根据父给的约束来自己决定的。固有尺寸肯定只有一个，而这里的最终尺寸是根据约束变化的
// 最终结果父和子一样大

// DataTable/DataColumn/DataRow 像 excel 的表格，用到再研究吧

// Checkbox 方形的复选框，可以有三种状态。还能开启错误模式 isError，整体朱红色。要改变边框颜色 side: BorderSide(color: Colors.red)
// 默认尺寸 48*48，设置 VisualDensity 后尺寸分别是 48 44 40，设置 .shrinkWrap 后 40 36 32，中间的框没变只是 padding 变了
// 另一个方法是 Transform.scale，不过这是整体缩放
//   activeColor 选中时候的颜色，非勾勾区域
//   checkColor 勾勾的颜色，当然只有选中时候才有勾勾
//   fillColor 填充复选框内部空白的颜色，如果设置，选中时候的 activeColor 就看不到了
//   overlayColor 点击时波纹的颜色
// Radio 圆形的单选框，要与 RadioGroup 配合起来用
// 默认尺寸 48*48，修改方法和 Checkbox 一模一样
//   toggleable 再次点击则取消选中
//   activeColor 选中时候 圆边和中心点的颜色，肯定不包括空白，要不然就成一坨了
//   fillColor 圆边和中心点的颜色，不包括空白区域
//   backgroundColor 空白区域的颜色
//   overlayColor 点击时波纹的颜色

// 不管 badge 多大都不会撑大按钮，但太大的 badge 会被按钮边界切掉
// IconButton(
//   icon: const Badge(
//     // alignment: Alignment.bottomLeft,
//     // offset: Offset(-10, 0), 有个默认值的，往右上移出去了
//
//     backgroundColor: Colors.green,
//     // textColor: Colors.red,
//     label: Text('10'), // 为空时显示一个小红点
//     // isLabelVisible: true, 控制 label 是否显示
//
//     // largeSize: 30, 有 label 时的高度
//     // smallSize: 6, 无 label 时的直径
//     // padding: EdgeInsets.all(20),
//     child: Icon(Icons.receipt),
//   ),
//   onPressed: () {},
// )

// 选择时间
//   showTimePicker
// 选择日期或日期区间，内部使用 DatePickerDialog
//   showDatePicker
//   showDateRangePicker

// Dismissible 左右滑显示列表某行下面的选项
// InteractiveViewer 查看大图片，也能放其它控件，反正就是大的

// Draggable<Color>，定义被移动的数据类型，正常情况显示，拖动中原始位置显示，拖动中鼠标下面显示。LongPressDraggable
// 接收方是 DragTarget，也有 child 定义自己的外观

// NotificationListener<T> 接收节点树下层传递过来的通知，子节点/孙子/重孙，只接收 T 类型，返回 true 能吞掉此消息
// 前一个 Route 收不到通知，只能当前页面接收子树发出来的通知
// 用 NotificationListener 包装 MaterialApp 时，能收到其它页面发出的通知，证明路由切换发生在它内部
// 包装 home: 不行，证明 home: 下是一个路由，跳转到其它路由以后，就是不同的树了
// 通知类
// class MyNotification extends Notification {
//   final String message;
//   MyNotification(this.message);
// }
// 发送通知
// context.dispatchNotification(MyNotification('hehe'));
// MyNotification('haha').dispatch(context);
// 接收通知
// NotificationListener(
//   onNotification: (notification) {
//     return false; // 通知继续往上传递
//   },
//   child: Builder( // 本来 context 是 build 方法的，它上面没有 listener，这个 Builder.context 上面有 listener
//     builder: (context) { },
//   ),
// )

// 把子元素切成圆角
// ClipRRect(
//   borderRadius: BorderRadius.circular(20),
//   child: Image.asset(...)
// )

// PopScope 控制导航返回操作，Form.canPop 类似
