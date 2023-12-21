import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/constant/colors.dart';
import 'package:superapp_flutter/utils/app_utils.dart';
import 'package:superapp_flutter/utils/my_toolbar.dart';
import '../../constant/e-state-valut/api_end_point.dart';
import '../../model/e-state-vault/ShareDataReportResponse.dart';
import '../../model/e-state-vault/share_data_model.dart';
import '../../utils/base_class.dart';
import '../../widget/loading.dart';

class ShareReportPage extends StatefulWidget {
  ShareReportPage({Key? key}) : super(key: key);
  @override
  BaseState<ShareReportPage> createState() => _ShareReportPageState();
}

class _ShareReportPageState extends BaseState<ShareReportPage> {
  bool _isLoading = false;
  bool isSubmitClick = false;
  List<ShareDataGetSet> listData = List<ShareDataGetSet>.empty(growable: true);
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    addMoreViews(ShareDataGetSet());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBg,
        appBar: AppBar(
          toolbarHeight: 55,
          automaticallyImplyLeading: false,
          title: const MyToolBar(pageName: "Share Data"),
          centerTitle: false,
          elevation: 0,
          backgroundColor: appBg,
        ),
        body: _isLoading ? const LoadingWidget() : setData());
  }

  SafeArea setData() {
    return SafeArea(
      child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                listItemData(),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    cursorColor: black,
                    controller: _passwordController,
                    decoration: const InputDecoration(
                        labelText: 'Set Password for Report (optional)',
                    ),
                    style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30, bottom: 10, left: 10, right: 10),
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: blue,
                        onPrimary: blue,
                        elevation: 0.0,
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                        side: const BorderSide(color: blue, width: 1.0, style: BorderStyle.solid),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kButtonCornerRadius)),
                        tapTargetSize: MaterialTapTargetSize.padded,
                        animationDuration: const Duration(milliseconds: 100),
                        enableFeedback: true,
                        alignment: Alignment.center,
                      ),
                      onPressed: ()
                      {
                        setState(()
                        {
                          isSubmitClick = true;
                          return;
                        });

                        if (isValidData())
                        {
                          var data = _makeJsonData();
                           if (isInternetConnected) {
                              _saveDataCall(data);
                            FocusScope.of(context).unfocus();
                          } else {
                            noInterNet(context);
                          }
                        }
                      }, //set both onPressed and onLongPressed to null to see the disabled properties
                      onLongPress: () => {}, //set both onPressed and onLongPressed to null to see the disabled properties
                      child: const Text(
                        "Share",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: white, fontWeight: FontWeight.w600),
                      )),
                ),
              ],
            ),
          )),
    );
  }

  Column listItemData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            padding: EdgeInsets.zero,
            itemCount: listData.length,
            itemBuilder: (ctx, index) => (GestureDetector(
                onTap: () async {},
                child: Container(
                  alignment: Alignment.topLeft,
                  width: double.infinity,
                  color: white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: black,
                          controller: listData[index].emailController,
                          onChanged: (text) {
                            setState(() {
                              listData[index].setEmail = text;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                            errorText: checkErrorForEmail(index).isEmpty ? null : checkErrorForEmail(index),
                          ),
                          style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
                        ),
                      ),
                      index == 0
                          ? Container()
                          : Container(
                          alignment: Alignment.centerRight,
                          margin: const EdgeInsets.only(top: 12, right: 10),
                          height: 32,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: white,
                                //button's fill color
                                onPrimary: white,
                                //specify the color of the button's text and icons as well as the overlay colors used to indicate the hover, focus, and pressed states
                                elevation: 0.0,
                                //buttons Material shadow
                                //specify the button's text TextStyle
                                side: const BorderSide(color: blue, width: 0.7, style: BorderStyle.solid),
                                padding: const EdgeInsets.only(left: 22.0, right: 22.0),
                                //set border for the button
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                                // set the buttons shape. Make its birders rounded etc
                                tapTargetSize: MaterialTapTargetSize.padded,
                                // set the MaterialTapTarget size. can set to: values, padded and shrinkWrap properties
                                animationDuration: const Duration(milliseconds: 100),
                                //the buttons animations duration
                                enableFeedback: true,
                                //to set the feedback to true or false
                                alignment: Alignment.center, //set the button's child Alignment
                              ),
                              onPressed: () {
                                setState(() {
                                  listData.removeAt(index);
                                });
                              }, //set both onPressed and onLongPressed to null to see the disabled properties
                              onLongPress: () => {}, //set both onPressed and onLongPressed to null to see the disabled properties
                              child: const Text(
                                "Remove",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14, color: blue, fontWeight: FontWeight.w600),
                              ))),
                    ],
                  ),
                )))),
        Row(
          children: [
            Expanded(flex: 1, child: Container()),
            Container(
              margin: const EdgeInsets.only(top: 12),
              height: 36,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: white,
                    onPrimary: white,
                    //specify the color of the button's text and icons as well as the overlay colors used to indicate the hover, focus, and pressed states
                    elevation: 0.0,
                    side: const BorderSide(color: blue, width: 0.7, style: BorderStyle.solid),
                    padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                    //set border for the button
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    // set the buttons shape. Make its birders rounded etc
                    tapTargetSize: MaterialTapTargetSize.padded,
                    // set the MaterialTapTarget size. can set to: values, padded and shrinkWrap properties
                    animationDuration: const Duration(milliseconds: 100),
                    //the buttons animations duration
                    enableFeedback: true,
                    //to set the feedback to true or false
                    alignment: Alignment.center, //set the button's child Alignment
                  ),
                  onPressed: () {
                    addMoreViews(ShareDataGetSet());
                  }, //set both onPressed and onLongPressed to null to see the disabled properties
                  onLongPress: () => {}, //set both onPressed and onLongPressed to null to see the disabled properties
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: blue, size: 16),
                      Text(
                        "Add More",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: blue, fontWeight: FontWeight.w600),
                      )
                    ],
                  )),
            ),
            Expanded(flex: 1, child: Container()),
          ],
        )
      ],
    );
  }

  void addMoreViews(ShareDataGetSet data) {
    setState(() {
      data.setEmail = "";
      listData.add(data);
    });
  }

  String checkErrorForEmail(int index) {
    String value = "";
    if (isSubmitClick) {
      if (checkValidString(listData[index].email).isEmpty) {
        value = "Email Address Can\'t Be Empty";
      } else if (!isValidEmail(checkValidString(listData[index].email))) {
        value = "Enter Valid Email Address";
      }
    }
    return value;
  }

  bool isValidData() {
    bool isValid = true;
    for (int i = 0; i < listData.length; i++)
    {
      var itemData = listData[i];
      if (checkValidString(itemData.email).isEmpty)
      {
        isValid = false;
        showSnackBar("Email Address Can\'t Be Empty", context);
        break;
      } else if (!isValidEmail(checkValidString(itemData.email)))
      {
        isValid = false;
        showSnackBar("Enter Valid Email Address", context);
        break;
      }
      else
      {
          continue;
      }
    }
    return isValid;
  }


   String _makeJsonData()  {
    String jsonData = "";
    for (int i = 0; i < listData.length; i++)
    {
      var itemData = listData[i];
      if(jsonData.isEmpty)
      {
        jsonData = itemData.email.toString().trim();
      }
      else
      {
        jsonData = "$jsonData,${itemData.email.toString().trim()}";
      }
    }
    return jsonData;
  }

  _saveDataCall(String data) async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_VAULT + generatePDF);
    Map<String, String> jsonBody = {
      'user_id': sessionManagerVault.getUserId().trim(),
      'email_addresses' : data,
      'password' : _passwordController.text.toString().trim().isNotEmpty ? _passwordController.text.toString().trim() : ""
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = ShareDataReportResponse.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1)
    {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(dataResponse.message, context);
      if(checkValidString(dataResponse.urlData).toString().isNotEmpty)
      {
        openFileFromURL(dataResponse.urlData.toString(), context);
      }
      Navigator.pop(context);
    }
    else {
      showSnackBar(dataResponse.message, context);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void castStatefulWidget() {
    widget is ShareReportPage;
  }
}
