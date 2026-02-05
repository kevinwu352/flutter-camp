import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/storage/storage.dart';
import '/utils/list_view_ext.dart';

class ThemePage extends StatelessWidget {
  ThemePage({super.key});

  final _items = ThemeMode.values.map((e) => _Item(name: e.name, value: e)).toList();

  @override
  Widget build(BuildContext context) {
    final defaults = context.read<Defaults>();
    return Scaffold(
      appBar: AppBar(title: Text('Theme')),
      body: ListViewExt.separate(
        items: _items,
        separator: (ctx, i) => Divider(thickness: 0),
        tile: (ctx, i, it) => ListTile(
          title: Text(it.name),
          trailing: it.value == defaults.theme ? Icon(Icons.check) : null,
          onTap: () => defaults.theme = it.value,
        ),
      ),
    );
  }
}

class _Item {
  const _Item({required this.name, required this.value});
  final String name;
  final ThemeMode value;
}
