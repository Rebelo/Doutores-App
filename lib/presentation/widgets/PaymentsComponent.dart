
import 'package:doutores_app/data/repositories/PaymentRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../data/models/PaymentModel.dart';
import '../../utils/APPColors.dart';
import 'package:url_launcher/url_launcher.dart' as ln;

class PaymentsComponent extends StatelessWidget {
  static String tag = '/PagamentosComponent';
  final List<Payment> paymentList;
  final int size;

  const PaymentsComponent({Key? key, required this.paymentList, this.size = 0}) : super(key: key);

  Future<void> _launchInBrowser(Uri url) async {
    if (!await ln.launchUrl(
      url,
      mode: ln.LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {

    int len = 0;

    if(size == 0 || size > paymentList.length){
      len = paymentList.length;
    }else{
      len = size;
    }

    return paymentList.isEmpty ? const Center(child: Text('Sem Dados')) : ListView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: len,
      padding: const EdgeInsets.all(10),
      itemBuilder: (context, index) {
        Payment mData = paymentList[index];
        var width = MediaQuery.of(context).size.width;
        return Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              padding: const EdgeInsets.only(
                  top: 7, bottom: 7, left: 12, right: 12),
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
                    decoration: const BoxDecoration(
                        color: APPBackGroundColor,
                        borderRadius: BorderRadius.all(Radius.circular(8))
                    ),
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
                            Text(
                              "R\$" + mData.value.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                        Text(mData.status ?? "", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0, color: mData.status == "Em aberto" ? APPColorSecondary : Colors.red)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ).onTap(
              () {
                _launchInBrowser(Uri.parse(mData.urlPath!));
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
