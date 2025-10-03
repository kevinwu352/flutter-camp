// DragStartBehavior
// 控制 GestureRecognizer 的 onStart 回调收到的点
//   .down 手指点上去那个点，当时还没被识别成 drag 手势
//   .start 当 drag 手势成功赢得竞技场那个点

// 点击事件的处理有两个层次：一是原始事件，点下/移动/抬起；二是手势事件，原始的经过识别成为某种手势
// 也是 hit-test 找出最内层的控件，再向上冒泡，不过 Flutter 无法阻击冒泡，iOS 里不调 super.touchBegan 就阻击了

// Listener 处理原始事件，一堆 down/move/up 之类的回调
