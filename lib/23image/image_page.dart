import 'package:flutter/material.dart';

// .../my_icon.png       (mdpi baseline)
// .../1.5x/my_icon.png  (hdpi)
// .../2.0x/my_icon.png  (xhdpi)
// .../3.0x/my_icon.png  (xxhdpi)
// .../4.0x/my_icon.png  (xxxhdpi)
// 真的加载了 3.0x 目录下的图片
// 且这些子目录不用在 pubspec.yaml 中分别列出来，这是例外，其它资源的子目录都要列出来
// 不加 my_icon.png 好像会崩，一定要它吗？
// Image.asset("assets/images/num.png")
//
// AssetImage / NetworkImage 继承了 ImageProvider<Object>
//   // 这俩等价
//   Image(image: AssetImage("assets/images/num.png")),
//   Image.asset("assets/images/num.png"),
//   // 这俩等价
//   Image(image: NetworkImage("https://avatars2.githubusercontent.com/u/20411648?s=460&v=4"), width: 100.0),
//   Image.network("https://avatars2.githubusercontent.com/u/20411648?s=460&v=4", width: 100.0),

// ================================================================================

// String name

// 宽高大于图片时，图片是居中的，fit 应该是 none，此时可以设置 alignment 把图片放到右下角
// double? width
// double? height
// AlignmentGeometry alignment = Alignment.center

// BoxFit? fit
//   .none 图片不缩放，大就大，小就小，切就切
//   .scaleDown 图片大了会缩小，小了不放大
//
//   .fill 缩放至盒子尺寸
//   .contain 缩放至盒子完全容纳图片，保持比例，大了缩小，小了拉大
//   .cover 缩放至图片完全占满盒子，保持比例，大了缩小，小了拉大
//
//   .fitWidth 缩放，让图片宽度完全占满盒子宽度
//   .fitHeight 缩放，让图片高度完全占满盒子高度

// 相当于告诉系统：我这里有个图片 50*50，但它是 2x 的图，所以你创建一个 25*25 的图片出来
// double? scale

// ImageRepeat repeat = ImageRepeat.noRepeat 平铺 repeatX repeatY repeat noRepeat

// 点9图，这个尺寸是赋给图片的，以图片的尺寸为基础，不是以 Image 控件的尺寸为基础
// 我觉得用 Rect.fromLTWH(35, 30, 3, 3) 安全点
// 用 Rect.fromLTRB(l, t, l+1, t+1) 容易出现异常，也不知内部怎么算的，如果 left <= right, top <= bottom 要异常，所以都 +1
// Rect? centerSlice

// ================================================================================

// 高级玩法，颜色和图片根据某个模式混合
// Color? color
// BlendMode? colorBlendMode

// bool isAntiAlias = false 抗锯齿

// 当设置新图片时，新图片还没拿到，是否保留旧图片
// 最好不要保留，如果当新图片失败时，可能会出现，旧用户的头像新用户的名字
// bool gaplessPlayback = false

// 渲染品质高或低，不知道这个影响大不大？
// FilterQuality filterQuality = FilterQuality.medium

// 指定要生成的图片大小，与真实大小不一样。比如一个超大 4K 图片，渲染成它的 1/10 大小 384×216，会极大减少内存使用
// int? cacheWidth
// int? cacheHeight

// ================================================================================

// 研究动画的时候再来？
// Animation<double>? opacity

// AssetBundle? bundle 估计不传就用的 main bundle 吧
// String? package

// 图片加载中或加载出错时，用这 builder 返回一个 widget
// ImageFrameBuilder? frameBuilder
// ImageErrorWidgetBuilder? errorBuilder

// 也是跟 ltr / rtl 相当的属性
// bool matchTextDirection = false

// bool excludeFromSemantics = false
// String? semanticLabel

class ImagePage extends StatelessWidget {
  const ImagePage({super.key});

  final fit = BoxFit.none;
  final w = 300.0;
  final h = 300.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image')),
      backgroundColor: Colors.teal,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ...
        },
        child: Icon(Icons.run_circle),
      ),
      body: Column(
        children: [
          // Container(
          //   decoration: BoxDecoration(
          //     border: Border.all(
          //       color: Colors.red, // Border color
          //       width: 1.0, // Border width
          //       style: BorderStyle.solid, // Border style (solid, dashed, etc.)
          //     ),
          //     // borderRadius: BorderRadius.circular(10.0), // Optional: rounded corners
          //   ),
          //   // padding: EdgeInsets.all(16.0), // Optional: padding inside the border
          //   child: Image.asset('assets/images/num.png', width: w, height: h, fit: fit, scale: 2),
          // ),
          // Container(
          //   decoration: BoxDecoration(
          //     border: Border.all(
          //       color: Colors.red, // Border color
          //       width: 1.0, // Border width
          //       style: BorderStyle.solid, // Border style (solid, dashed, etc.)
          //     ),
          //     // borderRadius: BorderRadius.circular(10.0), // Optional: rounded corners
          //   ),
          //   // padding: EdgeInsets.all(16.0), // Optional: padding inside the border
          //   child: Image.asset(
          //     'assets/images/girl.png',
          //     width: w,
          //     height: h,
          //     fit: fit,
          //     color: Colors.red,
          //     colorBlendMode: BlendMode.dst,
          //   ),
          // ),
          Container(
            // decoration: BoxDecoration(
            //   border: Border.all(
            //     color: Colors.red, // Border color
            //     width: 1.0, // Border width
            //     style: BorderStyle.solid, // Border style (solid, dashed, etc.)
            //   ),
            //   // borderRadius: BorderRadius.circular(10.0), // Optional: rounded corners
            // ),
            // padding: EdgeInsets.all(16.0), // Optional: padding inside the border
            child: Image.asset(
              'assets/images/bubble.png',
              width: w,
              height: h,
              fit: BoxFit.fill,
              centerSlice: Rect.fromLTWH(35, 30, 3, 3),
              // centerSlice: Rect.fromLTRB(30, 10, 31, 11),
            ),
          ),
        ],
      ),
    );
  }
}
