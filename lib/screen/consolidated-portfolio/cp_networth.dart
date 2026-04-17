import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/utils/app_utils.dart';
import '../../common_widget/common_widget.dart';
import '../../constant/colors.dart';
import '../../constant/consolidate-portfolio/api_end_point.dart';
import '../../model/consolidated-portfolio/NetworthResponseModel.dart';
import '../../utils/MessageHandler.dart';
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
  bool isSelectedAsset = false;
  bool isSelectedApplicant = false;
  bool isSelectedBroker = false;
  bool isSearchOpen = false;

  List<Networth> listData = [];
  List<Networth> listDataMain = [];
  List<String> listApplicants = [];
  String selectedApplicant = "";

  List<String> listSelectedAsset = [];
  String isForAsset = "Asset";

  List<String> listSelectedApplicant = [];
  String isForApplicant = "Applicant";

  List<String> listSelectedBroker = [];
  String isForBroker = "Broker";

  List<String> listBrokerFilter = [];
  List<String> listAssetFilter = [];

  String selectedApplicantName = "";
  String selectedBroker = "";
  String selectedAsset = "";

  String searchQuery = "";
  TextEditingController searchController = TextEditingController();

  StreamSubscription<Message>? _subscription;
  final MessageHandler _handler = MessageHandler();

  @override
  void initState(){
    super.initState();
    _getNetworthData();

    _subscription = _handler.stream.listen((message) async {
      if(message.what == 100)
      {
        setState(() {
          if(searchController.text != "" && isSearchOpen == true)
          {
            _displaySearchResult("");
          }
          isSearchOpen = !isSearchOpen;
        });
        _handler.sendMessage(Message(103,""));
      }
    });

    if (sessionManagerPMS.getApplicantsList()?.isNotEmpty ?? false)
    {
      listApplicants = [];
      listApplicants.addAll(sessionManagerPMS.getApplicantsList());

      if (listApplicants.isNotEmpty)
      {
        // selectedApplicantName = listApplicants[0];
        selectedApplicant = listApplicants[0];
      }

      print((listApplicants.length));
    }
    else
    {
      listApplicants = [];
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        margin: const EdgeInsets.only(top: 8,bottom: 8),
        child: Padding(
            padding: const EdgeInsets.only(left: 6, right: 6),
            child: Column(
              children: [
                SizedBox(
                  height: 45,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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

                        // GestureDetector(
                        //   onTap: () {
                        //     openFilterDialog(3);
                        //   },
                        //   child: Container(
                        //     padding: const EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
                        //     decoration: BoxDecoration(
                        //       color: white,
                        //       borderRadius: BorderRadius.circular(12)
                        //     ),
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         Text(
                        //           selectedAsset.isEmpty ? "All Assets" : selectedAsset,
                        //           style: getMediumTextStyle(fontSize: 12, color: selectedAsset == "" ? grayDark : blue),
                        //         ),
                        //         const Gap(4),
                        //         selectedAsset.isEmpty ?
                        //         const Icon(Icons.keyboard_arrow_down_outlined) :
                        //         GestureDetector(
                        //           behavior: HitTestBehavior.opaque,
                        //           onTap: () {
                        //             setState(() {
                        //               selectedAsset = "";
                        //               listData = listDataMain;
                        //             });
                        //           },
                        //           child: const Icon(Icons.close, size: 24, color: black,),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // const Gap(8),
                        // GestureDetector(
                        //   onTap: () {
                        //     openFilterDialog(1);
                        //   },
                        //   child: Container(
                        //     padding: const EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
                        //     decoration: BoxDecoration(
                        //         color: white,
                        //         borderRadius: BorderRadius.circular(12)
                        //     ),
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         Text(
                        //           selectedApplicantName.isEmpty ? "Select Applicant" : selectedApplicantName,
                        //           style: getMediumTextStyle(fontSize: 12, color: selectedApplicantName == "" ? grayDark : blue),
                        //         ),
                        //         const Gap(4),
                        //         selectedApplicantName.isEmpty ?
                        //         const Icon(Icons.keyboard_arrow_down_outlined) :
                        //         GestureDetector(
                        //           behavior: HitTestBehavior.opaque,
                        //           onTap: () {
                        //             setState(() {
                        //               selectedApplicantName = "";
                        //             });
                        //             _getNetworthData();
                        //           },
                        //           child: const Icon(Icons.close, size: 24, color: black,),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // const Gap(8),
                        // GestureDetector(
                        //   onTap: () {
                        //    openFilterDialog(2);
                        //   },
                        //   child: Container(
                        //     padding: const EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
                        //     decoration: BoxDecoration(
                        //         color: white,
                        //         borderRadius: BorderRadius.circular(12)
                        //     ),
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         Text(
                        //           selectedBroker.isEmpty ? "Select Brokers" : selectedBroker,
                        //           style: getMediumTextStyle(fontSize: 12, color: selectedBroker == "" ? grayDark : blue),
                        //         ),
                        //         const Gap(4),
                        //         selectedBroker.isEmpty ?
                        //         const Icon(Icons.keyboard_arrow_down_outlined) :
                        //         GestureDetector(
                        //           behavior: HitTestBehavior.opaque,
                        //           onTap: () {
                        //             setState(() {
                        //               selectedBroker = "";
                        //             });
                        //             _getNetworthData();
                        //           },
                        //           child: const Icon(Icons.close, size: 24, color: black,),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
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

                _isLoading
                    ? Expanded(
                  child: Center(
                    child: const LoadingWidget(),
                  ),
                ) :
                listData.isEmpty ?
                    Expanded(
                      child: Center(
                        child: const MyNoDataWidget(msg: "No data found."),
                      ),
                    ) :
                Expanded(
                  child: Column(
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
                ),
              ],
            )),
      ),
    );
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
                                            if (listSelectedAsset.contains(listAssetFilter[index]))
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

                                _getNetworthData();
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
                                _getNetworthData();
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

  _displaySearchResult(String query) {
    searchQuery = query.toLowerCase();
    if (query.isEmpty)
    {
      searchController.clear();
      listData = listDataMain;
    }
    else
    {
      listData = listDataMain.where((element) {
        return element.objectives?.any((obj) {
          return (obj.objective ?? "").toLowerCase().contains(query.toLowerCase());
        }) ?? false;
      }).toList();
    }

    setState(() {});
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
                          // child: _subItemList(listData[index].objectives ?? [],index)
                          child: _subItemList(
                              (listData[index].objectives ?? []).where((obj) {
                                if (searchQuery.isEmpty) return true;
                                return (obj.objective ?? "").toLowerCase().contains(searchQuery);
                              }).toList(),
                              index
                          )
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

/*
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
*/

  _getNetworthData() async {

    setState(() {
      listDataMain = [];
      listData = [];
      _isLoading = true;
    });

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

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_CP + networth);
    Map<String, dynamic> jsonBody = {
      'user_id': sessionManagerPMS.getUserId().trim(),
      "applicant": listSelectedApplicant,
      "broker": listSelectedBroker,
      "asset": listSelectedAsset
    };

    final response = await http.post(url, body: jsonEncode(jsonBody));
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

        if(dataResponse.assetsFilter?.isNotEmpty ?? false)
        {
          listAssetFilter = dataResponse.assetsFilter ?? [];
        }
        else
        {
          listAssetFilter = [];
        }

        print("Display list broker filter : $listBrokerFilter");

        if (dataResponse.result?.networth != null) {

          listDataMain = dataResponse.result?.networth ?? [];
          listData = listDataMain;

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
        listDataMain = [];
        listData = [];
        _isLoading = false;
      });
    }

  }

  @override
  void castStatefulWidget() {
    widget is CPNetworthPage;
  }
}
