import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/model/consolidated-portfolio/assets/AssetListResponseModel.dart';
import 'package:superapp_flutter/screen/consolidated-portfolio/asset/AddAssetScreen.dart';
import 'package:superapp_flutter/widget/loading.dart';

import '../../../common_widget/common_widget.dart';
import '../../../constant/colors.dart';
import '../../../constant/consolidate-portfolio/api_end_point.dart';
import '../../../model/CommanResponse.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/base_class.dart';
import '../../../widget/loading_more.dart';

class AssetListScreen extends StatefulWidget {
  const AssetListScreen({super.key});

  @override
  BaseState<AssetListScreen> createState() => AssetListScreenState();
}

class AssetListScreenState extends BaseState<AssetListScreen> {

  bool _isLoading = false;
  List<Assets> listAssets = [];

  bool isLoadingMore = false;
  int pageIndex = 1;
  int pageResult = 20;
  bool isLastPage = false;
  bool isScrollingDown = false;
  bool isSearchShow = false;
  late ScrollController _scrollViewController;


  @override
  void initState() {
    getAssetsListApi(true);

    _scrollViewController = ScrollController();
    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection == ScrollDirection.reverse)
      {
        if (!isScrollingDown)
        {
          isScrollingDown = true;
          setState(() => {});
        }
      }

