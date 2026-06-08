import 'package:flutter/material.dart';
import 'package:get/get.dart';

// to(() => NextScreen()) / toNamed("/details")
//
// back(result: "xxxx") 关闭 snackbar / dialog / bottomSheet，以前用 Navigator.pop(context) 的场景
//
// off(NextScreen()) / offNamed 跳转到下一页，不用返回，相当于 replace，场景 splash/login
//   动画还是 push
// offAndToNamed("/four")
//   说的是和 offNamed 一样，只是实现方式不同，动画不同
//   内部用的方法的确不一样，但我感觉动画效果没啥区别
//
// offAll(NextScreen()) / offAllNamed 跳转到下一页，不用返回，替换前面所有的页面，场景 支付完成
//   动画还是 push
//
// offUntil 注意用法，push "/five"，然后清除导航栈直到变成 xxx/yyy/two/five
// 另外 routeName 并非直接就有值，toNamed 虽然用 name 来 push，但最终 route 的 routeName 为空
// 只有 to() 这种函数才能传 routeName 参数
// Get.offUntil(GetPageRoute(page: () => Child5Page()), (route) => (route as GetPageRoute).routeName == '/two');
// Get.offNamedUntil("/five", (route) => (route as GetPageRoute).routeName == '/two');

// 这些函数一般有这些参数
//   dynamic page
//   dynamic arguments
//   Bindings? binding
//
//   Transition? transition
//   Curve? curve
//   Duration? duration
//     pop 的时候用相反的动画，这仨参数估计没必要改
//
//   String? routeName
//   bool preventDuplicates = true
//     能不能重复 push 相同的路由，根据 routeName 来判断是不是同一个
//
//   bool? opaque
//     如果不透明，不会渲染背后的页面，节省 CPU
//   bool fullscreenDialog = false
//
//   int? id
//     nested navigation 时用
//
//   bool? popGesture
//     在 iOS 上传 false 还是能拖拽返回，难道这是给安卓用的？
//   double Function(BuildContext context)? gestureWidth

// ================================================================================

// 获取次级页面的返回值
//   final val = await Get.to(() => Child2Page());
//   final val = await Get.toNamed("/two");
// 次级页面传递值
//   Get.back(result: "hehehahaadsf");

// ================================================================================

// 传参数
// 能定义两个 /two 路由，具体区别看下面定义路由那段
//
// Get.toNamed("/two?aa=11&bb=22", arguments: {"name": "kkk", "age": 111});
//   arguments:{name: kkk, age: 111}, parameters:{aa: 11, bb: 22}
// Get.toNamed("/two/1234?aa=11&bb=22", arguments: {"name": "kkk", "age": 111});
//   arguments:{name: kkk, age: 111}, parameters:{aa: 11, bb: 22, uid: 1234}

class GetApp10 extends StatelessWidget {
  const GetApp10({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // home: RootPage(),
      // 404 页面，但好像 Get.toNamed("/hifsuis") 触发不了，为什么？
      // 答：根页面不能定义为 "/"，必须取一个名字
      unknownRoute: GetPage(name: '/unknown', page: () => UnknownPage()),
      initialRoute: "/root",
      getPages: [
        GetPage(name: '/root', page: () => RootPage()),
        GetPage(name: '/one', page: () => Child1Page()),
        GetPage(name: '/two', page: () => Child2Page(), binding: Child2Binding()),
        // 能定义两个 /two，具体区别看上面传参数那段
        GetPage(name: '/two/:uid', page: () => Child2Page(), binding: Child2Binding()),
        GetPage(name: '/three', page: () => Child3Page()),
        GetPage(name: '/four', page: () => Child4Page(), binding: Child4Binding()),
        GetPage(name: '/five', page: () => Child5Page()),
      ],
    );
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //
          // Get.to(() => Child1Page());
          Get.toNamed("/one");
        },
        child: Icon(Icons.run_circle),
      ),
    );
  }
}

class Child1Page extends StatelessWidget {
  const Child1Page({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('child 111')),
      body: SizedBox.expand(
        child: Column(
          children: [
            //
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Get.to(() => Child2Page(), routeName: "/two");
          Get.toNamed("/two?aa=11&bb=22", arguments: {"name": "kkk", "age": 111});
          // Get.toNamed("/two/1234?aa=11&bb=22", arguments: {"name": "kkk", "age": 111});
        },
        child: Icon(Icons.run_circle),
      ),
    );
  }
}

class Child2Binding extends Bindings {
  @override
  void dependencies() {
    // 如果是 lazyPut 的话，Widget 里必须使用 Child2Controller 才会创建实例，所以改用 put 吧
    Get.put(Child2Controller());
  }
}

class Child2Controller extends GetxController {
  @override
  void onInit() {
    super.onInit();
    print("child2 init, args:${Get.arguments}, paras:${Get.parameters}");
  }
}

class Child2Page extends StatelessWidget {
  const Child2Page({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('child 222')),
      body: SizedBox.expand(
        child: Column(
          children: [
            //
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed("/three");
          // Get.toNamed("/three", arguments: {"name": "kkk", "age": 111});
          // Get.to(() => Child3Page());
          // Get.off(Child3Page());
          // Get.offAll(Child3Page());
        },
        child: Icon(Icons.run_circle),
      ),
    );
  }
}

class Child3Binding extends Bindings {
  @override
  void dependencies() {
    Get.put(Child3Controller());
  }
}

class Child3Controller extends GetxController {
  @override
  void onInit() {
    super.onInit();
    print("child3 init, args:${Get.arguments}");
  }
}

class Child3Page extends StatelessWidget {
  const Child3Page({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('child 333')),
      body: SizedBox.expand(
        child: Column(
          children: [
            //
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Get.to(() => Child2Page());
          // Get.toNamed("/four", arguments: "xixi");
          // Get.offNamed("/four");
          Get.offAndToNamed("/four");
        },
        child: Icon(Icons.run_circle),
      ),
    );
  }
}

class Child4Binding extends Bindings {
  @override
  void dependencies() {
    Get.put(Child4Controller());
  }
}

class Child4Controller extends GetxController {
  @override
  void onInit() {
    super.onInit();
    print("child4 init, args:${Get.arguments}");
  }
}

class Child4Page extends StatelessWidget {
  const Child4Page({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('child 444')),
      body: SizedBox.expand(
        child: Column(
          children: [
            //
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Get.to(() => Child2Page());
          // Get.offUntil(GetPageRoute(page: () => Child5Page()), (route) {
          //   print((route as GetPageRoute).routeName);
          //   return (route as GetPageRoute).routeName == '/two';
          // });
          Get.offNamedUntil("/five", (route) => (route as GetPageRoute).routeName == '/two');
        },
        child: Icon(Icons.run_circle),
      ),
    );
  }
}

class Child5Page extends StatelessWidget {
  const Child5Page({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('child 555')),
      body: SizedBox.expand(
        child: Column(
          children: [
            //
          ],
        ),
      ),
    );
  }
}

class UnknownPage extends StatelessWidget {
  const UnknownPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('unknown')),
      body: Center(child: Text("404")),
    );
  }
}
