import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp/constant/analysis_api_end_point.dart';
import 'package:superapp/screen/e-state-analysis/e_state_add_future_expense_page.dart';
import '../../constant/colors.dart';
import '../../model/e-state-analysis/aspiration_response_model.dart';
import '../../utils/app_utils.dart';
import '../../utils/base_class.dart';
import '../../widget/loading.dart';
import '../../widget/no_data.dart';
import '../../widget/no_internet.dart';

class EStateAspirationPage extends StatefulWidget {
  const EStateAspirationPage({Key? key}) : super(key: key);

  @override
  _EStateAspirationPageState createState() => _EStateAspirationPageState();
}

class _EStateAspirationPageState extends BaseState<EStateAspirationPage> {
  // late User userDataGetSet;
  List<ListData> listAspirationData = List<ListData>.empty();

  bool _isLoading = false;
  var isAddedOrRemovedAspirationFutureExpenses = false;

  @override
  void initState() {
    super.initState();

    if(isInternetConnected) {
      getAspirationFutureExpensesList();
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
                        if(isAddedOrRemovedAspirationFutureExpenses) {
                          Navigator.pop(context,"success");
                        }else {
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(right: 8),
                        child: Image.asset('assets/images/fin_plan_ic_back_arrow.png',height: 30, width: 30, color: black,),
                      )),
                  const Expanded(child: Text("Aspiration/Future Expense",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 16, color: black, fontWeight: FontWeight.w600),
                  )),
                ],
              ),
            ],
          ),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: white,
      ),
      body: isInternetConnected
          ? _isLoading
          ? const LoadingWidget()
          : SafeArea(
        child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: listAspirationData.isEmpty ?
            const Center(
                child: MyNoDataWidget(msg: 'No aspiration/future expense added!')
            )
                :AnimationLimiter(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  primary: false,
                  padding: EdgeInsets.zero,
                  itemCount: listAspirationData.length,
                  itemBuilder: (ctx, index) => AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: (Container(margin: const EdgeInsets.only( top: 5),
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: 0,
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
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Image.asset('assets/images/fin_plan_ic_delete_black.png',height: 30, width: 30, color: black,),
                                        Image.asset('assets/images/fin_plan_ic_edit_gray.png',height: 30, width: 30, color: black,)
                                      ],
                                    ),
                                    const Text("Rent", textAlign: TextAlign.start,
                                      style: TextStyle(fontSize: 14, color: black, fontWeight: FontWeight.bold),
                                    ),
                                    const Gap(6),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Expanded(
                                          flex:4,
                                          child: Text("Amount", textAlign: TextAlign.start,
                                            style: TextStyle(fontSize: 14, color: black, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const Text("  :  ", textAlign: TextAlign.start,
                                          style: TextStyle(fontSize: 14, color: black, fontWeight: FontWeight.w600),
                                        ),
                                        Expanded(
                                          flex:6,
                                          child: Text(checkValidString(getPrice(listAspirationData[index].amount.toString())), textAlign: TextAlign.start,
                                            style: const TextStyle(fontSize: 14, color: black, fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        /*InkWell(
                                          onTap:(){
                                            showBankActionDialog(listAspirationData[index],index);
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(right: 5),
                                            width: 40,
                                            height: 32,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Image.asset('assets/images/ic_more.png',
                                                  color: kTextDarkGray, height: 16, width: 18),
                                            ),
                                          )
                                      ),*/
                                      ],
                                    ),
                                    const Gap(8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Expanded(
                                          flex:4,
                                          child: Text("Periodicity(In Year)", textAlign: TextAlign.start,
                                            style: TextStyle(fontSize: 14, color: black, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const Text("  :  ", textAlign: TextAlign.start,
                                          style: TextStyle(fontSize: 14, color: black, fontWeight: FontWeight.w600),
                                        ),
                                        Expanded(
                                          flex:6,
                                          child: Text(checkValidString(listAspirationData[index].periodicity), textAlign: TextAlign.start,
                                            style: const TextStyle(fontSize: 14, color: black, fontWeight: FontWeight.w400),
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
                                                flex:4,
                                                child: Text("Start Year", textAlign: TextAlign.start,
                                                  style: TextStyle(fontSize: 14, color: black, fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                              const Text("  :  ", textAlign: TextAlign.start,
                                                style: TextStyle(fontSize: 14, color: black, fontWeight: FontWeight.w600),
                                              ),
                                              Expanded(
                                                flex:6,
                                                child: Text(checkValidString(listAspirationData[index].startYear), textAlign: TextAlign.start,
                                                  style: const TextStyle(fontSize: 14, color: black, fontWeight: FontWeight.w400),
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
                                                flex:4,
                                                child: Text("Start Year", textAlign: TextAlign.start,
                                                  style: TextStyle(fontSize: 14, color: black, fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                              const Text("  :  ", textAlign: TextAlign.start,
                                                style: TextStyle(fontSize: 14, color: black, fontWeight: FontWeight.w600),
                                              ),
                                              Expanded(
                                                flex:6,
                                                child: Text(checkValidString(listAspirationData[index].startYear), textAlign: TextAlign.start,
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
                        )),
                      ),
                    ),
                  )
              ),
            )
        ),)
          : const NoInternetWidget(),
      floatingActionButton: //listAspirationData.isNotEmpty ?
      FloatingActionButton(
        onPressed: (){
          _addFutureExpense(context, ListData(), false);
        },
        backgroundColor: blue,
        child: const Icon(Icons.add, color: white,),
      )
            //: Container(),
    );
  }

  void refreshData() {
    _addFutureExpense(context, ListData(), false);
  }

/*  void showBankActionDialog(ListData bank,int index) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      elevation: 5,
      isDismissible: true,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            Padding(padding: const EdgeInsets.all(14),
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(height: 2, width : 40, color: blue, margin: const EdgeInsets.only(bottom:12)),
                    const Text("Select Option",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: black, fontWeight: FontWeight.bold, fontSize: 16),),
                    Container(height: 12),
                    InkWell(
                      onTap: () async {
                        Navigator.pop(context);
                        ListData getSet = listAspirationData[index];
                        _addBank(context, getSet);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 18, right: 18, top: 15, bottom: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Image.asset('assets/images/ic_edit.png', height: 18, width: 18),
                            Container(width: 15),
                            const Text("Edit",
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 15, color: black, fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      color: kLightestGray,
                      height: 1,
                    ),
                    InkWell(
                      onTap: () async {
                        Navigator.pop(context);
                        _openBottomSheetForDeleteProduct(bank,index);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 18, right: 18, top: 15, bottom: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Image.asset('assets/images/ic_delete.png', height: 18, width: 18),
                            Container(width: 15),
                            const Text("Delete",
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 15, color: black, fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(height: 12)
                  ],
                )
            )
          ],
        );
      },
    );
  }*/

  void _openBottomSheetForDeleteProduct(ListData bank,int index) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      elevation: 5,
      isDismissible: true,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 16,
                ),
                Container(height: 2, width: 40, color: blue, margin: const EdgeInsets.only(bottom: 12)),
                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(right: 18),
                  child: GestureDetector(onTap: (){Navigator.pop(context);},child: const Icon(Icons.clear,size: 22)),
                ),
                const Text("Delete Bank",
                    style: TextStyle(
                        color: black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18)),
                Container(
                  height: 20,
                ),
                const Text("Are you sure want to Delete this Bank?",
                    style: TextStyle(
                        color: black,
                        fontWeight: FontWeight.normal,
                        fontSize: 16),
                    textAlign: TextAlign.center),
                Container(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 22, right: 22),
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: blue,
                        onPrimary: blue,
                        elevation: 0.0,
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        tapTargetSize: MaterialTapTargetSize.padded,
                        animationDuration: const Duration(milliseconds: 100),
                        enableFeedback: true,
                        alignment:
                        Alignment.center,
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                        // _makeDeleteBankRequest(bank,index);
                      },
                      //set both onPressed and onLongPressed to null to see the disabled properties
                      child: const Text("Delete",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: white, fontWeight: FontWeight.w600),
                      )),
                ),
                Container(height: 22,),
              ],
            )
          ],
        );
      },
    );
  }

  Future<void> _addFutureExpense(BuildContext context, ListData futureExpense, bool isFromList) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EStateAddFutureExpensePage(futureExpense, isFromList)),
    );
    print("result ===== $result");
    if (result == "success") {
      setState(() {

      });
      getAspirationFutureExpensesList();
    }
  }

  @override
  void castStatefulWidget() {
    widget is EStateAspirationPage;
  }

  //API call func..
  getAspirationFutureExpensesList() async {
    if(isInternetConnected) {
      setState(() {
        _isLoading = true;
      });
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(API_URL + aspirations);

      Map<String, String> jsonBody = {
        'user_id': sessionManager.getUserId().toString().trim(),
      };

      final response = await http.post(url, body: jsonBody);
      final statusCode = response.statusCode;

      final body = response.body;
      Map<String, dynamic> user = jsonDecode(body);
      var dataResponse = AspirationResponseModel.fromJson(user);

      if (statusCode == 200 && dataResponse.success == 1) {

        listAspirationData = [];
        if(dataResponse.aspirations!.listData != null) {
          if(dataResponse.aspirations!.listData!.isNotEmpty) {

            listAspirationData = dataResponse.aspirations!.listData!;
          }
        }


        if(listAspirationData.isEmpty) {
          // _addBank(context, Bank());

          Timer(const Duration(seconds: 2), () =>
              setState(() {
                _isLoading = false;
                // _isNoDataVisible = false;
              })
          );
        }else {
          Timer(const Duration(seconds: 2), () =>
              setState(() {
                _isLoading = false;
                // _isNoDataVisible = true;
              })
          );
        }

        setState(() {
          isAddedOrRemovedAspirationFutureExpenses = true;
        });
        // print("listAspirationData.length 2==>" + listAspirationData.length.toString());

      } else {
        // _addBank(context, Bank());
        Timer(const Duration(seconds: 2), () =>
            setState(() {
              listAspirationData = [];
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

/*
  _makeDeleteBankRequest(Bank bank,int index) async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(BASE_URL + deleteBankDetail);

    Map<String, String> jsonBody = {
      'bank_id': bank.bankId.toString().trim(),
      'user_id': sessionManager.getUserId().toString(),
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = CommonResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      showSnackBar(dataResponse.message, context);

      setState(() {
        isAddedOrRemovedBank = true;
        listAspirationData.removeAt(index);
        _isLoading = false;
      });

    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }
*/
}