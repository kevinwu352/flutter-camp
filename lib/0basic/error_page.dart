import 'package:flutter/material.dart';

class NetworkExc implements Exception {}

void networkWork(bool value) {
  if (value) {
    print('network done');
  } else {
    throw NetworkExc();
  }
}

class StatusExc implements Exception {}

void statusWork(bool value) {
  if (value) {
    print('status done');
  } else {
    throw StatusExc();
  }
}

class DecodeExc implements Exception {}

void decodeWork(bool value) {
  if (value) {
    print('decode done');
  } else {
    throw DecodeExc();
  }
}

class OperationExc implements Exception {}

void operationWork(bool value) {
  if (value) {
    print('operation done');
  } else {
    throw OperationExc();
  }
}

// ================================================================================

class HttpExcep implements Exception {
  const HttpExcep.networkError() : info = 'Network Error';
  const HttpExcep.statusError() : info = 'Status Error';
  const HttpExcep.decodeError() : info = 'Decode Error';
  const HttpExcep.operationFailed() : info = 'Operation Failed';
  const HttpExcep._(this.info);
  final String info;
  @override
  String toString() => info;
}

void pack1(bool value1, bool value2) {
  try {
    throw HttpExcep.statusError();
    networkWork(value1);
    statusWork(value2);
  } on HttpExcep catch (e) {
    print('pack1: 222 $e');
    rethrow;
  } catch (e) {
    print('pack1: $e');
    throw HttpExcep.networkError();
    // rethrow;
  }
}

// 等异步函数里面的异常，必须要 await，否则捕捉不到
Future<int> networkJob(bool value) async {
  print('110');
  await Future.delayed(Duration(seconds: 4));
  if (value) {
    print('network ok');
  } else {
    throw HttpExcep.networkError();
  }
  print('111');
  return 101;
}

Future<int> statusJob(bool value) async {
  print('220');
  await Future.delayed(Duration(seconds: 4));
  if (value) {
    print('status ok');
  } else {
    throw HttpExcep.statusError();
  }
  print('221');
  return 102;
}

void pack2(bool value1, bool value2) {
  try {
    networkJob(value1);
    statusJob(value2);

    // await networkJob(value1);
    // await statusJob(value2);

    // final val1 = await networkJob(value1);
    // print(val1);
    // final val2 = await statusJob(value2);
    // print(val2);
  } on HttpExcep catch (e) {
    print('pack2: 222 $e');
    // rethrow;
  } catch (e) {
    print('pack2: $e');
    // throw HttpExcep.networkError();
    // rethrow;
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Error")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('    begin');

          try {
            print('    111');
            pack2(true, false);
            print('    222');
          } catch (e) {
            print('got $e');
          }

          print('    end');
        },
        child: Icon(Icons.run_circle_outlined),
      ),
      body: Text("body"),
    );
  }
}
