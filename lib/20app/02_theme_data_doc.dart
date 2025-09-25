// bool? useMaterial3
// bool? useSystemColors 没懂？
// VisualDensity? visualDensity 定义控件在水平或垂直方向的空间
// MaterialTapTargetSize? materialTapTargetSize 决定控件的 hit-test 区域

// String? fontFamily 还真的把全局字体改了
// List<String>? fontFamilyFallback
// String? package

// ColorScheme? colorScheme
// Color? colorSchemeSeed ColorScheme.fromSeed(seedColor, brightness, ...)，所以，它在这里干嘛？
// MaterialColor? primarySwatch ColorScheme.fromSwatch(primarySwatch, brightness, ...)，所以，它在这里干嘛？样品/小样
// Brightness? brightness

// TextTheme? textTheme 里面是一堆 TextStyle，titleLarge / bodyMedium
// TextTheme? primaryTextTheme

// --------------------------------------------------------------------------------

// Color? primaryColor
// Color? primaryColorDark
// Color? primaryColorLight

// Color? disabledColor
// Color? highlightColor
// Color? hoverColor

// Color? scaffoldBackgroundColor 这个有用

// Color? secondaryHeaderColor

// Color? shadowColor

// Color? splashColor

// Color? canvasColor

// Color? focusColor

// Color? hintColor

// Color? unselectedWidgetColor

// --------------------------------------------------------------------------------

// Color? cardColor
// CardThemeData? cardTheme

// Color? dividerColor
// DividerThemeData? dividerTheme

// --------------------------------------------------------------------------------

// IconThemeData? iconTheme
// IconThemeData? primaryIconTheme
// ActionIconThemeData? actionIconTheme 修改 导航返回图标 关闭图标 左右抽屉图标

// ButtonThemeData? buttonTheme 文档说要废弃了，用下面这些具体的
// IconButtonThemeData? iconButtonTheme 唯一参数 ButtonStyle
// TextButtonThemeData? textButtonTheme 唯一参数 ButtonStyle
// ElevatedButtonThemeData? elevatedButtonTheme 唯一参数 ButtonStyle
// FilledButtonThemeData? filledButtonTheme 唯一参数 ButtonStyle
// OutlinedButtonThemeData? outlinedButtonTheme 唯一参数 ButtonStyle
// FloatingActionButtonThemeData? floatingActionButtonTheme

// ListTileThemeData? listTileTheme
// ExpansionTileThemeData? expansionTileTheme

// CheckboxThemeData? checkboxTheme
// RadioThemeData? radioTheme
// SwitchThemeData? switchTheme
// SliderThemeData? sliderTheme
// ProgressIndicatorThemeData? progressIndicatorTheme
// SegmentedButtonThemeData? segmentedButtonTheme
// ToggleButtonsThemeData? toggleButtonsTheme 文档说是 2 时代的，现在用 segmented

// DropdownMenuThemeData? dropdownMenuTheme
// PopupMenuThemeData? popupMenuTheme

// BadgeThemeData? badgeTheme
// TooltipThemeData? tooltipTheme
// ChipThemeData? chipTheme
// SnackBarThemeData? snackBarTheme

// TimePickerThemeData? timePickerTheme
// DatePickerThemeData? datePickerTheme 影响 DatePickerDialog
// DialogThemeData? dialogTheme
// BottomSheetThemeData? bottomSheetTheme

// Object? appBarTheme
// BottomAppBarThemeData? bottomAppBarTheme 一般 Scaffold.bottomNavigationBar = BottomAppBar
// NavigationBarThemeData? navigationBarTheme 底部的 TabBar，新版本的 BottomNavigationBar，用这个
// BottomNavigationBarThemeData? bottomNavigationBarTheme 底部的 TabBar，一般 Scaffold.bottomNavigationBar = BottomNavigationBar

// PageTransitionsTheme? pageTransitionsTheme 定义不同平台使用的页面过渡样式，参数是字典，键是平台，值是预设的过渡样式

// Object? inputDecorationTheme 影响 InputDecorator / TextField / TextFormField，但 DropdownMenu 里面的输入框不受此影响

// --------------------------------------------------------------------------------

// CarouselViewThemeData? carouselViewTheme 比较花哨，用到再研究吧

// DataTableThemeData? dataTableTheme 像 excel 的表格，用到再研究吧

// SearchBarThemeData? searchBarTheme 与 SearchAnchor 配合使用
// SearchViewThemeData? searchViewTheme 没有 SearchView 这个类，SearchAnchor 带的那个 suggest 就是 search view

// 位于导航条下面，有 图标 文字 按钮，单个按钮就排成一行
// 非模态，能忽略它，也能点按钮消失它
// 我感觉没啥特别的，没有非它不可
// 可以这样展示 ScaffoldMessenger.of(context).showMaterialBanner()
// MaterialBannerThemeData? bannerTheme

// 电脑上那种层级菜单，还有 MenuAnchor
// MenuBarThemeData? menuBarTheme 定义 MenuBar 的样式，子菜单的样式用下俩
// MenuThemeData? menuTheme
// MenuButtonThemeData? menuButtonTheme

// TextSelectionThemeData? textSelectionTheme 相关的类太多了，好复杂

// NoDefaultCupertinoThemeData? cupertinoOverrideTheme 未传的参数无默认值，CupertinoThemeData 则有默认值，干嘛用的？

// --------------------------------------------------------------------------------

// DrawerThemeData? drawerTheme
// NavigationDrawerThemeData? navigationDrawerTheme
// NavigationRailThemeData? navigationRailTheme

// TabBarThemeData? tabBarTheme

// ScrollbarThemeData? scrollbarTheme

// --------------------------------------------------------------------------------

// Iterable<Adaptation<Object>>? adaptations 主题的 adaptations，没懂？
// Iterable<ThemeExtension>? extensions 主题的扩展，干嘛的？

// bool? applyElevationOverlayColor 文档说是突显暗黑模式的半透明浮层，M3 后不用此属性

// TargetPlatform? platform

// InteractiveInkFeatureFactory? splashFactory 定义 ink splashe 的外观，应该是按钮点击那种波纹效果

// Typography? typography 配置 TextTheme 的 color and geometry

// @Deprecated('Use OverflowBar instead. ' 'This feature was deprecated after v3.21.0-10.0.pre.') ButtonBarThemeData? buttonBarTheme
// @Deprecated('Use DialogThemeData.backgroundColor instead. ' 'This feature was deprecated after v3.27.0-0.1.pre.') Color? dialogBackgroundColor
// @Deprecated('Use TabBarThemeData.indicatorColor instead. ' 'This feature was deprecated after v3.28.0-1.0.pre.') Color? indicatorColor
