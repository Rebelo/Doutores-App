
import 'package:doutores_app/utils/APPColors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter/gestures.dart';
//import 'package:url_launcher/url_launcher.dart';

import '../../data/models/MessageModel.dart';
import '../../utils/Utils.dart';

class ChatMessageWidget extends StatelessWidget {
  const ChatMessageWidget({
    Key? key,
    required this.isMe,
    required this.data,
  }) : super(key: key);

  void _launchURL(url) async {
    if (!await launch(url)) throw 'Could not launch url';
  }

  final bool isMe;
  final Message data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          margin: isMe ? EdgeInsets.only(top: 3.0, bottom: 3.0, right: 0, left: (500 * 0.25).toDouble()) : EdgeInsets.only(top: 4.0, bottom: 4.0, left: 0, right: (500 * 0.25).toDouble()),
          decoration: BoxDecoration(
            color: !isMe ? APPColorSecondary : Colors.white,
            boxShadow: defaultBoxShadow(),
            borderRadius: isMe
                ? const BorderRadius.only(bottomLeft: Radius.circular(10), topLeft: Radius.circular(10), topRight: Radius.circular(10))
                : const BorderRadius.only(topLeft: Radius.circular(10), bottomRight: Radius.circular(10), topRight: Radius.circular(10)),
            border: Border.all(color: isMe ? Theme.of(context).dividerColor : Colors.transparent),
          ),
          child: Column(
            crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  data.message!,
                  style: primaryTextStyle(
                      color: !isMe
                          ? white
                          : textPrimaryColor),
                ),
              ),
              data.filesObjects != null ? RichText(text: TextSpan(
                children: [
                  TextSpan(
                      text: data.filesObjects![0].name!,
                      style: const TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()..onTap = () => _launchURL("https://api.osayk.com.br/api/companies/DownloadDocumentDrive/?id="+data.filesObjects![0].downloadToken!+"&fullPath=/COMPROVANTES+DE+PAGAMENTO&preview=true"),
                  )

                ],

              )) : const SizedBox.shrink(),
              Text(Utils.getDefaultDate(data.created!, sum:3), style: secondaryTextStyle(color: !isMe ? white : textSecondaryColor, size: 12)),

            ],
          ),
        ),
      ],
    );
  }
}