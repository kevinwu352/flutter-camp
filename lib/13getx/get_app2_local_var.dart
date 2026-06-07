import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 用 ValueBuilder / ObxValue 将某个状态本地化

class GetApp2 extends StatelessWidget {
  const GetApp2({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: RootPage());
  }
}

class RootPage extends StatelessWidget {
  const RootPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('root')),
      body: SizedBox.expand(
        child: Column(
          children: [
            // ValueBuilder 是一个 StatefuleWidget，这里的初始值会用来初始化 State 里的 value
            // ValueBuilder.State.build 时将 value 传递给这里的 builder，builder 会创建 Switch 并返回
            // Switch 收到初始值，且将自己的事件通过 onChanged: update 通知给 ValueBuilder.State.update
            // update 是 ValueBuilder 内部的函数，update 内部调用 onUpdate 之类的事件会把事件再通知出来
            //
            // 现在用这东西会导致异常，无法用
            //
            // 文档说，这个控件能管理单个状态，且让它们 临时 本地化，也就是不用强行把本类改写成 StatefulWidget 并增加一个属性来保存状态
            // 要用这个状态，你可以在 onUpdate 回调里面得到新值，并作出相应响应
            // ValueBuilder<bool>(
            //   // 初始值，用于初始化内部状态
            //   initialValue: false,
            //   // 构建ValueBuilder的子Widget，接收两个参数：当前值和更新该值的回调函数
            //   builder: (value, update) => Switch(value: value, onChanged: update),
            //   // 每当ValueBuilder的值通过updater函数更新时回调此函数，value是新的值
            //   onUpdate: (value) => print("Value updated: $value"),
            //   // 当ValueBuilder从Widget树中移除并开始销毁过程时回调
            //   onDispose: () => print("Widget unmounted"),
            // ),

            // 和 ValueBuilder 等价，不过，这里是响应式的版本
            ObxValue(
              (data) => Switch(
                value: data.value,
                // Rx has a _callable_ function! You could use (flag) => data.value = flag,
                // onChanged: data,
                onChanged: (value) {
                  data.value = value;
                  // 修改界面上某些东西，这是关键部分，要的就是这部分
                  // 这里，我们让状态本地化了，且界面上能响应这个本地化的状态
                  print("value: $value");
                },
              ),
              true.obs,
            ),
            // 注意，这里的 switch 是无法改变值的，点不动，因为值是写死的，它没有可变的状态
            Switch(value: true, onChanged: (value) {}),
          ],
        ),
      ),
    );
  }
}
