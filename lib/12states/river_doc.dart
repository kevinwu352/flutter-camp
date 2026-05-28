// flutter pub add flutter_riverpod
// flutter pub add riverpod_annotation
// flutter pub add dev:riverpod_generator
// flutter pub add dev:build_runner

// part 'river_app1.g.dart';
// dart run build_runner build
// dart run build_runner watch


// ================================================================================

// https://riverpod.dev/docs/concepts/about_code_generation#defining-a-provider

//               Synchronous       Future                Stream
// Unmodifiable  Provider          FutureProvider        StreamProvider           提供一个值
// Modifiable    NotifierProvider  AsyncNotifierProvider StreamNotifierProvider   提供一个 Notifier，内部包含值
//
// 不可变 可变 可以看待成 StatelessWidget vs StatefulWidget
// 可变的 Notifier 在编写的时候，也分成两部分，一部分是 Provider，一部分是 Notifier
// Notifier 要负责提供一些方法来修改内部的状态
//
// final cityProvider = Provider((ref) => 'London');
// @riverpod
// String city(Ref ref) => 'London';
//
// final jokeProvider = FutureProvider((ref) async {
//   await Future.delayed(Duration(seconds: 3));
//   return Random().nextInt(10000);
// });
// @riverpod
// Future<int> joke(Ref ref) async {
//   await Future.delayed(Duration(seconds: 3));
//   return Random().nextInt(10000);
// }

// Provider 创建语法
//
// final name = SomeProvider.someModifier<Result>((ref) {
//   <your logic here>
// });
//
// @riverpod
// Result myFunction(Ref ref) {
//   <your logic here>
// }
//
// final name = SomeNotifierProvider.someModifier<MyNotifier, Result>(MyNotifier.new);
// class MyNotifier extends SomeNotifier<Result> {
//   @override
//   Result build() {
//     <your logic here>
//   }
//   <your methods here>
// }
//
// @riverpod
// class MyNotifier extends _$MyNotifier {
//   @override
//   Result build() {
//     <your logic here>
//   }
//   <your methods here>
// }
//
// 访问 Notifier 上的方法 ref.read(yourProvider.notifier).yourMethod().
// 不要在 Notifier 的构造器里写逻辑，写到 build 方法内


// ================================================================================

// 拿到 ref 的地方
//   Provider 天生就能访问 ref
//   直接使用 Consumer 组件，它的 builder 参数内部
//   继承 ConsumerWidget 组件，它的 build 方法内部
//   继承 ConsumerStatefulWidget 组件，继承 ConsumerState，它的 build 方法内部
//
// 如果全部使用 Consumer，代码量会多一点
// 如果使用继承的方式，侵入性强，我不想要这种方式
//
// 可以把 ref 传递给其它函数或类


// 数据是存到 ProviderContainer 的，把 Provider 看成是 key
// Flutter 里的 ProviderScope 内部包含 ProviderContainer
//
// 数据统一存储的优点：
// 1. 没看懂
// 2. 方便单元测试，不同测试函数内部使用 ProviderContainer.test() 创建自己的 container
//    不同的测试函数用相同的 key，但读取到的数据不一样，互不影响
// 3. 方便用 ProviderObserver 全局观察变化
// 4. 等于第 2 点的第二行


// 不用标注创建的 Provider，默认 keepAlive，要修改保活行为：
//   可以给 Provider 创建函数传参数 isAutoDispose
//   可以用修饰符 FutureProvider.autoDispose((ref) async {})
// 用 @riverpod 创建的，默认 dispose
// 用 @Riverpod(keepAlive: false)，默认 dispose
//
// keepAlive 的意义是：在没人 watch/listen 时，会不会自动销毁值
// 文档说：watch/listen/few others，还有其它？文中没明说
// 如果没有这些观察者，provider 会被视为未使用，马上触发 cancel
// 然后等待一帧，如果还未被使用，就触发 dispose
// 如果有新的观察者，触发 resume
//
// keepAlive: false 时，进次级页面会创建值，返回时 cancel dispose
//   再进次级页面，又创建新的值，且不一样
// 改成 true 后，因为前面用的是 build_runner watch，所以，修改并保存代码以后马上生成了新代码
//   第一次进次级页面会创建值，返回时只触发 cancel
//   再进次级页面不会创建值，已经有值，界面上马上会显示，不会加载，返回时只触发 cancel
//
// ref.invalidate 时，如果当前有观察者，马上重建状态，如果没有观察者，则完全销毁 provider
// 它告诉 Provider 抛弃当前的值，下次有人来取，重新获取值
// 要马上创建新值，用 read，或者直接用 refresh，refresh = invalidate + read
// 还有 ref.invalidateSelf
// 如果它有参数，还能 ref.invalidate(provider); / ref.invalidate(provider('John'));
//
// 高级操作
// 如果只想缓存成功的网络请求，先开启 dispose，如果成功，再开启 keepAlive，具体看 Automatic disposal 那节
// final provider = FutureProvider.autoDispose<String>((ref) async {
//   final response = await http.get(Uri.parse('https://example.com'));
//   final link = ref.keepAlive();
//   return response.body;
// });
// 如果只想保活一段时间，也可以操作，具体看文档


