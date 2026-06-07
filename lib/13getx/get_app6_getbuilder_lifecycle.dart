import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 文档说，用 GetX 的话，你可能再也不需要使用 StatefulWidget 了
// 文档说，除非要用 mixin，比如 TickerProviderStateMixin，否则没必要使用 StatefulWidget
//
// GetBuilder 是 StatefulWidget，它的构造器里有几个参数，把 State 的生命周期函数通知出来了
// 但文档更推荐使用 GetxController 自己的生命周期函数 onInit / onReady / onClose
// 文档说了，不推荐在 GetxController 的构造器里做事情，也忘掉 initState/dispose，用 onInit / onReady / onClose
//
// 文档说 Do not call a dispose method inside GetxController
// 的确有这方法，在 ListNotifierMixin 上，和 Listenable 相关
// 文档说 GetxController 不是 Widget，所以不要想着使用 dispose 来释放资源
//
// GetBuilder(init: some_other_instance 能传个现成的实例给它

// 如何更加精细化刷新界面，更少的刷新？
//   GetBuilder(id: 'xxx')
//   刷新时 update(['xxx'])
//   还能增加刷新条件 update(['xxx'], counter < 10)

final ccc = CounterController();

class GetApp6 extends StatelessWidget {
  const GetApp6({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: RootPage());
  }
}

// 当前页面 和 次级页面 都用 GetBuilder(init: CounterController()，也就是都创建了实例，会怎样呢？
// 当前页面肯定是创建，且 onInit 会被调用
// 次级页面也会创建，但 onInit 不会被调用，且界面上显示的是第一个 controller.count 的值
//
// 次级页面创建的实例像是一直处于幕后，虽然被创建了，但没有被用到，生命周期函数也没被调，点击返回以后，此实例被销毁了
//
// 第二个 GetBuilder(global: false) 就会创建自己的实例，且实例的生命周期函数会触发，界面上显示 0
//
// 终极解答：
// 其实这种 get 这个框架无关，并不是框架新建了多余的实例，是我们自己在写 GetBuilder(init: CounterController()) 时创建的
// 创建 GetBuilder 时，它的每个参数都要最终 resolve 了，才能传递给构造器，而这里就是因为参数里新建了 CounterController()
// 如果我们用其它地方传递过来的，或者全局的一个变量，传递给 GetBuilder，就能明显看出来，没有新建多余的了

// 当前页面不用实例，也不创建，空页面，次级页面用 put 创建实例，且保持
//   Get.put(CounterController(), permanent: true);
// 当退出次级页面时，实例不会被销毁
// 再进次级页面，代码里又 put 了一次，虽然创建了新实例，但新实例没被使用，界面上显示的上次实例的数据
//   新实例只调用了构造器，生命周期函数不会触发
//   旧实例的生命周期函数触发过了，所以，再进次级页面时不会触发了

class CounterController extends GetxController {
  CounterController() {
    print("controller6 create");
  }

  // 文档还说了这种用法，后面用的时候比较方便，不用写很多
  // 文档说性能没区别，也没副作用
  // CounterController.to.increase();
  // Get.find<CounterController>().increase();
  static CounterController get to => Get.find();

  // onStart / onDelete 貌似就没想让我们开发者在外面继承和使用

  // 分配内存后调用，在这里做初始化工作
  // onInit 执行后，将 initialized = true
  @override
  void onInit() {
    super.onInit();
    print("controller6 init, initialized:$initialized");
  }

  // onInit 一帧后触发，适合做 snackbar / dialogs / new route / async request
  @override
  void onReady() {
    super.onReady();
    print("controller6 ready, initialized:$initialized");
  }

  // onDelete 前触发，释放资源 / 保存文件 / 关闭订阅
  // onClose 执行前，将 onClose = true
  @override
  void onClose() {
    print("controller6 close, closed:$isClosed");
    super.onClose();
  }

  var count = 0;
  void increase() {
    count++;
    // 外面用的时候，观察的是 count，它不是 .obs，所以要手动触发更新
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
            TextButton(onPressed: () => Get.to(() => ChildPage()), child: Text("gogogo")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CounterController.to.increase();
          // Get.find<CounterController>().increase();
        },
        child: Icon(Icons.run_circle),
      ),
    );
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
          // global: false,
          init: CounterController(),
          builder: (controller) {
            print("builder updated child");
            return Text(controller.count.toString());
          },
        ),
      ),
    );
  }
}
