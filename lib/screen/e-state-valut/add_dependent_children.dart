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
import '../../model/e-state-vault/MinorChildrenDependentsData.dart';
import '../../utils/app_utils.dart';
import '../../utils/base_class.dart';
import '../../widget/loading.dart';

class AddDependentChildrenPage extends StatefulWidget {

  AddDependentChildrenPage({Key? key}) : super(key: key);

  @override
  BaseState<AddDependentChildrenPage> createState() => _AddDependentChildrenPageState();
}

class _AddDependentChildrenPageState extends BaseState<AddDependentChildrenPage> {
  bool _isLoading = false;
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  final TextEditingController _controller5 = TextEditingController();
  final TextEditingController _controller6 = TextEditingController();
  bool _validController1 = true;
  bool _validController2 = true;
  bool _validController3 = true;
  bool _validController4 = true;
  bool _validController5 = true;
  bool _validController6 = true;
  var mcadId = "";

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
          title: MyToolBar(pageName: "Dependent Children"),
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
                    "Enter details related to Dependent Children",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 15, color: black, fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top:10,left: 15, right: 10),
                  child: const Text(
                    "Please list minor children and/or adult dependents in your care, including their ages",
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
                        errorText: _validController1 ? null : "Please enter Please list minor children and/or adult dependents in your care, including their ages"

                    ),
                    style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top:10,left: 15, right: 10),
                  child: const Text(
                    "Name, address and phone number of prospective guardian(s) as designated in your will",
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
                        errorText: _validController2 ? null : "Please enter Name, address and phone number of prospective guardian(s) as designated in your will"

                    ),
                    style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top:10,left: 15, right: 10),
                  child: const Text(
                    "Has this person (or persons) agreed to assume this responsibility?",
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
                        errorText: _validController3 ? null : "Please enter Has this person (or persons) agreed to assume this responsibility?"

                    ),
                    style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top:10,left: 15, right: 10),
                  child: Text(
                    "Have you (1) discussed with this person, or (2) documented your specific goals and aspirations for, or suggestions regarding, continuing care of any minor children or adult dependents?",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 15, color: grayDark, fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    cursorColor: black,
                    controller: _controller4,
                    onChanged: (text) {
                      setState(() {
                        if (text.isEmpty) {
                          _validController4 = false;
                        } else {
                          _validController4 = true;
                        }
                      });
                    },
                    decoration: InputDecoration(
                        labelText: '',
                        errorText: _validController4 ? null : "Please enter Have you (1) discussed with this person, or (2) documented your specific goals and aspirations for, or suggestions regarding, continuing care of any minor children or adult dependents?"

                    ),
                    style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top:10,left: 15, right: 10),
                  child: const Text(
                    "If you have prepared a document, where is this document located?",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 15, color: grayDark, fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    cursorColor: black,
                    controller: _controller5,
                    onChanged: (text) {
                      setState(() {
                        if (text.isEmpty) {
                          _validController5 = false;
                        } else {
                          _validController5 = true;
                        }
                      });
                    },
                    decoration: InputDecoration(
                        labelText: '',
                        errorText: _validController5 ? null : "Please enter If you have prepared a document, where is this document located?"

                    ),
                    style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top:10,left: 15, right: 10),
                  child: const Text(
                    "Would you like to include here any instructions, directions or suggestions to the prospective guardian(s)?",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 15, color: grayDark, fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    cursorColor: black,
                    controller: _controller6,
                    onChanged: (text) {
                      setState(() {
                        if (text.isEmpty) {
                          _validController6 = false;
                        } else {
                          _validController6 = true;
                        }
                      });
                    },
                    decoration: InputDecoration(
                        labelText: '',
                        errorText: _validController6 ? null : "Please enter Would you like to include here any instructions, directions or suggestions to the prospective guardian(s)?"

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
                        else if(_controller4.text.isEmpty)
                        {
                          setState(() {
                            _validController4 = false;
                            return;
                          });
                        }
                        else if(_controller5.text.isEmpty)
                        {
                          setState(() {
                            _validController5 = false;
                            return;
                          });
                        }
                        else if(_controller6.text.isEmpty)
                        {
                          setState(() {
                            _validController6 = false;
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

    final url = Uri.parse(API_URL_VAULT + getMinorChildrenAdultDependents);
    Map<String, String> jsonBody = {'user_id': sessionManagerVault.getUserId().trim()};

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> jsonData = jsonDecode(body);

    if (statusCode == 200 && jsonData['success'] == 1)
    {
      List<MinorChildrenDependentsData> itemData = [];
      final parsedJson = jsonData['minor_children_adult_dependents'];
      parsedJson.forEach((key, value)
      {
        if(key == NavigationService.accountHolder[0].holderId)
        {
          itemData.add(MinorChildrenDependentsData.fromJson(value));
        }
      });

      if(itemData.isNotEmpty)
      {
        var generally = MinorChildrenDependentsData();
        generally = itemData[0];
        mcadId = checkValidString(generally.mcadId);
        _controller1.text = checkValidString(generally.minorChildrenAndDependents);
        _controller2.text = checkValidString(generally.nameAddressPhone);
        _controller3.text = checkValidString(generally.agreedToAssumeResponsibility);
        _controller4.text = checkValidString(generally.haveYou);
        _controller5.text = checkValidString(generally.documentLocated);
        _controller6.text = checkValidString(generally.instructionsDirectionsSuggestions);
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
    if(mcadId.isNotEmpty)
    {
      map['mcad_id'] = mcadId;
    }
    map['minor_children_and_dependents'] = _controller1.text.toString().trim();
    map['name_address_phone'] = _controller2.text.toString().trim();
    map['agreed_to_assume_responsibility'] = _controller3.text.toString().trim();
    map['have_you'] = _controller4.text.toString().trim();
    map['document_located'] = _controller5.text.toString().trim();
    map['instructions_directions_suggestions'] = _controller6.text.toString().trim();

    return map;
  }

  _saveDataCall(String data) async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_VAULT + saveMinorChildrenAdultDependents);
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
      lastInsertedModule();
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


  void lastInsertedModule() async {

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_VAULT + add);

    Map<String, String> jsonBody = {
      'module':"add-dependend_children",
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
    widget is AddDependentChildrenPage;
  }
}