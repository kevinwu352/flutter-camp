import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Obx vs GetX vs GetBuilder
//
// Obx 只有 builder key 俩参数，无泛型
//   里面不使用 observable 会崩
// GetX 有泛型，不给泛型会崩，因为 controller 为 null
//   参数很多
//   在 GetBuilder 里新建 controller，且把 GetX 放在它前面，会崩，因为还没创建呢，也是 null
//   里面不使用 observable 也会崩，和 Obx 一样，使用 controller.count 也会崩，因为 count 是普通变量
//   给泛型，且有值，但不使用 controller，使用另外某个地方来的 .obs，不会崩，但这有啥意义呢？你用 GetX 又不用它的 controller，那还是用 Obx 吧
// GetBuilder

// GetBuilder / GetX 共同参数
//   CounterController? init
//   required Widget Function(CounterController) builder
//
//   String? tag
//     和 Get 里面查找实例相关的 key，再研究
//   bool global = true
//     看代码，貌似，如果是全局的，就从 Get 里面找实例，否则就每个 Widget 创建自己的实例
//   bool autoRemove = true
//     要不要在 dispose 里清除实例，一堆判断，自己是不是创建者呀，之类的
//   bool assignId = false
//     只在 dispose 里决定要不要清除实例用到了，非常少
//
//   void Function(GetBuilderState<CounterController>)? initState
//   void Function(GetBuilderState<CounterController>)? dispose
//   void Function(GetBuilderState<CounterController>)? didChangeDependencies
//   void Function(GetBuilder<GetxController>, GetBuilderState<CounterController>)? didUpdateWidget
//
// GetBuilder 特有的参数
//   Object Function(CounterController)? filter
//     返回值变化时才会刷新界面，最终决定要不要调用 setState
//   Object? id
//     精细化控制界面刷新 update(['xxx'])

class GetApp7 extends StatelessWidget {
  const GetApp7({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: RootPage());
  }
}

class CounterController extends GetxController {
  static CounterController get to => Get.find();
  var count = 0;
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
      body: SizedBox.expand(
        child: Column(
          children: [
            GetBuilder<CounterController>(
              init: CounterController(),
              builder: (controller) {
                print("builder updated");
                return Text(controller.count.toString());
              },
            ),

            // GetX<CounterController>(builder: (controller) => Text("data: ${controller.count}")),
            GetX<CounterController>(builder: (controller) => Text("data: ${name.value}")),

            // Obx(() => Text("data")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CounterController.to.increase();
        },
        child: Icon(Icons.run_circle),
      ),
    );
  }
}

final name = 'abc'.obs;
