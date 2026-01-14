import 'package:flutter/material.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_camp/20widget/sprite_widget.dart';
// import 'package:lottie/lottie.dart';

// required Widget? child

// ScrollController? scrollController
// EasyRefreshController? controller
// FutureOr onRefresh()?
// FutureOr onLoad()? 赋值就会创建 footer，不管页面有无内容

// Header? header
// 当 onRefresh 为空时，OverScroll 的行为。传 NotRefreshHeader(clamping: true) 则无法 OverScroll
// NotRefreshHeader? notRefreshHeader
// Footer? footer
// NotLoadFooter? notLoadFooter

// bool refreshOnStart = false 进页面就开始刷新
// Header? refreshOnStartHeader 此时用的 Header，如果为空则用 header 属性的

// --------------------------------------------------------------------------------

// 如果在 onRefresh 里返回 noMore，头上会显示 noMore，而不是显示在尾上，这种状态下，能不能 refresh
// bool canRefreshAfterNoMore = false
// 这俩都该设为 false
// bool canLoadAfterNoMore = false
// 重置尾的 noMore 状态，当上次加载完 3页 数据后，刷新一下头，加载第 1 页的数据
// 尾就能从 noMore 状态变成能加载，从而加载 2 3 页的数据
// bool resetAfterRefresh = true

// double callRefreshOverOffset = 20
// double callLoadOverOffset = 20

// --------------------------------------------------------------------------------

// Axis? triggerAxis

// bool simultaneously = false 头和尾能否同时启动，一定不要啊

// SpringDescription? spring 弹簧动画参数
// FrictionFactor? frictionFactor 当 list 越过边界以后的摩擦力

// ERScrollBehaviorBuilder? scrollBehaviorBuilder 返回 ScrollPhysics 的函数

// StackFit fit = StackFit.loose
// Clip clipBehavior = Clip.hardEdge

// ================================================================================

// ClassicHeader 经典样式，左边转圈，右上文字，右下日期
// ClassicFooter

// CupertinoHeader 圆圈中间是菊花，下拉时像水滴一样被拉高，高度 60
// CupertinoFooter 只有一个转圈的菊花，高度 128 - 34，triggerOffset=0则高68，safeArea=false则高34
// MaterialHeader 圆圈里有个转圈的，转圈带有键头
// MaterialFooter

// DeliveryHeader 一个盒子，上面有热气球
// DeliveryFooter

// PhoenixHeader 很花哨，一堆房子，有个太阳转圈
// PhoenixFooter

// BezierHeader 很花哨，波浪线，水平一堆白色的点，转圈
// BezierFooter
// BezierCircleHeader 上面一个圆圈在转，下面一条波浪线在动

// TaurusHeader 很花哨，白云，飞机
// TaurusFooter

// ================================================================================

// 感觉 footer 的定位不太准确，所以要用 locator 来定位
// triggerOffset 就是条条的高度
// maxOverOffset 是能拖出来的最大高度
// 答：不是 footer 高度或位置不准确，是 ListView 底部有 padding，去掉就准确了，如下面的例子

class Refresh2Page extends StatefulWidget {
  const Refresh2Page({super.key});

  @override
  State<Refresh2Page> createState() => _Refresh2PageState();
}

class _Refresh2PageState extends State<Refresh2Page> {
  // List<String> items = [];
  List<String> items = List<String>.generate(20, (i) => '0 - $i');
  int order = 0;
  bool hasMore = false;

  // simultaneously 为假，头尾不会同时启动，所以，下面的函数里面不用判断
  bool loading = false;

  Future<void> refreshData() async {
    print('do refresh');
    // if (loading) return;
    loading = true;
    await Future.delayed(Duration(seconds: 3));
    order = 0;
    final list = List<String>.generate(20, (i) => '$order - $i');
    items = list;
    loading = false;
    hasMore = order < 2;
    setState(() {});
  }

