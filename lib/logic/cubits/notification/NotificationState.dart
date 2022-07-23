
import 'package:equatable/equatable.dart';

import '../../../data/models/NotificationModel.dart';

abstract class NotificationState extends Equatable {}

class InitialStateNotification extends NotificationState {
  @override
  List<Object> get props => [];
}
class NotificationLoadingState extends NotificationState {
  @override
  List<Object> get props => [];
}

class NotificationLoadedState extends NotificationState {
  NotificationLoadedState(this.notifications,  this.total);

  final List<NotificationModel> notifications;
  final int total;

  @override
  List<Object> get props => [notifications,  total];
}

class NotificationErrorState extends NotificationState {
  @override
  List<Object> get props => [];
}

class NoInternetState extends NotificationState {
  @override
  List<Object> get props => [];
}

