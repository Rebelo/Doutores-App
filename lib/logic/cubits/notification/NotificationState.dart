import 'package:equatable/equatable.dart';

import '../../../data/models/NotificationModel.dart';

abstract class NotificationState extends Equatable {}

class InitialState extends NotificationState {
  @override
  List<Object> get props => [];
}
class LoadingState extends NotificationState {
  @override
  List<Object> get props => [];
}

class LoadedState extends NotificationState {
  LoadedState(this.notifications);

  final List<NotificationModel> notifications;

  @override
  List<Object> get props => [notifications];
}

class ErrorState extends NotificationState {
  @override
  List<Object> get props => [];
}