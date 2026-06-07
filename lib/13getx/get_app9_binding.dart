import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetApp9 extends StatelessWidget {
  const GetApp9({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: RootPage());
  }
}

class CounterController extends GetxController {
  CounterController() {
    print("controller9 create");
  }

  @override
  void onInit() {
    super.onInit();
    print("controller9 init, initialized:$initialized");
  }

  @override
  void onReady() {
    super.onReady();
    print("controller9 ready, initialized:$initialized");
  }

  @override
  void onClose() {
    print("controller9 close, closed:$isClosed");
    super.onClose();
  }

  static CounterController get to => Get.find();
  var count = Random().nextInt(1000);
  void increase() {
    count++;
    update();
  }
}

class RootPage extends StatelessWidget {
  const RootPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('root')),
      body: SizedBox.expand(child: Column(children: [
          ],
        )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => ChildPage(), binding: ChildBinding());

          // Get.to(() => ChildPage(), binding: BindingsBuilder(() => Get.put(CounterController())));
          // Get.to(
          //   () => ChildPage(),
          //   binding: BindingsBuilder(() {
          //     Get.put(CounterController());
          //   }),
          // );

          // Get.to(() => ChildPage(), binding: BindingsBuilder(() => Get.lazyPut(() => CounterController())));
          // Get.to(
          //   () => ChildPage(),
          //   binding: BindingsBuilder(() {
          //     Get.lazyPut(() => CounterController());
          //   }),
          // );
        },
        child: Icon(Icons.run_circle),
      ),
    );
  }
}

// 普通路由使用
// Get.to(() => ChildPage(), binding: ChildBinding());
//
// 命名路由使用
// getPages: [
//   GetPage(
//     name: '/',
//     page: () => HomeView(),
//     binding: HomeBinding(),
//   ),
//   GetPage(
//     name: '/details',
//     page: () => DetailsView(),
//     binding: DetailsBinding(),
//   ),
// ];

// 用 BindingsBuilder 普通
//   BindingsBuilder(() => Get.put(CounterController())) 这有警告，还有崩
//   BindingsBuilder(() {
//     Get.put(CounterController());
//   })
// 用 BindingsBuilder 懒加载
//   BindingsBuilder(() => Get.lazyPut(() => CounterController()))
//   BindingsBuilder(() {
//     Get.lazyPut(() => CounterController());
//   })
//
// 我更喜欢用 Bindings 类，因为不用暴露 Controller 给外面
// 把 Bindings 类写到 screen 类文件里，其它地方引入 screen 文件即可
// 否则，用 BindingsBuilder 的话，其它地方要引入两个文件
class ChildBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CounterController());
  }
}

class ChildPage extends StatelessWidget {
  const ChildPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("child")),
      body: Center(
        child: GetBuilder<CounterController>(
          builder: (controller) {
            print("builder updated child");
            return Text(controller.count.toString());
          },
        ),
      ),
    );
  }
}
