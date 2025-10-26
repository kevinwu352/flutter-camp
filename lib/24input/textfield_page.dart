import 'package:flutter/material.dart';

// 默认样式是只有下边框

// 关闭键盘
// FocusManager.instance.primaryFocus?.unfocus();
// onTapOutside / onTapUpOutside 都能用于隐藏键盘，但网上的例子用的是前者

// Autocomplete 用户输入时下边展示推荐条目的控件

// KeyboardListener 看文档和例子，应该是监听物理键盘事件的

// 如下用法会抛出异常，双击输入框
// TextField(readOnly: true, controller: controller)
// Currently, the system context menu can only be shown for an active text input connection

// ================================================================================

// 回车时自动跳到下一个输入框
// 根上用 FocusScope 控件
//   FocusScope(
//     node: node, // FocusScopeNode node = FocusScopeNode();
//     child: ..., // 输入框列表
//   )
// 输入框添加回车处理逻辑
//   TextField(
//     onEditingComplete: () {
//       if (node.focusedChild == node.children.last) {
//         print('submit');
//       } else {
//         node.nextFocus();
//       }
//     },
//   )
// 中间如果有按钮，可能会就不能跳到下一个输入框了，解决方法如下
//   TextButton(focusNode: FocusNode(skipTraversal: true))

// ================================================================================

// bool? enabled
// bool? ignorePointers 是否忽略点击事件
// bool readOnly = false 不能修改内容，但能被选中，选中后边框颜色变了

// TextEditingController? controller

// TextInputType? keyboardType 键盘类型
// TextInputAction? textInputAction 回车类型

// bool? autocorrect
// TextCapitalization textCapitalization = TextCapitalization.none
// bool enableSuggestions = true iOS 上无效果因为只有一个开关，Android 自动改正和推荐是两个开关
// SpellCheckConfiguration? spellCheckConfiguration 没研究透？

// 点回车时，先调 complete 再调 submitted
// ValueChanged<String>? onChanged
// VoidCallback? onEditingComplete 这个参数有个默认值，一般用 submitted 足够了
// ValueChanged<String>? onSubmitted 一般用于把焦点给下一个输入框

// bool onTapAlwaysCalled = false 设成 false 时，双击三击多击只会调 onTap 一次，单击每次都会调用 onTap
// GestureTapCallback? onTap
// TapRegionCallback? onTapOutside 获取焦点后，点击外面。必须得先有焦点
// TapRegionUpCallback? onTapUpOutside 获取焦点后，点击外面并抬起了。必须得先有焦点
// AppPrivateCommandCallback? onAppPrivateCommand 文档说是调用 某个输入法和它的用户知道的私有方法

// bool obscureText = false 密码框
// String obscuringCharacter = '•'

// TextStyle? style
// StrutStyle? strutStyle

// InputDecoration? decoration = const InputDecoration()

// --------------------------------------------------------------------------------

// List<TextInputFormatter>? inputFormatters

// TextDirection? textDirection
// TextAlign textAlign = TextAlign.start
// TextAlignVertical? textAlignVertical 垂直方向的位置，文档说是根据 baseline，具体怎么定位不清楚

// bool autofocus = false 进页面时，如果没有其它控件有焦点，则直接获取焦点
// FocusNode? focusNode
// bool? selectAllOnFocus 没效果呢？
// bool canRequestFocus = true 如果关闭，tab 键不会移向它，点击它也不会弹出键盘。虽然点击无键盘，但有个光标在闪

// bool? showCursor 是否显示光标
// double cursorWidth = 2.0
// double? cursorHeight 光标变矮以后是垂直居中的，并非位于下方
// Radius? cursorRadius
// bool? cursorOpacityAnimates 是否通过变化透明度来闪烁
// Color? cursorColor
// Color? cursorErrorColor 要显示错误用：decoration: InputDecoration(errorText: 'xxx')
// MouseCursor? mouseCursor

