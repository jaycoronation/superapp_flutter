
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:superapp/model/blogs_response_model.dart';
import 'package:superapp/utils/app_utils.dart';

import '../../constant/colors.dart';
import '../../utils/base_class.dart';


class BlogsDetailPage extends StatefulWidget {
  final ItemsBlogs getSet;

  const BlogsDetailPage(this.getSet, {Key? key}) : super(key: key);

  @override
  _BlogsDetailPageState createState() => _BlogsDetailPageState();
}

class _BlogsDetailPageState extends BaseState<BlogsDetailPage> {
  late ItemsBlogs dataGetSet;

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
          title: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(right: 8),
                          child: Image.asset('assets/images/fin_plan_ic_back_arrow.png',height: 30, width: 30, color: black,),
                        )),
                     Expanded(
                       child: Text(checkValidString(dataGetSet.title.toString()),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: TextStyle(fontSize: 16, color: black, fontWeight: FontWeight.w600),
                       ),
                     ),
                    // Spacer()
                  ],
                ),
              ],
            ),
          ),
          centerTitle: false,
          elevation: 0,
          backgroundColor: white,
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
                          Container(
                            decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(0),
                            ),
                            padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                            child: HtmlWidget(
                              dataGetSet.contentHtml.toString(),
                              textStyle: const TextStyle(height: 1.5, color: black,fontSize: 16, fontWeight: FontWeight.w500),
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