import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 主题 和 国际化

// 后续，用一个东西把当前用户选择的主题模式存下来，下次 App 启动时加载回来用

// 当系统是暗黑模式时，启动 App 后，获取到的 Get.isDarkMode 是 false
var isDark = Get.isDarkMode;
// Get.isPlatformDarkMode 能获取到真的，但是如果用了这行代码，下面修改主题就不会有效果了，为什么？很怪
// var isDark = Get.isPlatformDarkMode;

class GetApp1 extends StatelessWidget {
  const GetApp1({super.key});
  @override
  Widget build(BuildContext context) {
    print("app build, dark-mode: ${Get.isDarkMode} ${Get.isPlatformDarkMode}");
    return GetMaterialApp(
      translations: AppTranslations(),
      // locale: Get.deviceLocale,
      locale: Locale("en", "US"),
      fallbackLocale: Locale("de", "DE"),
      // 要不要这行呢？加了要崩，官方文档没加，网上有个例子加了
      // supportedLocales: [Locale("en", "US"), Locale("zh", "CN"), Locale("zh", "TW"), Locale("de", "DE")],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red, brightness: Brightness.light),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green, brightness: Brightness.dark),
      ),
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      home: RootPage(),
    );
  }
}

// 用的时候关注这几个 key 的具体写法，以及最终的效果是否合理
class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': translationEnUS(),
    'zh_CN': translationZhCN(),
    'zh_TW': translationZhTW(),
    'de_DE': translationDeDE(),
  };
}

Map<String, String> translationEnUS() => {
  'hello': 'Hello World',
  'item_desc': 'an item',
  'item_descs': '@count items',
  'love_word': '@i love @you',
};
Map<String, String> translationZhCN() => {'hello': '你好，世界', 'item_desc': '@count 物体', 'love_word': '@you被@i爱着'};
Map<String, String> translationZhTW() => {
  'hello': '您好，世界', 'item_desc': '@count 物體',
  // 注意这里，@i @you 和下一个词之间没有空格，也能被识别出来，这个场景是，中文里是没空格的
  'love_word': '@yoube@ilove',
};
Map<String, String> translationDeDE() => {
  'hello': 'Hallo Welt',
  'item_desc': '@count Artikel',
  'love_word': '@i love @you',
};

class RootPage extends StatelessWidget {
  const RootPage({super.key});
  @override
  Widget build(BuildContext context) {
    print('device: ${Get.deviceLocale}, current: ${Get.locale}');
    var you = '你';
    var amount = 0;
    return Scaffold(
      appBar: AppBar(title: Text('root')),
      body: SizedBox.expand(
        child: Column(
          children: [
            Text("hello".tr),
            Text("love_word".trParams({'i': '我', 'you': you})),
            // 注意这个复数怎么用的：
            //   首先要在文件里定义两个 key，第一个参数是复数key
            //   然后根据第二个参数来决定使用哪个 key
            //   再把参数传递到第三个参数
            // 这个实现有点繁琐，并不完美
            Text("item_desc".trPluralParams("item_descs", amount, {'count': "$amount"})),
            // 这里有一个 String 的扩展，方便复数使用，可以参考一下
            // 我改了改，放最下面了
            // https://flutterlocalisation.com/blog/flutter-getx-localization
            Text("item_desc".plural(amount, "count")),
            TextButton(
              onPressed: () {
                // 不错，可以在应用内实时切换语言
                // 这里的 build 方法会被重新调用
                Get.updateLocale(Locale("zh", "CN"));
              },
              child: Text("doit"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 改变主题时，文档里面传的是 ThemeData.light() ThemeData.dark()
          // 但不要传这俩，传上面真正传的两个
          // Get.changeTheme(Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
          //
          // 要判断主题是否更改，观察这个漂浮按钮的颜色

          final light = ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.red, brightness: Brightness.light),
          );
          final dark = ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.green, brightness: Brightness.dark),
          );

          var oldDark = Get.isDarkMode;
          var oldIs = isDark;
          isDark = !isDark;
          Get.changeTheme(isDark ? dark : light);

          print("dark-mode: $oldDark -> ${Get.isDarkMode}, isDark: $oldIs -> $isDark");

          // 改变主题以后 Get.isDarkMode 的值并不会马上变，就算下个事件周期也没变，但是 1s 后肯定是变了
          Future.delayed(Duration.zero, () => print("future-dark-mode: ${Get.isDarkMode}"));
          Timer(Duration.zero, () => print("timer-dark-mode: ${Get.isDarkMode}"));
          Future.delayed(Duration(seconds: 1), () => print("delay-dark-mode: ${Get.isDarkMode}"));
        },
        child: Icon(Icons.run_circle),
      ),
    );
  }
}

// 本质是根据规则，用不同的数字来匹配不同的 key
// 然后将数字和其它参数一起打包发给 trParams
// 但其实，如果有多个复数，这个函数就不适合了，得继续改改
//
// 这个实现里面，虽然把 number 作为参数传了进去，不过，单数的时候是固定的 an item，并没有参数，不过，没关系，多余的参数没影响
extension PluralTranslation on String {
  String plural(int number, String? key, {Map<String, String>? params}) {
    final field = number <= 1 ? this : "${this}s";
    return field.trParams({?key: "$number", ...?params});
  }
}
