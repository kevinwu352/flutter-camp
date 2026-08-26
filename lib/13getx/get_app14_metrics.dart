import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 用 MediaQuery.of 获取这三个值，屏幕旋转以后，会重建
//   print(MediaQuery.of(context).viewInsets);
//   print(MediaQuery.of(context).padding);
//   print(MediaQuery.of(context).viewPadding);
// 用这种方式，屏幕旋转以后，也会触发 build
//   print(MediaQuery.sizeOf(context).isExpanded);
// 这四个获取到的值都是以 point 为单位
//   print(MediaQuery.sizeOf(context));
//   print(MediaQuery.viewInsetsOf(context));
//   print(MediaQuery.paddingOf(context));
//   print(MediaQuery.viewPaddingOf(context));
//
// 用 Get.mediaQuery 获取这三个值，屏幕旋转以后，不会重建，build 方法不会被调用
//   print(Get.mediaQuery.viewInsets);
//   print(Get.mediaQuery.padding);
//   print(Get.mediaQuery.viewPadding);
// 用这些也不会重建
//   print(Get.context!.mediaQuery.viewInsets);
//   print(Get.context!.mediaQuery.padding);
//   print(Get.context!.mediaQuery.viewPadding);
//   print(Get.context!.mediaQueryViewInsets);
//   print(Get.context!.mediaQueryPadding);
//   print(Get.context!.mediaQueryViewPadding);
// --------------------------------------------------
// 分析原因：
// 这种写法，旋转屏幕会触发 build 被调用
//   print(MediaQuery.of(context).viewInsets);
// 这种写法，旋转屏幕不会触发
// 但它的内容是调用的 MediaQuery.of(context!)，不过，它内部的 context 和这里的 context 不是同一个
//   print(Get.mediaQuery.viewInsets);

extension ScreenSizeExt on Size {
  bool get isExpanded => width > height && width > 600;
}

class GetApp14 extends StatelessWidget {
  const GetApp14({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: RootPage());
  }
}

class RootPage extends StatelessWidget {
  const RootPage({super.key});
  @override
  Widget build(BuildContext context) {
    print('[getx] begin');


    print('[getx] ${Get.window}');

    // 下面获取的这些值，虽然屏幕旋转的时候不会重建这些
    // 但是，如果横屏以后，重新启动 App，这里获取到的值是旋转过后的，也就是，宽高对调了

    print('[getx] ${Get.window.physicalSize}'); // Size(1179.0, 2556.0)
    print('[getx] ${Get.pixelRatio}');          // 3.0
    // window.physicalSize / pixelRatio
    print('[getx] ${Get.width} ${Get.height}'); // 393.0 852.0
    print('[getx] ${Get.context!.width} ${Get.context!.height}'); // 393.0 852.0

    // 安全区上，但内容用的是 padding，键盘弹出后会变，不好
    print('[getx] ${Get.statusBarHeight} ${Get.bottomBarHeight}'); // 177.0 102.0 也就是 59 34，是对的
    // 用 Get.safeTop / Get.safeBottom 我写的扩展

    return Scaffold(
      appBar: AppBar(title: Text('root')),
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            color: Colors.amber,
            child: Column(
              children: [
                // LayoutBuilder(builder: (context, constraints) {
                //   print('layout called');
                //   return Text('data');
                // })
              ],
            ),
          ),
        ),
      ),
      // body: LayoutBuilder(builder: (context, constraints) {
      //   // LayoutBuilder 应该是，只要给的约束变了，它就会重建子内容吧
      //   print('layout called');
      //   return Text('data');
      // }),
    );
  }
}
