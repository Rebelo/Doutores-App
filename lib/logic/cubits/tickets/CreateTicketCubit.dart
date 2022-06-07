

import 'package:doutores_app/data/repositories/TicketRepository.dart';
import 'package:doutores_app/logic/cubits/tickets/CreateTicketState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/Utils.dart';

class CreateTicketCubit extends Cubit<CreateTicketState> {
  CreateTicketCubit() : super(InitialState());

  void createTicket(String subject, String message, int id) async {
    try {
      if(await Utils.isConnected() == false) {
        emit(NoInternetState());

      }else {
        emit(SendingState());
        await TicketRepository.createTicket(subject, message, id) ? emit(SentState()) : emit(ErrorStateCreateTicket());
      }
    } catch (e) {
      emit(ErrorStateCreateTicket());
    }
  }


}