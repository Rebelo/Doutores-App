


import 'package:doutores_app/data/repositories/NotificationRepository.dart';
import 'package:doutores_app/logic/cubits/notification/NotificationState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/Utils.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(InitialStateNotification()) {
    //getNotificationsList();
  }

  Future getNotificationsList() async {
    try {
      if(await Utils.isConnected() == false) {
        emit(NoInternetState());

      }else {
        emit(LoadingState());
        await NotificationRepository.getUnpresented() ? emit(LoadedState(
            NotificationRepository.notifications,
            NotificationRepository.notifications.length)) : emit(ErrorState());
      }
    } catch (e) {
      emit(ErrorState());
    }
  }

}