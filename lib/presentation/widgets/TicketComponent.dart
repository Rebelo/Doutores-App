import 'dart:io';

import 'package:doutores_app/data/models/FileModel.dart';
import 'package:doutores_app/utils/APPColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../data/models/TicketModel.dart';
import '../../utils/AppWidget.dart';
import '../../utils/Utils.dart';

class TicketComponent extends StatefulWidget {

  final List<Ticket> ticketsList;

  const TicketComponent({Key? key, required this.ticketsList}) : super(key: key);

  @override
  TicketComponentState createState() => TicketComponentState();
}

class TicketComponentState extends State<TicketComponent> {
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

  @override
  Widget build(BuildContext context) {


    widget.ticketsList.sort((a, b) => a.updated!.compareTo(b.updated!));

    return ListView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: widget.ticketsList.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        Ticket mData = widget.ticketsList[index];
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
                        mData.updated!.split("T")[0].split("-")[2],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        Utils.numToMonth(mData.updated!.split("T")[0].split("-")[1]),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: boxDecoration(radius: 8, showShadow: true, bgColor: APPBackGroundColor),
                    margin: const EdgeInsets.only(left: 16, right: 16),
                    width: width / 8,
                    height: width / 8,
                    padding: EdgeInsets.all(width / 80),
                    child:  SvgPicture.asset(mData.unread! > 0 ? "assets/images/green_mail.svg" : "assets/images/mail.svg", height: width / 10, width: width / 10),

                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            //SizedBox(child: Text('${mData.title}', style: boldTextStyle(), softWrap: true, maxLines: 4),height: 75,),
                            Expanded(
                              child: Text(
                                mData.subject.toString() +" ("+ mData.unread.toString() + ")",
                                //"Era uma vez um computador que estava sobrecarregado e pediu para dormir um pouco",
                                maxLines: 3,
                                softWrap: true,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            const SizedBox(height: 0, width: 15),
                            Text(
                              mData.isClosed! ? "Fechado" : "Aberto",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: (mData.isClosed == true) ? Colors.red : Colors.green,
                              ),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                        //text("Ref.: " + mData.referenceMonth! + "/" + mData.referenceYear!, fontSize: 12.0)
                        text(mData.responsable!.split(" ")[0]+" "+mData.responsable!.split(" ")[1], fontSize: 12.0)
                      ],
                    ),
                  )


                ],
              ),
            ),
          ],
        ).onTap(
              () {
                Navigator.pushNamed(context, '/chat', arguments: {'id': mData.id, 'name': mData.responsable} );
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
