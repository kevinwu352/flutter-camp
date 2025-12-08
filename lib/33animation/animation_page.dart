import 'package:flutter/material.dart';

// REVIEW

// ImplicitlyAnimatedWidget
//   AnimatedAlign, which is an implicitly animated version of Align.
//   AnimatedDefaultTextStyle, which is an implicitly animated version of DefaultTextStyle.
//   AnimatedOpacity, which is an implicitly animated version of Opacity.
//   AnimatedPositioned, which is an implicitly animated version of Positioned.
//   AnimatedSize, which automatically transitions its size over a given duration.
//   AnimatedRotation, which is an implicitly animated version of Transform.rotate.
//   AnimatedScale, which is an implicitly animated version of Transform.scale.
//   AnimatedSlide, which implicitly animates the position of a widget relative to its normal position.
//
//   AnimatedContainer, which is an implicitly animated version of Container.
//   AnimatedPadding, which is an implicitly animated version of Padding.
//
//   AnimatedTheme, which is an implicitly animated version of Theme.
//   AnimatedPositionedDirectional, which is an implicitly animated version of PositionedDirectional.
//   AnimatedCrossFade, which cross-fades between two given children and animates itself between their sizes.
//   AnimatedPhysicalModel, which is an implicitly animated version of PhysicalModel.
//   AnimatedSwitcher, which fades from one widget to another.
//   TweenAnimationBuilder, which animates any property expressed by a Tween to a specified target value.

// AnimatedWidget
//   AlignTransition, which is an animated version of Align.
//   DefaultTextStyleTransition, which is an animated version of DefaultTextStyle.
//   FadeTransition, which is an animated version of Opacity.
//   PositionedTransition, which is an animated version of Positioned.
//   SizeTransition, which animates its own size.
//   RotationTransition, which animates the rotation of a widget.
//   ScaleTransition, which animates the scale of a widget.
//   SlideTransition, which animates the position of a widget relative to its normal position.
//
//   DecoratedBoxTransition, which is an animated version of DecoratedBox.
//
//   AnimatedModalBarrier, which is an animated version of ModalBarrier.
//   RelativePositionedTransition, which is an animated version of Positioned.
//
//   AnimatedBuilder, which uses a builder pattern that is useful for complex Animation use cases.
//   ListenableBuilder, which uses a builder pattern that is useful for complex Listenable use cases.

class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    // 使用 Animation<T>

    // 用法一
    //   开始动画
    //   animation.forward();
    //   订阅动画并更新界面
    //   anim.addListener(() => setState(() {}));
    //   界面上使用动画的值
    //   Image.asset("assets/images/jessica.jpg", width: anim.value, height: anim.value)

    // 用法二
    // AnimatedWidget 是显式动画类的父类，它内部封装了用法一调用 setState() 的逻辑
    // 这是抽象类，我们可以继承它

    // 用法三
    // 将 Animation<T> 直接传给显式动画子类，比如 SlideTransition
    // 它是 AnimatedWidget 的子类
    // exp_anim_page.dart 里面主要讲的是动画的构建过程，使用动画用的是用法三

    // 用法四
    // 用 AnimatedBuilder，它接收一个 Animation<T>，我们也不用手动订阅并刷新
    // 它是 AnimatedWidget 的子子类
    // 它的 child 参数用于缓存，不用每次重建它
    // 用于通用动画，用于比 AnimatedWidget 复杂的动画，比如我要把两个动画组合起来，而显式动画子类通常只改变一种属性，所以用这个

    // 用法五
    // 如果只需要 时间/曲线/目标值，用隐式动画方便点，它内部封装了动画
    // ImplicitlyAnimatedWidget
    // 第一次加到树上不会有动画，只在刷新时，如果值不同才会做动画

    anim = tween.animate(animation);

    // anim.addListener(() {
    //   print('a, ${anim.value}');
    //   setState(() {});
    // });
    // anim.addStatusListener((status) => print('a, $status'));

    // ================================================================================

    // 交织动画（Stagger Animation）
    // 将一个动画分成几个部分，比如动画总时间 9 秒
    // 0-3 秒改变大小，3-6 秒改变颜色，6-9 秒改变位置
    //
    // 按照下面的方式创建三个动画，每个动画用 Interval 指定自己所占的区间
    // heightAnim = Tween<double>(begin: 0.0, end: 300.0).animate(
    //   CurvedAnimation(
    //     parent: animation,
    //     curve: const Interval(0.0, 0.33, curve: Curves.ease),
    //   ),
    // );
    //
    // 然后在 build 方法内用这三个动画的 value 来构建界面
    // 注意：我们并不用把这三个动画合并成一个，而是分别用它们的值就行了
    // AnimatedBuilder(
    //   animation: animation,
    //   builder: (context, child) {
    //     return Container(
    //       alignment: Alignment.center,
    //       padding: padding.value,
    //       child: Container(color: color.value, width: 50.0, height: height.value),
    //     );
    //   },
    // )
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  late AnimationController animation = AnimationController(duration: Duration(seconds: 2), vsync: this);
  late Tween<double> tween = Tween(begin: 0, end: 200);

  late Animation<double> anim;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Animation')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          animation.forward();
        },
        child: Icon(Icons.run_circle),
      ),
      // body: Center(
      //   child: Image.asset('assets/images/jessica.jpg', width: anim.value, height: anim.value),
      // ),
      body: AnimatedBuilder(
        animation: anim,
        child: Image.asset('assets/images/jessica.jpg'),
        builder: (context, child) {
          return Center(
            child: SizedBox(width: anim.value, height: anim.value, child: child),
          );
        },
      ),
    );
  }
}
