import 'package:equatable/equatable.dart';

import '../../../data/models/UserModel.dart';


abstract class UserState extends Equatable {}

class InitialState extends UserState {
  @override
  List<Object> get props => [];
}

class LoadingState extends UserState {
  @override
  List<Object> get props => [];
}

class LoadedStateUser extends UserState {
  LoadedStateUser(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}

class ErrorState extends UserState {
  @override
  List<Object> get props => [];
}

class WrongCredentialsState extends UserState {

  @override
  List<Object> get props => [];
}

class NoInternetState extends UserState {
  @override
  List<Object> get props => [];
}