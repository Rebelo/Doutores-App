
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/MessagesRepository.dart';
import 'GetMessagesState.dart';

class GetMessagesCubit extends Cubit<GetMessagesState> {
  GetMessagesCubit() : super(InitialState());

  void getMessagesList(int? id) async {
    try {
      emit(LoadingState());
      await MessagesRepository.getMessages(id) ? emit(LoadedState(MessagesRepository.messagesList)) : emit(ErrorState());

    } catch (e) {
      emit(ErrorState());
    }
  }

  void emitLoadedState() => emit(LoadedState(MessagesRepository.messagesList));

  void emitInitialState() => emit(InitialState());

}


class TickestState {
}