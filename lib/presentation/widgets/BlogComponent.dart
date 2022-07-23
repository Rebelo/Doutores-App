import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../data/models/BlogModel.dart';
import '../../utils/AppWidget.dart';
import 'package:url_launcher/url_launcher.dart' as ln;


class BlogComponent extends StatelessWidget {
  static String tag = '/BlogComponent';

  final List<Blog> blogList;

  const BlogComponent({Key? key, required this.blogList}) : super(key: key);

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

    return ListView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: blogList.length,
      padding: const EdgeInsets.all(10),
      itemBuilder: (context, index) {
        Blog mData = blogList[index];
        var width = MediaQuery.of(context).size.width;
        return Container(
          margin: const EdgeInsets.only(top: 10),
          padding: EdgeInsets.all(width / 40),
          decoration: const BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(8))
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Padding(
                    padding: const EdgeInsets.only(top: 10, right: 5),
                    child: SizedBox(
                      child: Text(
                          '${mData.title}',
                          style: boldTextStyle(),
                          softWrap: true,
                          maxLines: 4
                      ),
                      height: 75,
                      
                    ),
                  ),

                  8.height,
                  //Text('${mData.categoryName}', style: boldTextStyle(color: BHColorPrimary)),
                  Text(
                    '${mData.date}',
                    style: secondaryTextStyle(),
                  ),
                ],
              ).expand(flex: 2),
              4.width,
              commonCachedNetworkImage('${mData.imagePath}', height: 100, fit: BoxFit.fill).cornerRadiusWithClipRRect(16).expand(flex: 1),
            ],
          ).onTap(
                () {
                  _launchInBrowser(Uri.parse(mData.url!));
            },
          ),
        );
      },

    );
  }
}

