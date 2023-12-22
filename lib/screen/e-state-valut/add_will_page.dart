import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/constant/colors.dart';
import 'package:superapp_flutter/utils/my_toolbar.dart';
import '../../constant/api_end_point.dart';
import '../../constant/e-state-valut/api_end_point.dart';
import '../../constant/global_context.dart';
import '../../model/CommanResponse.dart';
import '../../model/e-state-vault/WillDataResponse.dart';
import '../../utils/app_utils.dart';
import '../../utils/base_class.dart';
import '../../widget/loading.dart';

class AddWillPage extends StatefulWidget {

  AddWillPage({Key? key}) : super(key: key);

  @override
  BaseState<AddWillPage> createState() => _AddWillPageState();
}

class _AddWillPageState extends BaseState<AddWillPage> {
  bool _isLoading = false;
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  bool _validController1 = true;
  bool _validController2 = true;
  var willId = "";
  var filePath = "";

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
        backgroundColor: appBg,
        appBar: AppBar(
          toolbarHeight: 55,
          automaticallyImplyLeading: false,
          title: MyToolBar(pageName: "Will"),
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
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: const Text(
                    "Enter details of your Will",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 15, color: black, fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top:10,left: 15, right: 10),
                  child: const Text(
                    "Where is your original Will located?",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 15, color: grayDark, fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    cursorColor: black,
                    controller: _controller1,
                    onChanged: (text) {
                      setState(() {
                        if (text.isEmpty) {
                          _validController1 = false;
                        } else {
                          _validController1 = true;
                        }
                      });
                    },
                    decoration: InputDecoration(
                        labelText: '',
                        errorText: _validController1 ? null : "Please enter Where is your original Will located?"

                    ),
                    style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top:10,left: 15, right: 10),
                  child: const Text(
                    "Upload Document",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 15, color: grayDark, fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    cursorColor: black,
                    controller: _controller2,
                    readOnly: true,
                    onTap: () {
                      pickImagesFromGallery();
                    },
                    onChanged: (text) {
                      setState(() {
                        if (text.isEmpty) {
                          _validController2 = false;
                        } else {
                          _validController2 = true;
                        }
                      });
                    },
                    decoration: InputDecoration(
                        labelText: '',
                        errorText: _validController2 ? null : "Please upload document"

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
                      onPressed: () {
                        if(_controller1.text.isEmpty)
                        {
                          setState(() {
                            _validController1 = false;
                            return;
                          });
                        }
                        else if(_controller2.text.isEmpty)
                        {
                          setState(() {
                            _validController2 = false;
                            return;
                          });
                        }
                        else
                        {
                          if (isInternetConnected) {
                            _saveDataCall(_makeJsonData());
                            FocusScope.of(context).unfocus();
                          } else {
                            noInterNet(context);
                          }
                        }
                      }, //set both onPressed and onLongPressed to null to see the disabled properties
                      onLongPress: () => {}, //set both onPressed and onLongPressed to null to see the disabled properties
                      child: const Text(
                        "Save",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: white, fontWeight: FontWeight.w600),
                      )),
                ),
              ],
            ),
          )),
    );
  }

  Future<void> pickImagesFromGallery() async
  {
    try
    {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null)
      {
        File file = File(result.files.single.path.toString());
        setState(() {
          filePath = file.path;
          var fileName = file.path.split(Platform.pathSeparator).last;
          _controller2.text = fileName;
        });
      }
      else
      {
        showSnackBar("No file is selected.", context);
      }
    } on Exception catch (e)
    {
      print(e);
    }
  }

  _getApiData() async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_VAULT + getWillData);
    Map<String, String> jsonBody = {'user_id': sessionManagerVault.getUserId().trim()};

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> jsonData = jsonDecode(body);

    if (statusCode == 200 && jsonData['success'] == 1)
    {
      List<WillDataResponse> itemData = [];
      final parsedJson = jsonData['will'];
      parsedJson.forEach((key, value)
      {
        if(key == NavigationService.accountHolder[0].holderId)
        {
          itemData.add(WillDataResponse.fromJson(value));
        }
      });

      if(itemData.isNotEmpty)
      {
        var data = WillDataResponse();
        data = itemData[0];
        willId = checkValidString(data.willId);
        _controller1.text = checkValidString(data.originalWillLocated);

        if(checkValidString(data.uploadDocReview).toString().isNotEmpty)
        {
          filePath = checkValidString(data.uploadDocReview);
          var fileName = checkValidString(data.uploadDocReview).split(Platform.pathSeparator).last;
          _controller2.text = fileName;
        }
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  String _makeJsonData()  {
    String jsonData = "";

    try {

      Map<String, dynamic> objSelectedValueMain = <String, dynamic>{};

      Map<String, dynamic> objSelectedValue = <String, dynamic>{};
      objSelectedValue[NavigationService.accountHolder[0].holderId.toString()] =  makeData();

      objSelectedValueMain["items"] = objSelectedValue;
      jsonData = jsonEncode(objSelectedValueMain).toString();
      print("<><> JSON DATA "+ jsonData + " <><>");

    } catch (e) {
      print(e);
    }
    return jsonData;
  }

  Map<String, dynamic> makeData() {
    final map = <String, dynamic>{};
    if(willId.isNotEmpty)
    {
      map['will_id'] = willId;
    }
    map['original_will_located'] = _controller1.text.toString().trim();
    map['upload_doc_review'] = filePath.toString().trim();
    return map;
  }

  _saveDataCall(String data) async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_VAULT + saveWillData);
    var request = MultipartRequest("POST", url);
    request.fields['user_id'] = sessionManagerVault.getUserId().trim();
    request.fields['from_app'] = "true";
    request.fields['items'] = data;

    if (filePath.isNotEmpty) {
      if (!filePath.toString().startsWith("https") || !filePath.toString().startsWith("http"))
      {
        var holderIdApi = NavigationService.accountHolder[0].holderId.toString();
        var paramName = "upload_doc[$holderIdApi]";
        var multipartFile = await MultipartFile.fromPath(paramName, checkValidString(filePath));
        request.files.add(multipartFile);
      }
    }

    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    Map<String, dynamic> productRes = jsonDecode(responseString);
    final statusCode = response.statusCode;
    var dataResponse = CommanResponse.fromJson(productRes);

    if (statusCode == 200 && dataResponse.success == 1) {
      showSnackBar(dataResponse.message, context);
      lastInsertedModule();
      Navigator.pop(context);
      setState(() {
        _isLoading = false;
      });
    } else {
      showSnackBar(dataResponse.message, context);
      setState(() {
        _isLoading = false;
      });
    }
  }

  void lastInsertedModule() async {

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_ADD + add);

    Map<String, String> jsonBody = {
      'module':"add-future_expense",
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
    widget is AddWillPage;
  }
}
