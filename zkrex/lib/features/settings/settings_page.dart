import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '/storage/storage.dart';
import '/ui/router.dart';
import '/utils/list_view_ext.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  final _items = const [
    _Item(name: 'Language', value: Routes.settingsLanguage),
    _Item(name: 'Theme', value: Routes.settingsTheme),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        actions: [
          IconButton(
            onPressed: () {
              final secures = context.read<Secures>();
              secures.boardedVersion = null;
              context.go(Routes.onboard);
            },
            icon: Icon(Icons.slideshow),
          ),
        ],
      ),
      body: ListViewExt.separate(
        items: _items,
        separator: (ctx, i) => Divider(thickness: 0),
        tile: (ctx, i, it) =>
            ListTile(title: Text(it.name), trailing: Icon(Icons.keyboard_arrow_right), onTap: () => ctx.push(it.value)),
      ),
    );
  }
}

class _Item {
  const _Item({required this.name, required this.value});
  final String name;
  final String value;
}
