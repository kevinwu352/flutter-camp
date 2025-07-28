part of 'reader_bloc.dart';

@immutable
sealed class ReaderEvent {}

/// 初始化事件
class InitEvent extends ReaderEvent {}

/// 自增事件
class IncrementEvent extends ReaderEvent {}
