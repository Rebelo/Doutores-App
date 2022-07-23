

import 'package:doutores_app/data/repositories/NotificationRepository.dart';
import 'package:doutores_app/logic/cubits/notification/NotificationState.dart';
import 'package:doutores_app/logic/cubits/tickets/TicketsState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/Utils.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(InitialStateNotification());

  @override
  void onChange(Change<NotificationState> change){
    super.onChange(change);
    var debug = 1;
  }


  Future getNotificationsList() async {
    try {
      if(await Utils.isConnected() == false) {
        emit(NoInternetState());

      }else {
        emit(NotificationLoadingState());
        await NotificationRepository.getUnpresented() ? emit(NotificationLoadedState(
            NotificationRepository.notifications,
            NotificationRepository.notifications.length)) : emit(NotificationErrorState());
      }
    } catch (e) {
      emit(NotificationErrorState());
    }
  }

}