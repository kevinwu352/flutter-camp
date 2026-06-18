import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ================================================================================
// snackbar
// 能用 Get.rawSnackbar() 展示原始的样式

// String title
// String message
// Color? colorText
//   title & message 的颜色
//
// Widget? titleText
//   虽然能传任意 Widget，但最好还是传 Text/RichText
// Widget? messageText
//   虽然能传任意 Widget，但最好还是传 Text/RichText
//
// Widget? icon
//   左侧图标，虽然能传任意 Widget，但最好还是传 Icon/Image
// bool? shouldIconPulse
//   默认情况下，图标在一明一暗地闪
//
// TextButton? mainButton
//   右边的按钮，点击不会消失，要自己做
// OnTap? onTap
//   点击实体和上会响应，点击左右下 margin 不会响应

// SnackPosition? snackPosition
//   屏幕 顶部/底部
// SnackStyle? snackStyle
//   紧贴屏幕边 / 像泡泡一样漂浮

// double? borderRadius
// double? borderWidth
// Color? borderColor

// double? barBlur
//   整体的模糊，如果想要背景模糊，设置此值，且背景色一定要半透明
// Color? backgroundColor
//   整体的背景色，有 backgroundGradient 时忽略背景色
// Gradient? backgroundGradient
//   整体的背景渐变

// bool? isDismissible
//   能否 swipe/click 关闭
//   当 overlayBlur != 0 时，不管 overlayColor 是不是透明，如果开启了这开关，点击就能关闭
// double? overlayBlur
//   这管的是模糊，不是遮罩颜色的透明度
//   大于 0 时，背后的东西不能被点击，虽然此时遮罩可能是透明色
// Color? overlayColor
//   遮罩颜色，必须是半透明的颜色，overlayBlur > 0 才会起效
// DismissDirection? dismissDirection
//   看效果，感觉是 swipe 的方向
//   默认 top 时是 up，也就是位于上方时，只有 swipe-up 才会消失，无法向下 swipe 消失，我试了效果的确是这样
//   bottom 时是 down

// Duration? animationDuration
//   显示隐藏时的动画时间
// Curve? forwardAnimationCurve
// Curve? reverseAnimationCurve
//   显示隐藏时的动画曲线
//
// Duration? duration = const Duration(seconds: 3)
//   展示持续的时间，不是动画时间，传 null 则一直显示

// double? maxWidth
// EdgeInsets? margin
//   影响上下左右，其中上还要加上安全区，也就是，上距离屏幕顶部是 safe-top + insets.top
//   为什么下也受影响呢？把遮罩打开，点击遮罩会关闭，这是已知的事实
//   如果 insets.bottom 有值，我显示出来以后，点击实体下面一点点，不会消失，说明没点到遮罩，说明下受到影响了
// EdgeInsets? padding

// bool instantInit = true
//   看代码里面，是马上显示，还是下一帧显示

// bool? showProgressIndicator
// AnimationController? progressIndicatorController
// Color? progressIndicatorBackgroundColor
// Animation<Color>? progressIndicatorValueColor
//   实体顶部显示一个条状进度条

// List<BoxShadow>? boxShadows

// SnackbarStatusCallback? snackbarStatus
//   接收状态变化的回调

// Color? leftBarIndicatorColor
//   实体左侧显示一个颜色条条，感觉没啥用

// Form? userInputForm

// ================================================================================
// dialog

// Get.defaultDialog
//   内部创建 AlertDialog，这是系统提供的
//   然后传递给 dialog()
// Get.dialog(Text("data")) 显示无样式那种大字体，黄色下划线
//   内部调用 generalDialog()
// Get.generalDialog(pageBuilder: pageBuilder)

// 能弹出一个自定义的弹窗，定制宽度
//   Get.dialog(
//     Material(
//       color: Colors.transparent,
//       child: Center(child: Text("data")),
//     ),
//   );
//
// 传的参数，能从里面获取出来
// Get.dialog(
//   MyAlert(),
//   arguments: "abc",
//   routeSettings: RouteSettings(name: "pg", arguments: "xyz"),
// );
// print("args:${Get.arguments} paras:${Get.parameters}");
//   args:null paras:{} 都不传
//   args:abc paras:{}  传 arguments
//   args:xyz paras:{}  传 arguments 和 routeSettings

