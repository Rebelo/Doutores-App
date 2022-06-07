import 'package:equatable/equatable.dart';

import '../../../data/models/NotificationModel.dart';

abstract class NotificationState extends Equatable {}

class InitialStateNotification extends NotificationState {
  @override
  List<Object> get props => [];
}
class LoadingState extends NotificationState {
  @override
  List<Object> get props => [];
}

class LoadedState extends NotificationState {
  LoadedState(this.notifications,  this.total);

  final List<NotificationModel> notifications;
  final int total;

  @override
  List<Object> get props => [notifications,  total];
}

class ErrorState extends NotificationState {
  @override
  List<Object> get props => [];
}

class NoInternetState extends NotificationState {
  @override
  List<Object> get props => [];
}
