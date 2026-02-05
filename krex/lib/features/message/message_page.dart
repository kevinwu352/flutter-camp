import 'package:flutter/material.dart';
import '/core/core.dart';
import '/network/network.dart';
import '/utils/list_view_ext.dart';
import 'message_view_model.dart';
import 'message_repository.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key, required MessageViewModel vm}) : _vm = vm;

  final MessageViewModel _vm;

  MessagePage.create({super.key, required Networkable network})
    : _vm = MessageViewModel(repo: MessageRepository(network: network));

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  void initState() {
    super.initState();
    widget._vm.delete.addListener(_onDelete);
  }

  @override
  void dispose() {
    widget._vm.delete.removeListener(_onDelete);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Message')),
      body: ListenableBuilder(
        listenable: Listenable.merge([widget._vm.load, widget._vm.delete]),
        builder: (context, child) {
          if (widget._vm.hasData) {
            return ListViewExt.separate(
              items: widget._vm.messageList,
              separator: (ctx, i) => Divider(thickness: 0),
              tile: (ctx, i, it) => ListTile(
                title: Text('[${it.id}] ${it.title}'),
                subtitle: Text(it.body),
                trailing: IconButton(onPressed: () => widget._vm.delete.execute(it.id), icon: Icon(Icons.delete)),
              ),
            );
          }
          if (widget._vm.isLoading) {
            return Center(child: CircularProgressIndicator.adaptive());
          }
          if (widget._vm.failed) {
            return Center(child: Text('failed'));
          }
          return Center(child: Text('empty'));
        },
      ),
    );
  }

  void _onDelete() {
    final result = widget._vm.delete.result;
    if (result is Error) {
      final info = result.error.toString();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(info)));
    }
  }
}
