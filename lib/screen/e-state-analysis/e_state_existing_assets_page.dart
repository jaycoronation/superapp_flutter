import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/constant/analysis_api_end_point.dart';
import 'package:superapp_flutter/model/CommanResponse.dart';
import 'package:superapp_flutter/model/e-state-analysis/existing_assets_response_model.dart';
import '../../constant/api_end_point.dart';
import '../../constant/colors.dart';
import '../../utils/app_utils.dart';
import '../../utils/base_class.dart';
import '../../widget/loading.dart';
import '../../widget/no_data.dart';
import '../../widget/no_internet.dart';
import 'e_state_add_existing_assets_page.dart';

class EStateExistingAssetsPage extends StatefulWidget {
  const EStateExistingAssetsPage({Key? key}) : super(key: key);

  @override
  _EStateExistingAssetsPageState createState() => _EStateExistingAssetsPageState();
}

class _EStateExistingAssetsPageState extends BaseState<EStateExistingAssetsPage> {
  List<ExistingAssets> listData = List<ExistingAssets>.empty();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    if(isInternetConnected) {
      getListData();
    }else{
      noInterNet(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          toolbarHeight: 55,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(right: 8),
                          child: Image.asset('assets/images/fin_plan_ic_back_arrow.png',height: 30, width: 30, color: black,),
                        )),
                    const Expanded(child: Text("Existing Assets",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 16, color: black, fontWeight: FontWeight.w600),
                    )),
                  ],
                ),
              ],
            ),
          ),
          centerTitle: false,
          elevation: 0,
          backgroundColor: white,
        ),
        body: isInternetConnected
            ? _isLoading
            ? const LoadingWidget()
            : SafeArea(
          child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: listData.isEmpty ?
              const Center(
                  child: MyNoDataWidget(msg: 'No existing assets found!')
              )
                  :AnimationLimiter(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    primary: false,
                    padding: EdgeInsets.zero,
                    itemCount: listData.length,
                    itemBuilder: (ctx, index) => AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: Container(
                            margin: const EdgeInsets.only(top: 5),
                            /*decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:Border.all(color: grayLight, width: 1,)
                          ),*/
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Visibility(
                                        visible: listData[index].canDelete == "0",
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            InkWell(
                                                onTap:(){
                                                  _redirectToNextPage(context, listData[index], true);
                                                },
                                                child: Container(
                                                  width: 36,
                                                  height: 36,
                                                  decoration: BoxDecoration(color: grayLight,
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  // padding: const EdgeInsets.all(8),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: Image.asset('assets/images/fin_plan_ic_edit_gray.png',
                                                      color: black, ),
                                                  ),
                                                )
                                            ),
                                            const Gap(10),
                                            InkWell(
                                                onTap:(){
                                                  deleteListData(listData[index], index);
                                                },
                                                child: Container(
                                                  width: 36,
                                                  height: 36,
                                                  decoration: BoxDecoration(color: grayLight,
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  // padding: const EdgeInsets.all(8),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(7.0),
                                                    child: Image.asset('assets/images/fin_plan_ic_delete_black.png',
                                                      color: black, ),
                                                  ),
                                                )
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(checkValidString(listData[index].investmentType.toString()), textAlign: TextAlign.start,
                                        style: const TextStyle(fontSize: 15, color: black, fontWeight: FontWeight.bold),
                                      ),
                                      const Gap(6),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Expanded(
                                            flex:4,
                                            child: Text("Current Value", textAlign: TextAlign.start,
                                              style: TextStyle(fontSize: 14, color: graySemiDark, fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          const Text("  :  ", textAlign: TextAlign.start,
                                            style: TextStyle(fontSize: 14, color: graySemiDark, fontWeight: FontWeight.w600),
                                          ),
                                          Expanded(
                                            flex:6,
                                            child: Text(checkValidString(getPrice(listData[index].currentValue.toString())), textAlign: TextAlign.start,
                                              style: const TextStyle(fontSize: 14, color: black, fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Gap(8),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Expanded(
                                            flex:4,
                                            child: Text("Assets Type", textAlign: TextAlign.start,
                                              style: TextStyle(fontSize: 14, color: graySemiDark, fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          const Text("  :  ", textAlign: TextAlign.start,
                                            style: TextStyle(fontSize: 14, color: graySemiDark, fontWeight: FontWeight.w600),
                                          ),
                                          Expanded(
                                            flex:6,
                                            child: Text(checkValidString(listData[index].assetType), textAlign: TextAlign.start,
                                              style: const TextStyle(fontSize: 14, color: black, fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                ),
              )
          ),)
            : const NoInternetWidget(),
        floatingActionButton: //listData.isNotEmpty ?
        FloatingActionButton(
          onPressed: (){
            _redirectToNextPage(context, ExistingAssets(), false);
          },
          backgroundColor: blue,
          child: const Icon(Icons.add, color: white,),
        )
      //: Container(),
    );
  }

  void refreshData() {
    _redirectToNextPage(context, ExistingAssets(), false);
  }

  void deleteListData(ExistingAssets listData, int index) {
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
                                      backgroundColor: MaterialStateProperty.all<Color>(white)),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancel", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: blue)),
                                ))),
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
                                  deleteModule();
                                });
                              },
                              child: const Text("Delete", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: white)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(30)
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _redirectToNextPage(BuildContext context, ExistingAssets existingAssets, bool isFromList) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EStateAddExistingAssetsPage(existingAssets, isFromList)),
    );
    print("result ===== $result");
    if (result == "success") {
      setState(() {

      });
      getListData();
    }
  }

  @override
  void castStatefulWidget() {
    widget is EStateExistingAssetsPage;
  }

  //API call func..
  void getListData() async {
    if(isInternetConnected) {
      setState(() {
        _isLoading = true;
      });
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(API_URL_ANALYSIS + existingAssetsList);

      Map<String, String> jsonBody = {
        'user_id': sessionManager.getUserId().toString().trim(),
      };

      final response = await http.post(url, body: jsonBody);
      final statusCode = response.statusCode;

      final body = response.body;
      Map<String, dynamic> user = jsonDecode(body);
      var dataResponse = ExistingAssetsResponseModel.fromJson(user);

      if (statusCode == 200 && dataResponse.success == 1) {

        listData = [];
        if(dataResponse.existingAssets != null) {
          if(dataResponse.existingAssets!.isNotEmpty) {

            listData = dataResponse.existingAssets!;
          }
        }

        if(listData.isEmpty) {
          // _addBank(context, Bank());

          Timer(const Duration(seconds: 2), () =>
              setState(() {
                _isLoading = false;
                // _isNoDataVisible = false;
              })
          );
        }else {
          Timer(const Duration(seconds: 2), () =>
              setState(() {
                _isLoading = false;
                // _isNoDataVisible = true;
              })
          );
        }

        // print("listData.length 2==>" + listData.length.toString());

      } else {
        // _addBank(context, Bank());
        Timer(const Duration(seconds: 2), () =>
            setState(() {
              listData = [];
              _isLoading = false;
              // _isNoDataVisible = true;
            })
        );
        showSnackBar(dataResponse.message, context);
      }
    }else {
      noInterNet(context);
    }
  }

  void deleteData(int index) async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_ANALYSIS + existingAssetsDelete);

    Map<String, String> jsonBody = {
      'existing_assets_id': listData[index].existingAssetsId.toString(),
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = CommanResponse.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      showSnackBar(dataResponse.message, context);

      setState(() {
        listData.removeAt(index);
        _isLoading = false;
      });

    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void deleteModule() async {

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_ADD + add);

    Map<String, String> jsonBody = {
      'module':"delete-existing_assets",
      'user_id':sessionManagerPMS.getUserId().toString().trim(),
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = CommanResponse.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {

    } else {

    }
  }

}