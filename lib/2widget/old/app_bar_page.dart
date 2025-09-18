import 'package:flutter/material.dart';

class AppBarExample1 extends StatelessWidget {
  const AppBarExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // foregroundColor: Colors.green,
        // iconTheme: IconThemeData(color: Colors.red, opacity: 0.5),
        title: const Text('AppBar Demo'),
        elevation: 5,
        shadowColor: Colors.red,
        surfaceTintColor: Colors.green,
        // toolbarOpacity: 0.5,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_alert),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('This is a snackbar')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.navigate_next),
            tooltip: 'Go to the next page',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return Scaffold(
                      appBar: AppBar(title: const Text('Next page')),
                      body: const Center(
                        child: Text(
                          'This is the next page',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('This is the home page', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

// Color? backgroundColor
// Color? foregroundColor 文字图标，icon theme 优先级更高

// Widget? leading 能设置自己的 icon
// bool automaticallyImplyLeading = true
// double? leadingWidth

// IconThemeData? iconTheme  IconThemeData(color: Colors.grey, opacity: 0.5)

// Widget? title
// bool? centerTitle
// double? titleSpacing
// TextStyle? titleTextStyle

// List<Widget>? actions
// IconThemeData? actionsIconTheme
// EdgeInsetsGeometry? actionsPadding

// Widget? flexibleSpace

// PreferredSizeWidget? bottom 紧贴在 AppBar 下面
// bottom: PreferredSize(
//   preferredSize: Size(402, 60),
//   child: SizedBox(
//     width: 402,
//     height: 60,
//     child: Image.network(
//       'https://images.pexels.com/photos/850359/pexels-photo-850359.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500',
//       fit: BoxFit.cover,
//     ),
//   ),
// ),
// double bottomOpacity = 1.0

// double? elevation 控制阴影，如果有 surfaceTintColor，还会在背景上加 tint
// double? scrolledUnderElevation
// Color? shadowColor
// Color? surfaceTintColor

// ShapeBorder? shape  能加个红边框，以后再研究
// shape: RoundedRectangleBorder(
//   side: BorderSide(color: Colors.red, width: 5),
// ),

// bool primary = true 是否显示在屏幕顶部

// 没有 toolbar，这部分影响的是导航栏
// double toolbarOpacity = 1.0 只影响 title icon 这些内容的透明度，背景不会影响
// double? toolbarHeight 导航栏高度
// TextStyle? toolbarTextStyle

// Clip? clipBehavior

// ScrollNotificationPredicate notificationPredicate = defaultScrollNotificationPredicate

// SystemUiOverlayStyle? systemOverlayStyle

// bool forceMaterialTransparency = false

// bool excludeHeaderSemantics = false
// bool useDefaultSemanticsOrder = true

final List<int> _items = List<int>.generate(51, (int index) => index);

class AppBarExample2 extends StatefulWidget {
  const AppBarExample2({super.key});

  @override
  State<AppBarExample2> createState() => _AppBarExample2State();
}

class _AppBarExample2State extends State<AppBarExample2> {
  bool shadowColor = false;
  double? scrolledUnderElevation;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AppBar Demo'),
        toolbarOpacity: 0.5,
        toolbarHeight: 100,
        scrolledUnderElevation:
            scrolledUnderElevation, // 内容滚动到 AppBar 下面以后，AppBar 改变颜色
        shadowColor: shadowColor ? Theme.of(context).colorScheme.shadow : null,
      ),
      body: GridView.builder(
        itemCount: _items.length,
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2.0,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Center(
              child: Text(
                'Scroll to see the Appbar in effect.',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
            );
          }
          return Container(
            alignment: Alignment.center,
            // tileColor: _items[index].isOdd ? oddItemColor : evenItemColor,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: _items[index].isOdd ? oddItemColor : evenItemColor,
            ),
            child: Text('Item $index'),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: OverflowBar(
            overflowAlignment: OverflowBarAlignment.center,
            alignment: MainAxisAlignment.center,
            overflowSpacing: 5.0,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    shadowColor = !shadowColor;
                  });
                },
                icon: Icon(
                  shadowColor ? Icons.visibility_off : Icons.visibility,
                ),
                label: const Text('shadow color'),
              ),
              const SizedBox(width: 5),
              ElevatedButton(
                onPressed: () {
                  if (scrolledUnderElevation == null) {
                    setState(() {
                      // Default elevation is 3.0, increment by 1.0.
                      scrolledUnderElevation = 4.0;
                    });
                  } else {
                    setState(() {
                      scrolledUnderElevation = scrolledUnderElevation! + 1.0;
                    });
                  }
                },
                child: Text(
                  'scrolledUnderElevation: ${scrolledUnderElevation ?? 'default'}',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
