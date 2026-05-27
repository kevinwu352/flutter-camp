import 'package:flutter/material.dart';

// REVIEW

class DialogStatePage extends StatefulWidget {
  const DialogStatePage({super.key});

  @override
  State<DialogStatePage> createState() => _DialogStatePageState();
}

class _DialogStatePageState extends State<DialogStatePage> {
  var del = false;

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(title: Text('Dialog State')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final res = await showAlert();
          print('res: $res');
        },
        child: Icon(Icons.run_circle),
      ),
      body: Text('--'),
    );
  }

  Future<bool?> showAlert() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        print('build alert');
        return AlertDialog(
          title: Text('Are you sure?'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text('111?'),
                  Checkbox(
                    value: del,
                    onChanged: (value) {
                      print('change: $value');
                      // 这只会导致当前页面 rebuild，而 alert 其实是另外一个 NavigatorRoute，也就是另外一个页面
                      // 这里是问题，下面那些是解决方案
                      setState(() => del = value ?? false);
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Text('222?'),
                  Cb(
                    onChanged: (value) {
                      // 这也只会导致当前页面 rebuild，显示的 alert 其实并未 rebuild
                      // 原理是：
                      //   Cb 内部自己保存了状态，并且用状态来更新自己的界面，然后还将状态通知了出来
                      //   通知出来的新状态被保存到了当前页面里，所以最终内外状态都一样了
                      setState(() => del = value ?? false);
                    },
                    value: del,
                  ),
                ],
              ),
              Row(
                children: [
                  Text('333?'),
                  StatefulBuilder(
                    builder: (context, setState) {
                      print('builder called');
                      return Checkbox(
                        value: del,
                        onChanged: (value) {
                          print('change: $value');
                          // 这里的 setState 是 StatefulBuilder 内部的，并非本页面的
                          // 原理是：
                          //   Checkbox.onChanged 调用 StatefulBuilder.setState，导致 StatefulBuilder.build 被调用
                          //   然后导致 builder 被调用，builder 用新的状态重新创建了 Checkbox
                          //   同时注意，setState 的时候将最新状态保存到了页面，所以重建 Checkbox 时用的是最新状态
                          //
                          // 这种方法本质是：子组件通知父组件重新 build 子组件本身来实现 UI 更新
                          // Checkbox 调用 StatefulBuilder.setState，使其重建 Checkbox
                          setState(() => del = value ?? false);
                        },
                      );
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Text('444?'),
                  Checkbox(
                    value: del,
                    onChanged: (value) {
                      print('change: $value');
                      // 次佳方案
                      // 此时的 context 是 alert 的，将其标记为脏，不过这会导致整体个 alert 重建
                      //   showDialog(context: context, builder: (context) {})
                      // 仔细看这个 context，showDialog 接受的 context 是当前这个 Widget 的
                      // 但当前这个位置是 builder 函数体内，所以当前的 context 是 builder 那个参数，这个 context 是 alert 的
                      del = value ?? false;
                      (context as Element).markNeedsBuild();
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Text('555?'),
                  Builder(
                    builder: (context) {
                      print('builder called, checkbox');
                      return Checkbox(
                        value: del,
                        onChanged: (value) {
                          print('change: $value');
                          // 最佳方案
                          // 此时的 context 只是 Builder 的，将其标记为脏只会让 Builder 重建一下
                          del = value ?? false;
                          (context as Element).markNeedsBuild();
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: [TextButton(onPressed: () => Navigator.of(context).pop(true), child: Text('Done'))],
        );
      },
    );
  }
}

class Cb extends StatefulWidget {
  const Cb({super.key, required this.onChanged, required this.value});

  final ValueChanged<bool?> onChanged;
  final bool? value;

  @override
  State<Cb> createState() => _CbState();
}

class _CbState extends State<Cb> {
  bool? value;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: (v) {
        widget.onChanged(v);
        setState(() => value = v);
      },
    );
  }
}
