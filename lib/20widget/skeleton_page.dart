import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletonPage extends StatefulWidget {
  const SkeletonPage({super.key});

  @override
  State<SkeletonPage> createState() => _SkeletonPageState();
}

class _SkeletonPageState extends State<SkeletonPage> {
  bool loading = true;

  // 假数据的长短会影响绘制出来的骨架效果
  // BoneMock 是用来生成假数据的，这些数据只是用来生成骨架的，反正数据的内容不是用来渲染出来给人看的
  // 所以，数据内容是一样的，只是长度不一样，具体看实现文件
  List<Usr> users = [
    // Usr(name: "Patricia Lebsack Patricia Lebsack", title: "Karianne", avatar: "https://picsum.photos/id/27/200"),
    // Usr(name: "Chelsey Dietrich", title: "Kamren", avatar: "https://picsum.photos/id/29/200"),
    Usr(name: BoneMock.name, title: "Karianne", avatar: "https://picsum.photos/id/27/200"),
    Usr(name: BoneMock.name, title: BoneMock.email, avatar: "https://picsum.photos/id/29/200"),
  ];
  // 所以，可以像这样做，用 loading 来决定用假数据还是真数据
  // final users = loading ? List.filled(7, User(...)) : realUsers;
  // return Skeletonizer(
  //   enabled: loading,
  //   child: UserList(users: users),
  // );

  // 假数据里面的 url 会导致 NetworkImage 加载出错，所以，文档推荐用 Skeleton.replace 来处理
  // 但我感觉没必要，还是使用一个真的，图片 url 吧，反正内容也不是渲染出来给人看的

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Skeleton')),
      // body: Skeletonizer(
      //   enabled: loading,
      //   child: ListView.builder(
      //     itemCount: 7,
      //     itemBuilder: (context, index) {
      //       return Card(
      //         child: ListTile(
      //           title: Text('Item number $index as title'),
      //           subtitle: const Text('Subtitle here'),
      //           trailing: const Icon(Icons.ac_unit),
      //         ),
      //       );
      //     },
      //   ),
      // ),
      body: Skeletonizer(
        enabled: loading,
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(users[index].name),
                subtitle: Text(users[index].title),
                leading: CircleAvatar(radius: 24, backgroundImage: NetworkImage(users[index].avatar)),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() => loading = !loading);
        },
        child: Icon(loading ? Icons.hourglass_bottom : Icons.done),
      ),
    );
  }
}

class Usr {
  String name;
  String title;
  String avatar;
  Usr({required this.name, required this.title, required this.avatar});
}
