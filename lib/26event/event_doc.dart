// 点击事件的处理有两个层次：一是原始事件，点下/移动/抬起；二是手势事件，原始的经过识别成为某种手势
// 也是 hit-test 找出最内层的控件，再向上冒泡，不过 Flutter 无法阻击冒泡，iOS 里不调 super.touchBegan 就阻击了

// 事件处理流程：
// 1) 命中测试，找出哪些控件应该响应此事件
//    深度优先，调用 hit-test，通过的控件加入到一个列表中
//    只在 down 事件时进行命中测试，其它事件直接拿列表来用
//    子比父先响应事件，因为：查找是深度优先，子先进列表，分发是从头到尾
// 2) 事件分发，按照上面的列表顺序依次分发事件，调用 handleEvent，down/move 之类的
// 3) 事件清理，当抬起或取消时，先分发事件，再清理列表

// DragStartBehavior
// 控制 GestureRecognizer 的 onStart 回调收到的点
//   .down 手指点上去那个点，当时还没被识别成 drag 手势
//   .start 当 drag 手势成功赢得竞技场那个点

// ================================================================================

// 命中测试
// 某控件能否响应事件，就看测试命中时，会不会被加入到列表
// 实现是：
//   先判断点是否在自己区域内，如果不是直接返回 false
//   如果点击发生在自己区域内，则 hitTestChildren || hitTestSelf，这俩值决定是否通过命中
//     hitTestChildren => 有子通过测试，自己也会被加入列表
//     hitTestSelf => 某控件可以修改 hitTestSelf 并返回 true，强行声明自己要处理事件
// 重点：测试时如果 有子通过/自身通过，当前节点会被加入列表，且因为是深度优先，先测试的子，所以子会位于列表的前面
//
// 测试同级兄弟为何能中断？
//   因为一般兄弟间不会重叠，所以找到一个后，其它的都不会成功，也就没必要浪费时间了。但 Stack 是例外，它的子会重叠，用 HitTestBehavior 来解决
// 测试同级兄弟的顺序为何是从尾到头？
//   因为一般兄弟间不会重叠，如果有重叠，那也是列表后面的兄弟盖住列表前面的兄弟，所以从后往前遍历。如果从前往后，出来的效果是点到某控件，结果它背后的控件响应了

// HitTestBehavior
//   deferToChild 组件是否通过命中测试取决于子组件是否通过，它的 hitTestSelf 返回 false
//   opaque       组件必然会通过命中测试，因为它的 hitTestSelf 始终返回 true
//   translucent  组件必然会通过命中测试，因为它的 hitTest 用 || 测试了它，它的 hitTestSelf 返回 false，它的 hitTest 返回子的
//
// bool hitTest(BoxHitTestResult result, {required Offset position}) {
//   bool hitTarget = false;
//   if (size.contains(position)) {
//     hitTarget = hitTestChildren(result, position: position) || hitTestSelf(position);
//     if (hitTarget || behavior == HitTestBehavior.translucent) {
//       result.add(BoxHitTestEntry(this, position));
//     }
//   }
//   return hitTarget;
// }
//
// bool hitTestSelf(Offset position) => behavior == HitTestBehavior.opaque;
//
// 重点：opaque 和 translucent 时，当前控件都会通过测试，但 hitTest() 的返回值不同，opaque 返回 true，translucent 则返回子是否通过
// 具体看 listener_page 例子五六