  Future<void> moreData() async {
    print('do more');
    // if (loading) return;
    loading = true;
    await Future.delayed(Duration(seconds: 3));
    order++;
    final list = List<String>.generate(10, (i) => '$order - $i');
    items += list;
    loading = false;
    hasMore = order < 2;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Refresh 2'), backgroundColor: Colors.green),
      body: EasyRefresh(
        // onRefresh: () async {
        //   await refreshData();
        //   // return IndicatorResult.noMore;
        // },
        // onLoad: () async {
        //   await moreData();
        //   return order < 2 ? IndicatorResult.success : IndicatorResult.noMore;
        // },
        // notRefreshHeader: NotRefreshHeader(clamping: true),
        onRefresh: refreshData,
        onLoad: hasMore ? moreData : null,
        // header: CupertinoHeader(
        //   backgroundColor: Colors.red,
        //   // triggerOffset: 60
        // ),
        header: RefreshHeader(),
        footer: CupertinoFooter(
          backgroundColor: Colors.green,
          // triggerOffset: 60,
          // safeArea: true,
          // position: IndicatorPosition.locator,
        ),
        // resetAfterRefresh: true,
        // canRefreshAfterNoMore: false,
        // canLoadAfterNoMore: true,
        // callRefreshOverOffset: 100,
        // refreshOnStart: true,
        // refreshOnStartHeader: CupertinoHeader(),
        child: ListView.builder(
          padding: EdgeInsets.zero, // 注意这行，清除底部的 padding
          itemCount: items.length,
          itemBuilder: (context, i) => ListTile(title: Text(items[i]), tileColor: Colors.grey),
        ),
        // child: ListView(
        //   children: [
        //     ...items.map((e) => ListTile(title: Text(e), tileColor: Colors.grey)),
        //     FooterLocator(paintExtent: 0),
        //   ],
        // ),
      ),
    );
  }
}

// inactive 默认的
// drag 拖动时，且未达到启动点
// armed 拖动时，已达到启动点
//   如果往回拖会回到 drag，再松手会回到inactive
//   如果继续拖，不会变成 ready
// ready 达到启动点，且松手了，马上会变成 processing
// processing 开始处理
// processed 任务完成，但整个流程没完，还有结束动画，完成后变成 done
// done 最后会变成 inactive

class RefreshHeader extends Header {
  const RefreshHeader({this.key, super.triggerOffset = 60, super.clamping = false});
  final Key? key;

  double? progress(IndicatorState state) => switch (state.mode) {
    IndicatorMode.drag || IndicatorMode.armed => state.offset.clamp(0, triggerOffset) / triggerOffset,
    IndicatorMode.ready || IndicatorMode.processing || IndicatorMode.processed => -1,
    _ => null,
  };

  @override
  Widget build(BuildContext context, IndicatorState state) {
    // print(
    //   "mode:${state.mode} result:${state.result} offset:${state.offset} safeOffset:${state.safeOffset} o1:${state.triggerOffset} o2:${state.actualTriggerOffset}",
    // );
    // return _RefreshIndicator(key: key, state: state, height: triggerOffset);
    // return _RefreshIndicator2(state: state, height: triggerOffset);
    return Stack(
      key: key,
      alignment: Alignment.center,
      children: [
        SizedBox(height: state.offset, width: double.infinity), // 这个要要，它用来撑开 stack
        Positioned.fill(child: ColoredBox(color: Colors.yellow)), // 这个不要，目前只是用来看 header 所占区域的
        Positioned(
          bottom: 0,
          // child: CircularProgressIndicator.adaptive(),
          // child: Lottie.asset('assets/anim/dog/anim.json', width: 40, height: 40, controller: animation),
          child: SpriteWidget(
            frameCount: 30,
            frameFormat: 'assets/loading/spinner_##.png',
            // frameFormat: 'assets/spinner/seq_##.png',
            duration: Duration(seconds: 1),
            progress: progress(state),
            width: 40,
            height: 40,
          ),
        ),
      ],
    );
  }
}