// String title = "Alert"
// EdgeInsetsGeometry? titlePadding
// TextStyle? titleStyle
//
// Widget? content
// EdgeInsetsGeometry? contentPadding
//   就算设置为 .zero，下边还是有一点点空间，这是哪来的？
//   代码里面写死了，下面有 16 的空间
//
// String middleText = "Dialog made in 3 lines of code"
// TextStyle? middleTextStyle
//   有 content 时，就不用此信息

// double radius = 20.0

// Color? backgroundColor 弹窗实体的背景色
// bool barrierDismissible = true

// String? textConfirm
// String? textCancel
// Color? cancelTextColor
// Color? confirmTextColor
// VoidCallback? onCancel
// VoidCallback? onCustom
//
// Widget? cancel
// Widget? confirm
//
// Color? buttonColor
//   修饰按钮 边框/填充
//
// String? textCustom
// VoidCallback? onConfirm
// Widget? custom
//   这仨没用到，我想，真要自定义按钮，直接放到 actions 里吧
//
// List<Widget>? actions
//   上面的 确定/取消 按钮，是追加到这个列表里的，所以，你懂的

// bool useSafeArea
//   如果为真，内部会用 SafeArea 控件包起来

// WillPopCallback? onWillPop
//
// GlobalKey<NavigatorState>? navigatorKey

// ================================================================================
// sheet
// 有个预定义的高度，超过会有溢出警告，找出修改高度的方法？
//
// isScrollControlled: false 时，最大高度应该是 852 * 9 / 16 = 479.25
// 如果弹出来的 sheet 强行设置高度，也只会被限制在 479
// 这时就要把 isScrollControlled: true，此时最大高度是屏幕高，所以我们能自由决定 sheet 高度
// 并且，背景色也是半透明的，并未因为最大高度是全屏也挡住 sheet 背后的内容
// showModalBottomSheet 也能这样，isScrollControlled: true，再自由决定高度

// Widget bottomsheet

// Color? backgroundColor
// Color? barrierColor
//
// bool isDismissible = true
//   点击背景关闭
// bool enableDrag = true
//   拖拽关闭

// Duration? enterBottomSheetDuration
// Duration? exitBottomSheetDuration
//   显示隐藏动画时间

// bool? ignoreSafeArea
//   没啥效果，看文档，好像好像说的是顶部的安全区。为什么要有此参数呢？
//     因为 bottomSheet 位于屏幕底部，不会和顶部安全区有关系，而 bottomSheet 内部可能会拿安全区的值来布局
//     这样就造成了，内容和安全区十万八千里，但是却给安全区留了空间，不妥，所以，最好让后代拿到的上安全区值是 0
//     当内容里面使用了 SafeArea 这类控件，就能看出效果来了
//   内部用 MediaQuery.removePadding(removeTop:) 实现的
// return Scaffold(
//   body: MediaQuery.removePadding(
//     context: context,
//     removeTop: true,
//     child: SafeArea(child: Text("xyz")),
//   ),
// );
// 本来 xyz 是位于顶部安全区内，xyz 顶部挨着屏幕边
// 加上 SafeArea 以后，xyz 顶部挨着安全区下沿
// 加上 MediaQuery.removePadding(removeTop:) 以后，xyz 又重新回到屏幕边沿了
//
// MediaQuery.removePadding(removeTop:) 的内部实现是将上下左右对应的值清零，它的后代拿安全区的值，拿到的是 0

// double? elevation

// bool persistent = true
//   代码里面，如果是真，则把 sheet 赋值给 Scaffold.bottomSheet，否则直接显示 sheet
//   但是代码没使用外面传进去的这个值，所以这参数无效果
// bool isScrollControlled = false
//   BoxConstraints(
//     minWidth: constraints.maxWidth,
//     maxWidth: constraints.maxWidth,
//     minHeight: 0.0,
//     maxHeight: isScrollControlled ? constraints.maxHeight : constraints.maxHeight * 9.0 / 16.0,
//   )
// 内部用它来生成约束
// 所以，那个默认高度怎么来的？852 * 9 / 16 = 479.25

// bool useRootNavigator = false
// RouteSettings? settings
//   传的参数 settings: RouteSettings(name: "st", arguments: "vvvv")
//   内部能获取到 print("sheet, args:${Get.arguments} paras:${Get.parameters}");
//   sheet, args:vvvv paras:{}

