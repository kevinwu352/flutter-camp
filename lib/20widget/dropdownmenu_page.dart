import 'dart:collection';

import 'package:flutter/material.dart';

// T? initialSelection 初始值
// ValueChanged<T?>? onSelected
// int? maxLines = 1 被选中的值最多显示几行

// required List<DropdownMenuEntry<T>> dropdownMenuEntries

// bool enabled = true
// bool enableFilter = false 根据输入的内容，下边可选择的项会变化
// bool enableSearch = true 输入的时候会有个灰条条放到最适合的那一项上，回车就选中它

// double? width
// double? menuHeight 弹出来的下拉那部分的高度，默认是显示所有项

// Widget? leadingIcon
// Widget? trailingIcon
// Widget? selectedTrailingIcon 点击输入框以后的图标，不管有没有显示键盘
// bool showTrailingIcon = true

// Widget? label 没选中时显示在输入框内部，否则嵌入到上边框里面
// String? hintText 显示在输入框内部的占位文字
// String? helperText 显示在输入框正下方的帮助文字
// String? errorText 显示在输入框正下方的错误文字，输入框边框和里面的文字颜色也会变

// TextInputType? keyboardType 数字键盘/邮件键盘/...
// TextStyle? textStyle
// TextAlign textAlign = TextAlign.start 输入的文字靠哪，但 label 的位置不受此影响

// --------------------------------------------------------------------------------

// TextEditingController? controller

// FocusNode? focusNode
// bool? requestFocusOnTap 如果为真，点击的时候获取焦点并弹出键盘。手机上默认是 false，电脑上默认是 true

// --------------------------------------------------------------------------------

// Object? inputDecorationTheme
// MenuStyle? menuStyle

// EdgeInsetsGeometry? expandedInsets
// FilterCallback<T>? filterCallback
// SearchCallback<T>? searchCallback
// Offset? alignmentOffset

// List<TextInputFormatter>? inputFormatters
// DropdownMenuCloseBehavior closeBehavior = DropdownMenuCloseBehavior.all

// TextInputAction? textInputAction

class DropdownmenuPage extends StatefulWidget {
  const DropdownmenuPage({super.key});

  @override
  State<DropdownmenuPage> createState() => _DropdownmenuPageState();
}

class _DropdownmenuPageState extends State<DropdownmenuPage> {
  final TextEditingController colorController = TextEditingController();
  final TextEditingController iconController = TextEditingController();
  ColorLabel? selectedColor;
  IconLabel? selectedIcon;
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
            enabled: false,
            enableSearch: true,
            enableFilter: true,
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

// DropdownMenuEntry labels and values for the first dropdown menu.
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

typedef IconEntry = DropdownMenuEntry<IconLabel>;

// DropdownMenuEntry labels and values for the second dropdown menu.
enum IconLabel {
  smile('Smile', Icons.sentiment_satisfied_outlined),
  cloud('Cloud', Icons.cloud_outlined),
  brush('Brush', Icons.brush_outlined),
  heart('Heart', Icons.favorite);

  const IconLabel(this.label, this.icon);
  final String label;
  final IconData icon;

  static final List<IconEntry> entries = UnmodifiableListView<IconEntry>(
    values.map<IconEntry>((IconLabel icon) => IconEntry(value: icon, label: icon.label, leadingIcon: Icon(icon.icon))),
  );
}
