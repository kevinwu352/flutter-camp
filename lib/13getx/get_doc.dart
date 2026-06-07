// 文档说，如果只用 state management or dependency management，就不用 GetMaterialApp
// 如果要 routes, snackbars, internationalization, bottomSheets, dialogs,
// and high-level apis related to routes and absence of context，则必须要 GetMaterialApp

// GetConnect 相当于是一个 Restfull API 的封装

// 普通的 List 上居然有这功能，这是 GetX 提供的一个扩展方法
// final list = [1, 2, 3];
// list.addIf(count > 2, 101);
// print(list);

// 非 GetController 子类也能 put/lazyPut


// ================================================================================
// 状态管理
// 两种状态管理方式：简单的 GetBuilder，响应式的 GetX/Obx


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