// class _RefreshIndicator3 extends StatelessWidget {
//   const _RefreshIndicator3({required this.state, required this.height});
//   final IndicatorState state;
//   final double height;
//
//   double? get progress => switch (state.mode) {
//     IndicatorMode.drag || IndicatorMode.armed => state.offset.clamp(0, height) / height,
//     IndicatorMode.ready || IndicatorMode.processing || IndicatorMode.processed => -1,
//     _ => null,
//   };
//
//   @override
//   Widget build(BuildContext context) {
//     // double? progress;
//     // switch (state.mode) {
//     //   case IndicatorMode.drag:
//     //   case IndicatorMode.armed:
//     //     progress = state.offset.clamp(0, height) / height;
//     //   case IndicatorMode.ready:
//     //   case IndicatorMode.processing:
//     //   case IndicatorMode.processed:
//     //     progress = -1;
//     //   default:
//     //     progress = null;
//     // }
//     // print('progress: $progress');
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         SizedBox(height: state.offset, width: double.infinity), // 这个要要，它用来撑开 stack
//         Positioned.fill(child: ColoredBox(color: Colors.white)), // 这个不要，目前只是用来看 header 所占区域的
//         Positioned(
//           bottom: 0,
//           //
//           // child: CircularProgressIndicator.adaptive(),
//           // child: Lottie.asset('assets/anim/dog/anim.json', width: 40, height: 40, controller: animation),
//           child: SpriteWidget(
//             frameCount: 17,
//             // frameFormat: 'assets/loading/spinner_##.png',
//             frameFormat: 'assets/spinner/seq_##.png',
//             duration: Duration(seconds: 1),
//             progress: progress,
//             width: 40,
//             height: 40,
//           ),
//         ),
//       ],
//     );
//   }
// }

// ================================================================================
// 下面的例子是最初的，有点复杂

class RefreshHeader2 extends Header {
  const RefreshHeader2({this.key, super.triggerOffset = 60, super.clamping = false});
  final Key? key;
  @override
  Widget build(BuildContext context, IndicatorState state) {
    print(
      "mode:${state.mode} result:${state.result} offset:${state.offset} safeOffset:${state.safeOffset} o1:${state.triggerOffset} o2:${state.actualTriggerOffset}",
    );
    // return _RefreshIndicator(key: key, state: state, height: triggerOffset);
    return _RefreshIndicator2(key: key, state: state, height: triggerOffset);
  }
}

class _RefreshIndicator2 extends StatefulWidget {
  const _RefreshIndicator2({super.key, required this.state, required this.height});
  final IndicatorState state;
  final double height;
  @override
  State<_RefreshIndicator2> createState() => __RefreshIndicator2State();
}

class __RefreshIndicator2State extends State<_RefreshIndicator2> with SingleTickerProviderStateMixin {
  late final animation = AnimationController(duration: Duration(seconds: 1), vsync: this);
  late final tween = IntTween(begin: 0, end: 16);
  late final anim = animation.drive(tween);

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.state.mode) {
      case IndicatorMode.drag:
      case IndicatorMode.armed:
        animation.value = widget.state.offset.clamp(0, widget.height) / widget.height;
        print('value: ${animation.value}');
      // break;
      case IndicatorMode.ready:
      case IndicatorMode.processing:
      case IndicatorMode.processed:
        animation.value = 0;
        animation.repeat();
      // break;
      // case IndicatorMode.done:
      //   animation.value = 0;
      //   animation.stop();
      // break;
      default:
        // animation.value = 0;
        // animation.stop();
        animation.reset();
      // break;
    }
    // print('assets/spinner/seq_${anim.value}.png');
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(height: widget.state.offset, width: double.infinity), // 这个要要，它用来撑开 stack
        Positioned.fill(child: ColoredBox(color: Colors.red)), // 这个不要，目前只是用来看 header 所占区域的
        Positioned(
          bottom: 0,
          //
          // child: CircularProgressIndicator.adaptive(),
          // child: Lottie.asset('assets/anim/dog/anim.json', width: 40, height: 40, controller: animation),
          child: AnimatedBuilder(
            animation: anim,
            builder: (context, child) => Image.asset('assets/spinner/seq_${anim.value}.png', width: 40, height: 40),
          ),
        ),
      ],
    );
  }
}
