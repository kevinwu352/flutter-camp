// 文档说，如果只用 state management or dependency management，就不用 GetMaterialApp
// 如果要 routes, snackbars, internationalization, bottomSheets, dialogs,
// and high-level apis related to routes and absence of context，则必须要 GetMaterialApp

// 文档说，用 GetX 的话，你可能再也不需要使用 StatefulWidget 了

// GetConnect 相当于是一个 Restfull API 的封装

// 普通的 List 上居然有这功能，这是 GetX 提供的一个扩展方法
// final list = [1, 2, 3];
// list.addIf(count > 2, 101);
// print(list);

// ================================================================================
// 状态管理
// 两种状态管理方式：简单的 GetBuilder，响应式的 GetX/Obx


// ================================================================================
// 路由管理

// to(() => NextScreen()) / toNamed("/details")
// back() 关闭 snackbar / dialog / bottomSheet，以前用 Navigator.pop(context) 的场景
// off(NextScreen()) 跳转到下一页，不用返回，相当于 replace，场景 splash/login
// offAll(NextScreen()) 跳转到下一页，不用返回，替换前面所有的页面，场景 支付完成


// ================================================================================
// 依赖管理


// ================================================================================
// 中间件
// https://juejin.cn/post/7435679658253139977

// GetPage Middleware 能对路由进行控制和拦截，比如某个页面需要登录，否则跳转。网上说它可以做如下功能：
//   引导页逻辑：在用户首次打开应用时跳转到引导页
//   身份验证：在用户访问受保护的页面时检查其身份状态
//   权限管理：判断用户是否有权限访问特定的页面
//   页面缓存：在页面打开时进行缓存检查，避免重复加载
//   请求限流：对短时间内频繁的请求进行限制（如防止快速重复提交表单）
//   数据加载：在用户进入页面之前预加载数据，以便页面加载更流畅
// 用法是继承 GetMiddleware
// 配置路由时传递给参数 GetMaterialApp(getPages(...GetPage(middlewares: [AuthMiddleware()]
// 中间件有一堆生命周期函数：
//   redirect：在页面构建之前调用，可用于路由重定向。返回 RouteSettings 用于指定新的页面，或返回 null 以继续原始页面的导航
//   onPageCalled：在页面构建前执行，可以用于检查或初始化数据。通常和 redirect 配合使用
//   onBindingsStart：在页面的 Binding 初始化之前执行，适合提前准备数据
//   onPageBuildStart：在页面构建开始前执行，可以设置页面初始状态或进行预处理
//   onPageBuilt：在页面构建完成后调用，用于对页面完成后的额外操作
//   onPageDispose：在页面被释放时调用，可以用于清理资源


// ================================================================================
// 其它高级 API

// // give the current args from currentScreen
// Get.arguments
// 
// // give name of previous route
// Get.previousRoute
// 
// // give the raw route to access for example, rawRoute.isFirst()
// Get.rawRoute
// 
// // give access to Routing API from GetObserver
// Get.routing
// 
// // check if snackbar is open
// Get.isSnackbarOpen
// 
// // check if dialog is open
// Get.isDialogOpen
// 
// // check if bottomsheet is open
// Get.isBottomSheetOpen
// 
// // remove one route.
// Get.removeRoute()
// 
// // back repeatedly until the predicate returns true.
// Get.until()
// 
// // go to next route and remove all the previous routes until the predicate returns true.
// Get.offUntil()
// 
// // go to next named route and remove all the previous routes until the predicate returns true.
// Get.offNamedUntil()
// 
// //Check in what platform the app is running
// GetPlatform.isAndroid
// GetPlatform.isIOS
// GetPlatform.isMacOS
// GetPlatform.isWindows
// GetPlatform.isLinux
// GetPlatform.isFuchsia
// 
// //Check the device type
// GetPlatform.isMobile
// GetPlatform.isDesktop
// //All platforms are supported independently in web!
// //You can tell if you are running inside a browser
// //on Windows, iOS, OSX, Android, etc.
// GetPlatform.isWeb
// 
// 
// // Equivalent to : MediaQuery.of(context).size.height,
// // but immutable.
// Get.height
// Get.width
// 
// // Gives the current context of the Navigator.
// Get.context
// 
// // Gives the context of the snackbar/dialog/bottomsheet in the foreground, anywhere in your code.
// Get.contextOverlay
// 
// // Note: the following methods are extensions on context. Since you
// // have access to context in any place of your UI, you can use it anywhere in the UI code
// 
// // If you need a changeable height/width (like Desktop or browser windows that can be scaled) you will need to use context.
// context.width
// context.height
// 
// // Gives you the power to define half the screen, a third of it and so on.
// // Useful for responsive applications.
// // param dividedBy (double) optional - default: 1
// // param reducedBy (double) optional - default: 0
// context.heightTransformer()
// context.widthTransformer()
// 
// /// Similar to MediaQuery.of(context).size
// context.mediaQuerySize()
// 
// /// Similar to MediaQuery.of(context).padding
// context.mediaQueryPadding()
// 
// /// Similar to MediaQuery.of(context).viewPadding
// context.mediaQueryViewPadding()
// 
// /// Similar to MediaQuery.of(context).viewInsets;
// context.mediaQueryViewInsets()
// 
// /// Similar to MediaQuery.of(context).orientation;
// context.orientation()
// 
// /// Check if device is on landscape mode
// context.isLandscape()
// 
// /// Check if device is on portrait mode
// context.isPortrait()
// 
// /// Similar to MediaQuery.of(context).devicePixelRatio;
// context.devicePixelRatio()
// 
// /// Similar to MediaQuery.of(context).textScaleFactor;
// context.textScaleFactor()
// 
// /// Get the shortestSide from screen
// context.mediaQueryShortestSide()
// 
// /// True if width be larger than 800
// context.showNavbar()
// 
// /// True if the shortestSide is smaller than 600p
// context.isPhone()
// 
// /// True if the shortestSide is largest than 600p
// context.isSmallTablet()
// 
// /// True if the shortestSide is largest than 720p
// context.isLargeTablet()
// 
// /// True if the current device is Tablet
// context.isTablet()
// 
// /// Returns a value<T> according to the screen size
// /// can give value for:
// /// watch: if the shortestSide is smaller than 300
// /// mobile: if the shortestSide is smaller than 600
// /// tablet: if the shortestSide is smaller than 1200
// /// desktop: if width is largest than 1200
// context.responsiveValue<T>()






// ================================================================================

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
