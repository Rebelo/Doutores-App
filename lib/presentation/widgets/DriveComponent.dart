import 'dart:io';

import 'package:doutores_app/data/models/FileModel.dart';
import 'package:doutores_app/data/repositories/FileRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/AppWidget.dart';

class DriveComponent extends StatefulWidget {
  static String tag = '/DriveComponent';
  final postsList = FileRepository.files;

  DriveComponent({Key? key, required List<File> list}) : super(key: key);

  @override
  DriveComponentState createState() => DriveComponentState();
}

class DriveComponentState extends State<DriveComponent> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {}

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  void _launchURL(url) async {
    if (!await launch(url)) throw 'Could not launch url';
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: widget.postsList.length,
      padding: EdgeInsets.all(16),
      itemBuilder: (context, index) {
        File mData = widget.postsList[index];
        var width = MediaQuery.of(context).size.width;
        return Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 5),
              child: Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      text(mData.mes ?? "", fontSize: 14.0),
                      text(mData.dia ?? "", fontSize: 14.0),
                    ],
                  ),
                  Container(
                    decoration: boxDecoration(radius: 8, showShadow: true, bgColor: Colors.white),
                    margin: EdgeInsets.only(left: 16, right: 16),
                    width: width / 6,
                    height: width / 6,
                    padding: EdgeInsets.all(width / 60),
                    child:  SvgPicture.asset("assets/images/Icon-DARF-PREVIDENCIARIO.svg", height: width / 7.5, width: width / 7.5),

                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            text(mData.name ?? "", fontSize: 14.0),
                            const SizedBox(height: 0, width: 15),
                            text("R\$"+mData.value.toString() ?? "", fontSize: 14.0)
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                        text("Referência: " + mData.referenceMonth! + "/" + mData.referenceYear!, fontSize: 12.0)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ).onTap(
              () {
            _launchURL("https://api.osayk.com.br/api/Companies/DownloadDocumentDrive/?id=" + mData.urlPath! + "&fullPath=||||EMPRESA&preview=false");
          },
        );
      },
      separatorBuilder: (context, index) {
        //if(index != widget.postsList!.length -1 ) {
          return const Divider();
        //} else {
          //return Container();
        //}
      },
    );
  }
}
