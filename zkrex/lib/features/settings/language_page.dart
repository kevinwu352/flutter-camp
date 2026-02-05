import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/l10n/localizations.dart';
import '/storage/storage.dart';
import '/utils/list_view_ext.dart';

class LanguagePage extends StatelessWidget {
  LanguagePage({super.key});

  final _items = AppLocalizations.supportedLocales.map((e) => _Item(name: e.toLanguageTag(), value: e)).toList();

  @override
  Widget build(BuildContext context) {
    final defaults = context.read<Defaults>();
    return Scaffold(
      appBar: AppBar(title: Text('Language')),
      body: ListViewExt.separate(
        items: _items,
        separator: (ctx, i) => Divider(thickness: 0),
        tile: (ctx, i, it) => ListTile(
          title: Text(it.name),
          trailing: it.value == defaults.language ? Icon(Icons.check) : null,
          onTap: () => defaults.language = it.value,
        ),
      ),
    );
  }
}

class _Item {
  const _Item({required this.name, required this.value});
  final String name;
  final Locale value;
}
