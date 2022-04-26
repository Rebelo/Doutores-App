
import 'package:equatable/equatable.dart';

import '../../../data/models/PaymentModel.dart';


abstract class PaymentState extends Equatable {}

class InitialState extends PaymentState {
  @override
  List<Object> get props => [];
}
class LoadingState extends PaymentState {
  @override
  List<Object> get props => [];
}

class LoadedStatePayment extends PaymentState {
  LoadedStatePayment(this.payments);

  final List<Payment> payments;

  @override
  List<Object> get props => [payments];
}

class ErrorState extends PaymentState {
  @override
  List<Object> get props => [];
}