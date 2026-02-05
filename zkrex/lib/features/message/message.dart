final class Message {
  Message({required this.id, required this.title, required this.body});
  final int id;
  final String title;
  final String body;

  factory Message.fromJson(Map<String, dynamic> data) {
    final id = data['id'] as int;
    final title = data['title'] as String;
    final body = data['body'] as String;
    return Message(id: id, title: title, body: body);
  }

  Map<String, dynamic> toJson() => {'id': id, 'title': title, 'body': body};

  @override
  String toString() => '[$id:$title:$body]';
}

typedef Messages = List<Message>;
