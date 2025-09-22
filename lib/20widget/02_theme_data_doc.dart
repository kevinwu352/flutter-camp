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

// ButtonThemeData? buttonTheme
// IconButtonThemeData? iconButtonTheme
// TextButtonThemeData? textButtonTheme
// ElevatedButtonThemeData? elevatedButtonTheme
// FilledButtonThemeData? filledButtonTheme
// OutlinedButtonThemeData? outlinedButtonTheme
// FloatingActionButtonThemeData? floatingActionButtonTheme
// ToggleButtonsThemeData? toggleButtonsTheme
// SegmentedButtonThemeData? segmentedButtonTheme

// ListTileThemeData? listTileTheme

// ScrollbarThemeData? scrollbarTheme

// Object? appBarTheme
// BottomAppBarThemeData? bottomAppBarTheme
// BottomNavigationBarThemeData? bottomNavigationBarTheme

// NavigationBarThemeData? navigationBarTheme
// NavigationDrawerThemeData? navigationDrawerTheme
// NavigationRailThemeData? navigationRailTheme

// MenuThemeData? menuTheme
// MenuBarThemeData? menuBarTheme
// MenuButtonThemeData? menuButtonTheme

// ActionIconThemeData? actionIconTheme
// BadgeThemeData? badgeTheme
// MaterialBannerThemeData? bannerTheme
// BottomSheetThemeData? bottomSheetTheme
// CarouselViewThemeData? carouselViewTheme
// CheckboxThemeData? checkboxTheme
// ChipThemeData? chipTheme
// DataTableThemeData? dataTableTheme
// DialogThemeData? dialogTheme
// DrawerThemeData? drawerTheme
// DropdownMenuThemeData? dropdownMenuTheme
// ExpansionTileThemeData? expansionTileTheme
// PopupMenuThemeData? popupMenuTheme
// ProgressIndicatorThemeData? progressIndicatorTheme
// RadioThemeData? radioTheme
// SearchBarThemeData? searchBarTheme
// SearchViewThemeData? searchViewTheme
// SliderThemeData? sliderTheme
// SnackBarThemeData? snackBarTheme
// SwitchThemeData? switchTheme
// TabBarThemeData? tabBarTheme
// TextSelectionThemeData? textSelectionTheme
// DatePickerThemeData? datePickerTheme
// TimePickerThemeData? timePickerTheme
// TooltipThemeData? tooltipTheme
// PageTransitionsTheme? pageTransitionsTheme
// NoDefaultCupertinoThemeData? cupertinoOverrideTheme
// Object? inputDecorationTheme

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
