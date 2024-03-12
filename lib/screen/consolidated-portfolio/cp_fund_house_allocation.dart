import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/model/consolidated-portfolio/LatestTransactionResponse.dart';
import 'package:superapp_flutter/utils/app_utils.dart';
import '../../common_widget/common_widget.dart';
import '../../constant/colors.dart';
import '../../constant/consolidate-portfolio/api_end_point.dart';
import '../../model/consolidated-portfolio/FundHouseAllocationResponse.dart';
import '../../model/consolidated-portfolio/SchemeAllocationResponse.dart';
import '../../utils/base_class.dart';
import '../../widget/loading.dart';
import '../../widget/no_data.dart';

class CPFundHouseAllocationPage extends StatefulWidget {
  const CPFundHouseAllocationPage({Key? key}) : super(key: key);

  @override
  BaseState<CPFundHouseAllocationPage> createState() =>
      CPFundHouseAllocationPageState();
}

class CPFundHouseAllocationPageState extends BaseState<CPFundHouseAllocationPage> {
  bool _isLoading = false;
  List<FundHouseAllocation> listData =
      List<FundHouseAllocation>.empty(growable: true);

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
          title: getTitle("Fund House Allocation",)
      ),
      backgroundColor: const Color(0XffEDEDEE),
      body: _isLoading
          ? const LoadingWidget()
          : Container(
              margin: const EdgeInsets.only(top: 8,bottom: 50),
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
                                            color:semiBlue,
                                            borderRadius: BorderRadius.only(topLeft:Radius.circular(8),topRight: Radius.circular(8))),
                                        child: Row(
                                          children: const [
                                            Expanded(
                                                flex: 2,
                                                child: Text('Name',
                                                    style: TextStyle(
                                                        color: blue,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600))),
                                            Expanded(
                                                flex: 1,
                                                child: Text('Value',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: blue,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600))),
                                            Expanded(
                                                flex: 1,
                                                child: Text('Allocation',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: blue,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600))),
                                          ],
                                        ),
                                      ),
                                      Expanded(
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
                    padding: const EdgeInsets.only(left: 8,right: 8,top: 14,bottom: 14),
                    decoration: BoxDecoration(
                        color: index % 2 == 0 ? white : semiBlue,
                        borderRadius: index == listData.length - 1 ? const BorderRadius.only(bottomLeft:Radius.circular(8),bottomRight: Radius.circular(8)) : const BorderRadius.all(Radius.circular(0))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        index == listData.length - 1
                            ? Row(
                                children: [
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                          toDisplayCase(listData[index]
                                              .fundHouse
                                              .toString()),
                                          style: const TextStyle(
                                              color: black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700))),
                                  Expanded(
                                      flex: 1,
                                      child: Text(convertCommaSeparatedAmount(listData[index].currentValue.toString()),
                                          style: const TextStyle(
                                              color: black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w200))),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          "${listData[index].allocation}%",
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
                                              .fundHouse
                                              .toString()),
                                          style: const TextStyle(
                                              color: black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700))),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          convertCommaSeparatedAmount(listData[index].currentValue.toString()),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w200))),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          "${listData[index].allocation}%",
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
            )));
  }

  @override
  void initState() {
    super.initState();
    _getSchemeAllocationData();
  }

  _getSchemeAllocationData() async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_CP + networth);
    Map<String, String> jsonBody = {
      'user_id': sessionManagerPMS.getUserId().trim(),
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = FundHouseAllocationResponse.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      try {
        if (dataResponse.result?.fundHouseAllocation != null) {
          listData = dataResponse.result!.fundHouseAllocation!;
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
    widget is CPFundHouseAllocationPage;
  }
}
