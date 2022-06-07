
import 'package:equatable/equatable.dart';

import '../../../data/models/PaymentModel.dart';


abstract class PaymentState extends Equatable {}

class InitialStatePayment extends PaymentState {
  @override
  List<Object> get props => [];
}
class LoadingStatePayment extends PaymentState {
  @override
  List<Object> get props => [];
}

class LoadedStatePayment extends PaymentState {
  LoadedStatePayment(this.payments);

  final List<Payment> payments;

  @override
  List<Object> get props => [payments];
}

class ErrorStatePayment extends PaymentState {
  @override
  List<Object> get props => [];
}

class NoInternetStatePayment extends PaymentState {
  @override
  List<Object> get props => [];
}