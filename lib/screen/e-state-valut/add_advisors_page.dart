import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/constant/colors.dart';
import 'package:superapp_flutter/model/CommanResponse.dart';
import 'package:superapp_flutter/utils/app_utils.dart';
import 'package:superapp_flutter/utils/my_toolbar.dart';
import '../../common_widget/common_widget.dart';
import '../../constant/api_end_point.dart';
import '../../constant/e-state-valut/api_end_point.dart';
import '../../constant/global_context.dart';
import '../../model/e-state-vault/AdvisersListResponse.dart';
import '../../utils/base_class.dart';
import '../../widget/loading.dart';
import '../../model/e-state-vault/DeathNotificationResponse.dart';

class AddAdvisersPage extends StatefulWidget {
  Advisers data;
  final bool isForEdit;

  AddAdvisersPage(this.data, this.isForEdit, {Key? key}) : super(key: key);

  @override
  BaseState<AddAdvisersPage> createState() => _AddAdvisersPageState();
}

class _AddAdvisersPageState extends BaseState<AddAdvisersPage> {
  bool _isLoading = false;
  bool isForEdit = false;
  bool isSubmitClick = false;
  var itemData = Advisers();
  List<Advisers> listData = List<Advisers>.empty(growable: true);

  @override
  void initState() {
    super.initState();
    isForEdit = (widget as AddAdvisersPage).isForEdit;
    if (isForEdit) {
      itemData = (widget as AddAdvisersPage).data;
      itemData.nameController.text = checkValidString(itemData.name.toString().trim());
      itemData.phoneController.text = checkValidString(itemData.phone.toString().trim());
      itemData.addressController.text = checkValidString(itemData.address.toString().trim());
      itemData.relationshipController.text = checkValidString(itemData.relationship.toString().trim());
      itemData.companyController.text = checkValidString(itemData.company.toString().trim());

      addMoreViews(itemData);
    } else {
      addMoreViews(Advisers());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBg,
        appBar: AppBar(
          toolbarHeight: 55,
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: getBackArrow(),
          ),
          title: getTitle(isForEdit ? "Update Advisors" : "Add Advisors"),
          centerTitle: true,
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
                  margin: const EdgeInsets.only(top: 30, bottom: 10, left: 10, right: 10),
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: blue, backgroundColor: blue,
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
                          keyboardType: TextInputType.text,
                          cursorColor: black,
                          controller: listData[index].nameController,
                          onChanged: (text) {
                            setState(() {
                              listData[index].setName = text;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Full Name',
                            errorText: isSubmitClick
                                ? checkValidString(listData[index].name).isNotEmpty
                                    ? null
                                    : 'Full Name Can\'t Be Empty'
                                : null,
                          ),
                          style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          maxLength: 10,
                          cursorColor: black,
                          controller: listData[index].phoneController,
                          onChanged: (text) {
                            setState(() {
                              listData[index].setPhone = text;
                            });
                          },
                          decoration: InputDecoration(
                            counterText: "",
                            labelText: 'Mobile Number',
                            errorText: checkErrorForPhone(index).isEmpty ? null : checkErrorForPhone(index),
                          ),
                          style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          cursorColor: black,
                          controller: listData[index].addressController,
                          onChanged: (text) {
                            setState(() {
                              listData[index].setAddress = text;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Address',
                            errorText: isSubmitClick
                                ? checkValidString(listData[index].address).isNotEmpty
                                ? null
                                : 'Address Can\'t Be Empty'
                                : null,
                          ),
                          style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
                        child: TextField(
                          keyboardType: TextInputType.text,
                          cursorColor: black,
                          controller: listData[index].relationshipController,
                          onChanged: (text) {
                            setState(() {
                              listData[index].setRelationship = text;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Relationship',
                            errorText: isSubmitClick
                                ? checkValidString(listData[index].relationship).isNotEmpty
                                ? null
                                : 'Relationship Can\'t Be Empty'
                                : null,
                          ),
                          style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
                        child: TextField(
                          keyboardType: TextInputType.text,
                          cursorColor: black,
                          controller: listData[index].companyController,
                          onChanged: (text) {
                            setState(() {
                              listData[index].setCompany = text;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Company',
                            errorText: isSubmitClick
                                ? checkValidString(listData[index].company).isNotEmpty
                                ? null
                                : 'Company Can\'t Be Empty'
                                : null,
                          ),
                          style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
                        ),
                      ),
                      Visibility(
                        visible: !isForEdit,
                        child: index == 0
                            ? Container()
                            : Container(
                                alignment: Alignment.centerRight,
                                margin: const EdgeInsets.only(top: 12, right: 10),
                                height: 32,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: white, backgroundColor: white,
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
                      ),
                    ],
                  ),
                )))),
        Visibility(
            visible: !isForEdit,
            child: Row(
              children: [
                Expanded(flex: 1, child: Container()),
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  height: 36,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: white, backgroundColor: white,
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
                        addMoreViews(Advisers());
                      }, //set both onPressed and onLongPressed to null to see the disabled properties
                      onLongPress: () => {}, //set both onPressed and onLongPressed to null to see the disabled properties
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
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
        )
      ],
    );
  }

  String checkErrorForPhone(int index) {
    String value = "";
    if (isSubmitClick) {
      if (checkValidString(listData[index].phone).isEmpty) {
        value = "Mobile Number Can\'t Be Empty";
      } else if (checkValidString(listData[index].phone).toString().length != 10) {
        value = "Enter Valid Mobile Number";
      }
    }
    return value;
  }


  void addMoreViews(Advisers data) {
    setState(() {
      data.setName = checkValidString(itemData.name);
      data.setPhone = checkValidString(itemData.phone);
      data.setAddress = checkValidString(itemData.address);
      data.setRelationship = checkValidString(itemData.relationship);
      data.setCompany = checkValidString(itemData.company);
      listData.add(data);
    });
  }

  bool isValidData() {
    bool isValid = true;

    for (int i = 0; i < listData.length; i++)
    {
      var itemData = listData[i];
      if (checkValidString(itemData.name).isNotEmpty &&
              checkValidString(itemData.phone).isNotEmpty &&
              checkValidString(itemData.phone).length == 10 &&
              checkValidString(itemData.address).isNotEmpty &&
              checkValidString(itemData.relationship).isNotEmpty &&
              checkValidString(itemData.company).isNotEmpty)
      {
        continue;
      } else {
        isValid = false;
        showSnackBar("Please enter all field value or remove.", context);
        break;
      }
    }
    return isValid;
  }

   String _makeJsonData()  {
    String jsonData = "";

    try {
      Map<String, dynamic> objSelectedValueMain = <String, dynamic>{};

      Map<String, dynamic> objSelectedValue = <String, dynamic>{};
      objSelectedValue[isForEdit ? itemData.holderId.toString() : NavigationService.accountHolder[0].holderId.toString()] = listData;

      objSelectedValueMain["items"] = objSelectedValue;
      jsonData = jsonEncode(objSelectedValueMain).toString();
      print("<><> JSON DATA "+ jsonData + " <><>");
    } catch (e) {
      print(e);
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

    final url = Uri.parse(API_URL_VAULT + saveAdvisers);
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
      Navigator.pop(context, "success");
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
      'module':(widget as AddAdvisersPage).isForEdit ? "edit-advisors" : "add-advisors",
      'user_id':sessionManagerVault.getUserId().toString().trim(),
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
    widget is AddAdvisersPage;
  }
}
