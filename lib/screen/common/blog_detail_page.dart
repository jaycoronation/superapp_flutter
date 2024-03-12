import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:share_plus/share_plus.dart';
import 'package:superapp_flutter/common_widget/common_widget.dart';
import 'package:superapp_flutter/utils/app_utils.dart';
import '../../constant/colors.dart';
import '../../model/BlogListResponseModel.dart';
import '../../utils/base_class.dart';


class BlogsDetailPage extends StatefulWidget {
  final ItemBlogs getSet;

  const BlogsDetailPage(this.getSet, {Key? key}) : super(key: key);

  @override
  BaseState<BlogsDetailPage> createState() => _BlogsDetailPageState();
}

class _BlogsDetailPageState extends BaseState<BlogsDetailPage> {
  late ItemBlogs dataGetSet;

  @override
  void initState() {
    super.initState();

    dataGetSet = (widget as BlogsDetailPage).getSet;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          toolbarHeight: 55,
          automaticallyImplyLeading: false,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child:  getBackArrow(),
          ),
          centerTitle: false,
          elevation: 0,
          backgroundColor: white,
          actions: [
            GestureDetector(
              onTap: () {
                var shareText = "Hey There,\n\nSharing Alpha Capital's latest article, '${dataGetSet.title},' which is now available on there website. For the insightful read, click the below link \n\n https://www.alphacapital.in/blog/${dataGetSet.slug?.toString()}\n\nhope you find it engaging and valuable.";
                Share.share(shareText);
              },
              child: Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(right: 5),
                padding: const EdgeInsets.all(3),
                width: 32,
                height: 32,
                child: Image.asset('assets/images/ic_share.png', width: 32, height: 32, color: black),
              ),

            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraints.maxHeight),
                      child: Column(
                        children: [
                          const Gap(18),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(checkValidString(dataGetSet.title.toString()),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: const TextStyle(fontSize: 16, color: black, fontWeight: FontWeight.w600),
                            ),
                          ),
                          const Gap(6),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(checkValidString(dataGetSet.publishedDateView.toString()),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: const TextStyle(fontSize: 14, color: graySemiDark, fontWeight: FontWeight.w400),
                            ),
                          ),
                          const Gap(12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                                imageUrl: dataGetSet.blogImage ?? '',
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                                height: 220,
                                errorWidget: (context, url, error) => Container(
                                  color: gray,
                                  width: MediaQuery.of(context).size.width,
                                  height: 280,
                                ),
                                placeholder: (context, url) => Container(
                                  color: gray,
                                  width: MediaQuery.of(context).size.width,
                                  height: 280 ,
                                )
                            ),
                          ),
                          const Gap(22),

                          Container(
                            decoration: BoxDecoration(
                              color: lightgrey,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                            child: Column(
                              children: [
                                HtmlWidget(
                                  checkValidString(dataGetSet.discription).replaceAll("\r\n\r\n", "").replaceAll("\r\n\t", "").replaceAll("\r\n", ""),
                                  textStyle: const TextStyle(fontSize: 10),
                                  customStylesBuilder: (element) {
                                    if (element.styles.contains('font-size')) {
                                      return {'font-size': '10px'};
                                    }
                                    return null;
                                  },
                                ),
                                const Gap(12),

                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
            ),
          ),)
    );
  }

  @override
  void castStatefulWidget() {
    widget is BlogsDetailPage;
  }
  
}