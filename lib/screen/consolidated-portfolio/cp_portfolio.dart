import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/common_widget/common_widget.dart';
import 'package:superapp_flutter/model/consolidated-portfolio/TempResponse.dart';
import 'package:superapp_flutter/model/consolidated-portfolio/assets/AssetListResponseModel.dart';
import 'package:superapp_flutter/utils/app_utils.dart';
import '../../constant/colors.dart';
import '../../constant/consolidate-portfolio/api_end_point.dart';
import '../../utils/MessageHandler.dart';
import '../../utils/base_class.dart';
import '../../widget/loading.dart';
import '../../widget/no_data.dart';
import 'asset/AddAssetScreen.dart';

class CPPortfolioPage extends StatefulWidget {
  const CPPortfolioPage({super.key});

  @override
  BaseState<CPPortfolioPage> createState() => CPPortfolioPageState();
}

class CPPortfolioPageState extends BaseState<CPPortfolioPage> {
  bool _isLoading = false;
  bool isSelectedAsset = false;
  bool isSelectedApplicant = false;
  bool isSelectedBroker = false;
  bool isSearchOpen = false;

  List<TempResponse> listData = [];
  List<TempResponse> listDataMain = [];
  List<String> listApplicants = [];
  List<String> listBrokerFilter = [];
  List<String> listAssetFilter = [];
  String selectedApplicant = "";
  Map<String, dynamic> userData = {};

  List<String> listSelectedAsset = [];
  String isForAsset = "Asset";

  List<String> listSelectedApplicant = [];
  String isForApplicant = "Applicant";

  List<String> listSelectedBroker = [];
  String isForBroker = "Broker";

  String selectedBroker = "";
  String selectedApplicantName = "";

  String searchQuery = "";
  TextEditingController searchController = TextEditingController();

  StreamSubscription<Message>? _subscription;
  final MessageHandler _handler = MessageHandler();

