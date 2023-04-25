import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp/model/consolidated-portfolio/CapitalGainResponse.dart';
import 'package:superapp/utils/app_utils.dart';
import '../../constant/colors.dart';
import '../../constant/consolidate-portfolio/api_end_point.dart';
import '../../utils/base_class.dart';
import '../../widget/loading.dart';
import '../../widget/no_data.dart';

class CPCapitalGainPage extends StatefulWidget {
  const CPCapitalGainPage({Key? key}) : super(key: key);

  @override
  BaseState<CPCapitalGainPage> createState() =>
      CPCapitalGainPageState();
}

class CPCapitalGainPageState extends BaseState<CPCapitalGainPage> {
  bool _isLoading = false;
  List<SaleValues> listData =
      List<SaleValues>.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 60,
          automaticallyImplyLeading: false,
          backgroundColor: appBg,
          elevation: 0,
          centerTitle: false,
          title: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(right: 8),
                  child: Image.asset('assets/images/ic_back_arrow.png',
                      width: 30, height: 30),
                ),
              ),
              const Expanded(
                  child: Text(
                "Capital Gain",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 18, color: blue, fontWeight: FontWeight.w600),
              )),
            ],
          )),
      backgroundColor: const Color(0XffEDEDEE),
      body: _isLoading
          ? const LoadingWidget()
          : Container(
              margin: const EdgeInsets.only(top: 8),
            child: Column(
                children: [
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(left: 6, right: 6),
                          child: Stack(
                            children: [
                              listData.isNotEmpty
                                  ? Column(children: [
                                      Container(
                                        padding: const EdgeInsets.only(left: 8,right: 8,top: 14,bottom: 14),
                                        decoration: const BoxDecoration(
                                            color:white,
                                            borderRadius: BorderRadius.only(topLeft:Radius.circular(8),topRight: Radius.circular(8))),
                                        child: Row(
                                          children: const [
                                            Expanded(
                                                flex: 2,
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
                                      Container(
                                        child: _itemList(),
                                      ),
                                    ])
                                  : const MyNoDataWidget(msg: "No data found."),
                            ],
                          )))
                ],
              ),
          ),
    );
  }

  ListView _itemList() {
    return ListView.builder(
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
                    Container(child: _subItemList(listData[index].value!,index)),
                    Container(
                      margin: const EdgeInsets.only(left: 8,right: 8,top: 12,bottom: 12),
                      child: Row(
                        children: [
                          const Expanded(
                              flex: 2,
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
                                      fontWeight: FontWeight.w200))),
                          Expanded(
                              flex: 1,
                              child: Text(convertCommaSeparatedAmount(listData[index].schemeTotal!.lTCGTotal.toString()) + "\n" + convertCommaSeparatedAmount(listData[index].schemeTotal!.lTCLTotal.toString()),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: blue,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w200))),
                          Expanded(
                              flex: 1,
                              child: Text(
                                  convertCommaSeparatedAmount(listData[index].schemeTotal!.capitalGainTotal.toString()),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: blue,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700))),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )));
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
                            flex: 2,
                            child: Text(toDisplayCase(subListData[index].categoryKey.toString()),
                                style: const TextStyle(
                                    color: black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700))),
                        Expanded(
                            flex: 1,
                            child: Text(convertCommaSeparatedAmount(subListData[index].sTCGTotal.toString()) + "\n" + convertCommaSeparatedAmount(subListData[index].sTCLTotal.toString()),textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w200))),
                        Expanded(
                            flex: 1,
                            child: Text(convertCommaSeparatedAmount(subListData[index].lTCGTotal.toString()) + "\n" + convertCommaSeparatedAmount(subListData[index].lTCLTotal.toString()),textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w200))),
                        Expanded(
                            flex: 1,
                            child: Text(
                                convertCommaSeparatedAmount(subListData[index].capitalGain.toString()),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700))),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )));
  }

  @override
  void initState() {
    super.initState();
    _getLatestTransactionData();
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
      'cr_yr': "2022-2023",
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = CapitalGainResponse.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      try {
        if (dataResponse.saleValues != null) {
          listData = dataResponse.saleValues!;
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
