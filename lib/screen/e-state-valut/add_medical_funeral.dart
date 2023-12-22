import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/constant/colors.dart';
import 'package:superapp_flutter/utils/my_toolbar.dart';
import '../../constant/api_end_point.dart';
import '../../constant/e-state-valut/api_end_point.dart';
import '../../constant/global_context.dart';
import '../../model/CommanResponse.dart';
import '../../model/e-state-vault/MedicalFuneralData.dart';
import '../../utils/app_utils.dart';
import '../../utils/base_class.dart';
import '../../widget/loading.dart';

class AddMedicalFuneralPage extends StatefulWidget {

  AddMedicalFuneralPage({Key? key}) : super(key: key);

  @override
  BaseState<AddMedicalFuneralPage> createState() => _AddMedicalFuneralPageState();
}

class _AddMedicalFuneralPageState extends BaseState<AddMedicalFuneralPage> {
  bool _isLoading = false;
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  bool _validController1 = true;
  bool _validController2 = true;
  bool _validController3 = true;
  var generallyId = "";

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
          title: MyToolBar(pageName: "Medical & Funeral"),
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
                    "Enter details related to Medical &amp; Funeral",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 15, color: black, fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top:10,left: 15, right: 10),
                  child: const Text(
                    "Directions about Medical or Nursing Home Care",
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
                        errorText: _validController1 ? null : "Please enter Directions about Medical or Nursing Home Care"

                    ),
                    style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top:10,left: 15, right: 10),
                  child: const Text(
                    "Your wishes about Organ Donation",
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
                        errorText: _validController2 ? null : "Please enter Your wishes about Organ Donation"

                    ),
                    style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top:10,left: 15, right: 10),
                  child: const Text(
                    "Instructions regarding your Funeral, Memorial Services, Disposition of Remains, etc.",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 15, color: grayDark, fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    cursorColor: black,
                    controller: _controller3,
                    onChanged: (text) {
                      setState(() {
                        if (text.isEmpty) {
                          _validController3 = false;
                        } else {
                          _validController3 = true;
                        }
                      });
                    },
                    decoration: InputDecoration(
                        labelText: '',
                        errorText: _validController3 ? null : "Please enter Instructions regarding your Funeral, Memorial Services, Disposition of Remains, etc."

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
                        else if(_controller3.text.isEmpty)
                        {
                          setState(() {
                            _validController3 = false;
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

  _getApiData() async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_VAULT + getMedicalAndFuneralData);
    Map<String, String> jsonBody = {'user_id': sessionManagerVault.getUserId().trim()};

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> jsonData = jsonDecode(body);

    if (statusCode == 200 && jsonData['success'] == 1)
    {
      List<MedicalFuneralData> itemData = [];
      final parsedJson = jsonData['generally'];
      parsedJson.forEach((key, value)
      {
        if(key == NavigationService.accountHolder[0].holderId)
        {
          itemData.add(MedicalFuneralData.fromJson(value));
        }
      });

      if(itemData.isNotEmpty)
      {
        var generally = MedicalFuneralData();
        generally = itemData[0];
        generallyId = checkValidString(generally.generallyId);
        _controller1.text = checkValidString(generally.directionsAboutMedicalAndNursing);
        _controller2.text = checkValidString(generally.organDonorTransplantationWishes);
        _controller3.text = checkValidString(generally.instructionsAboutFuneral);
      }

    }

    setState(() {
      _isLoading = false;
    });
  }

  String _makeJsonData()  {
    String jsonData = "";

    try {
      Map<String, dynamic> objSelectedValue = <String, dynamic>{};
      objSelectedValue[NavigationService.accountHolder[0].holderId.toString()] = makeData();
      jsonData = jsonEncode(objSelectedValue).toString();
      print("<><> JSON DATA "+ jsonData + " <><>");
    } catch (e) {
      print(e);
    }
    return jsonData;
  }

  Map<String, dynamic> makeData() {
    final map = <String, dynamic>{};
    if(generallyId.isNotEmpty)
    {
      map['generally_id'] = generallyId;
    }
    map['directions_about_medical_and_nursing'] = _controller1.text.toString().trim();
    map['organ_donor_transplantation_wishes'] = _controller2.text.toString().trim();
    map['instructions_about_funeral'] = _controller3.text.toString().trim();
    return map;
  }

  _saveDataCall(String data) async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_VAULT + saveMedicalAndFuneralData);
    Map<String, String> jsonBody = {
      'user_id': sessionManagerVault.getUserId().trim(),
      'items' : data
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = CommanResponse.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1)
    {
      showSnackBar(dataResponse.message, context);
      Navigator.pop(context);
      setState(() {
        _isLoading = false;
      });
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
    widget is AddMedicalFuneralPage;
  }
}
