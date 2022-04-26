

import 'package:doutores_app/data/repositories/UserRepository.dart';
import 'package:doutores_app/logic/cubits/user/UserState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class UserCubit extends Cubit<UserState> {
  UserCubit() : super(InitialState()) {
    //login(email, pass);
  }

  void login(email, pass) async {
    try {
      emit(LoadingState());
      if(await UserRepository.login(email, pass) == 201){
        emit(WrongCredentialsState());
      }
      else if(await UserRepository.login(email, pass) == 200 && await UserRepository.getLastAccess() == true){
        emit(LoadedState(UserRepository.user));
      }
      else {
        emit(ErrorState());
      }

    } catch (e) {
      emit(ErrorState());
    }
  }


}