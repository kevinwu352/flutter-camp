
class TheApp extends StatefulWidget {
  const TheApp({super.key});
  @override
  State<TheApp> createState() => _TheAppState();
}

class _TheAppState extends State<TheApp> {
  Locale? lc;

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
                Text(AppLocalizations.of(context)!.welcom_msg("kim")),
                Text(AppLocalizations.of(context)!.n_wombats(0)),
                Text(AppLocalizations.of(context)!.n_wombats(1)),
                Text(AppLocalizations.of(context)!.n_wombats(2)),
                Text(AppLocalizations.of(context)!.n_wombats(3)),

                // 上面是数字，这里用字符串
                // 还能 he she it
                // "pronoun": "{gender, select, male{he} female{she} other{it}}"
                Text(AppLocalizations.of(context)!.pronoun('male')),
                Text(AppLocalizations.of(context)!.pronoun('female')),
                Text(AppLocalizations.of(context)!.pronoun('other')),

                // "escap": "Bonjour! '{Isn''t}' this''s a wonderful day?"
                // 单引号内的东西原样输出，如果要输出单引号，双写
                Text(AppLocalizations.of(context)!.escap),
                Bonjour! {Isn't} this's a wonderful day?
              ],
            );
          },
        ),
      ),
    );
  }
}


arb 要求，如果语言提供了不同地区，那么要给个默认地区，即：zh, zh_TW，其中的 zh 就是 fallback 用的
lc = Locale("zh", "TW"); 选择 zh_TW
lc = Locale("zh", "HK"); 选择 zh，因为我没提供 zh_HK
lc = Locale("zh"); 选择 zh
