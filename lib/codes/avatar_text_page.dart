import 'package:flutter/material.dart';

class AvatarTextPage extends StatelessWidget {
  const AvatarTextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("data")),
      body: Stack(
        // 注意这个参数：How to align the non-positioned and partially-positioned children in the stack.
        alignment: const Alignment(0.6, 0.6),
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage("assets/images/jessica.jpg"),
            radius: 100,
          ),
          Container(
            decoration: const BoxDecoration(color: Colors.black45),
            child: const Text(
              'Jessica',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
