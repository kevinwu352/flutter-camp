import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetApp0 extends StatelessWidget {
  const GetApp0({super.key});
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
            // Get.to(HomePage());
            Get.snackbar("aaa", "bbb");
          },
          child: Text('go'),
        ),
      ),
    );
  }
}
