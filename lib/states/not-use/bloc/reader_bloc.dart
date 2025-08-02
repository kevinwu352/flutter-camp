import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'reader_event.dart';
part 'reader_state.dart';

class ReaderBloc extends Bloc<ReaderEvent, ReaderState> {
  // super 是啥写法？
  ReaderBloc() : super(ReaderState().init()) {
    on<InitEvent>(_init);
    on<IncrementEvent>(_add);
  }

  void _init(InitEvent event, Emitter<ReaderState> emit) {
    emit(state.clone());
  }

  _add(IncrementEvent event, Emitter<ReaderState> emit) {
    state.num++;
    emit(state.clone());
  }
}
