
import 'package:doutores_app/data/repositories/UserRepository.dart';
import 'package:doutores_app/logic/cubits/forgot_password/ForgotPasswordState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/Utils.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(InitialState());

  void ask(email) async {
    try {
      if(await Utils.isConnected() == false) {
        emit(NoInternetState());

      }else {
        emit(LoadingState());

        int responseCode = await UserRepository.askNewPassword(email);

        if (responseCode == 201) {
          emit(WrongEmailState());
        } else if (responseCode == 200) {
          emit(LoadedState());
        } else {
          emit(ErrorState());
        }
      }

    } catch (e) {
      emit(ErrorState());
    }
  }


}