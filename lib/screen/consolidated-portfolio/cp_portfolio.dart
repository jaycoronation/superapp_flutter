import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/common_widget/common_widget.dart';
import 'package:superapp_flutter/model/consolidated-portfolio/ApplicantResponseModel.dart';
import 'package:superapp_flutter/model/consolidated-portfolio/NetworthResponseModel.dart' as networth;
import 'package:superapp_flutter/model/consolidated-portfolio/TempResponse.dart';
import 'package:superapp_flutter/utils/app_utils.dart';
import '../../constant/colors.dart';
import '../../constant/consolidate-portfolio/api_end_point.dart';
import '../../utils/base_class.dart';
import '../../widget/loading.dart';
import '../../widget/no_data.dart';

class CPPortfolioPage extends StatefulWidget {
  const CPPortfolioPage({Key? key}) : super(key: key);

  @override
  BaseState<CPPortfolioPage> createState() => CPPortfolioPageState();
}

class CPPortfolioPageState extends BaseState<CPPortfolioPage> {
  bool _isLoading = false;
  List<TempResponse> listData = [];
  List<ApplicantsOnly> listApplicants = [];
  String selectedApplicant = "";
  Map<String, dynamic> userData = {};

  @override
  void initState() {
    super.initState();
    //selectedApplicant = context.watch<UpdateData>().selectedApplicant.toString();

    if ((sessionManagerPMS.getApplicantsList() != null))
    {
      if (sessionManagerPMS.getApplicantsList().isNotEmpty ?? false)
      {
        listApplicants = [];
        listApplicants.addAll(sessionManagerPMS.getApplicantsList() ?? []);

        if (listApplicants.isNotEmpty)
        {
          selectedApplicant = listApplicants[0].applicant ?? '';
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


    _getPortfolioDataNew();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XffEDEDEE),
      /*appBar: AppBar(
        toolbarHeight: 60,
        automaticallyImplyLeading: false,
        backgroundColor: appBg,
        elevation: 0,
        leading: Visibility(
          visible: kIsWeb == false,
          child: GestureDetector(
            onTap: () {
              final BottomNavigationBar bar = bottomWidgetKey.currentWidget as BottomNavigationBar;
              bar.onTap!(0);
            },
            child: getBackArrow(),
          ),
        ),
        centerTitle: true,
        titleSpacing: 0,
        title: getTitle("Portfolio",),
      ),*/
      body: _isLoading
          ? const LoadingWidget()
          : Container(
              margin: const EdgeInsets.only(top: 8),
            child: Padding(
                padding: const EdgeInsets.only(left: 6, right: 6),
                child: Stack(
                  children: [
                    listData.isNotEmpty
                        ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                Container(
                                  padding: const EdgeInsets.only(left: 8,right: 8,top: 14,bottom: 14),
                                  decoration: const BoxDecoration(
                                      color:white,
                                      borderRadius: BorderRadius.only(topLeft:Radius.circular(8),topRight: Radius.circular(8))),
                                  child: const Row(
                                    children: [
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
                                  child: _assetList(),
                                ),
                              ]
                        )
                        : Column(
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
                            const Expanded(child: MyNoDataWidget(msg: "No data found.")),
                          ],
                        ),
                  ],
                )),
          ),
    );
  }

  /*ListView _applicantList() {
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
                            toDisplayCase(listApplicants[index].applicant.toString()),
                            style: const TextStyle(
                                color: blue,
                                fontSize: 16,
                                fontWeight: FontWeight.w900))),
                    Container(child: _assetList(listData[index].abhaagarwal ?? [])),
                  ],
                ),
              )
            ],
          ),
        )));
  }*/

