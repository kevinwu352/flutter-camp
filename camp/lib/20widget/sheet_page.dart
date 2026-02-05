import 'package:flutter/material.dart';

// 两种类型的 BottomSheet
//   showBottomSheet 相当于页面内容的附加内容，既没有遮罩，也不影响背后的点击。另外，Scaffold.bottomSheet 参数也是此功能
//   showModalBottomSheet 要求用户只能专注于此

// 全局的 BottomSheetThemeData 会影响它俩

// ================================================================================

// showModalBottomSheet 用法

// Color? backgroundColor 弹窗内容的背景色，内容的背景得是透明才能看到
// Color? barrierColor 弹窗背后那个遮罩色
// String? barrierLabel 给 semantic 用的

// ShapeBorder? shape 默认情况，弹窗上边两个是圆角，下边两个不是
// Clip? clipBehavior 沿边框裁剪

// bool enableDrag = true
// bool? showDragHandle
// bool isDismissible = true 点击遮罩关闭弹窗

// 如果为真，弹窗内的导航条不会伸到状态栏下方，那里会由遮罩盖着
// 内部实现里 _getConstraintsForChild 本来入参是 紧高874，变成 紧高812
// bool useSafeArea = false
//
// _getConstraintsForChild 内部实现，收到的是屏幕那么大的紧约束
// 给子的是 紧宽，如果 isScrollControlled 则 0-874，否则 0-(874*ratio)
// 这个参数在 isScrollControlled 为假时才有效
// double scrollControlDisabledMaxHeightRatio = _defaultScrollControlDisabledMaxHeightRatio
//
// 传给子，强行设置子尺寸
// 这参数在内部用在哪里的？不知道，没找到
// BoxConstraints? constraints
//
// 感觉：
// 如果要 iOS 那种 present 效果，用如下代码，但如果子里再 push，新页面会是全屏
//   useSafeArea: true,
//   scrollControlDisabledMaxHeightRatio: 1,
//   shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
//   clipBehavior: Clip.hardEdge,
// _getConstraintsForChild 的约束传给子，如果子是 Scaffold，它会占尽量多的空间，如果子是 Text，它占用尽量小，所以弹窗就会很小

// --------------------------------------------------------------------------------

// AnimationController? transitionAnimationController
// AnimationStyle? sheetAnimationStyle 显示和关闭的动画 曲线/时间

// 文档说：内容是否有 ListView/GridView 之类的滑动组件，没试过效果
// bool isScrollControlled = false
// 文档说：确保弹窗从根上弹窗，让弹窗位于一切其它内容之上，因为有些时候调用者在其它 Navigator 内部，没试过效果
// bool useRootNavigator = false

// RouteSettings? routeSettings 包含路由 名字/参数

// Offset? anchorPoint 没懂？
// bool? requestFocus 没试出来具体效果

// double? elevation

class SheetPage extends StatelessWidget {
  const SheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sheet')),
      backgroundColor: Colors.teal,
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.run_circle)),
      body: Builder(
        builder: (context) {
          return Column(
            children: [
              TextButton(
                onPressed: () {
                  showBottomSheet(
                    context: context,
                    // backgroundColor: Colors.blue,
                    constraints: BoxConstraints(maxHeight: 200),
                    // showDragHandle: true, 顶部那个胶囊线条
                    builder: (context) {
                      // 把 FAB 推到最上面去了，占用了导航条以下的全部空间，导航条上增加了返回按钮
                      // 能拖拽消失，能看到背后的颜色，上边是两圆角
                      // 点击遮罩不会消失，但是点击事件传递下去了
                      // return SizedBox.expand(child: Text('asdf'));
                      // 占据屏幕最下方中间一丁点空间，一个小半圆
                      return Text('asdf asdf asdf');
                    },
                  );
                },
                child: Text('show normal'),
              ),

              TextButton(
                onPressed: () {
                  // 点击遮罩会消失
                  showModalBottomSheet(
                    context: context,
                    useSafeArea: false, // 这属性感觉没啥用
                    builder: (context) {
                      // return SizedBox.expand(child: Text('1234'));
                      return Text('abc');
                    },
                  );
                },
                child: Text('show modal'),
              ),
            ],
          );
        },
      ),
    );
  }
}
