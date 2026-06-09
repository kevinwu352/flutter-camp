import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 依赖管理

// SmartManagement 作为参数，传递给 GetMaterialApp
// .full
//   清除 未使用 且 非永久 的实例
// .onlyBuilder
//   没看懂，网上说：只有通过 GetBuilder / GetX 使用的 Controller 才自动管理
// .keepFactory
//   和 .full 类似，只是这里会保留 factory，后续可以重建实例

// ================================================================================

// put 有泛型，但能推断出来
//   S dependency
//   String? tag
//     如果要创建 相同类型 的 不同实例，用 tag 区分
//     不同类型 的 相同tag 不会影响
//     仔细想一想，很少会创建两个实例，对吧，你一个 ViewModel 就是专门给这页面用的，怎么可能在其它地方再创建实例呢？
// bool permanent = false
//   保持在内存中，不被销毁，不被 SmartManagement 束缚，但能被 GetInstance.reset() / Get.delete()，好像没 reset 方法了
//   delete(force: true) / reload(force: true) 时能清除 permanent 的
//   replace 应该也能清除旧的，因为内部实现是先 delete 再 put
// InstanceBuilderCallback<S>? builder
//   通过这个函数来返回实例，而不是第一个参数。但代码里好像根本没用到这参数，文档也说这参数用的少
//
// 内部实现用的是 GetInstance._insert
//
// 存的时候，用 类型+tag 生成一个 key，内部判断 存在且脏数据 或 不存在，就存进去

// lazyPut 有泛型，好像不能推断出来
// 除了懒加载，其它和 put 一样，退出页面时也会销毁
//   InstanceBuilderCallback<S> builder
//   String? tag
//   bool fenix = false
//     内部真正用到的值是 fenix ?? Get.smartManagement == SmartManagement.keepFactory
//     即：如果不传，则根据 Get.smartManagement 是否等于 .keepFactory 来判断
//     我的理解：就是凤凰的意思，涅槃重生
//     在 delete 方法内部，如果 fenix==true，只 dependency = null, isInit = false，也就是只删除实例，下次还能重建
//     否则的话，直接从字典里把 key 对应的数据删除。这也正好对应了 .keepFactory 这俩词的意思，删除但保留工厂函数
// 内部实现用的是 GetInstance._insert

// putAsync 有泛型
//   AsyncInstanceBuilderCallback<S> builder
//   String? tag
//   bool permanent = false
// 内部其实就是用 await builder() 拿到值，再调用 put
// 看下面例子，要崩，这咋用？
//   putAsync 返回的是 Future，所以 await 一下就能用了，不过 build 方法并不是异步的

// create 有泛型
// 每次都会创建新的，permanent 默认是 true，使用场景是列表里每一行需要自己的 controller 时
// 文档里还有段描述，没太看懂
//   InstanceBuilderCallback<S> builder
//   String? tag
//   bool permanent = true
// put 那几个 isSingleton = true，它们不会重复创建
// create 则是每次都用 builder 创建新的
// create 没有返回值的，它只是注册一个创建函数

// replace / lazyReplace
// 就是替换，没啥特别的，能替换成子类实例，具体看下面的例子
// 但要注意，用 put<BaseClass> 来存，用 find<ParentClass> 来查，虽然存的是 ParentClass 实例，但是会异常，因为 key 不对，找不到
// 都有 tag 参数，lazy 有 fenix 参数
// 内部实现是：delete 旧的，put/lazyPut 新的

// find
// 如果用的是 create 方式，那么这里每次 find 都会创建新的
// 其实就两种情况：put 三兄弟随便谁创建的，都能被 find 出来，而 create 每次重新创建

// delete / deleteAll

// reload / reloadAll
// 文档没写描述，我看代码，应该是把当前已经存在的实例销毁，并修改状态，下次 find 会重新创建新实例

// isRegistered
//   就一句代码 _singl.containsKey(_getKey(S, tag))

// isPrepared
// 看代码里面，并不是说 已经创建出实例来了
// 真正表示的是：是否准备好产生实例了。下一步用 find 即可创建出实例

class GetApp8 extends StatelessWidget {
  const GetApp8({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: RootPage());
  }
}

class CounterController extends GetxController {
  CounterController() {
    print("controller8 create");
  }

  @override
  void onInit() {
    super.onInit();
    print("controller8 init, initialized:$initialized");
  }

  @override
  void onReady() {
    super.onReady();
    print("controller8 ready, initialized:$initialized");
  }

  @override
  void onClose() {
    print("controller8 close, closed:$isClosed");
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
      body: SizedBox.expand(
        child: Column(
          children: [
            //
            TextButton(onPressed: () => Get.to(() => ChildPage()), child: Text("gogogo")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.put<BaseClass>(ParentClass());

          // final ins0 = Get.find<ParentClass>();
          // print(ins0); // 异常

          final ins1 = Get.find<BaseClass>();
          print(ins1); // ParentClass

          Get.replace<BaseClass>(ChildClass()); // ParentClass 被释放了
          final ins2 = Get.find<BaseClass>();
          print(ins2); // ChildClass

          Get.lazyReplace<BaseClass>(() => OtherClass()); // ChildClass 被释放了
          final ins3 = Get.find<BaseClass>();
          print(ins3); // OtherClass

          // ================================================================================

          Get.create(() => ParentClass());

          final obj1 = Get.find<ParentClass>();
          print(obj1.hashCode);
          final obj2 = Get.find<ParentClass>();
          print(obj2.hashCode);

          print(identical(obj1, obj2)); // 不同的实例
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
    Get.put(CounterController());
    // Get.lazyPut(() => CounterController());
    // Get.putAsync(() async {
    //   return CounterController();
    // });
    // Get.create(() {
    //   return CounterController();
    // });

    return Scaffold(
      appBar: AppBar(title: Text("child")),
      body: Center(
        child: GetBuilder<CounterController>(
          // init: CounterController(),
          builder: (controller) {
            print("builder updated child");
            return Text(controller.count.toString());
          },
        ),
      ),
    );
  }
}

abstract class BaseClass {}

class ParentClass extends BaseClass {}

class ChildClass extends ParentClass {
  bool isChild = true;
}

class OtherClass extends BaseClass {}
