import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/widget/no_data.dart';
import '../../../constant/colors.dart';
import '../../../utils/base_class.dart';
import '../../constant/api_end_point.dart';
import '../../constant/e-state-valut/api_end_point.dart';
import '../../model/CommanResponse.dart';
import '../../model/e-state-vault/IntellectualPropertiesResponse.dart';
import '../../utils/app_utils.dart';
import '../../utils/my_toolbar.dart';
import '../../widget/loading.dart';
import 'add_intellectual_property.dart';

class IntellectualPropertyListPage extends StatefulWidget {
  const IntellectualPropertyListPage({Key? key}) : super(key: key);

  @override
  _IntellectualPropertyListPageState createState() => _IntellectualPropertyListPageState();
}

class _IntellectualPropertyListPageState extends BaseState<IntellectualPropertyListPage> {
  bool _isLoading = false;
  List<IntellectualProperties> listData = List<IntellectualProperties>.empty(growable: true);

  @override
  void initState() {
    super.initState();
    if (isOnline) {
      _getApiData();
    } else {
      noInterNet(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: appBg,
      appBar: AppBar(
        toolbarHeight: 55,
        automaticallyImplyLeading: false,
        title: const MyToolBar(pageName: "Intellectual Property"),
        centerTitle: false,
        elevation: 0,
        backgroundColor: appBg,
      ),
      body: SafeArea(
        top: false,
        child: _isLoading
            ? const LoadingWidget()
            : Column(
                children: [
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Stack(
                            children: [
                              listData.isNotEmpty ? Container(
                                child: _itemList(),
                              ) : const MyNoDataWidget(msg: "No data found."),
                              Positioned(
                                  bottom: 40,
                                  right: 10,
                                  child: InkWell(
                                    onTap: ()
                                    {
                                      _redirectAdd(IntellectualProperties(),false);
                                    },
                                    child: Container(
                                    width: 48,
                                    height: 48,
                                    decoration: const BoxDecoration(color: blue, borderRadius: BorderRadius.all(Radius.circular(10))),
                                    child: const Icon(Icons.add, color: white, size: 32)),
                                  ))
                            ],
                          )))
                ],
              ),
      )
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
          color: white,
          child: Column(
            children: [
              Container(
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
                        const Spacer(),
                        GestureDetector(
                          onTap: (){
                            openFileFromURL(checkValidString(listData[index].uploadDoc),context);
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(color: grayLight, borderRadius: BorderRadius.all(Radius.circular(30))),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Image.asset('assets/images/vault_ic_download.png', width: 24, height: 24, color: black),
                            ),
                          ),
                        ),
                        const Gap(10),
                        GestureDetector(
                          onTap: (){
                            _redirectAdd(listData[index],true);
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
                            deleteListData(listData[index], index);
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
                        const Expanded(flex: 2, child: Text(
                          "Lawyer Name",
                          style: TextStyle(color: black, fontSize: 16, fontWeight: FontWeight.w600),
                        )),
                        const Text(
                          " : ",
                          style: TextStyle(color: black, fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        Expanded(flex: 4, child: Text(
                          checkValidString(listData[index].lawyerName),
                          style: const TextStyle(color: black, fontSize: 16, fontWeight: FontWeight.w600),
                        )),
                      ],
                    ),
                    Gap(4),
                    Row(
                      children: [
                        const Expanded(flex: 2, child: Text(
                          "Holder Name",
                          style: TextStyle(color: black, fontSize: 16, fontWeight: FontWeight.w500),
                        )),
                        const Text(
                          " : ",
                          style: TextStyle(color: black, fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        Expanded(flex: 4, child: Text(
                          checkValidString(listData[index].holderName),
                          style: const TextStyle(color: black, fontSize: 16, fontWeight: FontWeight.w500),
                        )),
                      ],
                    ),
                    Gap(4),
                    Row(
                      children: [
                        const Expanded(flex: 2, child: Text(
                          "Firm",
                          style: TextStyle(color: black, fontSize: 16, fontWeight: FontWeight.w500),
                        )),
                        const Text(
                          " : ",
                          style: TextStyle(color: black, fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        Expanded(flex: 4, child: Text(
                          checkValidString(listData[index].firm),
                          style: const TextStyle(color: black, fontSize: 16, fontWeight: FontWeight.w500),
                        )),
                      ],
                    ),
                    Gap(4),
                    Row(
                      children: [
                        const Expanded(flex: 2, child: Text(
                          "Phone",
                          style: TextStyle(color: black, fontSize: 16, fontWeight: FontWeight.w500),
                        )),
                        const Text(
                          " : ",
                          style: TextStyle(color: black, fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        Expanded(flex: 4, child: Text(
                          checkValidString(listData[index].phone),
                          style: const TextStyle(color: black, fontSize: 16, fontWeight: FontWeight.w500),
                        )),
                      ],
                    ),
                    Gap(4),
                    Row(
                      children: [
                        const Expanded(flex: 2, child: Text(
                          "Created on",
                          style: TextStyle(color: black, fontSize: 16, fontWeight: FontWeight.w500),
                        )),
                        const Text(
                          " : ",
                          style: TextStyle(color: black, fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        Expanded(flex: 4, child: Text(
                          checkValidString(listData[index].createdOn),
                          style: const TextStyle(color: black, fontSize: 16, fontWeight: FontWeight.w500),
                        )),
                      ],
                    ),
                    Gap(4),
                    Row(
                      children: [
                        const Expanded(flex: 2, child: Text(
                          "Nominee Name",
                          style: TextStyle(color: black, fontSize: 16, fontWeight: FontWeight.w500),
                        )),
                        const Text(
                          " : ",
                          style: TextStyle(color: black, fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        Expanded(flex: 4, child: Text(
                          checkValidString(listData[index].nomineeName),
                          style: const TextStyle(color: black, fontSize: 16, fontWeight: FontWeight.w500),
                        )),
                      ],
                    ),
                    Gap(4),
                    Row(
                      children: [
                        const Expanded(flex: 2, child: Text(
                          "Location of Document",
                          style: TextStyle(color: black, fontSize: 16, fontWeight: FontWeight.w500),
                        )),
                        const Text(
                          " : ",
                          style: TextStyle(color: black, fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        Expanded(flex: 4, child: Text(
                          checkValidString(listData[index].locationOfDocument),
                          style: const TextStyle(color: black, fontSize: 16, fontWeight: FontWeight.w500),
                        )),
                      ],
                    ),
                    Gap(4),
                    Row(
                      children: [
                        const Expanded(flex: 2, child: Text(
                          "Notes",
                          style: TextStyle(color: black, fontSize: 16, fontWeight: FontWeight.w500),
                        )),
                        const Text(
                          " : ",
                          style: TextStyle(color: black, fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        Expanded(flex: 4, child: Text(
                          checkValidString(listData[index].notes),
                          style: const TextStyle(color: black, fontSize: 16, fontWeight: FontWeight.w500),
                        )),
                      ],
                    ),
                    Gap(4),
                    Row(
                      children: [
                        const Expanded(flex: 2, child: Text(
                          "Address",
                          style: TextStyle(color: black, fontSize: 16, fontWeight: FontWeight.w500),
                        )),
                        const Text(
                          " : ",
                          style: TextStyle(color: black, fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        Expanded(flex: 4, child: Text(
                          checkValidString(listData[index].address),
                          style: const TextStyle(color: black, fontSize: 16, fontWeight: FontWeight.w500),
                        )),
                      ],
                    ),
                    Gap(4),
                    Row(
                      children: [
                        const Expanded(flex: 2, child: Text(
                          "Description",
                          style: TextStyle(color: black, fontSize: 16, fontWeight: FontWeight.w500),
                        )),
                        const Text(
                          " : ",
                          style: TextStyle(color: black, fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        Expanded(flex: 4, child: Text(
                          checkValidString(listData[index].description),
                          style: const TextStyle(color: black, fontSize: 16, fontWeight: FontWeight.w500),
                        )),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )));
  }

  Future<void> _redirectAdd(IntellectualProperties listData, bool isFor) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddIntellectualPropertyPage(listData, isFor)),
    );
    print("result ===== $result");
    if (result == "success") {
      setState(() {
      });
      _getApiData();
    }
  }

  _getApiData() async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_VAULT + intellectualPropertyList);
    Map<String, String> jsonBody = {'user_id': sessionManagerVault.getUserId().trim()};

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = IntellectualPropertiesResponse.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1)
    {
      try {
        if (dataResponse.intellectualProperties != null) {
          listData = dataResponse.intellectualProperties!;
          setState(() {
            _isLoading = false;
          });
        }
      } catch (e) {
        listData = [];
        showSnackBar(dataResponse.message, context);
        setState(() {
          _isLoading = false;
        });
        print(e);
      }
    }
    else {
      listData = [];
      //showSnackBar(dataResponse.message, context);
      _redirectAdd(IntellectualProperties(), false);
      setState(() {
        _isLoading = false;
      });
    }
  }

  void deleteListData(IntellectualProperties data, int index) {
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
                                  deleteData(index);
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

    final url = Uri.parse(API_URL_VAULT + deleteIntellectualProperty);

    Map<String, String> jsonBody = {
      'intellectual_property_id': listData[index].intellectualPropertyId.toString(),
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
      'module':"delete-intellectual_property",
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


  @override
  void castStatefulWidget() {
    widget is IntellectualPropertyListPage;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
