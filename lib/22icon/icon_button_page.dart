import 'package:flutter/material.dart';

// 样式继承，优先顺序是 自身属性 > IconButtonTheme > IconTheme

// ================================================================================

// Widget icon 默认是方形的，如果不是，可能会渲染不正确
// double? iconSize 设置图标的尺寸，不是按钮的。不要写到 Icon 里 Icon(Icons.favorite, size: 72)
// VoidCallback? onPressed // 如果为空，则变成 disabled
// VoidCallback? onLongPress

// Color? color 图标的颜色，图标可能是镂空的
// Color? disabledColor 图标的颜色，图标可能是镂空的
// Color? highlightColor 点击时闪过的颜色，在图标后面，不影响图标的颜色

// 变成一个 toggle，为空时是正常按钮
// 点击不会自动切换，要自己在按钮回调里面 setState(() => sel = !sel);
// bool? isSelected
// Widget? selectedIcon 选中时候的图标

// 新建按钮不做配置时，尺寸 48，图标 24，文档说默认 padding 是 8。24 + 8*2 = 40，这 48 咋来的？
// 答：IconButton 的实现里面写死了最小宽高 48。所以，padding<=12 完全没变化，padding=13 时，按钮尺寸变为 24 + 13*2 = 50
// EdgeInsetsGeometry? padding 设置这个并不会在按钮内部创造空间
// BoxConstraints? constraints
// AlignmentGeometry? alignment 当 constraints: BoxConstraints(minWidth: 100, minHeight: 100) 时，按钮内部有空间了，此属性会起作用

// ================================================================================

// 长按时，弹出来一行字，弹出来的时候，好像还有一个响声
// 我发现长按时也有这响声，所以，我估计这声音是长按带来的，只不过长按顺带显示了 tooltip
// String? tooltip
// 是否提供反馈，和平台有关，比如 haptic。上面的长按声音可以用这关掉
// bool? enableFeedback

// 按钮被点击时，点击的那个位置释放出一个圆形的波纹，然后消散掉
// 如果 useMaterial3 == true，会忽略掉这俩属性，用 highlightColor 和 Material.defaultSplashRadius
// Color? splashColor
// double? splashRadius

// 定义控件在水平或垂直方向的空间
// IconButton 本来是 standard，点击后看到圆形的背景区域，如果是 compact，则变成胶囊了，说明按钮变矮了
// 很多控件都有这属性，不同的控件效果不同。ThemeData 能全局修改此属性
// VisualDensity? visualDensity

// focusColor 不起作用，如何让 IconButton 获取到焦点呢？node.requestFocus() 也不行
// bool autofocus = false
// Color? focusColor
// FocusNode? focusNode

// ValueChanged<bool>? onHover
// Color? hoverColor
// MouseCursor? mouseCursor 鼠标样式，系统的在 SystemMouseCursors 里面

// ==========

// ButtonStyle? style

class IconButtonPage extends StatelessWidget {
  const IconButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final VoidCallback? onPressed = () {};

    final node = FocusNode();

    return Scaffold(
      appBar: AppBar(title: Text('Icon Button')),
      backgroundColor: Colors.teal,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          node.requestFocus();
        },
        child: Icon(Icons.run_circle),
      ),
      body: Column(
        children: [
          IconButton(icon: const Icon(Icons.android), color: Colors.red, onPressed: () {}),
          // 给按钮加背景，后面再研究一下这个背景的用法？
          // 这个按钮，看起来比上面的大，其实他俩一样大，都是 48*48
          Ink(
            decoration: const ShapeDecoration(color: Colors.lightBlue, shape: CircleBorder()),
            child: IconButton(icon: const Icon(Icons.android), color: Colors.white, onPressed: () {}),
          ),

          // 去除按钮最小尺寸 48 限制
          IconButton(
            onPressed: () {},
            // iconSize: 30,
            icon: Icon(Icons.settings),
            constraints: BoxConstraints(),
            padding: EdgeInsets.zero,
            // 本来上两行就可以了，最近几年好像改了什么，必须加这行
            // ThemeData 里也能配置这属性，但那里是全局的
            style: ButtonStyle(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
          ),

          Text('-----'),

          // 四种预设类型
          IconButton(onPressed: onPressed, icon: const Icon(Icons.filter_drama)),
          IconButton.filled(onPressed: onPressed, icon: const Icon(Icons.filter_drama)),
          IconButton.filledTonal(onPressed: onPressed, icon: const Icon(Icons.filter_drama)),
          IconButton.outlined(onPressed: onPressed, icon: const Icon(Icons.filter_drama)),

          Text('-----'),

          IconButton(
            onPressed: () {},
            icon: Icon(Icons.run_circle),
            color: Colors.red,
            constraints: BoxConstraints(minWidth: 100, minHeight: 100),
            alignment: Alignment.bottomRight,
          ),
        ],
      ),
    );
  }
}
