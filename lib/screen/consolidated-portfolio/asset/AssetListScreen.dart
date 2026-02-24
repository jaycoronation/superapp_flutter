import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/model/consolidated-portfolio/assets/AssetListResponseModel.dart';
import 'package:superapp_flutter/widget/loading.dart';

import '../../../common_widget/common_widget.dart';
import '../../../constant/colors.dart';
import '../../../constant/consolidate-portfolio/api_end_point.dart';
import '../../../model/CommanResponse.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/base_class.dart';

class AssetListScreen extends StatefulWidget {
  const AssetListScreen({super.key});

  @override
  BaseState<AssetListScreen> createState() => AssetListScreenState();
}

class AssetListScreenState extends BaseState<AssetListScreen> {

  bool _isLoading = false;
  List<Assets> listAssets = [];

  @override
  void initState() {
    getAssetsListApi();
    super.initState();
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
      backgroundColor: const Color(0XffEDEDEE),
      body: _isLoading
          ? LoadingWidget()
          : Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
            itemCount: listAssets.length,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 8,right: 8,top: 14,bottom: 14),
                        decoration: BoxDecoration(
                            color: index % 2 == 0 ? white : semiBlue,
                            borderRadius: index == listAssets.length - 1 ? const BorderRadius.only(bottomLeft:Radius.circular(8),bottomRight: Radius.circular(8)) : const BorderRadius.all(Radius.circular(0))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                      toDisplayCase(listAssets[index].firstHolder ?? ''),
                                      style: const TextStyle(
                                          color: black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700)),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    // _redirectAdd(listData[index],true);
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
                                    // deleteListData(listData[index], index);

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
                            Text(convertCommaSeparatedAmount(listAssets[index].currentValue.toString()),
                                style: const TextStyle(
                                    color: black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w200)),
                            Text(
                                listAssets[index].investmentType,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700)),
                            Text(
                                listAssets[index].assetClass,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700)),
                            Text(
                                listAssets[index].companyName,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700)),
                            Text(
                                listAssets[index].brokerAdvisor,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700)),
                            Text(
                                listAssets[index].propertyName,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700)),
                            Text(
                                listAssets[index].schemeBankName,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
          )
        ],
      ),
    );
  }

  getAssetsListApi() async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_CP + getAssetsList);
    Map<String, String> jsonBody = {
      'user_id': sessionManagerPMS.getUserId().trim(),
      'from_aggrigator': "no",
      'loadArchives': "no",
      'is_from_superapp': "yes",
      'limit': "15",
      'page': "1",
      'search_string': "",
    };

    // from_aggrigator
    // :
    // "no"
    // is_from_superapp
    // :
    // "yes"
    // limit
    // :
    // "15"
    // loadArchives
    // :
    // "no"
    // page
    // :
    // "1"
    // search_string
    // :
    // ""
    // user_id
    // :
    // "500"

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = AssetListResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      try {
        if (dataResponse.assets != null) {
          listAssets = dataResponse.assets ?? [];


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