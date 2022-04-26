
import 'package:doutores_app/data/repositories/UserRepository.dart';
import 'package:doutores_app/logic/cubits/forgot_password/ForgotPasswordState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(email) : super(InitialState()) {
    getNotificationsList(email);
  }

  void getNotificationsList(email) async {
    try {
      emit(LoadingState());
      bool result = await UserRepository.askNewPassword(email);
      emit(LoadedState(result));
    } catch (e) {
      emit(ErrorState());
    }
  }


}