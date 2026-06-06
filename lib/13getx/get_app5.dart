import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 文档里这句话好像不对，现象是：当两个 Obx 嵌套时
//   内部 Obx 观察的值变化以后，只有内部 Obx 触发了，这没问题
//   外部 Obx 观察的值变化以后，两个 Obx 都触发了，这就和文档说的不一致了
//
// With GetX, even nested widgets are respected.
// If you have Obx watching your ListView, and another watching a checkbox inside the ListView,
// when changing the CheckBox value, only it will be updated,
// when changing the List value, only the ListView will be updated.

class GetApp5 extends StatelessWidget {
  const GetApp5({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: RootPage());
  }
}

// 修改 count1 会触发 count1 和 sum
// 修改 count2 会触发 count2 和 sum
class CounterController extends GetxController {
  CounterController() {
    // 添加观察时，不会响应
    // 每个函数都有个 condition 参数，传 bool 或 函数，决定要不要响应
    // 返回类型是 Worker，可以 worker.dispose()

    // 每一次赋不同的值时响应
    // 不过，当前值是 0，我给它赋 0，响应了，再赋 0 没响应。看看下面的 firstRebuild 用法
    // 还有个 everAll，接收参数是数组
    ever(count1, (state) {
      print("ever: $state");
    }, condition: () => count1.value < 10);

    // 第一次赋值时响应
    // once(count1, (state) {
    //   print("once: $state");
    // });

    // 一直往后推迟，直到停止赋新值 2s 后执行，赋相同的值也算停止赋新值
    // debounce(count1, (state) {
    //   print("decounce: $state");
    // }, time: Duration(seconds: 2));

    // 2s 内只响应一次，取周期开始时的值，就算现在值已经变了
    // interval(count1, (state) {
    //   print("interval: $state");
    // }, time: Duration(seconds: 2));
  }
  final count1 = 0.obs;
  final count2 = 0.obs;
  int get sum => count1.value + count2.value;
}

// GetX / Obx 内，如果不使用响应式的数据，会异常
// Obx(() => Text("data")),
// GetX<CounterController>(builder: (controller) => Text("data")),
//
// Obx(() => Text("data: ${ctr.count1.value}")),
// GetX<CounterController>(builder: (controller) => Text("data: ${ctr.count1.value}")),
// GetX<CounterController>(builder: (controller) => Text("data: ${controller.count1.value}")),
// 其中 GetX 里面，用参数那个 controller / ctr 都行

// 所有的 Rx 类型，它有初始值，然后，我们代码第一次给它赋值的时候，就算值相同，也会触发界面刷新，除非 firstRebuild = false
// flag.firstRebuild = false;
// flag.value = false;

var count = 0;
final name = 'abc-0'.obs;
final flag = false.obs;

class RootPage extends StatelessWidget {
  const RootPage({super.key});
  @override
  Widget build(BuildContext context) {
    // final ctr = Get.put(CounterController());
    return Scaffold(
      appBar: AppBar(title: Text('root')),
      body: SizedBox.expand(
        child: Column(
          children: [
            // Obx(() {
            //   print("obx updated");
            //   return Text(flag.value.toString());
            // }),

            // Obx(() {
            //   print('obx1 updated');
            //   return Column(
            //     children: [
            //       Text(name.value),
            //       Obx(() {
            //         print("obx2 updated");
            //         return Text(flag.value.toString());
            //       }),
            //     ],
            //   );
            // }),

            // GetX<CounterController>(
            //   builder: (controller) {
            //     print("count 1 rebuild");
            //     return Text('${controller.count1.value}');
            //   },
            // ),
            // GetX<CounterController>(
            //   builder: (controller) {
            //     print("count 2 rebuild");
            //     return Text('${controller.count2.value}');
            //   },
            // ),
            // GetX<CounterController>(
            //   builder: (controller) {
            //     print("count 3 rebuild");
            //     return Text('${controller.sum}');
            //   },
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // name.firstRebuild = false;
          // name.value = name.value;
          // flag.firstRebuild = false;
          // flag.value = false;

          // count += 1;
          // name.value = "abc-$count";
          // flag.toggle();

          // ctr.count1.value += 1;
          // ctr.count2.value += 1;
        },
        child: Icon(Icons.run_circle),
      ),
    );
  }
}
