// bool enabled = true
// InputBorder? border 只用它的 shape，颜色和宽度都不会体现出来，所以如果要定制，用其它几个
// InputBorder? enabledBorder
// InputBorder? disabledBorder
// InputBorder? focusedBorder

// bool? filled 为真时，不选中状态会填充 fillColor
// Color? fillColor
// Color? focusColor 文档说 输入框没用这颜色，因为输入框响应 focus 是通过变化 border 而不是背景色
// Color? hoverColor

// --------------------------------------------------------------------------------

// Widget? label 先在占位位置，点击后移到边框线上
// String? labelText 和上面只传其一
// TextStyle? labelStyle 文字在框框内部的样式
// TextStyle? floatingLabelStyle 当移到边线以后的样式，如果为空则用 labelStyle
// FloatingLabelBehavior? floatingLabelBehavior 文字始终位于边线上 文字始终位于框框内 文字自动变化位置
// FloatingLabelAlignment? floatingLabelAlignment 点击后文字位于上边线 中间 左边
// bool? alignLabelWithHint 输入框是多行时，false 能让 label 垂直居中

// String? hintText 占位文字
// Widget? hint
// TextStyle? hintStyle
// TextDirection? hintTextDirection
// Duration? hintFadeDuration 显示和隐藏的动画时间
// int? hintMaxLines 个人认为实际中不要改成多行，这东西会撑高输入框
// bool maintainHintSize = true 由多行占位文字带来的坑，没必要用多行占位文字

// Widget? prefixIcon 始终显示，居中对齐，图标和下面的能共存
// Color? prefixIconColor
// BoxConstraints? prefixIconConstraints
// Widget? prefix 选中才显示，和输入的文字 baseline 对齐
// String? prefixText prefix/prefixText 只能设其一
// TextStyle? prefixStyle

// Widget? suffixIcon
// Color? suffixIconColor
// BoxConstraints? suffixIconConstraints
// Widget? suffix
// String? suffixText
// TextStyle? suffixStyle

// --------------------------------------------------------------------------------

// Widget? icon 边框左外面的图标
// Color? iconColor

// Widget? helper 边框下面的帮助文字
// String? helperText
// TextStyle? helperStyle
// int? helperMaxLines

// Widget? error 和帮助文字位置相同，且优先级高于帮助文字
// String? errorText
// TextStyle? errorStyle
// int? errorMaxLines 多行文字会影响 TextField 整体高度
// InputBorder? errorBorder
// InputBorder? focusedErrorBorder

// Widget? counter
// String? counterText
// TextStyle? counterStyle
// String? semanticCounterText

// --------------------------------------------------------------------------------

// 整体的约束，而不仅仅是内部框框的
// 修改输入框高度后，光标的位置不对，要把 padding 也改改
// BoxConstraints? constraints
//
// 内部框区域的 padding，同时 helper/counter 也会受到水平 padding 的影响
// 和 isDense/isCollapsed 这些也有某种关联
// EdgeInsetsGeometry? contentPadding

// bool? isCollapsed 内部那个真正的框框变得很矮，用 InputDecoration.collapsed 来创建
// bool? isDense 稍微减少了一点高度，文档说，是不是位于 dense form 内
// VisualDensity? visualDensity
