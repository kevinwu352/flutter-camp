import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SwallowPointer extends SingleChildRenderObjectWidget {
  const SwallowPointer({super.key, this.swallowing = true, super.child});

  final bool swallowing;

  @override
  RenderSwallowPointer createRenderObject(BuildContext context) => RenderSwallowPointer(swallowing: swallowing);

  @override
  void updateRenderObject(BuildContext context, RenderSwallowPointer renderObject) {
    renderObject.swallowing = swallowing;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('swallowing', swallowing));
  }
}

class RenderSwallowPointer extends RenderProxyBox {
  RenderSwallowPointer({RenderBox? child, this.swallowing = true}) : super(child);

  bool swallowing;

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    super.hitTest(result, position: position);
    return !swallowing;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('swallowing', swallowing));
  }
}
