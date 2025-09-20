// ButtonStyle 相关

// WidgetStateProperty<Color> 意味着这个属性的值会跟着控件的状态变化
// WidgetStatePropertyAll 是简化 .all 的类
//
// 所有状态一个颜色
// WidgetStateProperty.all(Colors.purple)
// 
// 传一个字典，{状态: 颜色}
// WidgetStateProperty.fromMap({WidgetState.pressed: Colors.red})
// 
// 传一个闭包，状态改变时调用
// WidgetStateProperty.resolveWith((states) => states.contains(WidgetState.pressed) ? Colors.green : null)
// 
// 没懂？
// resolveAs

// 修改按钮某个状态的属性
// 这里用的是 ButtonStyle 直接创建，而不是 ElevatedButton.styleFrom，因为 styleFrom 的参数类型是 Color，而这里是 WidgetStateProperty<Color?>
//   ElevatedButton(
//     style: ButtonStyle(
//       // 按下时调用闭包，states 包含 .pressed，如果返回值则用，如果返回 null 则用原来的默认值
//       backgroundColor: WidgetStateProperty.resolveWith(
//         (states) => states.contains(WidgetState.pressed) ? Colors.green : null,
//       ),
//     ),
//     child: const Text('Fly me to the moon'),
//     onPressed: () {},
//   )
//
// 所有状态全用一种颜色，不过，点击时还是有波纹效果
//   ElevatedButton(
//     style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll<Color>(Colors.green)),
//     child: const Text('Let me play among the stars'),
//     onPressed: () {},
//   )
//     style: ElevatedButton.styleFrom(backgroundColor: Colors.green), 用这个效果一样

