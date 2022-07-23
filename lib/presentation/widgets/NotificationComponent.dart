
import 'package:doutores_app/data/models/NotificationModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../logic/cubits/notification/NotificationCubit.dart';


class NotificationComponent extends StatelessWidget {
  static String tag = '/NotificationComponent';

  final List<NotificationModel> notificationsList;

  const NotificationComponent({Key? key, required this.notificationsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    Future<void> _pullRefresh() async {
      BlocProvider.of<NotificationCubit>(context).getNotificationsList();
    }

    return RefreshIndicator(
      onRefresh: () => _pullRefresh(),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: notificationsList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          NotificationModel data = notificationsList[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration:BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Center(
                  child: Container(
                    width: 5,
                    height: 5,
                    decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                  ),
                ),
                Container(
                  height: 40,
                  width: 40,
                  padding: const EdgeInsets.all(8),
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.lightBlueAccent),
                  child: SvgPicture.asset("assets/images/invoice-8856.svg", height: width / 7.5, width: width / 7.5, fit: BoxFit.cover),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        data.date!,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: boldTextStyle(size: 14),
                      ),
                      const SizedBox(height: 4, width: 16),
                      Text(
                        data.message!,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: secondaryTextStyle(size: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

  }

}

