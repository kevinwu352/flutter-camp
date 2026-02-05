import 'package:flutter/material.dart';

extension ListViewExt on ListView {
  static ListView separate<T>({
    required List<T> items,
    required Widget Function(BuildContext ctx, int i) separator,
    required Widget? Function(BuildContext ctx, int i, T it) tile,
  }) {
    return ListView.separated(
      itemBuilder: (context, index) {
        if (index < items.length) {
          return tile(context, index, items[index]);
        } else {
          return Container();
        }
      },
      separatorBuilder: separator,
      itemCount: items.length + 1,
    );
  }
}
