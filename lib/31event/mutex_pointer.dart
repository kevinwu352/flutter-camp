import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

// MutexPointer(pattern: 'RenderEditable', child: ...)

class MutexPointer extends SingleChildRenderObjectWidget {
  const MutexPointer({super.key, this.pattern, super.child});

  final String? pattern;

  @override
  RenderMutexPointer createRenderObject(BuildContext context) => RenderMutexPointer(pattern: pattern);

  @override
  void updateRenderObject(BuildContext context, RenderMutexPointer renderObject) {
    renderObject.pattern = pattern;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<String>('pattern', pattern));
  }
}

class RenderMutexPointer extends RenderProxyBox {
  RenderMutexPointer({RenderBox? child, this.pattern}) : super(child);

  String? pattern;

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    // hitTestChildren(result, position: position) || hitTestSelf(position)
    // 父类中 hitTestSelf 为假，所以 super.hitTest() 的值就是 hitTestChildren 的值，然后将此值取反并返回
    // 什么意义呢？
    //   如果我的某个子元素要响应事件，那我就吞掉此事件，我返回 false，导致我和我的父元素点击测试失败
    //   如果我的所有子元素不响应事件，那我就传递此事件，我返回 true，导致我和我的父元素点击测试成功
    // 有啥使用场景呢？
    // 父元素监听按下事件，里面关闭键盘
    //   第一种情况，我点击输入框，子元素要响应事件，吞掉此事件，不会关闭键盘
    //   第二种情况，我点击空白处，子元素不响应事件，传递此事件，就会关闭键盘
    final children = super.hitTest(result, position: position);
    if (children) {
      final pat = pattern;
      if (pat != null && pat.isNotEmpty) {
        final contains = result.path.any((element) => element.target.toString().contains(pat));
        if (kDebugMode) debugPrint('mutex-pointer-3, children:true, contains:$contains');
        return !contains;
      } else {
        if (kDebugMode) debugPrint('mutex-pointer-2, children:true');
        return !false;
      }
    } else {
      if (kDebugMode) debugPrint('mutex-pointer-1, children:false');
      return true;
    }
    // return !super.hitTest(result, position: position);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<String>('pattern', pattern));
  }
}
