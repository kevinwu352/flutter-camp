import 'package:flutter/material.dart';
import 'package:flutter_camp/gen/assets.gen.dart';
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
  // 所以，数据内容是一样的，只是长度不一样，具体细节请查看 BoneMock 的实现文件
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

  // Skeleton.ignore 的子会被骨架忽略，不会渲染出色块
  // Skeleton.keep 的子不会被骨架化，会渲染出原始控件
  // Skeleton.shade 的子会渲染出内容骨架，看下面的例子，跟 CustomPainter 相关
  // Skeleton.leaf 的子会被作为整体，整体是个色块，不体现内部细节
  //   已知 svg 图片是无法像正常控件一样渲染出骨架的，即使用 leaf，它也不会撑起骨架的内容
  //   比如，我用 unite 把一个 row 合并到一起， Row(Text,svg)，结果 svg 那部分没撑起来，所以，还是用 replace 吧
  // Skeleton.replace 有两个参数，子 和 替换，在骨架状态下会用 替换 来刻画骨架
  // Skeleton.unite 能把几个子合并到一起渲染，比如子是 Row，里面有两三个 Icon，这会渲染出一个大胶囊

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
        // child: ListView.builder(
        //   itemCount: users.length,
        //   itemBuilder: (context, index) {
        //     return Card(
        //       child: ListTile(
        //         title: Text(users[index].name),
        //         subtitle: Text(users[index].title),
        //         leading: CircleAvatar(radius: 24, backgroundImage: NetworkImage(users[index].avatar)),
        //       ),
        //     );
        //   },
        // ),
        child: Column(
          children: [
            // Image 控件会被骨架化
            Assets.images.bear.image(),
            // 但下面这行网络图片需要注意：
            // 网络图片也会被骨架化，但它目前还没下载下来，还不知道尺寸
            // 然后，虽然它目前处于骨架状态，它也会去下载图片，下载下来以后，尺寸变成真正的图片尺寸
            // 但内容还是骨架化的
            Image.network("https://picsum.photos/id/27/200", width: 50, height: 50),

            Text("data"),

            // 我理解的，svg 这东西是个控件，不是原生的图片控件，所以它没被骨架化
            // 用下面的方式解决，也能用 Skeleton.replace
            Assets.images.alertDone.svg(width: 64, height: 64),

            // 实现一些控件的时候，如果想让此控件支持骨架化，在里面用 Skeletonizer.of(context).enabled 来判断
            // 如果是骨架状态，显示一些占位控件来渲染骨架
            // 参考下面的例子
            Builder(
              builder: (context) => Skeletonizer.of(context).enabled
                  ? Container(width: 64, height: 64, color: Colors.red)
                  : Assets.images.alertDone.svg(width: 64, height: 64),
            ),
            // 总结：
            // 如果我这里是创建一个子控件，它的 context 已经是下级，用 Skeletonizer.of
            // 如果我像上面这样，在 Skeletonizer 里面直接用，只能加个 Builder，这种情况还是用 replace 吧

            // 能透出 Icon 里图标的轮廓
            Skeleton.shade(child: Icon(Icons.ac_unit, size: 40)),

            // 也能这样硬生生画出一个骨架来，比如 WebView 没有内容，我们只能画个骨架给它用
            // 这种画出来的骨架就是纯骨架了，它在非骨架状态下，也只能显示出骨架的样子，因为它本来就是假的
            Skeletonizer.zone(
              child: Card(
                child: ListTile(
                  leading: Bone.circle(size: 48),
                  title: Bone.text(words: 2),
                  subtitle: Bone.text(),
                  trailing: Bone.icon(),
                ),
              ),
            ),
          ],
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
