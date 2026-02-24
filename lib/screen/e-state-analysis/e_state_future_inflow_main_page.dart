import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/constant/analysis_api_end_point.dart';
import 'package:superapp_flutter/model/CommanResponse.dart';
import 'package:superapp_flutter/model/e-state-analysis/future_inflow_list_reponse_model.dart';
import 'package:superapp_flutter/model/e-state-analysis/future_inflow_main_list_response_model.dart';
import 'package:superapp_flutter/screen/e-state-analysis/e_state_add_future_expense_page.dart';
import 'package:superapp_flutter/screen/e-state-analysis/e_state_future_inflow_page.dart';
import '../../common_widget/common_widget.dart';
import '../../constant/api_end_point.dart';
import '../../constant/colors.dart';
import '../../model/e-state-analysis/aspiration_response_model.dart';
import '../../utils/app_utils.dart';
import '../../utils/base_class.dart';
import '../../widget/loading.dart';
import '../../widget/no_data.dart';
import '../../widget/no_internet.dart';
import 'e_state_add_future_inflow_page.dart';

class EStateFutureInflowMainPage extends StatefulWidget {
  const EStateFutureInflowMainPage({Key? key}) : super(key: key);

  @override
  _EStateFutureInflowMainPageState createState() => _EStateFutureInflowMainPageState();
}

