import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/model/consolidated-portfolio/ApplicantResponseModel.dart';
import 'package:superapp_flutter/model/consolidated-portfolio/LatestTransactionResponse.dart';
import 'package:superapp_flutter/utils/app_utils.dart';
import '../../common_widget/common_widget.dart';
import '../../constant/colors.dart';
import '../../constant/consolidate-portfolio/api_end_point.dart';
import '../../model/consolidated-portfolio/NetworthResponseModel.dart';
import '../../utils/base_class.dart';
import '../../widget/loading.dart';
import '../../widget/no_data.dart';

class CPLatestTransactionPage extends StatefulWidget {
  const CPLatestTransactionPage({Key? key}) : super(key: key);

  @override
  BaseState<CPLatestTransactionPage> createState() =>
      CPLatestTransactionPageState();
}

class CPLatestTransactionPageState extends BaseState<CPLatestTransactionPage> {
  bool _isLoading = false;
  List<TransactionDetails> listDataMainHoldingData = [];
  List<TransactionDetails> listData = [];
  List<String> listApplicants = [];
  String selectedApplicant = "";

  @override
  void initState() {
    super.initState();
    _getLatestTransactionData();


    if ((sessionManagerPMS.getApplicantsList() != null))
    {
      if (sessionManagerPMS.getApplicantsList().isNotEmpty ?? false)
      {
        listApplicants = [];
        listApplicants.addAll(sessionManagerPMS.getApplicantsList() ?? []);

        if (listApplicants.isNotEmpty)
        {
          selectedApplicant = listApplicants[0] ?? '';
        }

        print((listApplicants.length));
      }
      else
      {
        listApplicants = [];
      }
    }
    else
    {
      listApplicants = [];
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 60,
          automaticallyImplyLeading: false,
          backgroundColor: appBg,
          elevation: 0,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: getBackArrow(),
          ),
          titleSpacing: 0,
          title: getTitle("Last Month Transactions",)
      ),
      backgroundColor: const Color(0XffEDEDEE),
      body: SafeArea(
        bottom: false,
        child: _isLoading
            ? const LoadingWidget()
            : Container(
                margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.only(left: 6, right: 6),
              child: Column(
                children: [
                  Visibility(
                    visible: listApplicants.length > 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Select Holder - ",style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 16),),
                        Container(
                          margin: const EdgeInsets.only(top: 12,bottom: 12),
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: Wrap(
                            children: [
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  openApplicantSelection();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(selectedApplicant,style: const TextStyle(color: blue,fontSize: 16,fontWeight: FontWeight.w600),),
                                      const Icon(Icons.keyboard_arrow_down_outlined),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: listData.isNotEmpty
                        ? Column(
                          children: [
                              Container(
                                padding: const EdgeInsets.only(left: 8,right: 8,top: 14,bottom: 14),
                                decoration: const BoxDecoration(
                                    color:semiBlue,
                                    borderRadius: BorderRadius.only(topLeft:Radius.circular(8),topRight: Radius.circular(8))),
                                child: const Row(
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: Text('Fund Name',
                                            style: TextStyle(
                                                color: blue,
                                                fontSize: 16,
                                                fontWeight:
                                                FontWeight.w600))),
                                    Expanded(
                                        flex: 1,
                                        child: Text('Type',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: blue,
                                                fontSize: 16,
                                                fontWeight:
                                                FontWeight.w600))),
                                    Expanded(
                                        flex: 1,
                                        child: Text('Tran Date',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: blue,
                                                fontSize: 16,
                                                fontWeight:
                                                FontWeight.w600))),
                                    Expanded(
                                        flex: 1,
                                        child: Text('Amount',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: blue,
                                                fontSize: 16,
                                                fontWeight:
                                                FontWeight.w600))),
                                  ],
                                ),
                              ),
                              _itemList(),
                            const Gap(22),
                            ]
                          )
                        : const MyNoDataWidget(msg: "No data found."),
                  ),
                ],
              ),
            ),
      ),
    );
  }

  Widget _itemList() {
    return Expanded(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          primary: false,
          padding: EdgeInsets.zero,
          itemCount: listData.length,
          itemBuilder: (ctx, index) => (Container(
                alignment: Alignment.center,
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 8,right: 8,top: 14,bottom: 14),
                      decoration: BoxDecoration(
                          color: index % 2 == 0 ? white : semiBlue,
                          borderRadius: index == listData.length - 1 ? const BorderRadius.only(bottomLeft:Radius.circular(8),bottomRight: Radius.circular(8)) : const BorderRadius.all(Radius.circular(0))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          listData[index].schemeName == "Total"
                              ? Row(
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: Text(
                                            toDisplayCase(listData[index]
                                                .schemeName
                                                .toString()),
                                            style: const TextStyle(
                                                color: black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700))),
                                    const Expanded(
                                        flex: 1,
                                        child: Text("",
                                            style: TextStyle(
                                                color: black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w200))),
                                    const Expanded(
                                        flex: 1,
                                        child: Text("",
                                            style: TextStyle(
                                                color: black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w200))),
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                            convertCommaSeparatedAmount(listData[index].amount.toString()),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700))),
                                  ],
                                )
                              : Row(
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: Text(
                                            toDisplayCase(listData[index]
                                                .schemeName
                                                .toString()),
                                            style: const TextStyle(
                                                color: black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700))),
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                            listData[index].type.toString(),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w200))),
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                            listData[index].tranDate.toString(),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w200))),
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                            convertCommaSeparatedAmount(listData[index].amount.toString()),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w200))),
                                  ],
                                ),
                        ],
                      ),
                    )
                  ],
                ),
              ))),
    );
  }

  _getLatestTransactionData() async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_CP + latestTransaction);
    Map<String, String> jsonBody = {
      'user_id': sessionManagerPMS.getUserId().trim(),
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = LatestTransactionResponse.fromJson(user);

    try {
      if (statusCode == 200 && dataResponse.success == 1) {
        try {
          if (dataResponse.transactionDetails != null) {
            listDataMainHoldingData = dataResponse.transactionDetails ?? [];
            listData = [];
            if (selectedApplicant.toLowerCase() == "all")
              {
                listData = listDataMainHoldingData;
              }
            else
              {
                num totalAmount = 0;
                for (var i=0; i < listDataMainHoldingData.length; i++)
                {
                  if (listDataMainHoldingData[i].applicant == selectedApplicant)
                  {

                    print("AMOUNT ==== ${listDataMainHoldingData[i].amount ?? 0}");

                    totalAmount += listDataMainHoldingData[i].amount ?? 0;
                    listData.add(listDataMainHoldingData[i]);
                  }
                }

                listData.add(TransactionDetails(schemeName: 'Total',amount: totalAmount,type: '',nav: 0,tranDate: ''));

              }
            setState(() {
              _isLoading = false;
            });
          }
        } catch (e) {
          setState(() {
            _isLoading = false;
          });
          if (kDebugMode) {
            print(e);
          }
        }
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } on Exception catch (e) {
        setState(() {
          _isLoading = false;
        });
    }
  }

  void openApplicantSelection() {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: white,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context, StateSetter setStatenew) {
            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 22),
              child: Wrap(
                children: <Widget>[

                  Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Select Holder",style: TextStyle(color: blue,fontSize: 18,fontWeight: FontWeight.w600),)
                        ],
                      ),
                      const Gap(22),
                      ListView.builder(
                        itemCount: listApplicants.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              Navigator.pop(context);
                              setState(() {
                                selectedApplicant = listApplicants[index] ?? '';

                                listData = [];

                                print(selectedApplicant);

                                if (selectedApplicant.toLowerCase() == "all")
                                {
                                  listData = listDataMainHoldingData;
                                }
                                else
                                {
                                  num totalAmount = 0;
                                  for (var i=0; i < listDataMainHoldingData.length; i++)
                                  {
                                    if (listDataMainHoldingData[i].applicant == selectedApplicant)
                                    {

                                      print("AMOUNT ==== ${listDataMainHoldingData[i].amount ?? 0}");

                                      totalAmount += listDataMainHoldingData[i].amount ?? 0;
                                      listData.add(listDataMainHoldingData[i]);
                                    }
                                  }

                                  listData.add(TransactionDetails(schemeName: 'Total',amount: totalAmount,type: '',nav: 0,tranDate: ''));

                                }

                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(listApplicants[index] ?? '',style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: blue),),
                                ),
                                const Divider(color: graySemiDark,thickness: 0.6,height: 0.6,)
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            );
          });
        }
    );
  }

  @override
  void castStatefulWidget() {
    widget is CPLatestTransactionPage;
  }
}
