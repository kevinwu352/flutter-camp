import '/network/network.dart';

final class MessageApi extends Endpoint {
  MessageApi.getAll() : super('/c/9b6b-f9a4-4a80-9c11', ReqMethod.get);
  MessageApi.delete(int id) : super('/c/xxx', ReqMethod.get);
}
