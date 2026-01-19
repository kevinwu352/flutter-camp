import 'package:flutter/material.dart';
// import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
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

class HomeObject {
  HomeObject() {
    print('home object init');
  }
  var name = 'kevin';
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // final dep = Get.put(HomeObject());
  // final dep = Get.lazyPut(() => HomeObject());

  // final dep = Get.replace(HomeObject());

  // final vm = Get.create(() => HomeObject());

  final vm = HomeObject();

  @override
  Widget build(BuildContext context) {
    // final no = Get.put(HomeObject());
    // final no = Get.find<HomeObject>();
    return Scaffold(
      appBar: AppBar(title: Text('home')),
      body: SizedBox.expand(
        child: Column(
          children: [
            // Text('name: ${no.name}'),
            Text('name: ${vm.name}'),
            // TextButton(onPressed: () => Get.back(), child: Text('back')),
            // TextButton(onPressed: () => no.name = 'abc', child: Text('back')),
          ],
        ),
      ),
    );
  }
}
