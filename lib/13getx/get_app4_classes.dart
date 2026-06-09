import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetApp4 extends StatelessWidget {
  const GetApp4({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: RootPage());
  }
}

// ================================================================================
// GetxService

// 和 GetxController 类似，但是 GetxController 一般服务于某个页面，会创建和销毁
// 而 GetxService 一般用于永不销毁的服务，文档说 Get.delete() 也删不了，要用 Get.reset()
class CounterService extends GetxService {
  Future<CounterService> init() async {
    return this;
  }
}
// Future<void> main() async {
//   await initServices();
//   runApp(SomeApp());
// }
// void initServices() async {
//   await Get.putAsync(  () => DbService().init()  );
//   await Get.putAsync(  SettingsService()  ).init();
// }

// ================================================================================
// StateMixin

// StateMixin 用于增加 数据 和 状态，loading success empty error 等
// 但只能有一个状态，名字叫 state，如果要管理两个数据，顶部User底部MessageList，则不好搞了
class CounterController extends GetxController with StateMixin<int> {}

// ================================================================================

// GetView 非常简单，完全等价于 StatelessWidget，只是内部帮你获取了 GetxController，不用自己再获取了
class CounterPage extends GetView<CounterController> {
  const CounterPage({super.key});
  @override
  Widget build(BuildContext context) {
    return controller.obx((state) => Text(state.toString()));
  }
}

// ================================================================================
// GetResponsiveView

// GetResponsiveView 是 GetView 的子类，它能根据屏幕的不同来创建不同的布局之类的
// 有个 screen 属性，包含尺寸平台之类的信息
// class ResponsivePage extends GetResponsiveView<CounterController> {}

// ================================================================================
// GetWidget
// 具体情况，参考 12 那个完整例子

class RootPage extends StatelessWidget {
  const RootPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('root')),
      body: SizedBox.expand(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                // ctr.increment();
              },
              child: Text("doit"),
            ),
          ],
        ),
      ),
    );
  }
}
