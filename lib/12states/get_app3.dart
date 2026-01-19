import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 使用 GetMaterialApp，无路由，原生导航，在 build 里 put，用 GetBuilder，无法释放 HomeViewModel
// 使用 GetMaterialApp，无路由，Get.to 但原生返回，在 build 里 put，用 GetBuilder，无法释放 HomePage，且数量会越来越多
// 使用 GetMaterialApp，无路由，Get.to/Get.back，在 build 里 put，用 GetBuilder，无法释放 HomePage，且数量会越来越多
// 使用 GetMaterialApp，无路由，Get.to/Get.back，用 Bindings 来 put，用 GetBuilder，无法释放 HomePage，且数量会越来越多

// 感觉很乱，要么是 ViewModel，要么是 Page，释放不掉哟

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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
      body: Center(
        child: TextButton(
          onPressed: () {
            // Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
            Get.to(HomePage(), binding: BindingsBuilder(() => Get.lazyPut(() => HomeViewModel())));
          },
          child: Text('go'),
        ),
      ),
    );
  }
}

class HomeViewModel extends GetxController {
  HomeViewModel() {
    print('home vm init');
  }
  var name = 'kevin';
  void change() {
    name = 'asdf';
    update();
  }

  // final age = 10.obs;
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // final dep = Get.put(HomeViewModel());

  @override
  Widget build(BuildContext context) {
    // final vm = Get.put(HomeViewModel());
    // final vm = Get.find<HomeViewModel>();
    return Scaffold(
      appBar: AppBar(title: Text('home')),
      body: SizedBox.expand(
        child: Column(
          children: [
            // Text('name: ${no.name}'),
            // Text('name: ${vm.name}'),

            // Obx(() => Text('name: ${vm.name}')),
            // GetX<HomeViewModel>(builder: (controller) => Text('name: ${controller.age}')),
            // GetBuilder(init: vm, builder: (controller) => Text('name: ${controller.name}')),
            GetBuilder<HomeViewModel>(builder: (controller) => Text('name: ${controller.name}')),

            // TextButton(onPressed: () => vm.change(), child: Text('change')),
            TextButton(onPressed: () => Get.back(), child: Text('back')),
          ],
        ),
      ),
    );
  }
}
