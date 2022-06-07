
import 'package:doutores_app/data/models/MessageModel.dart';
import 'package:equatable/equatable.dart';


abstract class GetMessagesState extends Equatable {}

class InitialState extends GetMessagesState {
  @override
  List<Object> get props => [];
}
class LoadingState extends GetMessagesState {
  @override
  List<Object> get props => [];
}


class LoadedState extends GetMessagesState {

  LoadedState(this.messages);

  final List<Message> messages;

  @override
  List<Object> get props => [messages];
}

class ErrorState extends GetMessagesState {

  @override
  List<Object> get props => [];
}