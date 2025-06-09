import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/model/consolidated-portfolio/CapitalGainResponse.dart';
import 'package:superapp_flutter/utils/app_utils.dart';
import '../../common_widget/common_widget.dart';
import '../../constant/colors.dart';
import '../../constant/consolidate-portfolio/api_end_point.dart';
import '../../utils/base_class.dart';
import '../../widget/loading.dart';
import '../../widget/no_data.dart';

class CPCapitalGainPage extends StatefulWidget {
  const CPCapitalGainPage({super.key});

  @override
  BaseState<CPCapitalGainPage> createState() => CPCapitalGainPageState();
}

class CPCapitalGainPageState extends BaseState<CPCapitalGainPage> {
  bool _isLoading = false;
  List<SaleValues> listData = [];
  GrandTotal grandTotal = GrandTotal();
  String selectedYear = '';

  @override
  void initState() {
    super.initState();
    selectedYear = getFinancialYear();
    _getLatestTransactionData();
  }

  @override
  Widget build(BuildContext context) {

    List<String> listYears = generateFinancialYears(20);


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
          title: getTitle("Capital Gain",)
      ),
      backgroundColor: const Color(0XffEDEDEE),
      body: _isLoading
          ? const LoadingWidget()
          : Container(
              margin: const EdgeInsets.only(top: 8),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: listYears.length > 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Gap(12),
                        const Text("Select Year - ",style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 16),),
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
                                  openApplicantSelection(listYears);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(selectedYear,style: const TextStyle(color: blue,fontSize: 16,fontWeight: FontWeight.w600),),
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
                      child: Padding(
                          padding: const EdgeInsets.only(left: 6, right: 6),
                          child: Stack(
                            children: [
                              listData.isNotEmpty
                                  ? Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                          Container(
                                            padding: const EdgeInsets.only(left: 8,right: 8,top: 14,bottom: 14),
                                            decoration: const BoxDecoration(
                                                color:white,
                                                borderRadius: BorderRadius.only(topLeft:Radius.circular(8),topRight: Radius.circular(8))),
                                            child: const Row(
                                              children: [
                                                Expanded(
                                                    flex: 1,
                                                    child: Text('Asset Type',
                                                        style: TextStyle(
                                                            color: blue,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600))),
                                                Expanded(
                                                    flex: 1,
                                                    child: Text('STCG\nSTCL',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                            color: blue,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600))),
                                                Expanded(
                                                    flex: 1,
                                                    child: Text('LTCG\nLTCL',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                            color: blue,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600))),
                                                Expanded(
                                                    flex: 1,
                                                    child: Text('Total',
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
                                        ]
                                  )
                                  : const MyNoDataWidget(msg: "No data found."),
                            ],
                          ))
                  )
                ],
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
          itemBuilder: (context, index) {
            return Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: index % 2 == 0 ? white : semiBlue,
                        borderRadius: index == listData.length - 1 ? const BorderRadius.only(bottomLeft:Radius.circular(8),bottomRight: Radius.circular(8)) : const BorderRadius.all(Radius.circular(0))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(12),
                            width: double.infinity,
                            color: lightBlue,
                            child: Text(
                                toDisplayCase(listData[index]
                                    .applicant
                                    .toString()),
                                style: const TextStyle(
                                    color: blue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900))),
                        Container(child: _subItemList(listData[index].value ?? [],index)),
                        Container(
                          margin: const EdgeInsets.only(left: 8,right: 8,top: 12,bottom: 12),
                          child: Row(
                            children: [
                              const Expanded(
                                  flex: 1,
                                  child: Text("Total",
                                      style: TextStyle(
                                          color: blue,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700))),
                              Expanded(
                                  flex: 1,
                                  child: Text(convertCommaSeparatedAmount(listData[index].schemeTotal!.sTCGTotal.toString()) + "\n" + convertCommaSeparatedAmount(listData[index].schemeTotal!.sTCLTotal.toString()),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: blue,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700))),
                              Expanded(
                                  flex: 1,
                                  child: Text(convertCommaSeparatedAmount(listData[index].schemeTotal!.lTCGTotal.toString()) + "\n" + convertCommaSeparatedAmount(listData[index].schemeTotal!.lTCLTotal.toString()),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: blue,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700))),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                      convertCommaSeparatedAmount(listData[index].schemeTotal!.capitalGainTotal.toString()),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: blue,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700)
                                  )
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: index == listData.length - 1,
                          child: Container(
                            margin: const EdgeInsets.only(left: 8,right: 8,top: 12,bottom: 12),
                            child: Row(
                              children: [
                                const Expanded(
                                    flex: 1,
                                    child: Text("Grand Total",
                                        style: TextStyle(
                                            color: blue,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700))),
                                Expanded(
                                    flex: 1,
                                    child: Text(convertCommaSeparatedAmount(grandTotal.sTCGGrandTotal.toString()) + "\n" + convertCommaSeparatedAmount(grandTotal.sTCLGrandTotal.toString()),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: blue,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700))),
                                Expanded(
                                    flex: 1,
                                    child: Text(convertCommaSeparatedAmount(grandTotal.lTCGGrandTotal.toString()) + "\n" + convertCommaSeparatedAmount(grandTotal.lTCLGrandTotal.toString()),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: blue,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700))),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                        convertCommaSeparatedAmount(grandTotal.capitalGainGrandTotal.toString()),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: blue,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700)
                                    )
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
      ),
    );
  }

  ListView _subItemList(List<Value> subListData,int topPos) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        primary: false,
        padding: EdgeInsets.zero,
        itemCount: subListData.length,
        itemBuilder: (ctx, index) => (Container(
          alignment: Alignment.center,
          width: double.infinity,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 8,right: 8,top: 14,bottom: 14),
                decoration: const BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.all(Radius.zero)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Text(toDisplayCase(subListData[index].categoryKey.toString()),
                                style: const TextStyle(
                                    color: black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700))),
                        Expanded(
                            flex: 1,
                            child: Text(convertCommaSeparatedAmount(subListData[index].sTCGTotal.toString()) + "\n" + convertCommaSeparatedAmount(subListData[index].sTCLTotal.toString()),textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: black,
                                    fontSize: 12,
                                    fontWeight: subListData[index].categoryKey.toString().toLowerCase() == "total" ? FontWeight.w700 : FontWeight.w200))),
                        Expanded(
                            flex: 1,
                            child: Text(convertCommaSeparatedAmount(subListData[index].lTCGTotal.toString()) + "\n" + convertCommaSeparatedAmount(subListData[index].lTCLTotal.toString()),textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: black,
                                    fontSize: 12,
                                    fontWeight: subListData[index].categoryKey.toString().toLowerCase() == "total" ? FontWeight.w700 : FontWeight.w200))),
                        Expanded(
                            flex: 1,
                            child: Text(
                                convertCommaSeparatedAmount(subListData[index].capitalGain.toString()),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: black,
                                    fontSize: 12,
                                    fontWeight: subListData[index].categoryKey.toString().toLowerCase() == "total" ? FontWeight.w700 : FontWeight.w700))),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )));
  }

  List<String> generateFinancialYears(int numberOfYears) {
    List<String> years = [];
    DateTime now = DateTime.now();

    // Calculate the current financial year
    int currentYear = now.year;
    int currentMonth = now.month;
    int startYear;

    if (currentMonth >= 4) {
      // Financial year has started
      startYear = currentYear;
    } else {
      // Financial year has not started yet
      startYear = currentYear - 1;
    }

    // Loop to generate financial years
    for (int i = 0; i < numberOfYears; i++) {
      String financialYear = "${startYear}-${startYear + 1}";
      years.add(financialYear);
      startYear--;
    }

    return years;
  }

  void openApplicantSelection(List<String> listYears) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: white,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context, StateSetter setStatenew) {
            return ConstrainedBox(
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.88),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 22),
                child: Wrap(
                  children: <Widget>[
                    Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Select Year",style: TextStyle(color: blue,fontSize: 18,fontWeight: FontWeight.w600),)
                          ],
                        ),
                        const Gap(22),
                        ListView.builder(
                          itemCount: listYears.length,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                Navigator.pop(context);
                                setState(() {
                                  selectedYear = listYears[index] ?? '';

                                  _getLatestTransactionData();

                                  print(selectedYear);

                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(listYears[index] ?? '',style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: blue),),
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
              ),
            );
          });
        }
    );
  }

  _getLatestTransactionData() async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_CP + capitalGain);
    Map<String, String> jsonBody = {
      'user_id': sessionManagerPMS.getUserId().trim(),
      'cr_yr': selectedYear,
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = CapitalGainResponse.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      try {
        if (dataResponse.saleValues != null) {
          listData = dataResponse.saleValues ?? [];

          grandTotal = dataResponse.grandTotal ?? GrandTotal();

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
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void castStatefulWidget() {
    widget is CPCapitalGainPage;
  }
}
