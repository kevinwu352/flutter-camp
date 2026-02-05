// 非 GetController 子类也能 put/lazyPut

// late final dep = Get.put(HomeObject());
// 这行代码会崩，因为 late 是懒加载，如果在 build 里面不访问一下 dep 成员
// 那么不会调用后面的 put 代码，所以会崩
// 非 late 的就不会崩，因为非 late 的会在这个 widget 被创建时就创建 dep，从而调用 put

// Get.back()/to() 必须要 GetMaterialApp，否则会崩

// 在 StatelessWidget 里用属性 put，在 build find，导航用系统的
// 会导致 object 无法释放，有时候 page 也释放不掉
// 在 build 里直接 put，效果也类似
// 但是，如果多次进入页面，虽然创建了多个，但是前面的会销毁
// 我在 Memory 页面能看到这个实例的数量始终是 1
// 所以，我认为的这个内在泄漏，估计只是 Get 超长管理了它的生命罢了
//
// 在页面内修改 object 里的值，后续进入页面，新值依然在
// 所以，虽然 object 的构造器被调用很多次，put 方法创建了很多实例
// 但 Get 管理的依然是最初那个，那 Get 为何还要创建那么多个呢？如何销毁？
//
// 试试 Get.replace 吧，它里面 delete 旧的，再 put 新的
// Get.create 可能更适合，页面退出后马上销毁了，很干净，但多个 find 调用会创建多个实例
//
// 其实，仔细想一想，可以不用 put/find 来管理 ViewModel 的生命周期
// 直接将 ViewModel 作为属性，在 build 方法内部使用，不就行了吗？

// 依赖管理有哪些 API？
// put/putAsync/lazyPut
// create
// find
// delete/deleteAll
// reload/reloadAll
// isRegistered
// isPrepared
// replace/lazyReplace

// ================================================================================

// Binding 里可以 put/lazyPut 多个依赖
// class HomeBinding implements Bindings {
//   @override void dependencies() {
//     Get.lazyPut<HomeController>(() => HomeController());
//     Get.put<Service>(() => Api());
//   }
// }
// 在静态路由表里面使用
// getPages: [
//   GetPage(
//     name: '/',
//     page: () => HomeView(),
//     binding: HomeBinding(),
//   ),
//   也能使用 BindingsBuilder，少写一个类
//   GetPage(
//     name: '/',
//     page: () => HomeView(),
//     binding: BindingsBuilder(() {
//       Get.lazyPut<ControllerX>(() => ControllerX());
//     }),
//   )
// ]
// 在 push 页面时使用
// Get.to(Home(), binding: HomeBinding());

// ================================================================================

// 这俩内部必须使用 RX 类型的数据
// Obx 内部自己获取相应的 controller，GetX 用泛型参数来获取相应的 controller
// Obx(() => Text('name: ${vm.name}'))
// GetX<HomeViewModel>(builder: (controller) => Text('name: ${controller.age}'))
//
// 它能使用 GetxController 的子类
// GetBuilder(init: vm, builder: (controller) => Text('name: ${controller.name}'))
