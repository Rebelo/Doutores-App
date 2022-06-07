
import 'package:equatable/equatable.dart';

abstract class CreateTicketState extends Equatable {}

class InitialState extends CreateTicketState {
  @override
  List<Object> get props => [];
}
class SendingState extends CreateTicketState {
  @override
  List<Object> get props => [];
}

class SentState extends CreateTicketState {

  @override
  List<Object> get props => [];
}

class ErrorStateCreateTicket extends CreateTicketState {

  @override
  List<Object> get props => [];
}

class NoInternetState extends CreateTicketState {
  @override
  List<Object> get props => [];
}