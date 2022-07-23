
import 'package:doutores_app/logic/cubits/tickets/TicketsState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../data/models/TicketModel.dart';
import '../../logic/cubits/tickets/TicketsCubit.dart';
import '../../utils/APPColors.dart';
import '../Widgets/Alerts.dart';
import '../Widgets/Drawer.dart';
import '../widgets/LoadingDialog.dart';

import '../widgets/TicketComponent.dart';

class TicketsScreen extends StatefulWidget {

  const TicketsScreen({Key? key}) : super(key: key);

  @override
  TicketScreenState createState() => TicketScreenState();
}

int currentIndex = 0;

class TicketScreenState extends State<TicketsScreen> {

  late TicketsCubit _ticketsCubit;

  Future<void> _pullRefresh() async {
    _ticketsCubit.getTicketsList();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    _ticketsCubit = BlocProvider.of<TicketsCubit>(context);
    if(_ticketsCubit.state is InitialStateTickets)_ticketsCubit.getTicketsList();

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      backgroundColor: APPBackGroundColor,
        key: _scaffoldKey,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: APPBackGroundColor),
        centerTitle: true,
        title: const Text('Chamados',  style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: APPBackGroundColor),
        ),
        elevation: 0,
          backgroundColor: APPColorPrimary,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
                icon: const Icon(Icons.menu, color: APPBackGroundColor),
                onPressed: () { _scaffoldKey.currentState!.openDrawer(); }
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<TicketsCubit, TicketsState>(
              bloc: _ticketsCubit,
              builder: (context, state) {

                List<Ticket> ticketsList = [];

                if (state is NoInternetStateTickets){
                  Alerts.noInternetError(context);
                  return const Center(child: Text('Sem Dados'));
                }
                else if (state is LoadingStateTickets){
                  return LoadingDialog.showLittleLoading();
                }

                else if (state is TicketsBackgroundWaitingState){
                  ticketsList = state.tickets;

                  return RefreshIndicator(
                    onRefresh: () => _pullRefresh(),
                    child: TicketComponent(
                        ticketsList: ticketsList
                    ),
                  );
                }else if (state is LoadedStateTickets){
                  ticketsList = state.tickets;

                  return RefreshIndicator(
                    onRefresh: () => _pullRefresh(),
                    child: TicketComponent(
                        ticketsList: ticketsList
                    ),
                  );
                }else {
                  return const Center(child: Text('Sem Dados'));
                }


              },
            )
          ],
        ),
      ),
    floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    floatingActionButton: FloatingActionButton(
      // isExtended: true,
      child: const Icon(Icons.add),
      backgroundColor: APPColorSecondary,
      onPressed: () {
        Navigator.pushNamed(context, '/newTicket');
      },
    ),
        drawer: const T2Drawer(),
    );

  }
}

