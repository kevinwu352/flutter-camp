import 'dart:collection';
import 'package:flutter/material.dart';

// 旧版是 DropdownButton

// 不会像 TextField 一样撑满宽度，用以下任意一种
// 貌似用这种时，弹出的下拉窗口会超出屏幕
// width: double.infinity,
// 所以，当时选择了用这种方式
// expandedInsets: EdgeInsets.zero,
//
// 默认高度 56
// 修改高度用以下方法
// inputDecorationTheme: InputDecorationThemeData(
//   修改高度后，左边的文字会垂直居中，但右边的图标不会居中，要把 isCollapsed 设为 true
//   constraints: BoxConstraints(maxHeight: 40),
//
//   就算 EdgeInsets.symmetric(horizontal: 20)，右边的图标也不会往内部移动
//   contentPadding: EdgeInsets.zero,
//
//   padding 和 collapsed 都能让左侧文字垂直居中，但此能让右侧图标垂直居中
//   isCollapsed: true,
// )

// ================================================================================

// T? initialSelection 初始值
// ValueChanged<T?>? onSelected
// int? maxLines = 1 被选中的值最多显示几行

// required List<DropdownMenuEntry<T>> dropdownMenuEntries

// bool enabled = true
// bool enableFilter = false 根据输入的内容，下边可选择的项会变化
// bool enableSearch = true 输入的时候会有个灰条条放到最适合的那一项上，回车就选中它
// FilterCallback<T>? filterCallback 自己计算，并返回相应的列表
// SearchCallback<T>? searchCallback 自己计算，并返回相应的列表

// double? width
// EdgeInsetsGeometry? expandedInsets 为空则根据菜单项的宽度来，不为空则根据父的宽度来，.zero 则等于父的宽度
// double? menuHeight 弹出来的下拉那部分的高度，默认是显示所有项
// Offset? alignmentOffset 下拉部分的偏移量

// Widget? leadingIcon
// Widget? trailingIcon
// Widget? selectedTrailingIcon 点击输入框以后的图标，不管有没有显示键盘
// bool showTrailingIcon = true

// Widget? label 没选中时显示在输入框内部，否则嵌入到上边框里面
// String? hintText 显示在输入框内部的占位文字
// String? helperText 显示在输入框正下方的帮助文字
// String? errorText 显示在输入框正下方的错误文字，输入框边框和里面的文字颜色也会变

// TextInputType? keyboardType 数字键盘/邮件键盘/...
// TextInputAction? textInputAction 回车键的类型
// TextStyle? textStyle
// TextAlign textAlign = TextAlign.start 输入的文字靠哪，但 label 的位置不受此影响

// MenuStyle? menuStyle 定义一堆外观
// Object? inputDecorationTheme 超多外观属性，传 InputDecorationThemeData

// --------------------------------------------------------------------------------

// DropdownMenuCloseBehavior closeBehavior = DropdownMenuCloseBehavior.all 选中某项时，要不要关闭下拉

// FocusNode? focusNode
// bool? requestFocusOnTap 如果为真，点击的时候获取焦点并弹出键盘。手机上默认是 false，电脑上默认是 true

// List<TextInputFormatter>? inputFormatters
//   LengthLimitingTextInputFormatter(4) 能选择 Orange，输入框也会显示全。但是如果自己输入只能输 4 位
//   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')) 能选择 Orange，输入框也会显示全。但是如果自己输入只能输数字

// TextEditingController? controller

class DropmenuPage extends StatefulWidget {
  const DropmenuPage({super.key});

  @override
  State<DropmenuPage> createState() => _DropmenuPageState();
}

class _DropmenuPageState extends State<DropmenuPage> {
  final TextEditingController colorController = TextEditingController();
  ColorLabel? selectedColor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dropdown Menu')),
      body: Column(
        children: [
          DropdownMenu<ColorLabel>(
            // initialSelection: ColorLabel.green,
            controller: colorController,
            // The default requestFocusOnTap value depends on the platform.
            // On mobile, it defaults to false, and on desktop, it defaults to true.
            // Setting this to true will trigger a focus request on the text field, and
            // the virtual keyboard will appear afterward.
            requestFocusOnTap: true,
            // keyboardType: TextInputType.url,
            // leadingIcon: const Icon(Icons.settings),
            // trailingIcon: Icon(Icons.run_circle),
            // selectedTrailingIcon: Icon(Icons.plus_one),
            // showTrailingIcon: true,
            label: const Text('Color'),
            // expandedInsets: EdgeInsets.zero,
            textInputAction: TextInputAction.search,

            closeBehavior: DropdownMenuCloseBehavior.all,

            alignmentOffset: Offset(0, 20),

            textStyle: TextStyle(fontSize: 10),

            // inputDecorationTheme: const InputDecorationTheme(
            //   filled: true,
            //   // contentPadding: EdgeInsets.symmetric(vertical: 5.0),
            // ),

            // inputFormatters: [
            //   // LengthLimitingTextInputFormatter(4),
            //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            // ],

            // textAlign: TextAlign.end,
            // width: 100,
            // maxLines: 2,
            // menuHeight: 185,
            // hintText: 'asdf',
            // helperText: 'god is a girl',
            // errorText: 'hehe',
            onSelected: (ColorLabel? color) {
              setState(() {
                selectedColor = color;
              });
            },
            dropdownMenuEntries: ColorLabel.entries,
          ),
        ],
      ),
    );
  }
}

typedef ColorEntry = DropdownMenuEntry<ColorLabel>;

enum ColorLabel {
  blue('Blue', Colors.blue),
  pink('Pink', Colors.pink),
  green('Green', Colors.green),
  yellow('Orange', Colors.orange),
  grey('Grey', Colors.grey);

  const ColorLabel(this.label, this.color);
  final String label;
  final Color color;

  static final List<ColorEntry> entries = UnmodifiableListView<ColorEntry>(
    values.map<ColorEntry>(
      (ColorLabel color) => ColorEntry(
        value: color,
        label: color.label,
        enabled: color.label != 'Grey',
        style: MenuItemButton.styleFrom(foregroundColor: color.color),
      ),
    ),
  );
}
