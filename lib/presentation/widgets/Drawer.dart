import 'package:doutores_app/data/repositories/UserRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../utils/APPColors.dart';

class T2Drawer extends StatefulWidget {

  const T2Drawer({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return T2DrawerState();
  }
}

class T2DrawerState extends State<T2Drawer> {
  var selectedItem = -1;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height,
      child: Observer(
        builder: (_) => Drawer(
          elevation: 8,
          child: Container(
            color: Colors.grey[50],
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.grey[50],
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 70, right: 20),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
                        decoration: const BoxDecoration(
                            color: APPColorPrimary,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(24.0),
                                topRight: Radius.circular(24.0))),
                        /*User Profile*/
                        child: Row(
                          children: <Widget>[
                            const CircleAvatar(
                              backgroundColor: APPColorSecondary,
                                backgroundImage:
                                    AssetImage('assets/images/app/placeholder.jpg'),
                                radius: 40),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(UserRepository.user.name,
                                      style: boldTextStyle(
                                          color: white, size: 20)),
                                  const SizedBox(height: 8),
                                  Text(UserRepository.user.email,
                                      style: primaryTextStyle(color: white)),
                                  const SizedBox(height: 4),
                                  Text(UserRepository.user.emailCompl,
                                      style: primaryTextStyle(color: white)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    getDrawerItem('assets/images/home-svgrepo-com.svg',
                        "Início", 1),
                    getDrawerItem('assets/images/chat_bubble_outline_black.svg',
                        "Solicitações", 2),
                    getDrawerItem('assets/images/feed_black.svg', "Blog", 3),
                    getDrawerItem(
                        'assets/images/notification-svgrepo-com.svg', "Notificações", 4),
                    getDrawerItem(
                        'assets/images/folder_black.svg', "Arquivos", 5),
                    getDrawerItem(
                        'assets/images/logout-svgrepo-com.svg', "Sair", 6),
                    const SizedBox(height: 30),
                    /*Divider(color: Colors.black, height: 1),
                    SizedBox(height: 30),
                    /*getDrawerItem(t2_share, t2_lbl_share_and_invite, 6),
                    getDrawerItem(t2_help, t2_lbl_help_and_feedback, 7),*/
                    SizedBox(height: 30),*/
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getDrawerItem(String icon, String name, int selectedItem) {
    return GestureDetector(
      onTap: () {
        setState(() {

          switch (selectedItem) {
            case 1:
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/home');
              break;
            case 2:
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/tickets');
              break;
            case 3:
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/blog');
              break;
            case 4:
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/notification');
              break;
            case 5:
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/files');
              break;
            case 6:
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
              break;

          }
        });
      },
      child: Container(
        color: APPBackGroundColor,
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
        child: Row(
          children: <Widget>[
            SvgPicture.asset(icon, width: 20, height: 20, color: Colors.black),
            const SizedBox(width: 20),
            Text(name,
                style: primaryTextStyle(
                    color:
                        selectedItem == selectedItem ? APPColorPrimary : Colors.black87,
                    size: 20)),

          ],
        ),
      ),
    );
  }
}
