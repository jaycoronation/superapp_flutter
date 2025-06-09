import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/constant/api_end_point.dart';
import 'package:superapp_flutter/widget/loading.dart';

import '../../common_widget/common_widget.dart';
import '../../constant/colors.dart';
import '../../model/GetDocumentsResponseModel.dart';
import '../../model/SummaryListResponseModel.dart';
import '../../utils/app_utils.dart';
import '../../utils/base_class.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  BaseState<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends BaseState<SummaryScreen> {

  bool isLoading = false;
  List<SummaryData> listSummary = [];
  final TextEditingController _summaryController = TextEditingController();


  @override
  void initState() {
    getDocuments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          toolbarHeight: 55,
          leading: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.pop(context);
            },
            child: getBackArrow(),
          ),
          automaticallyImplyLeading: false,
          title: getTitle("Summary",),
          centerTitle: true,
          elevation: 0,
          backgroundColor: white,
        ),
        body: isLoading
            ? LoadingWidget()
            : ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            primary: false,
            padding: EdgeInsets.zero,
            itemCount: listSummary.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(left: 12, right: 12),
                alignment: Alignment.center,
                width: double.infinity,
                color: white,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        _showActionDialog(listSummary[index]);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.only(top: 8, bottom: 8),
                        decoration: const BoxDecoration(color: semiBlue, borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "${index + 1 }. ${listSummary[index].title ?? ""} on ${universalDateConverter("yyyy-MM-dd'T'HH:mm:ss", "dd MMM, yyyy", listSummary[index].addedDate ?? "")}",
                                  style: TextStyle(color: black, fontSize: 14, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Gap(8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Checklist :",style: TextStyle(color: graySemiDark, fontSize: 14, fontWeight: FontWeight.w500),),
                                Gap(12),
                                Text(listSummary[index].checklist ?? "",style: TextStyle(color: black, fontSize: 14, fontWeight: FontWeight.w500),),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
        )
    );
  }

  getDocuments() async {
    if (isOnline) {

      setState(() {
        isLoading = true;
      });

      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);


      final url = Uri.parse(summaryLists);

      Map<String, String> jsonBody = {
        "email": "pratik@coronation.in",
      };

      final response = await http.post(url, body: jsonBody, headers: {
        "Authorization": authHeader,
      });

      final statusCode = response.statusCode;
      final body = response.body;
      Map<String, dynamic> data = jsonDecode(body);
      var dataResponse = SummaryListResponseModel.fromJson(data);


      if (statusCode == 200 && dataResponse.success == true) {
        if (dataResponse.summaryData != null) {
          listSummary = dataResponse.summaryData ?? [];
        }
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      noInterNet(context);
      setState(() {
        isLoading = false;
      });
    }
  }

  _showActionDialog(SummaryData listSummary) {
    showModalBottomSheet(
      context: context,
      backgroundColor: white,
      isScrollControlled: true,
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.80),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14))),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom,),
          child: StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) updateTask) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16,right: 16,bottom: 10,top: 18),
                  child: Wrap(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.all(18),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  listSummary.title ?? "",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: blue,
                                  ),
                                ),
                                // Uncomment to add close icon
                                /*GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          'assets/images/ic_close.png',
                          height: 26,
                          width: 26,
                        ),
                      ),*/
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: HtmlWidget(
                              checkValidString(listSummary.description ?? "")
                                  .replaceAll("\r\n\r\n", "")
                                  .replaceAll("\r\n\t", "")
                                  .replaceAll("\r\n", ""),
                              textStyle: const TextStyle(
                                fontSize: 14,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w400,
                                color: black,
                              ),
                              enableCaching: true,
                              customStylesBuilder: (element) {
                                if (element.styles.contains('font-size')) {
                                  return {
                                    'font-size': '10px',
                                    'background': "transparent",
                                  };
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomRight,
                            margin: const EdgeInsets.only(left: 15, right: 15, bottom: 8, top: 8),
                            child: TextButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    side: const BorderSide(width: 1, color: blue),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all<Color>(white),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                setState(() {});
                              },
                              child: const Text(
                                'Close',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: blue,
                                ),
                              ),
                            ),
                          ),
                          const Gap(40),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }



  @override
  void castStatefulWidget() {
    widget is SummaryScreen;
  }

}