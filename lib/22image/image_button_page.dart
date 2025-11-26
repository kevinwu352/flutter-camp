import 'package:flutter/material.dart';

class ImageButtonPage extends StatelessWidget {
  const ImageButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ImageButton')),
      body: Center(
        // child: InkWell(
        //   onTap: () => print('clicked'),
        //   splashColor: Colors.brown.withValues(alpha: 0.5),
        //   child: Ink(
        //     height: 100,
        //     width: 100,
        //     decoration: BoxDecoration(
        //       image: DecorationImage(image: AssetImage('assets/images/num.png'), fit: BoxFit.cover),
        //     ),
        //   ),
        //   // child: Ink.image(image: image)
        //   // child: Image.asset('assets/images/num.png'),
        // ),

        // 按钮尺寸和图片一样大，但是没有点击波纹效果
        // child: TextButton(
        //   onPressed: () => print('clicked'),
        //   style: TextButton.styleFrom(
        //     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        //     minimumSize: Size.zero,
        //     padding: EdgeInsets.zero,
        //   ),
        //   child: Image.asset('assets/images/num.png'),
        // ),
        // 用 IconButton/TextButton 效果是一样的
        child: IconButton(
          onPressed: () => print('clicked'),
          style: IconButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: Size.zero,
            padding: EdgeInsets.zero,
          ),
          icon: Image.asset('assets/images/num.png'),
        ),
      ),
    );
  }
}
