import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_camp/13getx/storage_page.dart';
import 'package:get/get.dart';

// 主题 和 国际化

// 当系统是暗黑模式时，启动 App 后，获取到的 Get.isDarkMode 是 false

// Get.isPlatformDarkMode 能获取到真的，但是如果用了它，下面修改主题就不会有效果了，为什么？很怪
//
// 答案是：效果是有的，只是用错了，有两种用法
// 用 Get.changeThemeMode
//   Get.changeThemeMode(Get.isPlatformDarkMode ? ThemeMode.dark : ThemeMode.light);
// 用 Get.changeTheme + Get.forceAppUpdate
//   Get.changeTheme(Get.isPlatformDarkMode ? ThemeDataEx.ddd() : ThemeDataEx.lll());
//   Get.forceAppUpdate();

// Get.updateLocale 以后，GetApp1.build 会被调用，它内部就是调用 forceAppUpdate 实现的
// Get.changeThemeMode 以后，GetApp1.build 不会调用，所以，我们需要手动调用了 forceAppUpdate 来整体刷新

abstract final class MyColors {
  // static Color text1() => Get.isDarkMode ? Colors.red : Colors.green;
  static Color text1() {
    final options = Get.find<AppOptions>();
    bool darken = options.darken ?? Get.isPlatformDarkMode;
    print('color-dark:${Get.isDarkMode} $darken');
    return darken ? Colors.red : Colors.green;
  }
  // Get.isDarkMode 只是 GetMaterialApp 当前设置的值，当前的状态
  // 所以，在 Get.changeThemeMode 以后，MyColors 里面获取的状态还是旧的，要等本次刷新完成以后，Get.isDarkMode 才会变成新值
  // 那么最好的办法就是用 options.darken ?? Get.isPlatformDarkMode 来手动计算当前正确的状态
}

extension LocaleExt on Locale {
  String get lcCode => [languageCode, countryCode].whereType<String>().where((e) => e.isNotEmpty).join("_");
}

class GetApp1 extends StatelessWidget {
  const GetApp1({super.key});
  @override
  Widget build(BuildContext context) {
    final options = Get.find<AppOptions>();

    print('launch, options:${options.locale}, current:${Get.locale}, device:${Get.deviceLocale}');
    Locale locale = AppTranslations.localeFrom(options.locale ?? Get.deviceLocale);
    print("set-locale:$locale");

    print("launch, options-dark:${options.darken}, system-dark:${Get.isPlatformDarkMode}, is-dark:${Get.isDarkMode}");
    bool darken = options.darken ?? Get.isPlatformDarkMode;
    print("set-darken:$darken");

    return GetMaterialApp(
      translations: AppTranslations(),
      locale: locale,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red, brightness: Brightness.light),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green, brightness: Brightness.dark),
      ),
      themeMode: darken ? ThemeMode.dark : ThemeMode.light,
      home: RootPage(),
    );
  }
}

// 用的时候关注这几个 key 的具体写法，以及最终的效果是否合理
class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': translationEn,
    'zh_CN': translationZhCN,
    'zh_HK': translationZhTW,
    'zh_MO': translationZhTW,
    'zh_TW': translationZhTW,
    'fr': translationFr,
    'es': translationEs,
  };

  static Locale localeFrom(Locale? from) {
    final locales = [
      Locale("en"),
      Locale("zh", "CN"),
      Locale("zh", "HK"),
      Locale("zh", "MO"),
      Locale("zh", "TW"),
      Locale("fr"),
      Locale("es"),
    ];

    print("compare language_Country");
    var code = from?.lcCode;
    var locale = locales.firstWhereOrNull((e) => e.lcCode == code);
    if (locale != null) return locale;

    print("compare language");
    code = from?.languageCode;
    locale = locales.firstWhereOrNull((e) => e.languageCode == code);
    if (locale != null) return locale;

    return Locale("es");
  }
}

Map<String, String> translationEn = {
  'hello': 'Hello World',
  'item_desc': 'an item',
  'item_descs': '@count items',
  'love_word': '@i love @you',
};
Map<String, String> translationZhCN = {'hello': '你好，世界', 'item_desc': '@count 物体', 'love_word': '@you被@i爱着'};
// 注意这里，@i @you 和下一个词之间没有空格，也能被识别出来，这个场景是，中文里是没空格的
Map<String, String> translationZhTW = {'hello': '您好，世界', 'item_desc': '@count 物體', 'love_word': '@yoube@ilove'};
Map<String, String> translationFr = {
  'hello': 'Bonjour le monde',
  'item_desc': '@count Artikel',
  'love_word': '@i love @you',
};

Map<String, String> translationEs = {'hello': 'Hola Mundo', 'item_desc': '@count Artikel', 'love_word': '@i love @you'};

class RootPage extends StatelessWidget {
  const RootPage({super.key});
  @override
  Widget build(BuildContext context) {
    print('page, current:${Get.locale}, device:${Get.deviceLocale}');
    var you = '你';
    var amount = 0;
    return Scaffold(
      appBar: AppBar(title: Text('root')),
      body: SizedBox.expand(
        child: Column(
          children: [
            Text("hello".tr, style: TextStyle(color: MyColors.text1())),
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
            TextButton(onPressed: () => changeLanguage(null), child: Text("Lang: auto")),
            TextButton(onPressed: () => changeLanguage(Locale("en")), child: Text("Lang: en")),
            TextButton(onPressed: () => changeLanguage(Locale("zh", "CN")), child: Text("Lang: zh_CN")),
            TextButton(onPressed: () => changeLanguage(Locale("zh", "TW")), child: Text("Lang: zh_TW")),
            TextButton(onPressed: () => changeLanguage(Locale("fr")), child: Text("Lang: fr")),
            TextButton(onPressed: () => changeLanguage(Locale("es")), child: Text("Lang: es")),
            Divider(),
            TextButton(onPressed: () => changeTheme(null), child: Text("Theme: auto")),
            TextButton(onPressed: () => changeTheme(false), child: Text("Theme: light")),
            TextButton(onPressed: () => changeTheme(true), child: Text("Theme: dark")),
            TextButton(
              onPressed: () => print("show, is-dark:${Get.isDarkMode}, system-dark:${Get.isPlatformDarkMode}"),
              child: Text("show theme"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.run_circle)),
    );
  }

  void changeLanguage(Locale? locale) {
    final options = Get.find<AppOptions>();
    options.locale = locale;
    Get.updateLocale(locale ?? AppTranslations.localeFrom(Get.deviceLocale));
  }

  void changeTheme(bool? darken) {
    final options = Get.find<AppOptions>();
    options.darken = darken;
    Get.changeThemeMode((darken ?? Get.isPlatformDarkMode) ? ThemeMode.dark : ThemeMode.light);
    Get.forceAppUpdate();
    print("change theme to $darken");
    dump();
  }

  void dump() {
    // 改变主题以后 Get.isDarkMode 的值并不会马上变，就算下个事件周期也没变，但是 1s 后肯定是变了
    Future.delayed(Duration.zero, () => print("future-dark-mode: ${Get.isDarkMode}"));
    Timer(Duration.zero, () => print("timer-dark-mode: ${Get.isDarkMode}"));
    Future.delayed(Duration(seconds: 1), () => print("delay-dark-mode: ${Get.isDarkMode}"));
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