// 限制的是显示的行数，而不是能输入的行数
//   不传，单行，文字太多时向左被吞没
//   传 null，随着文字输入，输入框会变高
//   传 2，输入框变高，足够容纳两行，如果输太多文字向上被吞没
//   传 2-4，输入框变高，足够容纳两行，内容太多时输入框继续变高，但最多 4 行
// int? maxLines = 1
// int? minLines
// bool expands = false 是否占满父空间的高度，必须将 minLines/maxLines 设为 null
// int? maxLength 中文字算 1 个长度，框框右下面还有个 3/10 计数
// MaxLengthEnforcement? maxLengthEnforcement
//   .none 不限制你输，但如果超了，下边框和 3/10 变成红色
//   .enforced 即使中文输入法那种没确定的部分也不行
//   .truncateAfterCompositionEnds 中文输入法没确定之前，随便你输，但最后确定后，框里不会超
// 右下角的输入计数，默认的实现应该是 isFocused ? Text('$currentLength/$maxLength') : null
// InputCounterWidgetBuilder? buildCounter

// --------------------------------------------------------------------------------

// ScrollController? scrollController 多行时能控制滚动的位置
// EdgeInsets scrollPadding = const EdgeInsets.all(20.0) 没懂？
// ScrollPhysics? scrollPhysics

// Brightness? keyboardAppearance 软键盘的主题，文档说只在 iOS 上有效

// DragStartBehavior dragStartBehavior = DragStartBehavior.start

// UndoHistoryController? undoController 输入一段文字，进行 undo/redo
// 试了下用代码将输入框改变状态，变成边框高亮，没成功
// MaterialStatesController? statesController

// bool? enableInteractiveSelection 关闭时，长按只有粘贴菜单会显示，点击文字中间也不会把光标移过去
// TextSelectionControls? selectionControls 长按后的菜单，有几个子类，定义不同平台的样式
// EditableTextContextMenuBuilder? contextMenuBuilder = _defaultContextMenuBuilder 桌面上右键 或 手机上长按 触发出来的上下文菜单
// TextMagnifierConfiguration? magnifierConfiguration 长按输入框那个放大镜

// SmartDashesType? smartDashesType 只影响 iOS，两个连续的破折号会拼成一个长的
// SmartQuotesType? smartQuotesType 只影响 iOS，但不清楚是什么效果

// BoxHeightStyle? selectionHeightStyle 选中输入框里文字时，那个选中的高亮背景的尺寸
// BoxWidthStyle? selectionWidthStyle

// --------------------------------------------------------------------------------

// bool enableIMEPersonalizedLearning = true 只影响 Android，好像是输入法根据用户习惯自主学习

// 好像是用户用 Apple Pencil 直接在输入框写，没太懂？
// bool stylusHandwritingEnabled = EditableText.defaultStylusHandwritingEnabled

// 自动填充相关，没太懂？
// Iterable<String>? autofillHints = const <String>[]
// List<Locale>? hintLocales

// Object groupId = EditableText 没懂？

// ContentInsertionConfiguration? contentInsertionConfiguration 输入多媒体信息，不知怎么用？

// Clip clipBehavior = Clip.hardEdge

// String? restorationId

class TextfieldPage extends StatefulWidget {
  const TextfieldPage({super.key});

  @override
  State<TextfieldPage> createState() => _TextfieldPageState();
}

class _TextfieldPageState extends State<TextfieldPage> {
  late TextEditingController controller;
  final states = WidgetStatesController();
  final node = FocusNode();

  final sc = ScrollController();

  final undo = UndoHistoryController();

