import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_camp/states/not-use/bloc/reader_bloc.dart';

// home: BlocProvider(
//   create: (context) => ReaderBloc(),
//   child: ReaderPage(),
// ),

class ReaderPage extends StatelessWidget {
  const ReaderPage({super.key});
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ReaderBloc>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: BlocBuilder<ReaderBloc, ReaderState>(
        builder: (context, state) => Center(child: Text('${state.num}')),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => context.read<ReaderBloc>().add(IncrementEvent()),
        // onPressed: () => bloc.add(IncrementEvent()),
      ),
    );
  }
}
