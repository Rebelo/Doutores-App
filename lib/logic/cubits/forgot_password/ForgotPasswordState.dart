import 'package:doutores_app/logic/cubits/forgot_password/ForgotPasswordCubit.dart';
import 'package:doutores_app/presentation/screens/ForgetPassword.dart';
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
  @override
  List<Object> get props => [];
}

class WrongEmailState extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}

class ErrorState extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}

class NoInternetState extends ForgotPasswordState{
  @override
  List<Object> get props => [];
}