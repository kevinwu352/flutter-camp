import 'package:flutter/material.dart';
import 'package:easy_refresh/easy_refresh.dart';

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
    await Future.delayed(Duration(seconds: 1));
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
        header: CupertinoHeader(
          backgroundColor: Colors.red,
          // triggerOffset: 60
        ),
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
