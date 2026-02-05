import 'dart:collection';
import 'package:flutter/foundation.dart';
import '/core/core.dart';

import 'message_repository.dart';
import 'message.dart';

final class MessageViewModel extends ChangeNotifier {
  MessageViewModel({required MessageRepo repo}) : _repo = repo {
    load = Command0(_load)..execute();
    delete = Command1(_delete);
  }

  final MessageRepo _repo;

  bool get hasData => _messageList.isNotEmpty;
  bool get isLoading => load.running;
  bool get failed => _error != null;

  Exception? _error;
  Exception? get error => _error;

  Messages _messageList = [];
  UnmodifiableListView<Message> get messageList => UnmodifiableListView(_messageList);

  late final Command0<void> load;
  late final Command1<void, int> delete;

  Future<Result<void>> _load() async {
    final result = await _repo.getAllMessages();
    switch (result) {
      case Ok():
        if (kDebugMode) debugPrint('${result.value}');
        _messageList = result.value;
        _error = null;
      case Error():
        if (kDebugMode) debugPrint('${result.error}');
        _error = result.error;
    }
    return result.toVoid();
  }

  Future<Result<void>> _delete(int id) async {
    final result = await _repo.deleteMessage(id);
    switch (result) {
      case Ok():
        _messageList.removeWhere((e) => e.id == id);
      case Error():
        break;
    }
    return result.toVoid();
  }
}
