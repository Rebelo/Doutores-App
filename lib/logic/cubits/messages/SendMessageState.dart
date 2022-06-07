
import 'package:equatable/equatable.dart';


abstract class SendMessageState extends Equatable {}

class InitialStateMessage extends SendMessageState {
  @override
  List<Object> get props => [];
}
class SendingState extends SendMessageState {
  @override
  List<Object> get props => [];
}

class SentState extends SendMessageState {


  @override
  List<Object> get props => [];
}

class ErrorStateMessage extends SendMessageState {

  @override
  List<Object> get props => [];
}