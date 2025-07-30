
创建并自己管理
Provider(
  create: (_) => MyModel(),
  child: ...
)
用一个现成的
MyChangeNotifier variable;
ChangeNotifierProvider.value(
  value: variable,
  child: ...
)

如果要随 count 更新对象
int count;
ProxyProvider0(
  update: (_, __) => MyModel(count),
  child: ...
)

create/update 回调默认是懒调用的，除非显示指定



刷新机制
// 这俩取出来的值，界面不会更新值的变化
  final counter = context.read<Counter>();
  final value = context.read<Counter>().value;
  Provider.of<T>(context, listen: false)
// 这俩取出来的值，界面会更新值的变化
  final counter = context.watch<Counter>();
  final value = context.watch<Counter>().value;
  Provider.of<T>(context)
// 这是用法
  body: Text("${counter.value}"),
  body: Text("$value"),


部分重建
watch 时，就算取出 value，当 Counter 其它部分改变而调用 notify，也会导致使用 value 的控件重建，用 select
  final value = context.select((Counter c) => c.value);
  Selector<Foo, Bar>(
    selector: (_, foo) => foo.bar,
    builder: (_, data, __) {
      return Text('${data.item}');
    }
  )
  单对象上提取多字段
  Selector<Foo, ({String item1, String item2})>(
    selector: (_, foo) => (item1: foo.item1, item2: foo.item2),
    builder: (_, data, __) {
      return Text('${data.item1}  ${data.item2}');
    },
  )

Consumer 的部分重建分两种
  1) 父包子，父依赖参数需要频繁重建，但子不用
  Consumer<Counter>(
    builder: (context, value, child) => Text("${value.value}"),
    child: 一个创建繁重的 widget，避免频繁创建，会被传给 builder
  )
  2) 父包子，父不重建，子要频繁重建
  Father {
    child: Consumer<Counter>(...) 这部分重建
  }

Consumer 提供了类似于 Builder 那样的下级
第一种用法，刚注入 Counter，此时的 context 还是这个 widget 的 context，它上面没有 Counter，要崩
第二种用法，下级的 context，往上找，能找到 Counter
return ChangeNotifierProvider(
  create: (_) => Counter(),
  // 这个要崩
  child: Text("${Provider.of<Counter>(context).value}"),
  // 这个能行
  child: Consumer<Counter>(
    builder: (context, value, child) => Text("${value.value}"),
  ),
);

一个 Provider 提供出来的普通实例，里面的值变了，界面不会更新
ChangeNotifierProvider 里面可是要调用 notify 方法，外面才会更新的
普通变量啥也没有，它也没办法，那么，Provider 有啥用？
  Provider(create: (_) => UserService(user: User(name: "--")))



用 ? 避免抛出异常 ProviderNotFoundException
final counter = context.watch<Counter?>();


// initState 里面 watch 要崩，read 不会
@override void initState() {
  super.initState();
  final counter = context.watch<Counter>();
}
// FAQ 里一个例子说：fetch 里面 http 请求，一个 future 赋给了 notifier，这些可能会崩
// 因为，目前处在 widget tree 创建阶段，之前的用旧状态，之后的用新状态，可能会导致不一致，所以不允许
// 没太明白？
@override void initState() {
  super.initState();
  context.read<MyNotifier>().fetch();
}
