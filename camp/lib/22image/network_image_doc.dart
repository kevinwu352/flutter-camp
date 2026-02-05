// required String imageUrl

// double? width
// double? height
// Alignment alignment = Alignment.center
// BoxFit? fit
// ImageRepeat repeat = ImageRepeat.noRepeat

// 图片成功时，在此进行深入定制
// ImageWidgetBuilder? imageBuilder

// ProgressIndicatorBuilder? progressIndicatorBuilder

// 图片出错时，如果不传此参数，会抛出异常
//   如果图片出错了，传 errorListener 不会阻止异常
//   如果图片出错了，传 placeholder 不会阻止异常
// LoadingErrorWidgetBuilder? errorWidget
// ValueChanged<Object>? errorListener

// 用于控件刚开始显示时，默认图淡入
// PlaceholderWidgetBuilder? placeholder
// Duration? placeholderFadeInDuration
// 用于图片加载完成时，图片淡入
// Duration fadeInDuration = const Duration(milliseconds: 500)
// Curve fadeInCurve = Curves.easeIn
// 用于图片加载完成时，默认图淡出
// Duration? fadeOutDuration = const Duration(milliseconds: 1000)
// Curve fadeOutCurve = Curves.easeOut

// --------------------------------------------------------------------------------

// 如果网上图片尺寸 200*200，这里传 2，界面上图片的尺寸是 100*100
// double scale = 1.0

// String? cacheKey
// BaseCacheManager? cacheManager

// Color? color 混合颜色
// BlendMode? colorBlendMode

// FilterQuality filterQuality = FilterQuality.low

// Map<String, String>? httpHeaders

// 保存到磁盘的图片是缩放后的
// int? maxWidthDiskCache
// int? maxHeightDiskCache
// int? memCacheWidth
// int? memCacheHeight

// bool matchTextDirection = false

// 为真时，当 url 变化，会从旧图动画到新图
// bool useOldImageOnUrlChange = false

// ImageRenderMethodForWeb imageRenderMethodForWeb = ImageRenderMethodForWeb.HtmlImage
