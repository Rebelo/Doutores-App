import 'package:equatable/equatable.dart';



abstract class ForgotPasswordState extends Equatable {}

class InitialState extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}
class LoadingState extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}

class LoadedState extends ForgotPasswordState {
  LoadedState(this.result);

  final bool result;

  @override
  List<Object> get props => [result];
}

class WrongEmailState extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}

class ErrorState extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}