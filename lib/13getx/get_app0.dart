import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetApp0 extends StatelessWidget {
  const GetApp0({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: EntrancePage());
  }
}

// 这里会有内存泄漏，RootPage 释放不掉，什么原因呢？
class EntrancePage extends StatelessWidget {
  const EntrancePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(onPressed: () => Get.to(() => RootPage()), child: Text("go")),
      ),
    );
  }
}

// GetxController 用来写 ViewModel
// 在 snippets 提供的例子里，这里会注入 repository，可见它就是用来写 VM 的
class CounterController extends GetxController {
  CounterController() {
    print("counter init");
  }
  // 这方式太复杂
  // final _obj = 0.obs;
  // set obj(value) => _obj.value = value;
  // get obj => _obj.value;
  // 用这种方式吧
  var count = 0.obs;
  void increment() => count++;
}

class RootPage extends StatelessWidget {
  const RootPage({super.key});
  @override
  Widget build(BuildContext context) {
    final ctr = Get.put(CounterController());
    return Scaffold(
      appBar: AppBar(title: Text('root')),
      body: SizedBox.expand(
        child: Column(
          children: [
            Obx(() => Text('${ctr.count}')),
            TextButton(
              onPressed: () {
                ctr.increment();
              },
              child: Text("doit"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => ChildPage());
        },
        child: Icon(Icons.run_circle),
      ),
    );
  }
}

class ChildPage extends StatelessWidget {
  const ChildPage({super.key});

  // 如果在这 find，那么此类就不能是 const
  // final CounterController ctr = Get.find();

  @override
  Widget build(BuildContext context) {
    // 如果在这 find，类可以是 const 的
    final CounterController ctr = Get.find();
    return Scaffold(
      appBar: AppBar(title: Text("child")),
      body: Center(child: Text("${ctr.count}")),
    );
  }
}
