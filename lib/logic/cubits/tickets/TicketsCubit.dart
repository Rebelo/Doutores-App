

import 'package:doutores_app/data/repositories/TicketRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/Utils.dart';
import 'TicketsState.dart';

class TicketsCubit extends Cubit<TicketsState> {
  TicketsCubit() : super(InitialStateTickets());

  @override
  void onChange(Change<TicketsState> change){
    super.onChange(change);
    var segura = 1;
  }

  Future getTicketsList() async {
    try {
      if(await Utils.isConnected() == false) {
        emit(NoInternetStateTickets());

      }else {
        emit(LoadingStateTickets());
        await TicketRepository.getTickets() ?
          emit(LoadedStateTickets(TicketRepository.tickets!, TicketRepository.totalUnread, TicketRepository.groupAccountants)) :
          emit(ErrorStateTickets());
      }
    } catch (e) {
      emit(ErrorStateTickets());
    }
  }

  Future backgroundFunc() async {
    try {
      Future.delayed(const Duration(milliseconds: 5000), () async {
        if(await Utils.isConnected() && await TicketRepository.getTickets()) {
          emit(LoadedStateTickets(TicketRepository.tickets!, TicketRepository.totalUnread, TicketRepository.groupAccountants));
        } else {
          emit(ErrorStateTickets());
        }
      });

    } catch (e) {
      emit(ErrorStateTickets());
    }
  }

  void sendToWait(){
    emit(TicketsBackgroundWaitingState(TicketRepository.tickets!, TicketRepository.totalUnread, TicketRepository.groupAccountants));
  }

  void getCompanyGroups() async {
    await TicketRepository.getCompanyGroups();
    emit(LoadedStateTickets(TicketRepository.tickets!, TicketRepository.totalUnread, TicketRepository.groupAccountants));
  }




}
