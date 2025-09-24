import 'package:flutter/material.dart';

// required List<ButtonSegment<T>> segments
// required Set<T> selected
// void onSelectionChanged(Set<T>)?

// bool multiSelectionEnabled = false
// bool emptySelectionAllowed = false

// bool showSelectedIcon = true 选中的时候有个勾勾，能替换
// Widget? selectedIcon

// 本来是用固有宽度，紧紧抱成一团，加上以后用父的宽度，可能会被拉大
// 内容没变形，只是占用的空间变多了，padding 变多了
// EdgeInsets? expandedInsets

// ButtonStyle? style

// Axis direction = Axis.horizontal

class SegmentedPage extends StatefulWidget {
  const SegmentedPage({super.key});

  @override
  State<SegmentedPage> createState() => _SegmentedPageState();
}

class _SegmentedPageState extends State<SegmentedPage> {
  Calendar calendar = Calendar.day;
  Set<Calendar> selection = <Calendar>{Calendar.day};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Segmented')),
      body: Center(
        child: SegmentedButton<Calendar>(
          segments: const <ButtonSegment<Calendar>>[
            ButtonSegment<Calendar>(value: Calendar.day, label: Text('Day'), icon: Icon(Icons.calendar_view_day)),
            ButtonSegment<Calendar>(value: Calendar.week, label: Text('Week'), icon: Icon(Icons.calendar_view_week)),
            ButtonSegment<Calendar>(value: Calendar.month, label: Text('Month'), icon: Icon(Icons.calendar_view_month)),
            // ButtonSegment<Calendar>(value: Calendar.year, label: Text('Year'), icon: Icon(Icons.calendar_today)),
          ],
          // selected: <Calendar>{calendar},
          selected: selection,
          onSelectionChanged: (Set<Calendar> newSelection) {
            setState(() {
              // calendar = newSelection.first;
              selection = newSelection;
            });
          },
          multiSelectionEnabled: true,
          showSelectedIcon: true,
          selectedIcon: Icon(Icons.settings),

          // direction: Axis.vertical,
          // expandedInsets: EdgeInsets.all(50),

          // 修改边框
          style: SegmentedButton.styleFrom(
            side: BorderSide(color: Colors.red),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
        ),
      ),
    );
  }
}

enum Calendar { day, week, month }
