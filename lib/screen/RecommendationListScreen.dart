import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/constant/api_end_point.dart';
import 'package:superapp_flutter/widget/loading.dart';
import 'package:superapp_flutter/widget/no_data.dart';

import '../../common_widget/common_widget.dart';
import '../../constant/colors.dart';
import '../../model/GetDocumentsResponseModel.dart';
import '../../model/SummaryListResponseModel.dart';
import '../../utils/app_utils.dart';
import '../../utils/base_class.dart';
import '../model/RecommendationListResponseModel.dart';

class RecommendationListScreen extends StatefulWidget {
  const RecommendationListScreen({super.key});

  @override
  BaseState<RecommendationListScreen> createState() => _RecommendationListScreenState();
}

class _RecommendationListScreenState extends BaseState<RecommendationListScreen> {

  bool isLoading = false;
  bool _isLoadingMore = false;
  bool _isLastPage = false;
  bool isScrollingDown = false;

  ScrollController _scrollViewController = ScrollController();

  int _pageIndex = 0;
  final int _pageResult = 20;

  List<RecommendationData> listRecommendationData = [];

  @override
  void initState() {
    fetchRecommendationList(true);
    //getDocuments();
    _scrollViewController = ScrollController();
    _scrollViewController.addListener(() {

      if (_scrollViewController.position.userScrollDirection == ScrollDirection.reverse)
      {
        if (!isScrollingDown)
        {
          isScrollingDown = true;
          setState(() {});
        }
      }
      if (_scrollViewController.position.userScrollDirection == ScrollDirection.forward)
      {
        if (isScrollingDown)
        {
          isScrollingDown = false;
          setState(() {});
        }
      }
      pagination();
    });
    super.initState();
  }

  void pagination() {
    if (!_isLastPage && !_isLoadingMore)
    {
      if ((_scrollViewController.position.pixels == _scrollViewController.position.maxScrollExtent))
      {
        setState(() {
          _isLoadingMore = true;
          fetchRecommendationList(false);
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          toolbarHeight: 0,
          automaticallyImplyLeading: false,
          title: const Text(""),
          centerTitle: false,
          elevation: 0,
          backgroundColor: white,
        ),
        body: isLoading
            ? LoadingWidget() :
        listRecommendationData.isEmpty ? MyNoDataWidget(msg: "No Data Found")
            : ListView.builder(
          controller: _scrollViewController,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          primary: false,
          padding: EdgeInsets.zero,
          itemCount: listRecommendationData.length,
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
                      _showActionDialog(listRecommendationData[index]);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.only(top: 8, bottom: 8),
                      decoration: const BoxDecoration(color: semiBlue, borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${index + 1 }.  ",
                            style: TextStyle(color: black, fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          Expanded(
                            child: Text(
                              "${listRecommendationData[index].title ?? ""} on ${universalDateConverter("yyyy-MM-dd'T'HH:mm:ss", "dd MMM, yyyy", listRecommendationData[index].addedDate ?? "")}",
                              style: TextStyle(color: black, fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ),
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

  fetchRecommendationList(bool isFirstTime) async{
    if(isOnline)
    {
      if(isFirstTime)
      {
        setState(() {
          isLoading = true;
          _isLoadingMore = false;
          _pageIndex = 1;
          _isLastPage = false;
        });
      }

      try
      {
        HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
          HttpLogger(logLevel: LogLevel.BODY),
        ]);
        final url = Uri.parse(RecommendationLists);
        Map<String, String> jsonBody = {
          "pan_card": sessionManagerPMS.getPanCard(),
          "first_name": "${sessionManagerPMS.getFirstName()} ${sessionManagerPMS.getLastName()}",
          "fromdate": '',
          "todate": '',
          "pageindex": _pageIndex.toString(),
          "pagesize": _pageResult.toString()
        };
        final response = await http.post(url, body: jsonBody, headers: {"Authorization": authHeader,});
        final statusCode = response.statusCode;
        final body = response.body;
        Map<String, dynamic> data = jsonDecode(body);
        var dataResponse = RecommendationListResponseModel.fromJson(data);

        if (statusCode == 200 && dataResponse.success == true)
        {
          if(dataResponse.recommendationData?.isNotEmpty ?? false)
          {

            List<RecommendationData>? tempList = [];
            tempList = dataResponse.recommendationData ?? [];
            listRecommendationData.addAll(tempList);

            if (tempList.isNotEmpty)
            {
              _pageIndex += 1;
              if (tempList.isEmpty || tempList.length % _pageResult != 0)
              {
                _isLastPage = true;
              }
            }
          }
          else
          {
            listRecommendationData = [];
          }
        }
      }
      catch(e)
      {
        print("Failed to fetch recommendation list : $e");
      }
      finally
      {
        setState(() {
          isLoading = false;
          _isLoadingMore = false;
        });
      }
    }
    else
    {
      noInterNet(context);
    }
  }

  getDocuments() async {
    if (isOnline) {

      setState(() {
        isLoading = true;
      });

      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);


      final url = Uri.parse(RecommendationLists);

      Map<String, String> jsonBody = {
        "email": "pratik@coronation.in",
      };

      final response = await http.post(url, body: jsonBody, headers: {
        "Authorization": authHeader,
      });

      final statusCode = response.statusCode;
      final body = response.body;
      Map<String, dynamic> data = jsonDecode(body);
      var dataResponse = RecommendationListResponseModel.fromJson(data);


      if (statusCode == 200 && dataResponse.success == true) {
        if (dataResponse.recommendationData != null) {
          listRecommendationData = dataResponse.recommendationData ?? [];
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

  _showActionDialog(RecommendationData listRecommendationData) {
    showModalBottomSheet(
      context: context,
      backgroundColor: white,
      isScrollControlled: true,
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.80),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14))),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom,),
            child: StatefulBuilder(
              builder: (BuildContext context, void Function(void Function()) updateTask) {
                return SingleChildScrollView(
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
                                Expanded(
                                  child: Text(
                                    "${listRecommendationData.title} - ${universalDateConverter("yyyy-MM-dd'T'HH:mm:ss", "dd MMM, yyyy", listRecommendationData.addedDate ?? "")}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: blue,
                                    ),
                                  ),
                                ),
                                const Gap(16),
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Image.asset(
                                    "assets/images/ic_close.png",
                                    height: 24,
                                    width: 24,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: HtmlWidget(
                              checkValidString(listRecommendationData.description ?? "")
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
                          const Gap(20),

                          /*Container(
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
                          const Gap(40),*/
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }


  @override
  void castStatefulWidget() {
    widget is RecommendationListScreen;
  }

}