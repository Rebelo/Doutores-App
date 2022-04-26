
import 'package:doutores_app/data/repositories/NotificationRepository.dart';
import 'package:doutores_app/data/models/NotificationModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Widgets/Drawer.dart';

class NotificationScreen extends StatefulWidget {
  final bool isNotification;

  const NotificationScreen({Key? key, this.isNotification = false}) : super(key: key);

  @override
  CPNotificationFragmentState createState() => CPNotificationFragmentState();
}

class CPNotificationFragmentState extends State<NotificationScreen> {
  List<NotificationModel> notification = NotificationRepository.notifications;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Notificações', style: boldTextStyle(color: black)),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                  icon: const Icon(Icons.menu, color: black),
                  onPressed: () { _scaffoldKey.currentState!.openDrawer(); }
              );
            },
          ),
          backgroundColor: white,
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
                  child: TextButton(
                    onPressed: (){

                    },
                    child: const Text(
                      true ? "Marcar como lido" : "Mark all as unread",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Color(0xff2972ff),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: notification.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                NotificationModel data = notification[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
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
          ],
        ),
      ),
      drawer: const T2Drawer(),
    );
  }
}
