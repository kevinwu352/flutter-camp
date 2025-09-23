import 'package:flutter/material.dart';

// 两种类型的 BottomSheet
//   showBottomSheet 相当于页面内容的附加内容，既没有遮罩，也不影响背后的点击。另外，Scaffold.bottomSheet 参数也是此功能
//   showModalBottomSheet 要求用户只能专注于此

// 全局的 BottomSheetThemeData 会影响它俩

class SheetPage extends StatelessWidget {
  const SheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sheet')),
      backgroundColor: Colors.teal,
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.run_circle)),
      body: Builder(
        builder: (context) {
          return Column(
            children: [
              TextButton(
                onPressed: () {
                  showBottomSheet(
                    context: context,
                    // backgroundColor: Colors.blue,
                    constraints: BoxConstraints(maxHeight: 200),
                    // showDragHandle: true, 顶部那个胶囊线条
                    builder: (context) {
                      // 把 FAB 推到最上面去了，占用了导航条以下的全部空间，导航条上增加了返回按钮
                      // 能拖拽消失，能看到背后的颜色，上边是两圆角
                      // 点击遮罩不会消失，但是点击事件传递下去了
                      // return SizedBox.expand(child: Text('asdf'));
                      // 占据屏幕最下方中间一丁点空间，一个小半圆
                      return Text('asdf asdf asdf');
                    },
                  );
                },
                child: Text('show normal'),
              ),

              TextButton(
                onPressed: () {
                  // 点击遮罩会消失
                  showModalBottomSheet(
                    context: context,
                    useSafeArea: false, // 这属性感觉没啥用
                    builder: (context) {
                      // return SizedBox.expand(child: Text('1234'));
                      return Text('abc');
                    },
                  );
                },
                child: Text('show modal'),
              ),
            ],
          );
        },
      ),
    );
  }
}
