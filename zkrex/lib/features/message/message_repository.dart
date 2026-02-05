import '/core/core.dart';
import '/network/network.dart';

import 'message_api.dart';
import 'message.dart';

abstract class MessageRepo {
  Future<Result<Messages>> getAllMessages();
  Future<Result<void>> deleteMessage(int id);
}

class MessageRepository implements MessageRepo {
  MessageRepository({required Networkable network}) : _network = network;

  final Networkable _network;

  @override
  Future<Result<Messages>> getAllMessages() async {
    try {
      final res = await _network.getres(MessageApi.getAll(), Message.fromJson);
      await Future.delayed(Duration(seconds: 1));
      switch (res) {
        case Ok():
          final list = res.value.getList<Message>() ?? [];
          return Result.ok(list);
        case Error():
          return Result.error(res.error);
      }
    } catch (e) {
      final error = e is HttpError ? e : HttpError.unknownError();
      return Result.error(error);
    }
  }

  @override
  Future<Result<void>> deleteMessage(int id) async {
    await Future.delayed(Duration(seconds: 1));
    if (id % 2 == 1) {
      return Result.error(HttpError.unknownError());
    } else {
      return Result.ok(null);
    }
  }
}