// 生命周期函数不用取消注册，它们会在 Provider 被 reset 时取消，如果想手动操作，就这样：
// final unregister = ref.onDispose(() { });
// unregister();


// 只关注 Provider 某一部分的变化，这有待研究？
// 我猜：如果 tick 是个复杂对象，我只关注它的一个属性，其它属性变化时，应该不会触发界面更新
// final isEven = ref.watch(tickProvider.select((tick) => tick.isEven));


// 标注时，写的名字是 aaa，会自动生成 aaaProvider
// 标注时，第一个参数必须是 Ref，可以有其它参数，参数能是泛型，函数能返回 Future/Stream
//
// 第二种标注方式，@Riverpod(keepAlive: true) 能传参数


// 还有 retry 功能，以后再研究？
// 默认的 retry 逻辑还值得研究一下，文档说得挺牛逼的
//   Duration? myRetry(int retryCount, Object error) {
//     if (retryCount >= 5) return null;
//     if (error is ProviderException) return null;
//     return Duration(milliseconds: 200 * (1 << retryCount)); // Exponential backoff
//   }
//   final myProvider = Provider<int>(retry: myRetry, (ref) => 0);
//   final container = ProviderContainer(retry: myRetry);
//   ProviderScope(retry: myRetry, child: MyApp())


// 还有 Observer 功能，主要观察 Provider 的一些生命事件，主要用于 日志/分析/调试错误
// 写个类，继承自 ProviderObserver，再将实例传递给 ProviderScope


// 还有 Override 功能
// overrideWith / overrideWithValue / overrideWithBuild
//   ProviderScope(
//     overrides: [
//       counterProvider.overrideWith((ref) => 42),
//     ]
//   )


// 还有 Scoping Provider，文档说相当复杂，将来可能会变化
// 就是 Provider 创建时的 dependencies 参数，看来这东西不该用啊


// 文档里 Guides 那部分值得继续研究一下，包含几个实用的实例，解决实际问题，非常好


// ================================================================================

// invalidate 后，使用它的 Consumer 内部会重建，当前组件不会重建
// invalidate 后，此 provider 还是有值的，case 还是走有值那行，界面上还是显示作废前的值，3s 后才会显示出最新的值
// 要检查是否正在加载中，用 val.isRefreshing，而不是 provider.isRefreshing
//
// final jokeProvider = FutureProvider((ref) async {
//   await Future.delayed(Duration(seconds: 3));
//   return Random().nextInt(10000);
// });
// 当前组件不需要继承自 ConsumerWidget
// 在普通 StatelessWidget 的 build 方法内使用 Consumer 即可
// 注意这里的 switch 解构方式，非常不错
// Consumer(
//   builder: (context, ref, child) {
//     final joke = ref.watch(jokeProvider);
//     switch (joke) {
//       // 不加问号的话，会一直匹配到这个 case
//       // 加了问号以后，只有当 value 有值时，才走这个 case
//       case AsyncValue(:final value?):
//         // return Text("${value}");
//         return ElevatedButton(onPressed: () => ref.invalidate(jokeProvider), child: Text("$value"));
//       // 如果我不需要 error 的值，只想知道它是否为空，用这种匹配方式
//       // 注意：下面的语句中，无法使用 error，只能使用 joke.error
//       case AsyncValue(error: != null):
//         return Text('Error: ${joke.error}');
//       case AsyncValue():
//         return const CircularProgressIndicator();
//     }
//   },
// )


// ================================================================================

// 普通 Provider 类比为一个 Value，拥有 family 的 Provider 类比为一个 Map
// 用参数作为 key，在这个 Provider 内查询对应的值，所以，参数要能用 ==/hashCode 比较
//
// 文档说，最好启用 auto-dispose
//
// 更多具体语法看文档
//   final userProvider = FutureProvider.autoDispose.family<User, String>((ref, id) async {
//     final dio = Dio();
//     final response = await dio.get('https://api.example.com/users/$id');
//     return User.fromJson(response.data);
//   });
// 界面用法
//   final user1 = ref.watch(userProvider('123'));
//   final user2 = ref.watch(userProvider('456'));
// 遍历访问所有家族成员
//   for (final reference in ref.container.allProviders(family: userProvider)) {
//     ref.invalidate(reference.provider);
//   }
// 填充数据，能用于测试场景填充测试数据
//   userProvider('123').overrideWith((ref) => User(name: 'User 123'))  填充单个
//   userProvider.overrideWith((ref, arg) => User(name: 'User $arg'))   填充家族内所有的






