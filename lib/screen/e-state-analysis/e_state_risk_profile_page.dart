import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/constant/analysis_api_end_point.dart';
import 'package:superapp_flutter/model/e-state-analysis/risk_profile_question_response_model.dart';
import 'package:superapp_flutter/model/e-state-analysis/risk_profile_save_response_model.dart';
import '../../common_widget/common_widget.dart';
import '../../constant/colors.dart';
import '../../model/CommanResponse.dart';
import '../../utils/app_utils.dart';
import '../../utils/base_class.dart';
import '../../widget/loading.dart';
import '../../widget/no_internet.dart';


class EStateRiskProfilePage extends StatefulWidget {
  const EStateRiskProfilePage({Key? key}) : super(key: key);

  @override
  _EStateRiskProfilePageState createState() => _EStateRiskProfilePageState();
}

class _EStateRiskProfilePageState extends BaseState<EStateRiskProfilePage> {
  List<RiskProfilerQuestions> listData = List<RiskProfilerQuestions>.empty();

  bool _isLoading = false;
  PageController controller = PageController();
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();

    if(isOnline) {
      getListData();
    }else{
      noInterNet(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    ListView _answersOptions(int index) {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: listData[index].answers!.length,
        itemBuilder: (context, i) {
          return Wrap(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: (){
                  setState(() {
                    for (var z=0; z < listData[index].answers!.length; z++) {
                      if (z == i) {
                        listData[index].answers![z].isSelected = true;
                      }else {
                        listData[index].answers![z].isSelected = false;
                      }
                    }
                  });
                },
                child: Container(
                  width: size.width,
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20, top: 8),
                        child: listData[index].answers![i].isSelected ?? false
                            ? Image.asset("assets/images/ic_radio_selected.png", width: 18, height: 18, color: blue)
                            : Image.asset("assets/images/ic_radio_unselected.png", width: 18, height: 18, color: blue),
                      ),
                      Flexible(
                        child: Container(
                          width: size.width,
                          margin: const EdgeInsets.only(left: 15, right: 12 ,top: 8),
                          child: Text(listData[index].answers![i].answer.toString(),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(color: grayDark, fontSize: 15, fontWeight: FontWeight.w500)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      );
    }

    final pages = List.generate(
      listData.length,
        (index) => Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 5),
              child: const Text("Enter Following Data:",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18, color: black, fontWeight: FontWeight.w600),
              ),
            ),
            Flexible(
              child: Container(
                margin: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 15),
                child: Text(
                  textAlign: TextAlign.start,
                  listData[index].question.toString(),
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: black),
                ),
              ),
            ),
            _answersOptions(index)
        ],
      )
    );

    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          toolbarHeight: 55,
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: getBackArrow(),
          ),
          title: getTitle("Find Risk Profile",),
          centerTitle: true,
          elevation: 0,
          backgroundColor: white,
        ),
        body: isOnline
            ? _isLoading
            ? const LoadingWidget()
            :  SafeArea(
                child: Column(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(top: 10, right: 14, left: 14),
                        padding: const EdgeInsets.all(10),
                        child: PageView.builder(
                          controller: controller,
                          itemCount: listData.length,
                          physics: const NeverScrollableScrollPhysics(),
                          onPageChanged: (index) {
                            setState(() {
                              _currentPageIndex = index;
                            });
                          },
                          itemBuilder: (_, index) {
                            return pages[index % pages.length];
                          },
                        ),
                      ),
                    ),
                    setUpButton()
                  ],
                ),
              )
            : NoInternetWidget(() {
          if(isOnline) {
            getListData();
          }else{
            noInterNet(context);
          }
            },),
    );
  }

  Widget setUpButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Visibility(
          visible: _currentPageIndex == 0 ? false : true,
          child: Container(
            margin: const EdgeInsets.only(top: 14, left: 15),
            // padding: const EdgeInsets.all(15),
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: () {
                controller.jumpToPage(_currentPageIndex - 1);
              },
              child: Container(
                decoration: BoxDecoration(color: grayLight,
                    borderRadius: BorderRadius.circular(10.0)),
                padding: const EdgeInsets.all(10),
                height: 42,
                child: const Text("Previous",
                  style: TextStyle(color: white, fontWeight: FontWeight.w400, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 12),
          padding: const EdgeInsets.all(12),
          alignment: Alignment.bottomLeft,
          child: InkWell(
            onTap: () {
              if (checkIsAnyAnswerSelected(_currentPageIndex)) {
                if (_currentPageIndex == listData.length - 1) {
                  try {
                    var ansId = getAnswerIds();
                    print("<><> Answer Ids : " + ansId + " <><>");

                    if(isOnline) {
                      saveDetails(ansId);
                    }else{
                      noInterNet(context);
                    }
                  }
                  catch (e)
                  {
                    print(e);
                  }
                }
                else
                {
                  controller.jumpToPage(_currentPageIndex + 1);
                }

              }else {
                showSnackBar("Please select at least one answer!", context);
              }

            },
            child: Container(
              decoration:
              /* _currentPageIndex + 1 ==
                  listData.length
                  ? BoxDecoration(
                  color: kLightPurple,
                  borderRadius:
                  BorderRadius.circular(20.0)) :*/
              BoxDecoration(
                color: blue,
                borderRadius: BorderRadius.circular(12.0)
              ),
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
              height: 42,
              child: Text(_currentPageIndex + 1 == listData.length ? "Calculate Risk Profile" : "Next",
                style: const TextStyle(color: white, fontWeight: FontWeight.w400, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )
      ],
    );
  }

  bool checkIsAnyAnswerSelected(int currentItem) {
    var isSelect = false;
    try
    {
      for (var i in listData[currentItem].answers ?? []) {
        if(i.isSelected) {
          isSelect = true;
          break;
        }
      }
    }
    catch (e)
    {
      print(e);
    }

    return isSelect;

  }

  String getAnswerIds() {
    var ansIds = "";

    try
    {
      for (var i=0; i < listData.length; i++)
      {
        for (var j=0; j < listData[i].answers!.length; j++)
        {
          if (listData[i].answers![j].isSelected ?? false)
          {
            if (ansIds.isEmpty)
            {
              ansIds = listData[i].answers![j].answerId.toString();
            }
            else
            {
              ansIds = "$ansIds,${listData[i].answers![j].answerId}";
            }
          }
        }
      }
    }
    catch (e)
    {
      print(e);
    }

    return ansIds;
  }
  
  @override
  void castStatefulWidget() {
    widget is EStateRiskProfilePage;
  }

  //API call func..
  void getListData() async {
    if(isOnline) {
      setState(() {
        _isLoading = true;
      });
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(API_URL_ANALYSIS + riskProfiler);

      final response = await http.get(url);
      final statusCode = response.statusCode;

      final body = response.body;
      Map<String, dynamic> user = jsonDecode(body);
      var dataResponse = RiskProfileQuestionResponseModel.fromJson(user);

      if (statusCode == 200 && dataResponse.success == 1) {

        listData = [];
        if(dataResponse.riskProfilerQuestions != null) {
          if(dataResponse.riskProfilerQuestions!.isNotEmpty) {
            listData = dataResponse.riskProfilerQuestions!;
          }
        }

        setState(() {
          _isLoading = false;
        });
        // print("listData.length 2==>" + listData.length.toString());

      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(dataResponse.message, context);
      }
    }else {
      setState(() {
        _isLoading = false;
      });
      noInterNet(context);
    }
  }

   saveDetails(String ids) async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_ANALYSIS + getRiskProfile);

    Map<String, String> jsonBody = {
      'user_id': sessionManager.getUserId().toString().trim(),
      'answer_ids': ids
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = RiskProfileSaveResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      showSnackBar("Your Risk Profile is ${dataResponse.riskProfile}", context);

      sessionManager.setRiskProfile(checkValidString(dataResponse.riskProfile.toString().trim()));

      Navigator.pop(context, "success");

      setState(() {
        _isLoading = false;
      });

    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

}