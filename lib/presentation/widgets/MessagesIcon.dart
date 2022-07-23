
import 'package:doutores_app/data/models/TicketModel.dart';
import 'package:doutores_app/logic/cubits/tickets/TicketsCubit.dart';
import 'package:doutores_app/logic/cubits/tickets/TicketsState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../utils/APPColors.dart';

class MessagesIcon extends StatefulWidget {

  const MessagesIcon({Key? key}) : super(key: key);

  @override
  MessagesIconState createState() => MessagesIconState();
}

class MessagesIconState extends State<MessagesIcon> {


  @override
  Widget build(BuildContext context) {
    final _ticketsCubit = BlocProvider.of<TicketsCubit>(context);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/tickets');
      },
      child: Container(
        width: 30,
        height: 30,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(right: 10.0),
        child: Stack(
          children: [
            const Icon(
              Icons.mail,
              color: APPBackGroundColor,
              size: 30,
            ),
            Container(
              width: 30,
              height: 30,
              alignment: Alignment.bottomRight,
              margin: const EdgeInsets.only(top: 5),
              child: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xffc32c37),
                    border: Border.all(color: Colors.white, width: 1)),
                child: Center(
                  child: BlocBuilder<TicketsCubit, TicketsState>(
                    bloc: _ticketsCubit,
                    builder: (context, state) {

                      int counter = 0;

                      if (state is LoadedStateTickets) {
                        counter = state.total;
                      } else if (state is TicketsBackgroundWaitingState){
                        counter = state.total;
                      }

                      return Text(
                        counter.toString(),
                        style: const TextStyle(fontSize: 10),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}