import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:superapp_flutter/utils/app_utils.dart';
import '../../constant/colors.dart';
import '../../model/BlogListResponseModel.dart';
import '../../utils/base_class.dart';


class BlogsDetailPage extends StatefulWidget {
  final ItemBlogs getSet;

  const BlogsDetailPage(this.getSet, {Key? key}) : super(key: key);

  @override
  _BlogsDetailPageState createState() => _BlogsDetailPageState();
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
          title: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
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
                     Container(width: 8,),
                     // Expanded(
                     //   child: Text(checkValidString(dataGetSet.title.toString()),
                     //    textAlign: TextAlign.start,
                     //    overflow: TextOverflow.clip,
                     //    style: TextStyle(fontSize: 24, color: black, fontWeight: FontWeight.w800),
                     //   ),
                     // ),
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
                          Container(height: 18,),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(checkValidString(dataGetSet.title.toString()),
                             textAlign: TextAlign.start,
                             overflow: TextOverflow.clip,
                             style: const TextStyle(fontSize: 24, color: black, fontWeight: FontWeight.w800),
                            ),
                          ),
                          Container(height: 18,),
                          Container(
                            decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(0),
                            ),
                            padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                            child: HtmlWidget(
                              dataGetSet.discription.toString(),
                              textStyle: const TextStyle(height: 1.5, color: black,fontSize: 18, fontWeight: FontWeight.w500),
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