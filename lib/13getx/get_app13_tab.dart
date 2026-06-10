import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetApp13 extends StatelessWidget {
  const GetApp13({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: "/login",
      getPages: [
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/main', page: () => MainPage(), binding: MainBinding()),
      ],
    );
  }
}

// ================================================================================

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Center(
        child: ElevatedButton(onPressed: () => Get.offNamed("/main"), child: Text("enter")),
      ),
    );
  }
}

// ================================================================================

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainController());
    Get.lazyPut(() => ProfileController());
  }
}

class MainController extends GetxController {
  var currentIndex = 0.obs;
  void changeTo(int index) {
    currentIndex.value = index;
  }
}

class MainPage extends GetView<MainController> {
  const MainPage({super.key});
  // Favorite 是有状态的，我点击按钮增加了计数，然后，切换到另外一个页面
  // 当前页面 Widget 会从树上拿下来，它对应的 State 对象也会被拿下来并销毁，仔细想想
  //
  // 就算我把页面 Widget 保存到这里，然后在 build 里面直接拿出来用，也不行
  // 这只能说 Widget 对象复用了，但它对应的 State 对象的管理是靠 Element 树
  // Widget 不在 Widget 树上，那么下一帧 Element 树也会把 State 对象拿下来丢弃掉，这是没办法的
  //
  // final pages = [HomePage(), FavoritePage(), ProfilePage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          onDestinationSelected: (value) => controller.changeTo(value),
          selectedIndex: controller.currentIndex.value,
          indicatorColor: Colors.amber,
          labelTextStyle: WidgetStateTextStyle.resolveWith(
            (states) => TextStyle(color: states.contains(WidgetState.selected) ? Colors.amber : Colors.black),
          ),
          destinations: [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.favorite), label: 'Favorite'),
            NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(
        () => IndexedStack(index: controller.currentIndex.value, children: [HomePage(), FavoritePage(), ProfilePage()]),
      ),
    );
  }
}

// ================================================================================

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(title: Text("Home")),
      body: Center(
        child: ElevatedButton(onPressed: () => Get.find<MainController>().changeTo(1), child: Text("to Favorite")),
      ),
    );
  }
}

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});
  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    super.initState();
    print("favorite init");
  }

  @override
  void dispose() {
    print("favorite dispose");
    super.dispose();
  }

  var count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(title: Text("Favorite")),
      body: SizedBox.expand(
        child: Column(
          children: [
            Text("favorite-1"),
            Expanded(
              child: Center(
                child: ElevatedButton(onPressed: () => setState(() => count++), child: Text(count.toString())),
              ),
            ),
            Text("favorite-2"),
          ],
        ),
      ),
    );
  }
}

class ProfileController extends GetxController {
  var amount = 100.obs;
  void increase() {
    amount++;
  }
}

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text("Profile"),
        actions: [IconButton(onPressed: () => Get.offNamed("/login"), icon: Icon(Icons.logout))],
      ),
      body: Center(
        child: Obx(
          () => ElevatedButton(onPressed: () => controller.increase(), child: Text(controller.amount.toString())),
        ),
      ),
    );
  }
}
