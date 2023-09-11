import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/model/consolidated-portfolio/PortfolioResponse.dart';
import 'package:superapp_flutter/utils/app_utils.dart';
import '../../constant/colors.dart';
import '../../constant/consolidate-portfolio/api_end_point.dart';
import '../../utils/base_class.dart';
import '../../widget/loading.dart';
import '../../widget/no_data.dart';

class CPPortfolioPage extends StatefulWidget {
  const CPPortfolioPage({Key? key}) : super(key: key);

  @override
  BaseState<CPPortfolioPage> createState() =>
      CPPortfolioPageState();
}

class CPPortfolioPageState extends BaseState<CPPortfolioPage> {
  bool _isLoading = false;
  List<Portfolio> listData =
      List<Portfolio>.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                                flex: 1,
                                                child: Text('Fund Name',
                                                    style: TextStyle(
                                                        color: blue,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600))),
                                            Expanded(
                                                flex: 1,
                                                child: Text('Amount\nInvested',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: blue,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600))),
                                            Expanded(
                                                flex: 1,
                                                child: Text('Current\nValue',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: blue,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600))),
                                            Expanded(
                                                flex: 1,
                                                child: Text('Gain/Loss\nCAGR%',
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
                                        child: _applicantList(),
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

  ListView _applicantList() {
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
                                .applicantName
                                .toString()),
                            style: const TextStyle(
                                color: blue,
                                fontSize: 16,
                                fontWeight: FontWeight.w900))),
                    Container(child: _assetList(listData[index].data!)),
                  ],
                ),
              )
            ],
          ),
        )));
  }

  ListView _assetList(List<Data> data) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        primary: false,
        padding: EdgeInsets.zero,
        itemCount: data.length,
        itemBuilder: (ctx, index) => (Container(
          alignment: Alignment.center,
          width: double.infinity,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: index % 2 == 0 ? white : semiBlue,
                    borderRadius: index == data.length - 1 ? const BorderRadius.only(bottomLeft:Radius.circular(8),bottomRight: Radius.circular(8)) : const BorderRadius.all(Radius.circular(0))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(12),
                        width: double.infinity,
                        color: lightBlue,
                        child: Text(
                            toDisplayCase(data[index]
                                .asset
                                .toString()),
                            style: const TextStyle(
                                color: blue,
                                fontSize: 16,
                                fontWeight: FontWeight.w900))),
                    Container(child: _objectiveList(data[index].objectives!)),
                  ],
                ),
              )
            ],
          ),
        )));
  }

  ListView _objectiveList(List<Objectives> objectives) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        primary: false,
        padding: EdgeInsets.zero,
        itemCount: objectives.length,
        itemBuilder: (ctx, index) => (Container(
          alignment: Alignment.center,
          width: double.infinity,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: index % 2 == 0 ? white : white,
                    borderRadius: const BorderRadius.all(Radius.zero)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(12),
                        width: double.infinity,
                        color: white,
                        child: Text(
                            toDisplayCase(objectives[index]
                                .objective
                                .toString()),
                            style: const TextStyle(
                                color: blue,
                                fontSize: 16,
                                fontWeight: FontWeight.w900))),
                    Container(child: _schemeList(objectives[index].schemes!)),
                  ],
                ),
              )
            ],
          ),
        )));
  }

  ListView _schemeList(List<Schemes> schemes) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        primary: false,
        padding: EdgeInsets.zero,
        itemCount: schemes.length,
        itemBuilder: (ctx, index) => (Container(
          alignment: Alignment.center,
          width: double.infinity,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: index % 2 == 0 ? white : semiBlue,
                    borderRadius: const BorderRadius.all(Radius.zero)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Text(toDisplayCase(schemes[index].schemeName.toString()),
                                style: const TextStyle(
                                    color: black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700))),
                        Expanded(
                            flex: 1,
                            child: Text(convertCommaSeparatedAmount(schemes[index].initialValue.toString()),textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w200))),
                        Expanded(
                            flex: 1,
                            child: Text(convertCommaSeparatedAmount(schemes[index].currentValue.toString()),textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w200))),
                        Expanded(
                            flex: 1,
                            child: Text(convertCommaSeparatedAmount(schemes[index].gain.toString()) + "\n" + schemes[index].cagr,textAlign: TextAlign.center,
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
    _getPortfolioData();
  }

  _getPortfolioData() async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_CP + portfolio);
    Map<String, String> jsonBody = {
      'user_id': sessionManagerPMS.getUserId().trim(),
      'from_app': 'true',
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = PortfolioResponse.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      try {
        if (dataResponse.result?.portfolio != null) {
          listData = dataResponse.result!.portfolio!;
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
    widget is CPPortfolioPage;
  }
}
