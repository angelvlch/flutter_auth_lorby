import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'data_submit_event.dart';
part 'data_submit_state.dart';

class DataSubmitBloc extends Bloc<DataSubmitEvent, DataSubmitState> {
  DataSubmitBloc() : super(DataSubmitInitial()) {
    on<DataSubmitEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
