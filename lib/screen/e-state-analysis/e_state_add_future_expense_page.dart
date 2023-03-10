import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp/constant/analysis_api_end_point.dart';
import 'package:superapp/model/CommanResponse.dart';
import '../../constant/colors.dart';
import '../../model/e-state-analysis/aspiration_response_model.dart';
import '../../utils/app_utils.dart';
import '../../utils/base_class.dart';
import '../../widget/loading.dart';

class EStateAddFutureExpensePage extends StatefulWidget {
  final ListData dataGetSet;
  final bool isFromList;

  const EStateAddFutureExpensePage(this.dataGetSet, this.isFromList, {Key? key}) : super(key: key);

  @override
  _EStateAddFutureExpensePageState createState() => _EStateAddFutureExpensePageState();
}

class _EStateAddFutureExpensePageState extends BaseState<EStateAddFutureExpensePage> {
  bool _isLoading = false;

  final TextEditingController _aspirationTypeController = TextEditingController();
  final TextEditingController _startYearController = TextEditingController();
  final TextEditingController _endYearController = TextEditingController();
  final TextEditingController _periodicityController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return Future.value(true);
      },
      child: Scaffold(
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
                            Navigator.pop(context,"success");
                          },
                          child: Container(
                            alignment: Alignment.topLeft,
                            margin: const EdgeInsets.only(right: 8),
                            child: Image.asset('assets/images/fin_plan_ic_back_arrow.png',height: 30, width: 30, color: black,),
                          )),
                      const Expanded(child: Text("Add Future Expense",
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
          body: _isLoading
              ? const LoadingWidget()
              : SafeArea(
            child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(top: 15, left: 12),
                      child: const Text("Enter Following Data:",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16, color: black, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
                      child: TextField(
                        cursorColor: black,
                        controller: _aspirationTypeController,
                        readOnly: true,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
                        decoration: const InputDecoration(
                          hintText: 'Aspiration Type',
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 8, right: 8, top: 10),
                            child: TextField(
                              cursorColor: black,
                              controller: _startYearController,
                              readOnly: true,
                              keyboardType: TextInputType.text,
                              style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
                              decoration: const InputDecoration(
                                hintText: 'Start Year',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 8, right: 8, top: 10),
                            child: TextField(
                              cursorColor: black,
                              controller: _endYearController,
                              readOnly: true,
                              keyboardType: TextInputType.text,
                              style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
                              decoration: const InputDecoration(
                                hintText: 'End Year',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 8, right: 8, top: 10),
                      child: TextField(
                        cursorColor: black,
                        controller: _periodicityController,
                        readOnly: true,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
                        decoration: const InputDecoration(
                          hintText: 'Periodicity',
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 8, right: 8, top: 10),
                      child: TextField(
                        cursorColor: black,
                        controller: _amountController,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
                        decoration: const InputDecoration(
                          hintText: 'Amount',
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: blue,
                            onPrimary: blue,
                            elevation: 0.0,
                            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                            side: const BorderSide(color: blue, width: 1.0, style: BorderStyle.solid),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kButtonCornerRadius)),
                            tapTargetSize: MaterialTapTargetSize.padded,
                            animationDuration: const Duration(milliseconds: 100),
                            enableFeedback: true,
                            alignment: Alignment.center,
                          ),
                          onPressed: () {
                            // if(_nameController.text.isEmpty) {
                            //   setState(() {
                            //     _validateName = false;
                            //     return;
                            //   });
                            // }

                            // else {
                              if(isInternetConnected)
                              {
                                // _saveBrandCall();
                                FocusScope.of(context).unfocus();
                              }
                              else
                              {
                                noInterNet(context);
                              }
                            // }
                          },
                          onLongPress: () => {},
                          child: const Text("Submit",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: white, fontWeight: FontWeight.w600),
                          )
                      ),
                    ),
                  ],
                ),
            ),)

      ),
    );
  }

  @override
  void castStatefulWidget() {
    widget is EStateAddFutureExpensePage;
  }

  //API call func..

  void saveAspirationsFutureExpense() async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL + aspirationsFutureExpenseSave);

    Map<String, String> jsonBody = {
      'user_id': sessionManager.getUserId().toString().trim(),
      'aspiration_type': _aspirationTypeController.value.text.trim(),
      'start_year' : _startYearController.value.text.trim(),
      'end_year' : _endYearController.value.text.trim(),
      'periodicity': _periodicityController.value.text.trim(),
      'amount' : _amountController.value.text.trim(),
      'aspiration_id' : '',

    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = CommanResponse.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      showSnackBar(dataResponse.message, context);

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