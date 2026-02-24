import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/model/consolidated-portfolio/ApplicantResponseModel.dart';
import 'package:superapp_flutter/utils/app_utils.dart';
import '../../common_widget/common_widget.dart';
import '../../constant/colors.dart';
import '../../constant/consolidate-portfolio/api_end_point.dart';
import '../../model/consolidated-portfolio/NetworthResponseModel.dart';
import '../../model/consolidated-portfolio/TempResponse.dart';
import '../../utils/base_class.dart';
import '../../widget/loading.dart';
import '../../widget/no_data.dart';

class CPNetworthPage extends StatefulWidget {
  const CPNetworthPage({Key? key}) : super(key: key);

  @override
  BaseState<CPNetworthPage> createState() =>
      CPNetworthPageState();
}

class CPNetworthPageState extends BaseState<CPNetworthPage> {
  bool _isLoading = false;
  List<Networth> listData = [];
  List<Networth> listDataMain = [];
  List<String> listApplicants = [];
  String selectedApplicant = "";

  List<String> listBrokerFilter = [];
  List<String> listAssetFilter = [];

  String selectedApplicantName = "";
  String selectedBroker = "";
  String selectedAsset = "";

  @override
  void initState(){
    super.initState();
    _getNetworthData();

    if (sessionManagerPMS.getApplicantsList()?.isNotEmpty ?? false)
    {
      listApplicants = [];
      listApplicants.addAll(sessionManagerPMS.getApplicantsList());

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XffEDEDEE),
      body: _isLoading
          ? const LoadingWidget()
          : Container(
        margin: const EdgeInsets.only(top: 8,bottom: 8),
        child: Padding(
            padding: const EdgeInsets.only(left: 6, right: 6),
            child: Column(
              children: [

                SizedBox(
                  height: 50,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            openFilterDialog(3);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
                            decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(12)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  selectedAsset.isEmpty ? "All Assets" : selectedAsset,
                                  style: getMediumTextStyle(fontSize: 12, color: selectedAsset == "" ? grayDark : blue),
                                ),
                                const Gap(4),
                                selectedAsset.isEmpty ?
                                const Icon(Icons.keyboard_arrow_down_outlined) :
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    setState(() {
                                      selectedAsset = "";
                                      listData = listDataMain;
                                    });
                                  },
                                  child: const Icon(Icons.close, size: 24, color: black,),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Gap(8),
                        GestureDetector(
                          onTap: () {
                            openFilterDialog(1);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
                            decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(12)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  selectedApplicantName.isEmpty ? "Select Applicant" : selectedApplicantName,
                                  style: getMediumTextStyle(fontSize: 12, color: selectedApplicantName == "" ? grayDark : blue),
                                ),
                                const Gap(4),
                                selectedApplicantName.isEmpty ?
                                const Icon(Icons.keyboard_arrow_down_outlined) :
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    setState(() {
                                      selectedApplicantName = "";
                                    });
                                    _getNetworthData();
                                  },
                                  child: const Icon(Icons.close, size: 24, color: black,),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Gap(8),
                        GestureDetector(
                          onTap: () {
                           openFilterDialog(2);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
                            decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(12)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  selectedBroker.isEmpty ? "Select Brokers" : selectedBroker,
                                  style: getMediumTextStyle(fontSize: 12, color: selectedBroker == "" ? grayDark : blue),
                                ),
                                const Gap(4),
                                selectedBroker.isEmpty ?
                                const Icon(Icons.keyboard_arrow_down_outlined) :
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    setState(() {
                                      selectedBroker = "";
                                    });
                                    _getNetworthData();
                                  },
                                  child: const Icon(Icons.close, size: 24, color: black,),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),


                // Visibility(
                //   visible: listApplicants.length > 1,
                //   // visible: false,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       const Text("Select Holder - ",style: TextStyle(color: black,fontWeight: FontWeight.w600,fontSize: 16),),
                //       Container(
                //         margin: const EdgeInsets.only(top: 12,bottom: 12),
                //         decoration: BoxDecoration(
                //             color: white,
                //             borderRadius: BorderRadius.circular(12)
                //         ),
                //         child: Wrap(
                //           children: [
                //             GestureDetector(
                //               behavior: HitTestBehavior.opaque,
                //               onTap: () {
                //                 openApplicantSelection();
                //               },
                //               child: Padding(
                //                 padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                //                 child: Row(
                //                   mainAxisAlignment: MainAxisAlignment.start,
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   mainAxisSize: MainAxisSize.min,
                //                   children: [
                //                     Text(selectedApplicant,style: const TextStyle(color: blue,fontSize: 16,fontWeight: FontWeight.w600),),
                //                     const Icon(Icons.keyboard_arrow_down_outlined),
                //                   ],
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                Expanded(
                  child: listData.isNotEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 8,right: 8,top: 14,bottom: 14),
                              decoration: const BoxDecoration(
                                  color:white,
                                  borderRadius: BorderRadius.only(
                                      topLeft:Radius.circular(8),
                                      topRight: Radius.circular(8)
                                  )
                              ),
                              child: const Row(
                                children: [
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                          'Asset Type',
                                          style: TextStyle(
                                              color: blue,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600
                                          )
                                      )
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Text('Amount',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: blue,
                                              fontSize: 16,
                                              fontWeight:
                                              FontWeight.w600)
                                      )
                                  ),
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
                            Expanded(child: _itemList()),
                          ]
                      )
                      : const MyNoDataWidget(msg: "No data found."),
                ),
              ],
            )),
      ),
    );
  }

  ListView _itemList() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
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
                      borderRadius: index == listData.length - 1
                          ? const BorderRadius.only(bottomLeft:Radius.circular(8),bottomRight: Radius.circular(8))
                          : const BorderRadius.all(Radius.circular(0)
                      )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          padding: const EdgeInsets.all(12),
                          width: double.infinity,
                          color: lightBlue,
                          child: Text(
                              listData[index].asset ?? '',
                              style: const TextStyle(
                                  color: blue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900
                              )
                          )
                      ),
                      Container(
                          child: _subItemList(listData[index].objectives ?? [],index)
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
    );
  }

  ListView _subItemList(List<Objectives> subListData,int topPos) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        primary: false,
        padding: EdgeInsets.zero,
        itemCount: subListData.length,
        itemBuilder: (context, index) {
          return Container(
            alignment: Alignment.center,
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 8,right: 8,top: 14,bottom: 14),
                  decoration: BoxDecoration(
                      color: index % 2 == 0
                          ? white
                          : semiBlue,
                      borderRadius: const BorderRadius.all(Radius.zero)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text(
                                  toDisplayCase(subListData[index].objective ?? ''),
                                  style: const TextStyle(
                                      color: black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700)
                              )
                          ),
                          Expanded(
                              flex: 1,
                              child: Text(convertCommaSeparatedAmount(subListData[index].amount.toString())
                                  ,textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 12,
                                      fontWeight: subListData[index].objective.toString().toLowerCase() == "sub total"
                                          ? FontWeight.w700
                                          : subListData[index].objective.toString().toLowerCase() == "total"
                                          ? FontWeight.w700
                                          : FontWeight.w200
                                  )
                              )
                          ),
                          Expanded(
                              flex: 1,
                              child: Text("${subListData[index].percentage.toString()} %",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 12,
                                      fontWeight: subListData[index].objective.toString().toLowerCase() == "sub total"
                                          ? FontWeight.w700
                                          : subListData[index].objective.toString().toLowerCase() == "total"
                                          ? FontWeight.w700
                                          : FontWeight.w200
                                  )
                              )
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
    );
  }

  void openFilterDialog(int isFor) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: white,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context, StateSetter setStateNew) {
            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 22),
              child: Wrap(
                children: <Widget>[

                  Column(
                    children: [
                      Center(
                        child: Text(isFor == 1 ? "Select Applicant" : isFor == 2 ? "Select Broker" : "Select Asset",style: TextStyle(color: blue,fontSize: 18,fontWeight: FontWeight.w600),),
                      ),
                      const Gap(22),

                      ListView.builder(
                        itemCount: isFor == 1 ?  listApplicants.length : isFor == 2 ? listBrokerFilter.length : listAssetFilter.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              if(isFor == 1)
                              {
                                setState(() {
                                  selectedApplicantName = listApplicants[index];
                                });
                                _getNetworthData();
                              }
                              else if(isFor == 2)
                              {
                                setState(() {
                                  selectedBroker = listBrokerFilter[index];
                                });
                                _getNetworthData();
                              }
                              else
                              {

                                setState(() {
                                  selectedAsset = listAssetFilter[index];

                                  if (selectedAsset.isEmpty)
                                  {
                                    listData = listDataMain;
                                  }
                                  else
                                  {
                                    listData = listDataMain.where((item) => item.asset == selectedAsset).toList();
                                  }
                                });
                              }
                              Navigator.pop(context);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                                  child: isFor == 1 ?
                                  Text(
                                    listApplicants[index],
                                    style: getMediumTextStyle(fontSize: 14, color: selectedApplicantName == listApplicants[index] ? blue : black),
                                  ) :
                                  isFor == 2 ?
                                  Text(
                                    listBrokerFilter[index],
                                    style: getMediumTextStyle(fontSize: 14, color: selectedBroker == listBrokerFilter[index] ? blue : black),
                                  ) :
                                  Text(
                                    listAssetFilter[index],
                                    style: getMediumTextStyle(fontSize: 14, color: selectedAsset == listAssetFilter[index] ? blue : black),
                                  ),
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

                                _getNetworthData();

                                print(selectedApplicant);

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

  _getNetworthData() async {

    listAssetFilter = [];

    if ((sessionManagerPMS.getNetworthData() != null))
    {
      print("IS FIRST IF");
      if (sessionManagerPMS.getNetworthData().networth?.isNotEmpty ?? false)
      {
        print("IS IN IF");
        listData = sessionManagerPMS.getNetworthData().networth ?? [];
        listDataMain = sessionManagerPMS.getNetworthData().networth ?? [];
        print((listData.length));
      }
      else
      {
        print("IS IN ELSE");
        listData = [];
        listDataMain = [];
      }
    }
    else
    {
      listData = [];
    }

    if (listData.isEmpty)
      {
        setState(() {
          _isLoading = true;
        });
      }

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_CP + networth);
    Map<String, String> jsonBody = {
      'user_id': sessionManagerPMS.getUserId().trim(),
      // 'applicant' : selectedApplicant == 'ALL' ? "" : selectedApplicant
      "applicant": selectedApplicantName.isEmpty ? "" : selectedApplicantName,
      "broker": selectedBroker.isEmpty ? "" : selectedBroker
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = NetworthResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1)
    {
      try {

        if(dataResponse.brokerFilter?.isNotEmpty ?? false)
        {
          listBrokerFilter = dataResponse.brokerFilter ?? [];
        }
        else
        {
          listBrokerFilter = [];
        }

        print("Display list broker filter : $listBrokerFilter");

        if (dataResponse.result?.networth != null) {

          listDataMain = dataResponse.result?.networth ?? [];
          listData = listDataMain;


          for(int i = 0; i < listDataMain.length; i++)
          {
            listAssetFilter.add(listDataMain[i].asset ?? "");
          }

          print("Display list asset filter : $listAssetFilter");

          setState(() {
            _isLoading = false;
          });

        }
        else{
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
    }
    else
    {
      setState(() {
        _isLoading = false;
      });
    }

  }

  @override
  void castStatefulWidget() {
    widget is CPNetworthPage;
  }
}
