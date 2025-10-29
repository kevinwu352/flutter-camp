import 'package:flutter/material.dart';

// List<TableRow> children = const <TableRow>[]

// 某列不指定则用 defaultColumnWidth
// Map<int, TableColumnWidth>? columnWidths
// TableColumnWidth defaultColumnWidth = const FlexColumnWidth()

// TextDirection? textDirection

// 可以分别设置 外边框 和 中间十字边框 的样式
// TableBorder? border

// 如果第一行某个内容比较高，它会带动整行的高度，但第二行不受影响
// TableCellVerticalAlignment defaultVerticalAlignment = TableCellVerticalAlignment.top

// TextBaseline? textBaseline

class TablePage extends StatelessWidget {
  const TablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Table')),
      body: Text('--'),
    );
  }
}
