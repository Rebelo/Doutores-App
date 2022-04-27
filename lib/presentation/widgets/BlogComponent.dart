import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/BlogSamplePostModel.dart';
import '../../utils/AppWidget.dart';


class BlogComponent extends StatelessWidget {
  static String tag = '/BlogComponent';

  final List<BlogSamplePost> blogList;

  BlogComponent({required this.blogList});

  void _launchURL(url) async {
    if (!await launch(url)) throw 'Could not launch url';
  }


  @override
  Widget build(BuildContext context) {

    return ListView.separated(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: blogList.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        BlogSamplePost mData = blogList[index];
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(child: Text('${mData.title}', style: boldTextStyle(), softWrap: true, maxLines: 3),height: 70,),

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
            _launchURL(mData.url);
          },
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }
}

