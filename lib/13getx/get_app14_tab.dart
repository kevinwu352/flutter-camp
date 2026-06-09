import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: controller.tabController,
          tabs: [
            Tab(icon: Icon(Icons.directions_car)),
            Tab(icon: Icon(Icons.directions_bike)),
          ],
        ),
        title: Text('Tabs Demo'),
      ),
      body: TabBarView(controller: controller.tabController, children: [CarPage(), BikePage()]),
    );
  }
}

class HomeController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: 2);
    super.onInit();
  }
}

class CarPage extends StatefulWidget {
  @override
  _CarPageState createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> with AutomaticKeepAliveClientMixin {
  final controller = Get.put(CarPageController());

  @override
  Widget build(BuildContext context) {
    print('>>> Build Car Page');
    super.build(context);
    return Center(child: Obx(() => Text(controller.car.value)));
  }

  @override
  bool get wantKeepAlive => true;
}

class CarPageController extends GetxController {
  final car = ''.obs;

  @override
  void onInit() {
    print('Call API Car'); // called only once
    car.value = 'Ferrari';
    super.onInit();
  }
}

class BikePage extends StatefulWidget {
  @override
  _BikePageState createState() => _BikePageState();
}

class _BikePageState extends State<BikePage> with AutomaticKeepAliveClientMixin {
  final controller = Get.put(BikePageController());

  @override
  Widget build(BuildContext context) {
    print('>>> Build Bike Page');
    super.build(context);
    return Center(child: Obx(() => Text(controller.bike.value)));
  }

  @override
  bool get wantKeepAlive => true;
}

class BikePageController extends GetxController {
  final bike = ''.obs;

  @override
  void onInit() {
    print('Call API Bike'); // called only once
    bike.value = 'BMC';
    super.onInit();
  }
}
