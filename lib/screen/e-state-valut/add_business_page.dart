import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/constant/colors.dart';
import 'package:superapp_flutter/utils/my_toolbar.dart';
import '../../constant/e-state-valut/api_end_point.dart';
import '../../constant/global_context.dart';
import '../../model/CommanResponse.dart';
import '../../model/e-state-vault/BusinessDataResponse.dart';
import '../../model/e-state-vault/MinorChildrenDependentsData.dart';
import '../../utils/app_utils.dart';
import '../../utils/base_class.dart';
import '../../widget/loading.dart';

class AddBusinessPage extends StatefulWidget {

  AddBusinessPage({Key? key}) : super(key: key);

  @override
  BaseState<AddBusinessPage> createState() => _AddBusinessPageState();
}

class _AddBusinessPageState extends BaseState<AddBusinessPage> {
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
  var businessData = Business();

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
          title: MyToolBar(pageName: "Business(es)"),
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
                    "Enter details of your Business",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 15, color: black, fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top:10,left: 15, right: 10),
                  child: const Text(
                    "Do you own or jointly own a business or businesses?",
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
                    readOnly: true,
                    onTap: () {
                      showSelection(0);
                    },
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
                        errorText: _validController1 ? null : "Please enter Do you own or jointly own a business or businesses?"

                    ),
                    style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top:10,left: 15, right: 10),
                  child: const Text(
                    "If yes, list the name, line/area of business and type of organization (e.g., sole proprietorship, partnership,limited liability partnership, corporation, closely held corporation).",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 15, color: grayDark, fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
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
                        labelText: 'Name',
                        errorText: _validController2 ? null : "Please enter Name."

                    ),
                    style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
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
                        labelText: 'Line/Area of Business',
                        errorText: _validController3 ? null : "Please enter Line/Area of Business"

                    ),
                    style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
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
                        labelText: 'Type of Organization',
                        errorText: _validController4 ? null : "Please enter Type of Organization"

                    ),
                    style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top:15,left: 15, right: 10),
                  child: const Text(
                    "Do you have a document stating your wishes as to the treatment of this entity after your death?",
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
                    readOnly: true,
                    onTap: () {
                      showSelection(1);
                    },
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
                        errorText: _validController5 ? null : "Please enter Do you have a document stating your wishes as to the treatment of this entity after your death?"

                    ),
                    style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top:10,left: 15, right: 10),
                  child: const Text(
                    "If yes, please write below the location(s) of the document(s). If no, would you like to include any instructions or directions here as to the business or any employees?",
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
                        errorText: _validController6 ? null : "Please enter If yes, please write below the location(s) of the document(s). If no, would you like to include any instructions or directions here as to the business or any employees?"

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

    final url = Uri.parse(API_URL_VAULT + getBusinessesData);
    Map<String, String> jsonBody = {'user_id': sessionManagerVault.getUserId().trim()};

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = BusinessDataResponse.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1)
    {
      try {
        if (dataResponse.business != null) {
          businessData = dataResponse.business!;

          _controller1.text = checkValidStringWithToDisplayCase(businessData.ownOrJointlyBusiness);
          _controller5.text = checkValidStringWithToDisplayCase(businessData.documentStatingYourWishes);
          _controller6.text = checkValidString(businessData.documentInstructions);

          if(businessData.businessesDetails != null)
          {
            if(businessData.businessesDetails!.isNotEmpty)
            {
              _controller2.text = checkValidString(businessData.businessesDetails![0].name);
              _controller3.text = checkValidString(businessData.businessesDetails![0].areaOfBusiness);
              _controller4.text = checkValidString(businessData.businessesDetails![0].typeOfOrganization);
            }
          }
          
          setState(() {
            _isLoading = false;
          });
        }
        else
          {
            businessData = Business();
            showSnackBar(dataResponse.message, context);
            setState(() {
              _isLoading = false;
            });
          }
      } catch (e) {
        businessData = Business();
        showSnackBar(dataResponse.message, context);
        setState(() {
          _isLoading = false;
        });
        print(e);
      }
    }
    else {
      businessData = Business();
      showSnackBar(dataResponse.message, context);
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _makeJsonData()  {
    String jsonData = "";

    try {
      Map<String, dynamic> objSelectedValueMain = <String, dynamic>{};
      Map<String, dynamic> objSelectedValue = <String, dynamic>{};
      objSelectedValue[NavigationService.accountHolder[0].holderId.toString()] = makeData();
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
    map['name'] = _controller2.text.toString().trim();
    map['area_of_business'] = _controller3.text.toString().trim();
    map['type_of_organization'] = _controller4.text.toString().trim();
    return map;
  }

  _saveDataCall(String data) async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_VAULT + saveBusinessesData);
    Map<String, String> jsonBody = {
      'user_id': sessionManagerVault.getUserId().trim(),
      'items' : data,
      'own_or_jointly_business' : _controller1.text.toString().trim(),
      'document_stating_your_wishes' : _controller5.text.toString().trim(),
      'document_instructions' : _controller6.text.toString().trim(),
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

  void showSelection(int isFor) {
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
              BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)), color: white),
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
                  InkWell(
                    onTap: (){
                      if(isFor == 0)
                      {
                         setState(() {
                           _controller1.text = "Yes";
                         });
                      }
                      else
                      {
                        setState(() {
                          _controller5.text = "Yes";
                        });
                      }
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 10, bottom: 15),
                      child: const Text('Yes',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: black)),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    color: grayLight
                  ),
                  InkWell(
                    onTap: (){
                      if(isFor == 0)
                      {
                        setState(() {
                          _controller1.text = "No";
                        });
                      }
                      else
                      {
                        setState(() {
                          _controller5.text = "No";
                        });
                      }
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 10, bottom: 15),
                      child: const Text('No',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: black)),
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

  @override
  void castStatefulWidget() {
    widget is AddBusinessPage;
  }
}