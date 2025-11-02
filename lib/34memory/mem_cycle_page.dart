import 'package:flutter/material.dart';

// 循环引用也能正常释放
// 注意：本文件的私有类的私有成员能被本文件的其它类访问

// 被全局持有以后，Widget/State/Object 都释放不了
// 注意：
//   这里只有一个挂载点，也就是一个全局变量
//   下次再进页面，创建新的，旧的会被释放
_CycleObject? _ooo;

// 子元素的成员团包访问了 state 实例，退出页面时也能正常释放
// 见下面的 _ChildView

class MemCyclePage extends StatefulWidget {
  const MemCyclePage({super.key});

  @override
  State<MemCyclePage> createState() => _MemCyclePageState();
}

class _MemCyclePageState extends State<MemCyclePage> {
  @override
  void initState() {
    super.initState();
    obj._stt = this;
    _ooo = obj;
    print(_ooo);
    print(_ooo?._stt);
    // print('init');
  }

  @override
  void dispose() {
    // print('dispose');
    super.dispose();
  }

  final obj = _CycleObject();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cycle')),
      body: SizedBox.expand(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                //
              },
              child: Text('start'),
            ),
            _ChildView(action: () => print('$this')),
          ],
        ),
      ),
    );
  }
}

class _CycleObject {
  late _MemCyclePageState _stt;
}

class _ChildView extends StatelessWidget {
  const _ChildView({required this.action});
  final void Function() action;
  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: () => action(), child: Text('doit'));
  }
}
