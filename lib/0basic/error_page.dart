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
    // throw 'abc';
    // throw Exception('asdf');
    networkWork(value1);
    statusWork(value2);
  } on NetworkExc {
    print('pack1: 111');
    rethrow;
  } on Exception catch (e) {
    print('pack1: 222 $e');
    rethrow;
  } catch (e) {
    print('pack1: $e');
    rethrow;
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
            pack1(false, false);
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
