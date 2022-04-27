
import 'package:doutores_app/data/repositories/PaymentRepository.dart';
import 'package:doutores_app/logic/cubits/payments/PaymentState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(InitialState()) {
    getPaymentsList();
  }

  void getPaymentsList() async {
    try {
      emit(LoadingState());
      await PaymentRepository.get_payments();
      emit(LoadedStatePayment(PaymentRepository.pagamentosList));
    } catch (e) {
      emit(ErrorState());
    }
  }


}