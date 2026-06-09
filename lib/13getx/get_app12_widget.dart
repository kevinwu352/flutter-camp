import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

// GetWidget 使用案例

// https://medium.com/@lee645521797/flutter-getx-3-getview-and-getwidget-34154ddbfa26

// 个人理解：
//
//   每次创建新的 GetView，它的 controller 实例是用 find 找出来的，没有就创建
//   当然 GetView 销毁以后，它的 controller 肯定也销毁了
//
//   每次创建新的 GetWidget，它的 controller 实例是从 cache 里找的，当然最初肯定也是 find，找到以后存到 cache 里
//   按照文档说的 GetWidget 搭配 Get.create 使用，所以这里的 find 其实是每次都创建新的

// 注意实验中的效果，ListView 会清除滚出边界的 ShopItem，与之相关联的 controller 也销毁了
// 下次再滚回可见区域，虽然上次我可能修改了某行的数量，但已无法找回来了，新建的 ShopItem 和新建的 controller 没原来的数据
//
// 解决办法：数据不存到行内呗，存到页面的 controller 里面，保持行处于无状态的模式
// 滚出就销毁，滚回再新建，反正行内也没状态，行的状态都是外面传给它的
// 这样的话，其实也不会使用到 GetWidget 了

class GetApp12 extends StatelessWidget {
  const GetApp12({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      getPages: [
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/shop', page: () => ShopPage(), binding: ShopBinding()),
      ],
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HOME')),
      body: Center(
        child: ElevatedButton(onPressed: () => Get.toNamed('/shop'), child: Text('Go to Shop')),
      ),
    );
  }
}

class ShopBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ShopController());
    Get.create(() => ShopItemController()); // <= 注意这里
  }
}

class ShopController extends GetxController {
  ShopController() {
    print("controller12 create");
  }

  @override
  void onInit() {
    super.onInit();
    print("controller12 init, initialized:$initialized");
  }

  @override
  void onReady() {
    super.onReady();
    print("controller12 ready, initialized:$initialized");
  }

  @override
  void onClose() {
    print("controller12 close, closed:$isClosed");
    super.onClose();
  }

  final total = 0.obs;
  void increment() => total.value += 1;

  // final list = ['item 1', 'item 2', 'item 3'].obs;
  final list = ['item 1', 'item 2', 'item 3', 'item 4', 'item 5', 'item 6', 'item 7', 'item 8', 'item 9'].obs;
  void addList() => list.add('item ${(list.length + 1).toString()}');
}

class ShopPage extends GetView<ShopController> {
  const ShopPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SHOP')),
      body: Column(
        children: [
          Obx(() => Text('Total: ${controller.total}')),

          SizedBox(
            height: 200,
            child: Obx(
              () => ListView.builder(
                scrollCacheExtent: ScrollCacheExtent.pixels(0),
                itemCount: controller.list.length,
                itemBuilder: (context, item) {
                  String produto = controller.list[item];
                  return ShopItem(produto: produto);
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          controller.addList();
        },
      ),
    );
  }
}

class ShopItemController extends GetxController {
  ShopItemController() {
    print("item-controller create, $produto, hash:$hashCode");
  }
  String? produto;

  @override
  void onInit() {
    super.onInit();
    print("item-controller init, $produto, hash:$hashCode");
  }

  @override
  void onReady() {
    super.onReady();
    print("item-controller ready, $produto, hash:$hashCode");
  }

  @override
  void onClose() {
    print("item-controller close, $produto, hash:$hashCode");
    super.onClose();
  }

  final quantity = 0.obs;
  ShopController shop = Get.find<ShopController>();
  void increment() {
    quantity.value += 1;
    shop.increment();
  }
}

class ShopItem extends GetWidget<ShopItemController> {
  const ShopItem({super.key, required this.produto});

  final String produto;

  @override
  Widget build(BuildContext context) {
    controller.produto = produto;
    return Row(
      children: [
        Text(produto),
        SizedBox(width: 10),
        Obx(() => Text('Qty: ${controller.quantity.toString()}')),
        SizedBox(width: 10),
        ElevatedButton.icon(onPressed: () => controller.increment(), icon: Icon(Icons.add), label: Text('add')),
      ],
    );
  }
}