  var hasError = false;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: 'When needing');
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  var ison = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TextField')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // controller.text = 'god';
          // setState(() {
          //   hasError = !hasError;
          // });

          // setState(() {
          //   print('object');
          //   states.update(WidgetState.selected, true);
          // });

          // if (ison) {
          //   undo.redo();
          // } else {
          //   undo.undo();
          // }
          // ison = !ison;
          // sc.animateTo(20, duration: Duration(seconds: 2), curve: Curves.bounceOut);
          node.unfocus();
        },
        child: Icon(Icons.run_circle),
      ),
      body: Column(
        children: [
          // ...
          Container(
            // padding: EdgeInsets.symmetric(horizontal: 20),
            color: Colors.white,
            child: TextField(
              controller: controller,
              statesController: states,
              scrollController: sc,

              scrollPadding: EdgeInsets.all(100),

              // keyboardType: TextInputType.url,
              // textInputAction: TextInputAction.search,

              // textAlignVertical: TextAlignVertical.top,
              // autocorrect: false,
              // textCapitalization: TextCapitalization.characters,
              // enableSuggestions: true,
              // readOnly: true,
              // keyboardAppearance: Brightness.dark,
              // onChanged: (value) => print('changed: $value'),
              // onSubmitted: (value) => print('submitted: $value'),
              // onEditingComplete: () => print('complete'),
              // onTapAlwaysCalled: false,
              // onTap: () => print('tap'),
              onTapOutside: (event) {
                print('tap-out $event');
                // FocusManager.instance.primaryFocus?.unfocus();
                node.unfocus();
              },
              onTapUpOutside: (event) {
                print('tap-up-out $event');
              },
              // onAppPrivateCommand: (action, data) => print('private-cmd $action $data'),

              // enabled: false,
              // focusNode: node,

              // autofocus: true,
              // selectAllOnFocus: true,

              // showCursor: false,
              // cursorWidth: 4,
              // // cursorHeight: 10,
              // // cursorRadius: Radius.circular(2),
              // // cursorOpacityAnimates: true,
              // cursorColor: Colors.green,
              // cursorErrorColor: Colors.yellow,
              // decoration: InputDecoration(
              //   // labelText: 'Enter text',
              //   errorText: hasError ? 'This field is required' : null, // Show error text
              //   // errorText: 'asdf',
              // ),

              // obscureText: true,
              // obscuringCharacter: 'a',
              // style: TextStyle(color: Colors.red),
              // maxLength: 5,
              minLines: 2,
              maxLines: 4,
              // maxLines: 4,
              // maxLength: 10,
              // maxLengthEnforcement: MaxLengthEnforcement.none,
              // magnifierConfiguration: TextMagnifierConfiguration.disabled,
              // ignorePointers: false,
              // smartDashesType: SmartDashesType.enabled,
              // smartQuotesType: SmartQuotesType.enabled,
              // selectionHeightStyle: BoxHeightStyle.tight,
              // selectionWidthStyle: BoxWidthStyle.tight,
              // undoController: undo,
              // enableInteractiveSelection: true,
              // selectionControls: MaterialTextSelectionControls(),
              // stylusHandwritingEnabled: false,
              // autofillHints: ['aaa', 'bbb'],
              // buildCounter: (context, {required currentLength, required isFocused, required maxLength}) =>
              //     Text('[$currentLength $maxLength]'),
              // maxLength: 20,
              // buildCounter: (context, {required currentLength, required isFocused, required maxLength}) =>
              //     isFocused ? Text('[$currentLength $maxLength]') : null,
            ),
          ),
          SizedBox(height: 20),
          Container(
            color: Colors.green,
            child: TextField(
              focusNode: node,
              decoration: InputDecoration(
                icon: Icon(Icons.settings),
                iconColor: Colors.red,
                label: Text('name'),
                // labelText: 'asdf',
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                floatingLabelAlignment: FloatingLabelAlignment.start,
                // floatingLabelStyle: TextStyle(color: Colors.red),
                labelStyle: TextStyle(color: Colors.green),

                // alignLabelWithHint: true,
                helperText: 'Helper Text',

                hintText:
                    'When needing to access scrolling information from a context that is within the scrolling widget itself',
                // hintFadeDuration: Duration(seconds: 3),
                hintMaxLines: 1,

                // errorText: 'When needing to',
                // // errorMaxLines: 2,
                // errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green, width: 2)),
                // focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.yellow, width: 2)),
                // enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green, width: 2)),
                // disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.brown, width: 2)),
                // focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.yellow, width: 2)),

                // enabled: false,
                counter: Text('data'),
                counterText: '0 characters',

                border: OutlineInputBorder(),
                // suffixIcon: Icon(Icons.run_circle),
                // // suffixIconColor: Colors.amber,
                // // prefixIconConstraints: BoxConstraints.tight(Size(16, 16)),
                // // prefix: Text('a'),
                // suffixText: '123',
                // suffixStyle: TextStyle(color: Colors.red),
                filled: true,
                fillColor: Colors.amber,
                focusColor: Colors.teal,
                hoverColor: Colors.blue,

                // isCollapsed: false,
                // isDense: true,
                // visualDensity: VisualDensity.compact,
                // contentPadding: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
                constraints: BoxConstraints(maxWidth: 200),
              ),
              // minLines: 4,
              // maxLines: 8,
            ),
          ),
          SizedBox(height: 20),
          TextField(decoration: InputDecoration.collapsed(hintText: 'asdf', filled: true)),
          TextField(readOnly: true, controller: controller),
        ],
      ),
    );
  }
}
