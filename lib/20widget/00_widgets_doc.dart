// 一般规律
// XXX 创建控件
//   Divider({Key? key, double? height, double? thickness, double? indent, double? endIndent, Color? color, BorderRadiusGeometry? radius})
// XXXTheme 指定样式，样式传递给子
//   DividerTheme({Key? key, required DividerThemeData data, required Widget child})
// XXXThemeData 指定样式的具体内容
//   DividerThemeData({Color? color, double? space, double? thickness, double? indent, double? endIndent, BorderRadiusGeometry? radius})

// Clip 类型 none不切，hardEdge最快但不保真，antiAlias慢一点少用，antiAliasWithSaveLayer最慢不要用

// ================================================================================

// Card 圆角带阴影那种卡片

// CircleAvatar 圆形头像，能显示图片或字母

// Divider / VerticalDivider
//   color / thickness / endIndent

// Tooltip 参数 message，给子提供提示

// CarouselView 比较花哨，用到再研究吧

// DataTable/DataColumn/DataRow 像 excel 的表格，用到再研究吧

// Wrap 能自动换行的 Row/Column，Chip 放里面比较好
// Chip 三个元素的小组件，文字/图标/删除
//   ActionChip 添加 onPress，删除 delete 相关的，相当于两个元素的组件
//   ChoiceChip 增加选中状态，删除 delete 相关的
//   FilterChip 选中时，变宽，前面显示一个勾勾，背景色也变。除了有 delete，没看出和 ChoiceChip 有什么区别
//   InputChip 也有选中状态和删除按钮，允许设置 isEnabled，没看出和 FilterChip 有什么区别

// Checkbox 方形的复选框，可以有三种状态。还能开启错误模式 isError，整体朱红色。要改变边框颜色 side: BorderSide(color: Colors.red)
//   activeColor 选中时候的颜色，非勾勾区域
//   checkColor 勾勾的颜色，当然只有选中时候才有勾勾
//   fillColor 填充复选框内部空白的颜色，如果设置，选中时候的 activeColor 就看不到了
//   overlayColor 点击时波纹的颜色
// Radio 圆形的单选框，要与 RadioGroup 配合起来用
//   toggleable 再次点击则取消选中
//   activeColor 选中时候 圆边和中心点的颜色，肯定不包括空白，要不然就成一坨了
//   fillColor 圆边和中心点的颜色，不包括空白区域
//   backgroundColor 空白区域的颜色
//   overlayColor 点击时波纹的颜色

// 不管 badge 多大都不会撑大按钮，但如果 badge 太大会被按钮边界切掉
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
// showTimePicker
// 选择日期或日期区间，内部使用 DatePickerDialog
// showDatePicker
// showDateRangePicker
