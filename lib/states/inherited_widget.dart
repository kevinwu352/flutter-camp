// 继承
class MyState extends InheritedWidget {
  const MyState({super.key, required this.data, required super.child});

  final String data;

  static MyState of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<MyState>();
    assert(result != null, 'No MyState found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(MyState oldWidget) => data != oldWidget.data;
}

// 使用
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var data = MyState.of(context).data;
    return Scaffold(body: Center(child: Text(data)));
  }
}

// 包装，这里是一个 StatefulWidget
class _TestInheritedWidgetState extends State<TestInheritedWidget> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MyState(
        data: count,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HomeScreen(),
            RaisedButton(
              child: Text('add'),
              onPressed: () {
                setState(() {
                  ++count;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
