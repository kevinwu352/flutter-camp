import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'app_localizations.dart';

class TheApp extends StatefulWidget {
  const TheApp({super.key});
  @override
  State<TheApp> createState() => _TheAppState();
}

class _TheAppState extends State<TheApp> {
  Locale? lc;

  @override
  void initState() {
    super.initState();

    final val = 1200000;
    // final val = 1200000.5678;
    // final val = 1.5678;
    // final val = 0.345618;

    print(NumberFormat().format(val)); // 1,200,000 | 1,200,000.568 | 1.568
    print(NumberFormat.compact(locale: "zh_TW").format(val)); // 1.2M 120萬 | 120萬 | 1.57
    print(NumberFormat.compactLong().format(val)); // 1.2 million | 1.2 million | 1.57

    // 前缀用什么？优先级递减：symbol(€) > name(JPY) > locale(USD)。有 symbol 用的是单符号，否则是 JPY 这种名字
    print(NumberFormat.currency().format(val)); // USD1,200,000.00 | USD1,200,000.57 | USD1.57
    print(NumberFormat.compactCurrency().format(val)); // USD1.2M | USD1.2M | USD1.57
    // 货币的 name 是 CNY / JPY 这种。如果随便给字符串，位数用 locale 的，前面符号是传的那值
    // 个人感觉 name 和 locale 最好匹配，比如 en_US 和 JPY 感觉很别扭
    // 货币小数点后面的位数是多少？优先级递减：decimalDigits 参数 > name 的 > locale 的
    print(NumberFormat.simpleCurrency().format(val)); // $1,200,000.00 | $1,200,000.57 | $1.57
    print(NumberFormat.compactSimpleCurrency().format(val)); // $1.2M | $1.2M | $1.57

    // 默认三位小数，且是四舍五入
    // 第一个方法会去除末尾的 0，第二个方法会保持 0
    print(NumberFormat.decimalPattern().format(val)); // 0.345678 => 0.346
    print(NumberFormat.decimalPatternDigits(decimalDigits: 2).format(val)); // 0.345678 => 0.35

    // 百分比数，它会把数乘以 100 再加百分号
    print(NumberFormat.percentPattern().format(val)); // 0.345678 => 35%
    print(NumberFormat.decimalPercentPattern(decimalDigits: 2).format(val)); // 0.345678 => 34.57%

    print(NumberFormat.scientificPattern().format(val)); // 1E6

    // var f = NumberFormat("###.##", "en_US");
    // print(f.format(12.345));
    // print(f.format(12345.345));
    // print(f.format(12.3));
    // print(f.format(12));
    // print(f.format(12.345));
    // print(f.format(12.345));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: lc,

      home: Scaffold(
        appBar: AppBar(title: Text("LOCAL")),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              if (lc == null) {
                print("null => fr");
                lc = Locale("fr");
              } else if (lc?.languageCode == "en") {
                print("en => fr");
                lc = Locale("fr");
              } else {
                print("fr => null");
                lc = null;
              }
            });
          },
          child: Icon(Icons.work),
        ),
        body: Builder(
          builder: (context) {
            return Column(
              children: [
                Text(AppLocalizations.of(context)!.dt_msg(DateTime.timestamp())),

                Text(AppLocalizations.of(context)!.num_msg(1200000)),
                Text(AppLocalizations.of(context)!.str_msg('god')),

                // Text(AppLocalizations.of(context)!.welcom_msg("kim")),
                // Text(AppLocalizations.of(context)!.n_wombats(0)),
                // Text(AppLocalizations.of(context)!.n_wombats(1)),
                // Text(AppLocalizations.of(context)!.n_wombats(2)),
                // Text(AppLocalizations.of(context)!.n_wombats(3)),

                // 上面是数字，这里用字符串
                // 还能 he she it
                // "pronoun": "{gender, select, male{he} female{she} other{it}}"
                // Text(AppLocalizations.of(context)!.pronoun('male')),
                // Text(AppLocalizations.of(context)!.pronoun('female')),
                // Text(AppLocalizations.of(context)!.pronoun('other')),

                // "escap": "Bonjour! '{Isn''t}' this''s a wonderful day?"
                // 单引号内的东西原样输出，如果要输出单引号，双写
                Text(AppLocalizations.of(context)!.escap),
                // Bonjour! {Isn't} this's a wonderful day?
                Row(
                  children: [
                    TextButton(onPressed: () => setState(() => lc = Locale('en')), child: Text('en')),
                    TextButton(onPressed: () => setState(() => lc = Locale('fr')), child: Text('fr')),
                    TextButton(onPressed: () => setState(() => lc = Locale('zh')), child: Text('zh')),
                    TextButton(onPressed: () => setState(() => lc = Locale('zh', 'HK')), child: Text('zh_HK')),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// arb 要求，如果语言提供了不同地区，那么要给个默认地区，即：zh, zh_TW，其中的 zh 就是 fallback 用的
// lc = Locale("zh", "TW"); 选择 zh_TW
// lc = Locale("zh", "HK"); 选择 zh，因为我没提供 zh_HK
// lc = Locale("zh"); 选择 zh

// "@@locale": "zh_TW",
// 如果文件名和这个 key 的值不匹配，会编译出错
// 如果项目里给了 zh_TW，但传 Locale('zh', 'HK')，会使用 zh

// vscode settings.json
// "arb-editor.suppressedWarnings": ["missing_metadata_for_key", "placeholder_without_metadata"],
