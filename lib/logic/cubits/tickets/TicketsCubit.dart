

import 'package:doutores_app/data/repositories/TicketRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/Utils.dart';
import 'TicketsState.dart';

class TicketsCubit extends Cubit<TicketsState> {
  TicketsCubit() : super(InitialState());

  Future getTicketsList() async {
    try {
      if(await Utils.isConnected() == false) {
        emit(NoInternetStateTickets());

      }else {
        emit(LoadingStateTickets());
        await TicketRepository.getTickets() ? emit(LoadedStateTickets(
            TicketRepository.tickets!, TicketRepository.totalUnread,
            TicketRepository.groupAccountants)) : emit(ErrorState());
      }
    } catch (e) {
      emit(ErrorState());
    }
  }

  void getCompanyGroups() async {
    await TicketRepository.getCompanyGroups();
    emit(LoadedStateTickets(TicketRepository.tickets!, TicketRepository.totalUnread, TicketRepository.groupAccountants));
  }


}

class TickestState {
}