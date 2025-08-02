import 'package:flutter/material.dart';

class ImagePage extends StatelessWidget {
  const ImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          "assets/images/bg.jpg",
          width: 200,
          height: 200,
          fit: BoxFit.fill,
        ),
      ],
    );
  }
}