// ShapeBorder? shape
//   貌似只影响 左上/右上 两个角
//   已实测，影响四个角，且，规定的是整个 sheet 实体区域，超过这个范围就算外面了
//   如果圆角超级大，比如 200，那么区域就是一个大圆，四个角的内容肯定会显示在区域外面，此时点四个角，
//   你以为你点在内容上的，其实已经出边界了，会让 sheet 消失
// Clip? clipBehavior

class GetApp11 extends StatelessWidget {
  const GetApp11({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: RootPage());
  }
}

class RootPage extends StatelessWidget {
  const RootPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('root')),
      body: SizedBox.expand(
        child: Column(
          children: [
            SizedBox(height: 200),
            TextButton(
              onPressed: () {
                print("asdf 111");
                // Get.to(ChildPage());
              },
              child: Text("xxx"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // showSnackbar();
          // showDialog1();
          // showDialog2();
          showSheet();
        },
        child: Icon(Icons.run_circle),
      ),
    );
  }

  void showSnackbar() {
    Get.snackbar(
      'Hi',
      'i am a modern snackbar',
      colorText: Colors.red,
      duration: null,
      icon: Icon(Icons.settings),
      shouldIconPulse: false,

      barBlur: 5,
      backgroundColor: Colors.teal.withValues(alpha: 0.5),

      // borderWidth: 2,
      // borderColor: Colors.purple,
      // borderRadius: 40,
      // margin: EdgeInsets.zero,

      // padding: EdgeInsets.all(50),
      snackbarStatus: (status) => print(status),

      leftBarIndicatorColor: Colors.blue,

      // maxWidth: 200,
      onTap: (snack) => print("tapped"),
      mainButton: TextButton(
        onPressed: () {
          print("abc");
        },
        child: Text("done"),
      ),

      // snackStyle: SnackStyle.GROUNDED,
      isDismissible: true,
      overlayBlur: 0.5,
      overlayColor: Colors.black.withAlpha(128),
    );
  }

  void showDialog1() async {
    // Widget buttonWithResult({required String text, required bool result}) => TextButton(
    //   onPressed: () => Get.back(result: result),
    //   child: Text(text),
    // );
    // bool? delete = await Get.dialog(
    //   AlertDialog(
    //     content: const Text('Are you sure you would like to delete?'),
    //     actions: [
    //       buttonWithResult(text: 'No', result: false),
    //       buttonWithResult(text: 'Yes', result: true),
    //     ],
    //   ),
    // );
    // print("got: $delete");

    // Get.dialog(
    //   Material(
    //     color: Colors.transparent,
    //     child: Center(
    //       child: Container(color: Colors.amber, padding: EdgeInsets.all(50), child: Text("data")),
    //     ),
    //   ),
    // );

    Get.dialog(
      MyAlert(),
      arguments: "abc",
      routeSettings: RouteSettings(name: "pg", arguments: "xyz"),
    );
  }

  void showDialog2() {
    Get.defaultDialog(
      title: "WARNING",
      titlePadding: EdgeInsets.zero,
      content: Icon(Icons.run_circle),
      contentPadding: EdgeInsets.zero,

      textCancel: "ccl",
      textConfirm: "conf",
      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.run_circle))],

      buttonColor: Colors.red,
    );
  }

  void showSheet() {
    Get.bottomSheet(
      // SafeArea(
      //   child: Wrap(
      //     children: [
      //       ListTile(leading: Icon(Icons.music_note), title: Text('Music'), onTap: () {}),
      //       ListTile(leading: Icon(Icons.videocam), title: Text('Video'), onTap: () {}),
      //     ],
      //   ),
      // ),
      MySheet(),
      backgroundColor: Colors.green,
      barrierColor: Colors.blue.withValues(alpha: 0.5),

      isScrollControlled: true,

      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(200)),
      // clipBehavior: Clip.hardEdge
    );
  }
}

class MyAlert extends StatelessWidget {
  const MyAlert({super.key});
  @override
  Widget build(BuildContext context) {
    print("alert, args:${Get.arguments} paras:${Get.parameters}");
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(color: Colors.amber, padding: EdgeInsets.all(50), child: Text("alert info")),
      ),
    );
  }
}

class MySheet extends StatelessWidget {
  const MySheet({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.amber, width: 200, height: 500);
  }
}

class ChildPage extends StatelessWidget {
  const ChildPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('child')),
      body: SizedBox.expand(
        child: Column(
          children: [
            //
          ],
        ),
      ),
    );
  }
}
