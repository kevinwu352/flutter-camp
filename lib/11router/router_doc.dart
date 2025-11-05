// 定义路由的时候有 /，push 的时候也要加 /。定义的时候不加，使用的时候可以不加
// 最好加不加呢？

// 父路由只相当于一个 group，并不会在导航栈上创建多个页面
// push 子路由的时候，并不会创建父路由的实例
// 父路由有参数的时候，子路由要把参数带上

// ================================================================================

// pop
// push / pushNamed
// go / goNamed                             会替换掉原来的整个栈，有 push 动画
//   实测：当 go 的目标是根时，只是 pop 回去，动画也是 pop，那个路由并不是新建的；其它情况都比较正常
// replace / replaceNamed                   替换栈顶这个页面，无动画
// pushReplacement / pushReplacementNamed   替换栈顶这个页面，有 push 动画
// 调用时，路径末尾的 / 不影响

// GoRoute(
//   name: 'song',
//   path: 'songs/:songId',
//   builder: /* ... */,
// )
// 直接用 name
//   context.goNamed('song', pathParameters: {'songId': 123});
// 用 name 查找 location
//   context.go(context.namedLocation('song', pathParameters: {'songId': 123}));

// ================================================================================

// 传参数
// 知道有几个参数时，用路径参数，Widget 内部接收参数用 String?
// GoRoute(
//   path: '/users/:name/:age',
//   builder: (context, state) => const UserScreen(id: state.pathParameters['userId']),
// )
// 不知有几个参数时，用 Query
// GoRoute(
//   path: '/users',
//   builder: (context, state) => const UsersScreen(filter: state.uri.queryParameters['filter']),
// )
// 复杂对象，用额外参数
// context.go('/123', extra: User());
// final String extraString = GoRouterState.of(context).extra! as User;

// ================================================================================

// 等结果
//   onTap: () async {
//     final bool? result = await context.push<bool>('/page2');
//     if(result ?? false)...
//   }
// 返回结果
//   onTap: () => context.pop(true)

// ================================================================================

// 打印路由栈
// GoRouter.of(context).routerDelegate.currentConfiguration.matches.forEach(print);
