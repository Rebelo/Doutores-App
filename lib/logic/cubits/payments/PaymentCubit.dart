
import 'package:doutores_app/data/repositories/PaymentRepository.dart';
import 'package:doutores_app/logic/cubits/payments/PaymentState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/Utils.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(InitialStatePayment()) {
    //getPaymentsList();
  }

  Future getPaymentsList() async {
    try {
      if(await Utils.isConnected() == false) {
        emit(NoInternetStatePayment());

      } else {
        emit(LoadingStatePayment());
        await PaymentRepository.getPayments() ? emit(LoadedStatePayment(PaymentRepository.pagamentosList)) : emit(ErrorStatePayment());
      }

    } catch (e) {
      emit(ErrorStatePayment());
    }
  }

}