  ListView _assetList() {
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
                            toDisplayCase(listData[index].asset.toString()),
                            style: const TextStyle(
                                color: blue,
                                fontSize: 16,
                                fontWeight: FontWeight.w900))),
                    Container(child: _objectiveList(listData[index].objectives ?? [])),
                  ],
                ),
              )
            ],
          ),
        )));
  }

  ListView _objectiveList(List<ObjectivesTemp> objectives) {
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

  ListView _schemeList(List<SchemesTemp> schemes) {
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
                                style: TextStyle(
                                    color: black,
                                    fontSize: 12,
                                    fontWeight: schemes[index].schemeName.toString().toLowerCase() == "sub total" ? FontWeight.w700 : schemes[index].schemeName.toString().toLowerCase() == "total" ?  FontWeight.w700 : FontWeight.w200))),
                        Expanded(
                            flex: 1,
                            child: Text(convertCommaSeparatedAmount(schemes[index].currentValue.toString()),textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: black,
                                    fontSize: 12,
                                    fontWeight: schemes[index].schemeName.toString().toLowerCase() == "sub total" ? FontWeight.w700 : schemes[index].schemeName.toString().toLowerCase() == "total" ?  FontWeight.w700 : FontWeight.w200))),
                        Expanded(
                            flex: 1,
                            child: Text(schemes[index].schemeName.toString().toLowerCase() == "sub total" ? convertCommaSeparatedAmount(schemes[index].gain.toString()) : convertCommaSeparatedAmount(schemes[index].gain.toString()) + "\n" + schemes[index].cagr,textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: black,
                                    fontSize: 12,
                                    fontWeight: schemes[index].schemeName.toString().toLowerCase() == "sub total" ? FontWeight.w700 : schemes[index].schemeName.toString().toLowerCase() == "total" ?  FontWeight.w700 : FontWeight.w200))),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )));
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
                                selectedApplicant = listApplicants[index].applicant ?? '';

                                listData = [];

                                print(selectedApplicant);


                                final result = userData['result'];
                                final parsedJson = result['portfolio'];
                                parsedJson.forEach((value){
                                  print(value);
                                  print(selectedApplicant);


                                  Map<String,dynamic> valueData = value;

                                  valueData.forEach((key, value) {
                                    print("USER DATA ADDING IN IF == $key === $value");
                                    if(key == (selectedApplicant))
                                    {
                                      var tpp = List<TempResponse>.empty(growable: true);
                                      if(value !=null)
                                        {
                                          value.forEach((v) {
                                            tpp.add(TempResponse.fromJson(v));
                                          });
                                          print("USER DATA ADDING IN IF == ${tpp.length}");
                                          listData.addAll(tpp);
                                        }
                                    }
                                  });
                                });


                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(listApplicants[index].applicant ?? '',style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: blue),),
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

  /*_getPortfolioData() async {
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
  }*/

  _getPortfolioDataNew() async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.NONE),
    ]);

    final url = Uri.parse(API_URL_CP + portfolio);
    Map<String, String> jsonBody = {
      'user_id': sessionManagerPMS.getUserId().trim(),
      'from_app': 'true',
    };

    final response = await http.post(url, body: jsonBody);

    print("USER DATA response == $response");

    final statusCode = response.statusCode;
    final body = response.body;
    userData = jsonDecode(body);

    print("USER DATA FIled == $userData");

    if (statusCode == 200 && userData['success'] == 1)
    {
      final result = userData['result'];
      final parsedJson = result['portfolio'];
      parsedJson.forEach((value){
        print(value);
        print(selectedApplicant);


        Map<String,dynamic> valueData = value;

        valueData.forEach((key, value) {
          print("USER DATA ADDING IN IF == $key === $value");
          if(key == (selectedApplicant))
          {
            var tpp = List<TempResponse>.empty(growable: true);
            if(value !=null)
            {
              value.forEach((v) {
                tpp.add(TempResponse.fromJson(v));
              });
              print("USER DATA ADDING IN IF == ${tpp.length}");
              listData.addAll(tpp);
            }
          }
        });
      });

      print("listData SIZE === ${listData.length}");
    }
    else
    {
      print("USER DATA Filed  ELSE == $userData");
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void castStatefulWidget() {
    widget is CPPortfolioPage;
  }
}
