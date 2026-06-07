import 'package:flutter/material.dart';
import 'package:get/get.dart';

// to(() => NextScreen()) / toNamed("/details")
//   dynamic page
//
//   bool? opaque
//     如果不透明，不会渲染背后的页面，节省 CPU
//
//   Transition? transition
//   Curve? curve
//   Duration? duration
//     pop 的时候用相反的动画，这估没必要改

//   int? id
//     nested navigation 时用

//   String? routeName
//   bool fullscreenDialog = false

//   dynamic arguments
//   Bindings? binding

//   bool preventDuplicates = true
//   bool? popGesture
//   double Function(BuildContext context)? gestureWidth
//
// back() 关闭 snackbar / dialog / bottomSheet，以前用 Navigator.pop(context) 的场景
//
// off(NextScreen()) 跳转到下一页，不用返回，相当于 replace，场景 splash/login
//   动画还是 push
//
// offAll(NextScreen()) 跳转到下一页，不用返回，替换前面所有的页面，场景 支付完成
//   动画还是 push

class GetApp10 extends StatelessWidget {
  const GetApp10({super.key});
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
          Get.to(() => Child1Page(), popGesture: false);
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
          Get.to(() => Child2Page(), popGesture: false);
        },
        child: Icon(Icons.run_circle),
      ),
    );
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
          Get.arguments
          Get.to(() => Child3Page(), popGesture: false);
          Get.off(Child3Page());
          // Get.offAll(Child3Page());
        },
        child: Icon(Icons.run_circle),
      ),
    );
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
    );
  }
}
