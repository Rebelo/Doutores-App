
import 'package:doutores_app/data/models/PaymentModel.dart';
import 'package:doutores_app/logic/cubits/payments/PaymentCubit.dart';
import 'package:doutores_app/logic/cubits/payments/PaymentState.dart';
import 'package:doutores_app/presentation/widgets/PaymentsComponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/APPColors.dart';
import '../Widgets/Alerts.dart';
import '../Widgets/Drawer.dart';
import '../widgets/LoadingDialog.dart';

class PaymentsScreen extends StatefulWidget {
  static var tag = "/payment";

  const PaymentsScreen({Key? key}) : super(key: key);

  @override
  PaymentsScreenState createState() => PaymentsScreenState();
}

class PaymentsScreenState extends State<PaymentsScreen> {

  late PaymentCubit _paymentCubit;

  Future<void> _pullRefresh() async {
    _paymentCubit.getPaymentsList();
  }

  @override
  Widget build(BuildContext context) {

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    _paymentCubit = BlocProvider.of<PaymentCubit>(context);
    if(_paymentCubit.state is InitialStatePayment)_paymentCubit.getPaymentsList();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: APPBackGroundColor,
        appBar: AppBar(
          title: const Text('Mensalidades', style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: APPBackGroundColor),),
          backgroundColor: APPColorPrimary,
          centerTitle: true,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                  icon: const Icon(Icons.menu, color: APPBackGroundColor),
                  onPressed: () {
                    _scaffoldKey.currentState!.openDrawer();
                  }
              );
            },
          ),

        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<PaymentCubit, PaymentState>(
                bloc: _paymentCubit,
                builder: (context, state) {

                  List<Payment> paymentsList = [];

                  if(state is NoInternetStatePayment){
                    Alerts.noInternetError(context);
                    return const Center(child: Text('Sem Dados'));
                  }
                  else if (state is LoadingStatePayment){
                    return LoadingDialog.showLittleLoading();
                  }

                  if (state is LoadedStatePayment){
                    paymentsList = state.payments;

                    if(paymentsList.isEmpty){
                      return const Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Center(child: Text('Sem Dados'))
                      );
                    }else {
                      return RefreshIndicator(
                        onRefresh: () => _pullRefresh(),
                        child: PaymentsComponent(
                          paymentList: paymentsList,
                        ),
                      );
                    }
                  }

                  return const Center(child: Text('Sem Dados'));
                },
              )
            ],
          ),
        ),
        drawer: const T2Drawer(),
      ),
    );
  }
}
