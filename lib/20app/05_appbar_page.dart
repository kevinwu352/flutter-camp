import 'package:flutter/material.dart';

// Widget? leading
// bool automaticallyImplyLeading = true 自动处理前功能，比如，返回按钮 抽屉按钮
// double? leadingWidth 给前面留多少空间，并不是前面的按钮宽度

// 一些数据：左边按钮宽48，左右空间4，占56；右边按钮整体占48
// Widget? title
// bool? centerTitle
// double? titleSpacing 标题不居中的时候能明显看出来效果，真的刚好。空间是两边都有，如果太大则会挤压标题
// TextStyle? titleTextStyle
// TextStyle? toolbarTextStyle 影响 leading 和 actions，不影响 title

// List<Widget>? actions
// EdgeInsetsGeometry? actionsPadding 不会撑高条条，如果给上下会压缩按钮尺寸，图标尺寸好像不会被压，个人认为只应该被用来控制左右位移

// PreferredSizeWidget? bottom 一般传 TabBar

// 位于整个 AppBar 的内容背后，包括 bottom 指定的 TabBar
// 如果是 Text，Text 和自身一样大，如果是 Container 且不指定尺寸，Container 充满整个条
// Widget? flexibleSpace

// Color? backgroundColor
// Color? foregroundColor

// IconThemeData? iconTheme 只传这个，会影响 actions 里的图标
// IconThemeData? actionsIconTheme 传了这个，则不受上面影响了

// double? toolbarHeight 主体的高度，默认 56，不包括安全区，不包括 bottom

// --------------------------------------------------------------------------------

// double? elevation
// Color? shadowColor
// Color? surfaceTintColor
// double? scrolledUnderElevation 内容滚动到 AppBar 下面以后，AppBar 改变颜色

// ShapeBorder? shape

// double toolbarOpacity = 1.0 背景色没变，里面的元素变了。文档说，一般不改这个，给 SliverAppBar 用的
// double bottomOpacity = 1.0 背景色没变，里面的元素变了。只是条条，下面的 TabBarView 没影响

// bool primary = true 如果为真，布局的时候会考虑安全区

// --------------------------------------------------------------------------------

// ScrollNotificationPredicate notificationPredicate = defaultScrollNotificationPredicate 没懂？

// SystemUiOverlayStyle? systemOverlayStyle 没懂？

// bool forceMaterialTransparency = false 没懂？

// bool animateColor = false 没懂？

// Clip? clipBehavior

// bool excludeHeaderSemantics = false
// bool useDefaultSemanticsOrder = true

class AppbarPage extends StatefulWidget {
  const AppbarPage({super.key});

  @override
  State<AppbarPage> createState() => _AppbarPageState();
}

class _AppbarPageState extends State<AppbarPage> with TickerProviderStateMixin {
  late final TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // backgroundColor: Colors.blue,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.run_circle)),
        title: Text('Appbar', style: TextStyle(backgroundColor: Colors.green)),

        // toolbarTextStyle: TextStyle(backgroundColor: Colors.red),
        // animateColor: false,
        // forceMaterialTransparency: true,
        // systemOverlayStyle: SystemUiOverlayStyle.dark,
        scrolledUnderElevation: 1.0,

        // primary: false,

        // title: Container(color: Colors.green, height: 30), 不一定要用文字标题，用这个 Container 更好测量尺寸
        // titleTextStyle: TextStyle(color: Colors.amber),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.run_circle))],

        // actionsPadding: EdgeInsets.all(20),
        // actionsPadding: EdgeInsets.symmetric(vertical: 20),

        // shape: Border.all(color: Colors.green),
        // shape: RoundedRectangleBorder(
        //   side: BorderSide(color: Colors.red, width: 2),
        //   borderRadius: BorderRadius.circular(20),
        // ),

        // toolbarOpacity: 0.5,
        // bottomOpacity: 0.4,

        // iconTheme: IconThemeData(size: 10),
        // actionsIconTheme: IconThemeData(size: 20),
        // backgroundColor: Colors.red,
        // foregroundColor: Colors.green,
        // flexibleSpace: Container(color: Colors.teal),
        // centerTitle: false,
        // titleSpacing: 10,
        // leadingWidth: 100,
        // toolbarHeight: 100,
        bottom: TabBar(
          controller: controller,
          tabs: [
            Tab(icon: Icon(Icons.directions_car)),
            Tab(icon: Icon(Icons.directions_transit)),
          ],
        ),
      ),
      body: TabBarView(controller: controller, children: [Icon(Icons.directions_car), Icon(Icons.directions_transit)]),
      // body: Text('asdf'),
    );
  }
}
