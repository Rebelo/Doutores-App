


import 'package:doutores_app/data/repositories/NotificationRepository.dart';
import 'package:doutores_app/logic/cubits/notification/NotificationState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(InitialStateNotification()) {
    //getNotificationsList();
  }

  void getNotificationsList() async {
    try {
      emit(LoadingState());
      await NotificationRepository.getUnpresented();
      emit(LoadedState(NotificationRepository.notifications));
    } catch (e) {
      emit(ErrorState());
    }
  }


}