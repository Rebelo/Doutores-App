
import 'package:equatable/equatable.dart';

import '../../../data/models/TicketModel.dart';

abstract class TicketsState extends Equatable {}

class InitialState extends TicketsState {
  @override
  List<Object> get props => [];
}
class LoadingStateTickets extends TicketsState {
  @override
  List<Object> get props => [];
}

class LoadedStateTickets extends TicketsState {


  LoadedStateTickets(this.tickets, this.total, this.groups);

  final List<Ticket> tickets;
  final int total;
  final List<Map> groups;

  @override
  List<Object> get props => [tickets, total, groups];
}

class ErrorState extends TicketsState {

  @override
  List<Object> get props => [];
}

class NoInternetStateTickets extends TicketsState {

  @override
  List<Object> get props => [];
}