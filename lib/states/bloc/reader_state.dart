part of 'reader_bloc.dart';

// @immutable
// sealed class ReaderState {}

// final class ReaderInitial extends ReaderState {}

class ReaderState {
  // 自增数字
  late int num;

  ReaderState init() {
    // 初始化为0
    return ReaderState()..num = 0;
  }

  ReaderState clone() {
    // 获取最新对象
    return ReaderState()..num = num;
  }
}
