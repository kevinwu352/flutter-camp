import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HTTPMgr {
  HTTPMgr() {
    print('http init');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(HTTPMgr());
    return MaterialApp(home: RootPage());
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
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
            // Get.to(HomePage());
          },
          child: Text('go'),
        ),
      ),
    );
  }
}

class HomeViewModel extends GetxController {
  HomeViewModel({required this.http}) {
    print('home vm init');
  }
  final HTTPMgr http;

  var name = 'kevin';
  void change() {
    name = 'asdf';
    print(http);
    update();
  }

  // final age = 10.obs;
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // final dep = Get.put(HomeViewModel());
  // final dep = Get.lazyPut(() => HomeObject());

  // final dep = Get.replace(HomeObject());

  // final vm = Get.create(() => HomeObject());

  late final vm = HomeViewModel(http: Get.find());

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
            // GetBuilder<HomeViewModel>(builder: (controller) => Text('name: ${controller.name}')),
            GetBuilder(init: vm, builder: (controller) => Text('name: ${controller.name}')),

            TextButton(onPressed: () => vm.change(), child: Text('back')),
            // TextButton(onPressed: () => no.name = 'abc', child: Text('back')),
          ],
        ),
      ),
    );
  }
}
