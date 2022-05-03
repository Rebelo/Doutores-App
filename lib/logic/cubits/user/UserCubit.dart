

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

      String responseResult = await UserRepository.login(email, pass);

      if(responseResult == "InvalidCredentials"){
        emit(WrongCredentialsState());
      }
      else if(responseResult == "Success" && await UserRepository.getLastAccess() == true){
        emit(LoadedStateUser(UserRepository.user));
      }
      else {
        emit(ErrorState());
      }

    } catch (e) {
      emit(ErrorState());
    }
  }


}