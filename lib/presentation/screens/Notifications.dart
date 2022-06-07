
import 'package:doutores_app/data/repositories/NotificationRepository.dart';
import 'package:doutores_app/data/models/NotificationModel.dart';
import 'package:doutores_app/logic/cubits/notification/NotificationCubit.dart';
import 'package:doutores_app/logic/cubits/notification/NotificationState.dart';
import 'package:doutores_app/presentation/widgets/NotificationComponent.dart';
import 'package:doutores_app/utils/APPColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Widgets/Alerts.dart';
import '../Widgets/Drawer.dart';
import '../widgets/LoadingDialog.dart';

class NotificationScreen extends StatefulWidget {


  const NotificationScreen({Key? key}) : super(key: key);

  @override
  CPNotificationFragmentState createState() => CPNotificationFragmentState();
}

class CPNotificationFragmentState extends State<NotificationScreen> {

  @override
  Widget build(BuildContext context) {

    final _notificationCubit = BlocProvider.of<NotificationCubit>(context);
    if(_notificationCubit.state is InitialStateNotification)_notificationCubit.getNotificationsList();

    Future<void> _pullRefresh() async {
      _notificationCubit.getNotificationsList();
    }

    var width = MediaQuery.of(context).size.width;

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('Notificações',  style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
              color: APPBackGroundColor),
          ),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                  icon: const Icon(Icons.menu, color: APPBackGroundColor),
                  onPressed: () { _scaffoldKey.currentState!.openDrawer(); }
              );
            },
          ),
          backgroundColor: APPColorPrimary,
          elevation: 0,
          centerTitle: true,

        ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 16, width: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text(
                  "Mais recentes:",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontStyle: FontStyle.normal,
                    fontSize: 16,
                    color: Color(0xff000000),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    NotificationRepository.markAsPresented();
                  },
                  child: const Text(
                    "Marcar como lido",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: APPColorSecondary,
                    ),
                  ),
                ),
              ],
            ),
            BlocBuilder<NotificationCubit, NotificationState>(
              bloc: _notificationCubit,
              builder: (context, state) {

                List<NotificationModel> notificationsList = [];

                if(state is NoInternetState){
                  Alerts.noInternetError(context);
                  return const Center(child: Text('Sem Dados'));
                }
                else if(state is LoadingState){
                  return LoadingDialog.showLittleLoading();
                }

                else if (state is LoadedState){
                  notificationsList = state.notifications;
                  if(notificationsList.isNotEmpty) {
                    return RefreshIndicator(
                      onRefresh: () => _pullRefresh(),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: notificationsList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          NotificationModel data = notificationsList[index];
                          return Container(
                            decoration:BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.only(top: 7, bottom: 7, left: 12, right: 12),
                            margin: const EdgeInsets.only(top: 2, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                /*Center(
                                  child: Container(
                                    width: 5,
                                    height: 5,
                                    decoration: const BoxDecoration(
                                        color: Colors.blue,
                                        shape: BoxShape.circle),
                                  ),
                                ),*/
                                Container(
                                  height: 40,
                                  width: 40,
                                  padding: const EdgeInsets.all(8),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: APPColorSecondary),
                                  child: SvgPicture.asset(
                                      "assets/images/invoice-8856.svg",
                                      height: width / 7.5,
                                      width: width / 7.5,
                                      fit: BoxFit.cover),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
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
                  }else {
                    return const Center(child: Text('Sem Dados'));
                  }

                }else {
                  return const Center(child: Text('Sem Dados'));
                }



              },
            ),
          ],
        ),
      ),
      drawer: const T2Drawer(),
    );
  }
}