class _EStateFutureInflowMainPageState extends BaseState<EStateFutureInflowMainPage> {
  List<ListMainInflow> listData = List<ListMainInflow>.empty();
  FutureInflowMainListResponseModel futureInflowMainListResponseModel = FutureInflowMainListResponseModel();
  bool _isLoading = false;

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
          title: getTitle("Future Inflow",),
          actions: [
            Visibility(
              visible: false,
              child: InkWell(
                onTap: () {
                  _redirectToNextPage(context, true);
                },
                child: Container(
                  alignment: Alignment.center,
                  child: const Text("Add/Edit",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 15, color: black, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
            Gap(12)
          ],
          centerTitle: true,
          elevation: 0,
          backgroundColor: white,
        ),
        body: isOnline
            ? _isLoading
            ? const LoadingWidget()
            : SafeArea(
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: listData.isEmpty ?
                const Center(
                    child: MyNoDataWidget(msg: 'No future inflow data found!')
                )
                    :AnimationLimiter(
                  child: Column(
                    children: [


                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        /*decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:Border.all(color: grayLight, width: 1,)
                            ),*/
                        child: Card(
                          color: blue,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Inflation Adjusted", textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: 15, color: gray, fontWeight: FontWeight.bold),
                                  ),
                                  const Gap(6),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Expanded(
                                        flex:5,
                                        child: Text("Income", textAlign: TextAlign.start,
                                          style: TextStyle(fontSize: 14, color: gray, fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      const Text("  :  ", textAlign: TextAlign.start,
                                        style: TextStyle(fontSize: 14, color: white, fontWeight: FontWeight.w600),
                                      ),
                                      Expanded(
                                        flex:5,
                                        child: Text(checkValidString(getPrice(futureInflowMainListResponseModel.futureInflow!.total!.inflationAdjustedIncome.toString())), textAlign: TextAlign.start,
                                          style: const TextStyle(fontSize: 14, color: white, fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Gap(8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Expanded(
                                        flex:5,
                                        child: Text("PV of Income", textAlign: TextAlign.start,
                                          style: TextStyle(fontSize: 14, color: gray, fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      const Text("  :  ", textAlign: TextAlign.start,
                                        style: TextStyle(fontSize: 14, color: white, fontWeight: FontWeight.w600),
                                      ),
                                      Expanded(
                                        flex:5,
                                        child: Text(checkValidString(getPrice(futureInflowMainListResponseModel.futureInflow!.total!.pvOfIncome.toString())), textAlign: TextAlign.start,
                                          style: const TextStyle(fontSize: 14, color: white, fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          primary: false,
                          padding: EdgeInsets.zero,
                          itemCount: listData.length,
                          itemBuilder: (ctx, index) => AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  /*decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border:Border.all(color: grayLight, width: 1,)
                                ),*/
                                  child: Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        width: double.infinity,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(checkValidString(listData[index].source.toString()), textAlign: TextAlign.start,
                                              style: const TextStyle(fontSize: 15, color: black, fontWeight: FontWeight.bold),
                                            ),
                                            const Gap(6),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Expanded(
                                                  flex:5,
                                                  child: Text("Amount", textAlign: TextAlign.start,
                                                    style: TextStyle(fontSize: 14, color: graySemiDark, fontWeight: FontWeight.w600),
                                                  ),
                                                ),
                                                const Text("  :  ", textAlign: TextAlign.start,
                                                  style: TextStyle(fontSize: 14, color: graySemiDark, fontWeight: FontWeight.w600),
                                                ),
                                                Expanded(
                                                  flex:5,
                                                  child: Text(checkValidString(getPrice(listData[index].amount.toString())), textAlign: TextAlign.start,
                                                    style: const TextStyle(fontSize: 14, color: black, fontWeight: FontWeight.w600),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Gap(8),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Expanded(
                                                  flex:5,
                                                  child: Text("Expected Growth(In %)", textAlign: TextAlign.start,
                                                    style: TextStyle(fontSize: 14, color: graySemiDark, fontWeight: FontWeight.w600),
                                                  ),
                                                ),
                                                const Text("  :  ", textAlign: TextAlign.start,
                                                  style: TextStyle(fontSize: 14, color: graySemiDark, fontWeight: FontWeight.w600),
                                                ),
                                                Expanded(
                                                  flex:5,
                                                  child: Text(checkValidString(listData[index].expectedGrowth), textAlign: TextAlign.start,
                                                    style: const TextStyle(fontSize: 14, color: black, fontWeight: FontWeight.w600),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Gap(8),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Expanded(
                                                  flex:5,
                                                  child: Text("PV of Income", textAlign: TextAlign.start,
                                                    style: TextStyle(fontSize: 14, color: graySemiDark, fontWeight: FontWeight.w600),
                                                  ),
                                                ),
                                                const Text("  :  ", textAlign: TextAlign.start,
                                                  style: TextStyle(fontSize: 14, color: graySemiDark, fontWeight: FontWeight.w600),
                                                ),
                                                Expanded(
                                                  flex:5,
                                                  child: Text(checkValidString(listData[index].pvOfIncome), textAlign: TextAlign.start,
                                                    style: const TextStyle(fontSize: 14, color: black, fontWeight: FontWeight.w600),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Gap(8),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Expanded(
                                                  flex:5,
                                                  child: Text("Inflation Adjustment", textAlign: TextAlign.start,
                                                    style: TextStyle(fontSize: 14, color: graySemiDark, fontWeight: FontWeight.w600),
                                                  ),
                                                ),
                                                const Text("  :  ", textAlign: TextAlign.start,
                                                  style: TextStyle(fontSize: 14, color: graySemiDark, fontWeight: FontWeight.w600),
                                                ),
                                                Expanded(
                                                  flex:5,
                                                  child: Text(checkValidString(listData[index].inflationAdjustedIncome), textAlign: TextAlign.start,
                                                    style: const TextStyle(fontSize: 14, color: black, fontWeight: FontWeight.w600),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Gap(8),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      const Expanded(
                                                        flex:5,
                                                        child: Text("Start Year", textAlign: TextAlign.start,
                                                          style: TextStyle(fontSize: 14, color: graySemiDark, fontWeight: FontWeight.w600),
                                                        ),
                                                      ),
                                                      const Text("  :  ", textAlign: TextAlign.start,
                                                        style: TextStyle(fontSize: 14, color: graySemiDark, fontWeight: FontWeight.w600),
                                                      ),
                                                      Expanded(
                                                        flex:5,
                                                        child: Text(checkValidString(listData[index].startYear), textAlign: TextAlign.start,
                                                          style: const TextStyle(fontSize: 14, color: black, fontWeight: FontWeight.w600),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      const Expanded(
                                                        flex:5,
                                                        child: Text("End Year", textAlign: TextAlign.start,
                                                          style: TextStyle(fontSize: 14, color: graySemiDark, fontWeight: FontWeight.bold),
                                                        ),
                                                      ),
                                                      const Text("  :  ", textAlign: TextAlign.start,
                                                        style: TextStyle(fontSize: 14, color: graySemiDark, fontWeight: FontWeight.w600),
                                                      ),
                                                      Expanded(
                                                        flex:5,
                                                        child: Text(checkValidString(listData[index].endYear), textAlign: TextAlign.start,
                                                          style: const TextStyle(fontSize: 14, color: black, fontWeight: FontWeight.w400),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            // const Divider(height: 0.5, color: kLightGray, thickness: 1,)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                      ),
                    ],
                  ),
                )
            ),
          ),)
            : NoInternetWidget(() {
          if(isOnline) {
            getListData();
          }else{
            noInterNet(context);
          }
            },),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            _redirectToNextPage(context, true);
          },
          backgroundColor: blue,
          child: const Icon(Icons.add, color: white,),
        )
    );
  }

  void deleteListData(ListMainInflow listMainInflow, int index) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      builder: (BuildContext context) {
        return Wrap(
          children: [
            Container(
              margin: const EdgeInsets.all(15),
              decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                  color: white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 2,
                    width: 40,
                    alignment: Alignment.center,
                    color: black,
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      child: const Text('Delete?', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: black))),
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 15),
                    child: const Text('Are you sure you want to delete this entry?',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: black)),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15, bottom: 12, top: 20),
                    child: Row(
                      children: [
                        Expanded(
                            child: SizedBox(
                                height: kButtonHeight,
                                child: TextButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          side: const BorderSide(width: 1, color: blue),
                                          borderRadius: BorderRadius.circular(kBorderRadius),
                                        ),
                                      ),
                                      backgroundColor: MaterialStateProperty.all<Color>(white)),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancel", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: blue)),
                                ))),
                        const Gap(20),
                        Expanded(
                          child: SizedBox(
                            height: kButtonHeight,
                            child: TextButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(kBorderRadius),
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all<Color>(blue)),
                              onPressed: () {
                                Navigator.pop(context);
                                setState(() {
                                  deleteData( index);
                                });
                              },
                              child: const Text("Delete", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: white)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(30)
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _redirectToNextPage(BuildContext context, bool isFromMainList) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EStateFutureInflowPage(isFromMainList)),
    );
    print("result ===== $result");
    if (result == "success") {
      setState(() {

      });
      getListData();
    }
  }

  @override
  void castStatefulWidget() {
    widget is EStateFutureInflowMainPage;
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

      final url = Uri.parse(API_URL_ANALYSIS + futureInflowMainList);

      Map<String, String> jsonBody = {
        'user_id': sessionManager.getUserId().toString().trim(),
      };

      final response = await http.post(url, body: jsonBody);
      final statusCode = response.statusCode;

      final body = response.body;
      Map<String, dynamic> user = jsonDecode(body);
      var dataResponse = FutureInflowMainListResponseModel.fromJson(user);

      if (statusCode == 200 && dataResponse.success == 1) {
        futureInflowMainListResponseModel = dataResponse;
        listData = [];
        if(dataResponse.futureInflow!.listMainInflow != null) {
          if(dataResponse.futureInflow!.listMainInflow!.isNotEmpty) {
            listData = dataResponse.futureInflow!.listMainInflow!;
          }
        }

        if(listData.isEmpty) {
          setState(() {
            _isLoading = false;
            // _isNoDataVisible = false;
          });
        }else {
          setState(() {
            _isLoading = false;
            // _isNoDataVisible = false;
          });
        }

        setState(() {
        });
        // print("listData.length 2==>" + listData.length.toString());

      } else {
        // _addBank(context, Bank());
        Timer(const Duration(seconds: 2), () =>
            setState(() {
              listData = [];
              _isLoading = false;
              // _isNoDataVisible = true;
            })
        );
        showSnackBar(dataResponse.message, context);
      }
    }else {
      noInterNet(context);
    }
  }

  void deleteData(int index) async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_ANALYSIS + futureInflowDelete);

    Map<String, String> jsonBody = {
      'future_inflow_id': listData[index].futureInflowId.toString(),
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = CommanResponse.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      showSnackBar(dataResponse.message, context);
      deleteModule();
      setState(() {
        listData.removeAt(index);
        _isLoading = false;
      });

    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void deleteModule() async {

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_ADD + add);

    Map<String, String> jsonBody = {
      'module':"delete-future_inflow",
      'user_id':sessionManagerPMS.getUserId().toString().trim(),
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = CommanResponse.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {

    } else {

    }
  }


}