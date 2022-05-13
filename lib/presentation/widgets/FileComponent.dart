import 'dart:io';

import 'package:doutores_app/data/models/FileModel.dart';
import 'package:doutores_app/data/repositories/FileRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/AppWidget.dart';

class FileComponent extends StatefulWidget {
  static String tag = '/DriveComponent';
  final List<File> filesList;
  final int size;

  const FileComponent({Key? key, required this.filesList, this.size = 0}) : super(key: key);

  @override
  FileComponentState createState() => FileComponentState();
}

class FileComponentState extends State<FileComponent> {
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

    int len = 0;

    if(widget.size == 0 || widget.size > widget.filesList.length){
      len = widget.filesList.length;
    }else{
      len = widget.size;
    }

    widget.filesList.sort((a, b) => a.dueDate!.compareTo(b.dueDate!));

    return ListView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: len,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        File mData = widget.filesList[index];
        var width = MediaQuery.of(context).size.width;
        return Column(
          children: <Widget>[
            Container(
              decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
              ),
              padding: const EdgeInsets.only(top: 7, bottom: 7, left: 12, right: 12),
              margin: const EdgeInsets.only(top: 2, bottom: 5),
              child: Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        mData.dia ?? "",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        mData.mes ?? "",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: boxDecoration(radius: 8, showShadow: true, bgColor: const Color.fromRGBO(244, 244, 244, 1)),
                    margin: const EdgeInsets.only(left: 16, right: 16),
                    width: width / 6,
                    height: width / 6,
                    padding: EdgeInsets.all(width / 80),
                    child:  SvgPicture.asset("assets/images/cash.svg", height: width / 10, width: width / 10),

                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              mData.name.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 0, width: 15),
                            Text(
                              "R\$"+mData.value.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                        text("Ref.: " + mData.referenceMonth! + "/" + mData.referenceYear!, fontSize: 12.0)
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
      /*separatorBuilder: (context, index) {
        //if(index != widget.postsList!.length -1 ) {
          return const Divider();
        //} else {
          //return Container();
        //}
      },*/
    );
  }
}
