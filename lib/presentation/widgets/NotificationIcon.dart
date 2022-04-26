
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../logic/cubits/notification/NotificationCubit.dart';
import '../../logic/cubits/notification/NotificationState.dart';
import '../Screens/Notifications.dart';

class NotificationIcon extends StatefulWidget {
  static String tag = '/NotificationTag';

  const NotificationIcon({Key? key}) : super(key: key);

  @override
  NotificationIconState createState() => NotificationIconState();
}

class NotificationIconState extends State<NotificationIcon> {


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NotificationScreen().launch(context);
      },
      child: Container(
        width: 30,
        height: 30,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(right: 10.0),
        child: Stack(
          children: [
            const Icon(
              Icons.notifications,
              color: Colors.black,
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
                  child: BlocBuilder<NotificationCubit, NotificationState>(
                    builder: (context, state) {

                      int counter = 0;

                      if (state is LoadedState) {
                        counter = state.notifications.length;
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