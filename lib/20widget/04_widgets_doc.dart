// 一般规律
// XXX 创建控件
//   Divider({Key? key, double? height, double? thickness, double? indent, double? endIndent, Color? color, BorderRadiusGeometry? radius})
// XXXTheme 指定样式，样式传递给子
//   DividerTheme({Key? key, required DividerThemeData data, required Widget child})
// XXXThemeData 指定样式的具体内容
//   DividerThemeData({Color? color, double? space, double? thickness, double? indent, double? endIndent, BorderRadiusGeometry? radius})

// ================================================================================

// Card 圆角带阴影那种卡片

// Divider / VerticalDivider
//   color / thickness / endIndent

// Wrap 能自动换行的 Row/Column，Chip 放里面比较好
// Chip 三个元素的小组件，文字/图标/删除
//   ActionChip 添加 onPress，删除 delete 相关的，相当于两个元素的组件
//   ChoiceChip 增加选中状态，删除 delete 相关的
//   FilterChip 选中时，变宽，前面显示一个勾勾，背景色也变。除了有 delete，没看出和 ChoiceChip 有什么区别
//   InputChip 也有选中状态和删除按钮，允许设置 isEnabled，没看出和 FilterChip 有什么区别

// Checkbox 方形的复选框，可以有三种状态。还能开启错误模式 isError，整体朱红色
//   activeColor 选中时候的颜色
//   checkColor 勾勾的颜色，当然只有选中时候才有勾勾
//   fillColor 填充复选框内部空白的颜色，如果设置，选中时候的 activeColor 就看不到了
//   overlayColor 点击时波纹的颜色
