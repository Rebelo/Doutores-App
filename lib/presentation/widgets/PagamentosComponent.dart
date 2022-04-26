
import 'package:doutores_app/data/repositories/PaymentRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/PaymentModel.dart';
import '../../utils/AppWidget.dart';

class PagamentosComponent extends StatefulWidget {
  static String tag = '/PagamentosComponent';
  final pagssList = PaymentRepository.pagamentosList;

  PagamentosComponent({Key? key, required List<Payment> list}) : super(key: key);

  @override
  PagamentosComponentState createState() => PagamentosComponentState();
}

class PagamentosComponentState extends State<PagamentosComponent> {
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
      physics: const ScrollPhysics(),
      itemCount: widget.pagssList.length,
      padding: const EdgeInsets.all(10),
      itemBuilder: (context, index) {
        Payment mData = widget.pagssList[index];
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
                    margin: const EdgeInsets.only(left: 16, right: 16),
                    width: width / 6,
                    height: width / 6,
                    padding: EdgeInsets.all(width / 60),
                    child:  SvgPicture.asset("assets/images/Icon-MENSALIDADE.svg", height: width / 7.5, width: width / 7.5),

                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[

                            Flexible(child: Text(mData.description ?? "0", maxLines: 2)),
                            const SizedBox(height: 0, width: 25),
                            text("R\$"+mData.value.toString() ?? "0", fontSize: 14.0)
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                        text(mData.status ?? "", fontSize: 14.0),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ).onTap(
              () {
            _launchURL(mData.urlPath);
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