      if (_scrollViewController.position.userScrollDirection == ScrollDirection.forward)
      {
        if (isScrollingDown)
        {
          isScrollingDown = false;
          setState(() => {});
        }
      }
      pagination();
    });
    super.initState();
  }

  void pagination() {
    if (!isLastPage && !isLoadingMore && listAssets.isNotEmpty)
    {
      if ((_scrollViewController.position.pixels == _scrollViewController.position.maxScrollExtent))
      {
        setState(() {
          isLoadingMore = true;
        });
        getAssetsListApi(false);
      }
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
          title: getTitle("Assets",)
      ),
      // backgroundColor: const Color(0XffEDEDEE),
      backgroundColor: white,
      body: _isLoading
          ? LoadingWidget()
          : Padding(
            padding: const EdgeInsets.only(left: 15, right: 15), 
            child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: listAssets.length,
                              controller: _scrollViewController,
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: const EdgeInsets.all(15),
                                  margin: const EdgeInsets.only(top: 8, bottom: 8),
                                  decoration: const BoxDecoration(color: semiBlue, borderRadius: BorderRadius.all(Radius.circular(10))),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              listAssets[index].firstHolder ?? '',
                                              style: const TextStyle(color: black, fontSize: 16, fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          const Gap(10),
                                          GestureDetector(
                                            onTap: (){
                                            },
                                            child: Container(
                                              width: 32,
                                              height: 32,
                                              decoration: const BoxDecoration(color: grayLight, borderRadius: BorderRadius.all(Radius.circular(30))),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8),
                                                child: Image.asset('assets/images/fin_plan_ic_edit_gray.png', width: 24, height: 24, color: black),
                                              ),
                                            ),
                                          ),
                                          const Gap(10),
                                          InkWell(
                                            onTap: (){
                                              deleteListData(listAssets[index], index);
                                            },
                                            child: Container(
                                                width: 32,
                                                height: 32,
                                                decoration: const BoxDecoration(color: grayLight, borderRadius: BorderRadius.all(Radius.circular(30))),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(5),
                                                  child: Image.asset('assets/images/fin_plan_ic_delete_black.png', width: 24, height: 24, color: black),
                                                )),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Expanded(
                                              flex: 2,
                                              child: Text(
                                                "Current Value",
                                                maxLines: 3,
                                                style: TextStyle(color: black, fontSize: 12, fontWeight: FontWeight.w500),
                                              )
                                          ),
                                          const Text(
                                            " : ",
                                            maxLines: 3,
                                            style: TextStyle(color: black, fontSize: 14, fontWeight: FontWeight.w500),
                                          ),
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                convertCommaSeparatedAmount(listAssets[index].currentValue.toString()),
                                                maxLines: 3,
                                                style: const TextStyle(color: black, fontSize: 14, fontWeight: FontWeight.w500),
                                              )
                                          ),
                                        ],
                                      ),
                                      Gap(4),
                                      Row(
                                        children: [
                                          const Expanded(flex: 2, child: Text(
                                            "Investment Type",
                                            maxLines: 3,
                                            style: TextStyle(color: black, fontSize: 12, fontWeight: FontWeight.w500),
                                          )),
                                          const Text(
                                            " : ",
                                            maxLines: 3,
                                            style: TextStyle(color: black, fontSize: 15, fontWeight: FontWeight.w500),
                                          ),
                                          Expanded(flex: 4, child: Text(
                                            listAssets[index].investmentType?.isEmpty ?? true ? "-" :  listAssets[index].investmentType ?? '',
                                            maxLines: 3,
                                            style: const TextStyle(color: black, fontSize: 14, fontWeight: FontWeight.w500),
                                          )),
                                        ],
                                      ),
                                      Gap(4),
                                      Row(
                                        children: [
                                          const Expanded(flex: 2, child: Text(
                                            "Asset Class",
                                            maxLines: 3,
                                            style: TextStyle(color: black, fontSize: 12, fontWeight: FontWeight.w500),
                                          )),
                                          const Text(
                                            " : ",
                                            maxLines: 3,
                                            style: TextStyle(color: black, fontSize: 15, fontWeight: FontWeight.w500),
                                          ),
                                          Expanded(flex: 4, child: Text(
                                            listAssets[index].assetClass?.isEmpty ?? true ? "-" :  listAssets[index].assetClass ?? '',
                                            maxLines: 3,
                                            style: const TextStyle(color: black, fontSize: 14, fontWeight: FontWeight.w500),
                                          )),
                                        ],
                                      ),
                                      Gap(4),
                                      Row(
                                        children: [
                                          const Expanded(flex: 2, child: Text(
                                            "Company",
                                            maxLines: 3,
                                            style: TextStyle(color: black, fontSize: 12, fontWeight: FontWeight.w500),
                                          )),
                                          const Text(
                                            " : ",
                                            maxLines: 3,
                                            style: TextStyle(color: black, fontSize: 15, fontWeight: FontWeight.w500),
                                          ),
                                          Expanded(flex: 4, child: Text(
                                            listAssets[index].companyName?.isEmpty ?? true ? "-" :  listAssets[index].companyName ?? '',
                                            maxLines: 3,
                                            style: const TextStyle(color: black, fontSize: 14, fontWeight: FontWeight.w500),
                                          )),
                                        ],
                                      ),
                                      Gap(4),
                                      Row(
                                        children: [
                                          const Expanded(flex: 2, child: Text(
                                            "Broker",
                                            maxLines: 3,
                                            style: TextStyle(color: black, fontSize: 12, fontWeight: FontWeight.w500),
                                          )),
                                          const Text(
                                            " : ",
                                            maxLines: 3,
                                            style: TextStyle(color: black, fontSize: 15, fontWeight: FontWeight.w500),
                                          ),
                                          Expanded(flex: 4, child: Text(
                                            listAssets[index].brokerAdvisor?.isEmpty ?? true ? "-" :  listAssets[index].brokerAdvisor ?? '',
                                            maxLines: 3,
                                            style: const TextStyle(color: black, fontSize: 14, fontWeight: FontWeight.w500),
                                          )),
                                        ],
                                      ),
                                      Gap(4),
                                      Row(
                                        children: [
                                          const Expanded(flex: 2, child: Text(
                                            "Property",
                                            maxLines: 3,
                                            style: TextStyle(color: black, fontSize: 12, fontWeight: FontWeight.w500),
                                          )),
                                          const Text(
                                            " : ",
                                            maxLines: 3,
                                            style: TextStyle(color: black, fontSize: 15, fontWeight: FontWeight.w500),
                                          ),
                                          Expanded(flex: 4, child: Text(
                                            listAssets[index].propertyName?.isEmpty ?? true ? "-" :  listAssets[index].propertyName ?? '',
                                            maxLines: 3,
                                            style: const TextStyle(color: black, fontSize: 14, fontWeight: FontWeight.w500),
                                          )),
                                        ],
                                      ),
    
                                      Gap(4),
                                      Row(
                                        children: [
                                          const Expanded(flex: 2, child: Text(
                                            "Scheme/Bank Name",
                                            maxLines: 3,
                                            style: TextStyle(color: black, fontSize: 12, fontWeight: FontWeight.w500),
                                          )),
                                          const Text(
                                            " : ",
                                            maxLines: 3,
                                            style: TextStyle(color: black, fontSize: 15, fontWeight: FontWeight.w500),
                                          ),
                                          Expanded(flex: 4, child: Text(
                                            listAssets[index].schemeBankName?.isEmpty ?? true ? "-" : listAssets[index].schemeBankName ?? '',
                                            maxLines: 3,
                                            style: const TextStyle(color: black, fontSize: 14, fontWeight: FontWeight.w500),
                                          )),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          Visibility(visible: isLoadingMore, child: const LoadingMoreWidget()),
                        ],
                      ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            startActivity(context, AddAssetScreen());
          },
          backgroundColor: blue,
          child: const Icon(Icons.add, color: white,),
        )
    );
  }

  getAssetsListApi(bool isFirstTime) async {
    if (isFirstTime)
    {
      setState(() {
        isLastPage = false;
        pageIndex = 1;
        isLoadingMore = false;
        _isLoading = true;
      });
    }

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_CP + getAssetsList);
    Map<String, String> jsonBody = {
      // 'user_id': sessionManagerPMS.getUserId().trim(),
      'user_id': '423',
      'from_aggrigator': "no",
      'loadArchives': "no",
      'is_from_superapp': "yes",
      'limit': pageResult.toString(),
      'page': pageIndex.toString(),
      'search_string': "",
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = AssetListResponseModel.fromJson(user);

    if (isFirstTime)
    {
      listAssets = [];
    }

    if (statusCode == 200 && dataResponse.success == 1) {
      try
      {
        List<Assets>? _tempList = dataResponse.assets ?? [];
        listAssets.addAll(_tempList);

        if (_tempList.isNotEmpty)
        {
          pageIndex += 1;
          if (_tempList.isEmpty || _tempList.length % pageResult != 0)
          {
            isLastPage = true;
          }
        }
      }
      catch(error)
      {
        print("display error : $error");
      }

      setState(() {
        _isLoading = false;
        isLoadingMore = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void deleteListData(Assets listData, int index) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      builder: (BuildContext context) {
        return Wrap(
          children: [
            Container(
              margin: const EdgeInsets.all(15),
              decoration:
              const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)), color: white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 2,
                    width: 40,
                    alignment: Alignment.center,
                    color: black,
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      child: const Text('Delete?', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: black))),
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 15),
                    child: const Text('Are you sure you want to delete this entry?',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: black)),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15, bottom: 12, top: 20),
                    child: Row(
                      children: [
                        Expanded(
                            child: SizedBox(
                                height: kButtonHeight,
                                child: TextButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          side: const BorderSide(width: 1, color: blue),
                                          borderRadius: BorderRadius.circular(kBorderRadius),
                                        ),
                                      ),
                                      backgroundColor: MaterialStateProperty.all<Color>(white)
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancel", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: blue)),
                                )
                            )
                        ),
                        const Gap(20),
                        Expanded(
                          child: SizedBox(
                            height: kButtonHeight,
                            child: TextButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(kBorderRadius),
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all<Color>(blue)),
                              onPressed: () {
                                Navigator.pop(context);
                                setState(() {
                                  deleteData( index);
                                });
                              },
                              child: const Text("Delete", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: white)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(30)
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void deleteData(int index) async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_CP + assetDelete);

    Map<String, String> jsonBody = {
      'assets_id': listAssets[index].id ?? '',
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = CommanResponse.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      showSnackBar(dataResponse.message, context);

      setState(() {
        listAssets.removeAt(index);
        _isLoading = false;
      });

    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void castStatefulWidget() {
    widget is AssetListScreen;
  }
}