  @override
  void initState() {
    super.initState();

    _subscription = _handler.stream.listen((message) async {
      if(message.what == 101)
      {
        setState(() {
          if(searchController.text != "" && isSearchOpen == true)
          {
            _displaySearchResult("");
          }
          isSearchOpen = !isSearchOpen;
        });
        _handler.sendMessage(Message(104,""));
      }
      else if(message.what == 105)
      {
        _redirectToAddAsset();
      }
    });

    if ((sessionManagerPMS.getApplicantsList() != null))
    {
      if (sessionManagerPMS.getApplicantsList().isNotEmpty)
      {
        listApplicants = [];
        listApplicants.addAll(sessionManagerPMS.getApplicantsList());

        if (listApplicants.isNotEmpty)
          {
            //selectedApplicantName = listApplicants[0] ?? '';
            selectedApplicant = listApplicants[0] ?? '';
          }
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

  String getDisplayName(String isFor) {

    if(isFor == isForAsset)
    {
      if (listSelectedAsset.isEmpty)
      {
        return "All Asset";
      }
      final firstSelected = listAssetFilter.firstWhere((value) => value == listSelectedAsset.first, orElse: () => "All Asset",);

      if(listSelectedAsset.length >= 2)
      {
        return "$firstSelected+${listSelectedAsset.length - 1}";
      }
      else
      {
        return firstSelected;
      }
    }
    else if(isFor == isForApplicant)
    {
      if (listSelectedApplicant.isEmpty)
      {
        return "Select Applicant";
      }
      final firstSelected = listApplicants.firstWhere((value) => value == listSelectedApplicant.first, orElse: () => "Select Applicant",);

      if(listSelectedApplicant.length >= 2)
      {
        return "$firstSelected+${listSelectedApplicant.length - 1}";
      }
      else
      {
        return firstSelected;
      }
    }
    else if(isFor == isForBroker)
    {
      if (listSelectedBroker.isEmpty)
      {
        return "Select Broker";
      }
      final firstSelected = listBrokerFilter.firstWhere((value) => value == listSelectedBroker.first, orElse: () => "Select Broker",);

      if(listSelectedBroker.length >= 2)
      {
        return "$firstSelected+${listSelectedBroker.length - 1}";
      }
      else
      {
        return firstSelected;
      }
    }
    return "";
  }

  _redirectToAddAsset() async{
    if (!mounted) return;
    var value = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddAssetScreen(Assets(), false)));
    if (!mounted) return;
    if (value == "success")
    {
      _getPortfolioDataNew();
    }
    else
    {
      print("Simple back press in screen");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        margin: const EdgeInsets.only(top: 8),
        child: Padding(
            padding: const EdgeInsets.only(left: 6, right: 6),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 45,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      child: Row(
                        children: [
                          GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                if(listAssetFilter.isNotEmpty)
                                {
                                  openFilterDialogMultiple(isForAsset);
                                }
                                else
                                {
                                  showSnackBar("Asset Data Not Found", context);
                                }
                              },
                              child: getDisplayFilterCategory(getDisplayName(isForAsset), listSelectedAsset)
                          ),
                          GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                if(listApplicants.isNotEmpty)
                                {
                                  openFilterDialogMultiple(isForApplicant);
                                }
                                else
                                {
                                  showSnackBar("Applicant Data Not Found", context);
                                }
                              },
                              child: getDisplayFilterCategory(getDisplayName(isForApplicant), listSelectedApplicant)
                          ),
                          GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                if(listBrokerFilter.isNotEmpty)
                                {
                                  openFilterDialogMultiple(isForBroker);
                                }
                                else
                                {
                                  showSnackBar("Broker Data Not Found", context);
                                }
                              },
                              child: getDisplayFilterCategory(getDisplayName(isForBroker), listSelectedBroker)
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isSearchOpen,
                    child: Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: TextField(
                        cursorColor: black,
                        controller: searchController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.search,
                        style: getRegularTextStyle(fontSize: 14, color: black),
                        onSubmitted: (value) {
                          _displaySearchResult(value);
                        },
                        onChanged: (value) {
                          _displaySearchResult(value);
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: white,
                          hintText: 'Search here...',
                          contentPadding: const EdgeInsets.only(left: 12, right: 12),
                          prefixIcon: const InkWell(
                            onTap: null,
                            child: Icon(Icons.search_rounded, size: 26, color: black),
                          ),
                          suffixIcon: searchController.text.isNotEmpty
                              ? GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              hideKeyboard(context);
                              _displaySearchResult("");
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Image.asset('assets/images/ic_close.png', height: 12, width: 12, color: gray),
                            ),
                          )
                              : null,
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  _isLoading
                      ? Expanded(
                    child: Center(
                      child: const LoadingWidget(),
                    ),
                  )
                      :
                  listData.isEmpty ?
                  Expanded(
                    child: Center(
                      child: MyNoDataWidget(msg: "No data found."),
                    ),
                  ) :
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 60),
                      child: Column(
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
                          _assetList(),
                        ],
                      ),
                    ),
                  )
                ]
            )
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   heroTag: 'add_asset_portfolio',
      //   onPressed: () async{
      //
      //     var value = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddAssetScreen(Assets(), false)));
      //     if (value == "success")
      //     {
      //       _getPortfolioDataNew();
      //     }
      //   },
      //   icon: Icon(Icons.add, color: white,),
      //   label: Text("Add Asset", style: getMediumTextStyle(fontSize: 14, color: white),),
      //   backgroundColor: blue,
      // ),
    );
  }

  _displaySearchResult(String query) {
    searchQuery = query.toLowerCase();
    if (query.isEmpty)
    {
      searchController.clear();
      listData = listDataMain;
    }
    else
    {
      listData = listDataMain.where((asset) {
        return asset.objectives?.any((objective) {
          return objective.schemes?.any((scheme) {
            return (scheme.schemeName ?? "").toLowerCase().contains(searchQuery);
          }) ?? false;
        }) ?? false;
      }).toList();
    }

    setState(() {});
  }

  ListView _assetList() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
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
                            listData[index].asset ?? '',
                            style: const TextStyle(
                                color: blue,
                                fontSize: 16,
                                fontWeight: FontWeight.w900))),
                    Container(
                      // child: _objectiveList(listData[index].objectives ?? [])
                      child: _objectiveList(
                        (listData[index].objectives ?? []).where((objective) {
                        if (searchQuery.isEmpty) return true;

                        return objective.schemes?.any((scheme) => (scheme.schemeName ?? "").toLowerCase().contains(searchQuery)) ?? false;
                      }).toList(),
                      )
                    ),
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
                            objectives[index].objective ?? '',
                            style: const TextStyle(
                                color: blue,
                                fontSize: 16,
                                fontWeight: FontWeight.w900))),
                    Container(
                      //child: _schemeList(objectives[index].schemes!)
                      child: _schemeList(
                        (objectives[index].schemes ?? []).where((scheme) {
                          if (searchQuery.isEmpty) return true;

                          return (scheme.schemeName ?? "")
                              .toLowerCase()
                              .contains(searchQuery);
                        }).toList(),
                      ),
                    ),
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
        itemBuilder: (context, index) {
          return Container(
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
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                        schemes[index].schemeName ?? '',
                                        style: const TextStyle(
                                            color: black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700
                                        )
                                    ),
                                  ),
                                  Visibility(
                                    visible: (schemes[index].mfId?.isNotEmpty ?? false) && (schemes[index].itId != "NA" && schemes[index].itId != ""),
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        _redirectToEdit(schemes[index]);
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 4),
                                        child: Image.asset(
                                          "assets/images/fin_plan_ic_edit_gray.png",
                                          height: 18,
                                          width: 18,
                                          color: chart_color3,
                                        ),
                                      ),
                                    )
                                  )
                                ],
                              )
                          ),
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
          );
        },
    );
  }

  _redirectToEdit(SchemesTemp schemeData) async{
    Assets getSet = Assets(
      quantity: "",
      id: schemeData.mfId,
      userId: schemeData.userId,
      itId: schemeData.itId,
      investmentType: schemeData.objective
    );

    var value = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddAssetScreen(getSet, true)));
    if (value == "success")
    {
      _getPortfolioDataNew();
    }
  }

  void openFilterDialogMultiple(String isFor) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      elevation: 5,
      isDismissible: true,
      builder: (context) {
        return SafeArea(
          child: StatefulBuilder(
            builder: (context, setStateDialog) {
              return ConstrainedBox(
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: getBottomSheetHeaderWithoutButton(
                            context,
                            isFor == isForAsset ? "Select Asset" :
                            isFor == isForApplicant ? "Select Applicant" :
                            isFor == isForBroker ? "Select Broker" : ""
                        ),
                      ),
                      Flexible(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return SingleChildScrollView(
                              child: ListView.builder(
                                itemCount: isFor == isForAsset ? listAssetFilter.length : isFor == isForApplicant ? listApplicants.length : isFor == isForBroker ? listBrokerFilter.length : 0,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  if(isFor == isForAsset)
                                  {
                                    isSelectedAsset = listSelectedAsset.contains(listAssetFilter[index]);
                                  }
                                  else if(isFor == isForApplicant)
                                  {
                                    isSelectedApplicant = listSelectedApplicant.contains(listApplicants[index]);
                                  }
                                  else if(isFor == isForBroker)
                                  {
                                    isSelectedBroker = listSelectedBroker.contains(listBrokerFilter[index]);
                                  }
                                  return GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        if(isFor == isForAsset)
                                        {
                                          setStateDialog((){
                                            if(listSelectedAsset.contains(listAssetFilter[index]))
                                            {
                                              listSelectedAsset.remove(listAssetFilter[index]);
                                            }
                                            else
                                            {
                                              listSelectedAsset.add(listAssetFilter[index]);
                                            }
                                          });
                                        }
                                        else if(isFor == isForApplicant)
                                        {
                                          setStateDialog((){
                                            if (listSelectedApplicant.contains(listApplicants[index]))
                                            {
                                              listSelectedApplicant.remove(listApplicants[index]);
                                            }
                                            else
                                            {
                                              listSelectedApplicant.add(listApplicants[index]);
                                            }
                                          });
                                        }
                                        else if(isFor == isForBroker)
                                        {
                                          setStateDialog((){
                                            if (listSelectedBroker.contains(listBrokerFilter[index]))
                                            {
                                              listSelectedBroker.remove(listBrokerFilter[index]);
                                            }
                                            else
                                            {
                                              listSelectedBroker.add(listBrokerFilter[index]);
                                            }
                                          });
                                        }
                                        setState(() {});
                                      },
                                      child: isFor == isForAsset ? getBottomSheetItemWithSelection(listAssetFilter[index], isSelectedAsset, false) :
                                      isFor == isForApplicant ? getBottomSheetItemWithSelection(listApplicants[index], isSelectedApplicant, false) :
                                      isFor == isForBroker ? getBottomSheetItemWithSelection(listBrokerFilter[index], isSelectedBroker, false)
                                          : Container()
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                if(isFor == isForAsset)
                                {
                                  listSelectedAsset.clear();
                                }
                                else if(isFor == isForApplicant)
                                {
                                  listSelectedApplicant.clear();
                                }
                                else if(isFor == isForBroker)
                                {
                                  listSelectedBroker.clear();
                                }

                                _getPortfolioDataNew();
                                Navigator.pop(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: blue,
                                    borderRadius: BorderRadius.circular(4)
                                ),
                                padding: const EdgeInsets.only(top: 16, bottom: 16,),
                                child: Center(
                                  child: Text(
                                    "Clear",
                                    style: getMediumTextStyle(color: white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Gap(8),
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                _getPortfolioDataNew();
                                Navigator.pop(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: blue,
                                    borderRadius: BorderRadius.circular(4)
                                ),
                                padding: const EdgeInsets.only(top: 16, bottom: 16,),
                                child: Center(
                                  child: Text(
                                    "Apply",
                                    style: getMediumTextStyle(color: white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Gap(10),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
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
      listDataMain = [];
      listData = [];
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_CP + portfolio);
    Map<String, dynamic> jsonBody = {
      'user_id': sessionManagerPMS.getUserId().trim(),
      'from_app': 'true',
      "broker": listSelectedBroker,
      "applicant": listSelectedApplicant,
      "asset": listSelectedAsset
      // "broker": selectedBroker,
      // "applicant": selectedApplicantName,
      
    };

    final response = await http.post(url, body: jsonEncode(jsonBody));

    print("USER DATA Body == ${jsonEncode(jsonBody)}");
    print("USER DATA response == $response");

    final statusCode = response.statusCode;
    final body = response.body;
    userData = jsonDecode(body);

    if (statusCode == 200 && userData['success'] == 1)
    {

      listBrokerFilter = List<String>.from(userData['broker_filter'] ?? []);
      print("Display broker filter data : $listBrokerFilter");

      listAssetFilter = List<String>.from(userData['assets_filter'] ?? []);
      print("Display asset filter data : $listAssetFilter");

      final result = userData['result'];
      final parsedJson = result['portfolio'];

      parsedJson.forEach((value){
        Map<String,dynamic> valueData = value;
        valueData.forEach((key, value) {
          var tpp = List<TempResponse>.empty(growable: true);
          if(value !=null)
          {
            value.forEach((v) {
              tpp.add(TempResponse.fromJson(v));
            });
            listDataMain.addAll(tpp);
            listData = listDataMain;
          }
        });
      });
      print("Display list length : ${listData.length}");
      print("Display list main length : ${listDataMain.length}");
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
