import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp/constant/colors.dart';
import 'package:superapp/model/CommanResponse.dart';
import 'package:superapp/utils/app_utils.dart';
import 'package:superapp/utils/my_toolbar.dart';
import '../../constant/e-state-valut/api_end_point.dart';
import '../../constant/global_context.dart';
import '../../model/e-state-vault/OtherDebtsResponse.dart';
import '../../utils/base_class.dart';
import '../../widget/loading.dart';

class AddOtherDebtsPage extends StatefulWidget {
  OtherDebtsDetails data;
  final bool isForEdit;

  AddOtherDebtsPage(this.data, this.isForEdit, {Key? key}) : super(key: key);

  @override
  BaseState<AddOtherDebtsPage> createState() => _AddOtherDebtsPageState();
}

class _AddOtherDebtsPageState extends BaseState<AddOtherDebtsPage> {
  bool _isLoading = false;
  bool isForEdit = false;
  bool isSubmitClick = false;
  var itemData = OtherDebtsDetails();
  List<OtherDebtsDetails> listData = List<OtherDebtsDetails>.empty(growable: true);

  @override
  void initState()
  {
    super.initState();
    isForEdit = (widget as AddOtherDebtsPage).isForEdit;
    if (isForEdit)
    {
      itemData = (widget as AddOtherDebtsPage).data;
      itemData.descriptionController.text = checkValidString(itemData.description.toString().trim());
      itemData.currentlyOutstandingController.text = checkValidString(itemData.currentlyOutstanding.toString().trim());
      itemData.termsController.text = checkValidString(itemData.terms.toString().trim());
      itemData.toWhomOwedController.text = checkValidString(itemData.toWhomOwed.toString().trim());
      itemData.contactController.text = checkValidString(itemData.contact.toString().trim());
      itemData.phoneController.text = checkValidString(itemData.phone.toString().trim());
      itemData.addressController.text = checkValidString(itemData.address.toString().trim());
      itemData.createdOnController.text = checkValidString(itemData.createdOn.toString().trim());
      itemData.notesController.text = checkValidString(itemData.notes.toString().trim());
      if(checkValidString(itemData.uploadDoc).toString().isNotEmpty)
      {
        var fileName = checkValidString(itemData.uploadDoc).split(Platform.pathSeparator).last;
        itemData.uploadDocController.text = fileName;
      }
      addMoreViews(itemData);
    }
    else
    {
      addMoreViews(OtherDebtsDetails());
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
        backgroundColor: appBg,
        appBar: AppBar(
          toolbarHeight: 55,
          automaticallyImplyLeading: false,
          title: MyToolBar(pageName: isForEdit ? "Update Other Debts" : "Add Other Debts"),
          centerTitle: false,
          elevation: 0,
          backgroundColor: appBg,
        ),
        body: _isLoading ? const LoadingWidget() : setData());
  }

  SafeArea setData()
  {
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

  Column listItemData()
  {
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
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          cursorColor: black,
                          controller: listData[index].descriptionController,
                          onChanged: (text) {
                            setState(() {
                              listData[index].setDescription = text;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Description',
                            errorText: isSubmitClick
                                ? checkValidString(listData[index].description).isNotEmpty
                                    ? null
                                    : 'Description Can\'t Be Empty'
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
                          controller: listData[index].currentlyOutstandingController,
                          onChanged: (text) {
                            setState(() {
                              listData[index].setCurrentlyOutstanding = text;
                            });
                          },
                          decoration: InputDecoration(
                            counterText: "",
                            labelText: 'Currently Outstanding',
                            errorText: isSubmitClick
                                ? checkValidString(listData[index].currentlyOutstanding).isNotEmpty
                                ? null
                                : 'Currently Outstanding Can\'t Be Empty'
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
                          controller: listData[index].termsController,
                          onChanged: (text) {
                            setState(() {
                              listData[index].setTerms = text;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Terms',
                            errorText: isSubmitClick
                                ? checkValidString(listData[index].terms).isNotEmpty
                                ? null
                                : 'Terms Can\'t Be Empty'
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
                          controller: listData[index].toWhomOwedController,
                          onChanged: (text) {
                            setState(() {
                              listData[index].setToWhomOwed = text;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'To Whom Owed',
                            errorText: isSubmitClick
                                ? checkValidString(listData[index].toWhomOwed).isNotEmpty
                                ? null
                                : 'To Whom Owed Can\'t Be Empty'
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
                          controller: listData[index].contactController,
                          onChanged: (text) {
                            setState(() {
                              listData[index].setContact = text;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Contact Person',
                            errorText: isSubmitClick
                                ? checkValidString(listData[index].contact).isNotEmpty
                                ? null
                                : 'Contact Person Can\'t Be Empty'
                                : null,
                          ),
                          style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          cursorColor: black,
                          controller: listData[index].phoneController,
                          onChanged: (text) {
                            setState(() {
                              listData[index].setPhone = text;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Phone',
                            counterText: '',
                            errorText: checkErrorForPhone(index).isEmpty ? null : checkErrorForPhone(index),
                          ),
                          style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
                        child: TextField(
                          keyboardType: TextInputType.text,
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
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: checkValidString(listData[index].createdOn).isNotEmpty ? DateFormat("dd/MM/yyyy").parse(checkValidString(listData[index].createdOn)) : DateTime.now(),
                                firstDate: DateTime(1901),
                                lastDate:  DateTime.now().subtract(const Duration(days: 0)),
                                helpText: 'Created On',
                                 builder: (context, Widget? child) => Theme(
                                data: Theme.of(context).copyWith(
                                    appBarTheme: Theme.of(context)
                                        .appBarTheme
                                        .copyWith(backgroundColor: black, iconTheme: Theme.of(context).appBarTheme.iconTheme?.copyWith(color: white)),
                                    scaffoldBackgroundColor: white,
                                    colorScheme: const ColorScheme.light(onPrimary: white, primary: black)),
                                child: child!,
                              ));
                            if (pickedDate != null) {
                              String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
                              setState(() {
                                listData[index].createdOnController.text = formattedDate; //set output date to TextField value.
                                listData[index].setCreatedOn = formattedDate;
                              });
                            }
                          },
                          controller: listData[index].createdOnController,
                          onChanged: (text) {
                            setState(() {
                              listData[index].setCreatedOn = text;
                            });
                          },
                          decoration: InputDecoration(
                            counterText: "",
                            labelText: 'Created on',
                            errorText: isSubmitClick
                                ? checkValidString(listData[index].createdOn).isNotEmpty
                                ? null
                                : 'Created on Can\'t Be Empty'
                                : null,
                          ),
                          style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          cursorColor: black,
                          maxLines: 3,
                          controller: listData[index].notesController,
                          onChanged: (text) {
                            setState(() {
                              listData[index].setNotes = text;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Notes',
                            errorText: isSubmitClick
                                ? checkValidString(listData[index].notes).isNotEmpty
                                ? null
                                : 'Notes Can\'t Be Empty'
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
                          readOnly: true,
                          onTap: () {
                            pickImagesFromGallery(index);
                          },
                          controller: listData[index].uploadDocController,
                          onChanged: (text) {
                            setState(() {
                              listData[index].setUploadDoc = text;
                            });
                          },
                          decoration: InputDecoration(
                            counterText: "",
                            labelText: 'Upload File',
                            errorText: isSubmitClick
                                ? checkValidString(listData[index].uploadDoc).isNotEmpty
                                ? null
                                : 'Please select file.'
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
                        addMoreViews(OtherDebtsDetails());
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
            ))
      ],
    );
  }

  String checkErrorForPhone(int index) {
    String value = "";
    if (isSubmitClick) {
      if (checkValidString(listData[index].phone).isEmpty) {
        value = "Phone Number Can\'t Be Empty";
      } else if (checkValidString(listData[index].phone).toString().length != 10) {
        value = "Enter Valid Phone Number";
      }
    }
    return value;
  }

  Future<void> pickImagesFromGallery(int index) async
  {
    try
    {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null)
      {
        File file = File(result.files.single.path.toString());
        setState(() {
          listData[index].setUploadDoc = file.path;
          var fileName = file.path.split(Platform.pathSeparator).last;
          listData[index].uploadDocController.text = fileName;
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

  void addMoreViews(OtherDebtsDetails data)
  {
    setState(() {
      data.setDescription = checkValidString(itemData.description.toString().trim());
      data.setCurrentlyOutstanding = checkValidString(itemData.currentlyOutstanding.toString().trim());
      data.setTerms = checkValidString(itemData.terms.toString().trim());
      data.setToWhomOwed = checkValidString(itemData.toWhomOwed.toString().trim());
      data.setContact = checkValidString(itemData.contact.toString().trim());
      data.setPhone = checkValidString(itemData.phone.toString().trim());
      data.setAddress = checkValidString(itemData.address.toString().trim());
      data.setCreatedOn = checkValidString(itemData.createdOn.toString().trim());
      data.setNotes = checkValidString(itemData.notes.toString().trim());
      data.setUploadDoc = checkValidString(itemData.uploadDoc);
      listData.add(data);
    });
  }

  bool isValidData()
  {
    bool isValid = true;

    for (int i = 0; i < listData.length; i++)
    {
      var itemData = listData[i];
      if (checkValidString(itemData.description).isNotEmpty &&
          checkValidString(itemData.currentlyOutstanding).isNotEmpty &&
          checkValidString(itemData.terms).isNotEmpty &&
          checkValidString(itemData.toWhomOwed).isNotEmpty &&
          checkValidString(itemData.contact).isNotEmpty &&
          checkValidString(itemData.phone).isNotEmpty &&
          checkValidString(itemData.address).isNotEmpty &&
          checkValidString(itemData.createdOn).isNotEmpty &&
          checkValidString(itemData.notes).isNotEmpty &&
          checkValidString(itemData.uploadDoc).isNotEmpty)
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

  String _makeJsonData()
  {
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

  _saveDataCall(String data) async
  {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_VAULT + saveOtherDebts);
    var request = MultipartRequest("POST", url);
    request.fields['user_id'] = sessionManagerVault.getUserId().trim();
    request.fields['from_app'] = "true";
    request.fields['items'] = data;

    if (isForEdit) {
      if (!listData[0].uploadDoc.toString().startsWith("https") || !listData[0].uploadDoc.toString().startsWith("http"))
      {
        var holderIdApi = isForEdit ? itemData.holderId.toString() : NavigationService.accountHolder[0].holderId.toString();
        var paramName = "upload_doc[$holderIdApi][0]";
        var multipartFile = await MultipartFile.fromPath(paramName, checkValidString(listData[0].uploadDoc));
        request.files.add(multipartFile);
      }
    } else {
      for (int i = 0; i < listData.length; i++) {
        var holderIdApi = isForEdit ? itemData.holderId.toString() : NavigationService.accountHolder[0].holderId.toString();
        var paramName = "upload_doc[$holderIdApi][$i]";
        var multipartFile = await MultipartFile.fromPath(paramName, checkValidString(listData[i].uploadDoc));
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
      Navigator.pop(context, "success");
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

  @override
  void castStatefulWidget() {
    widget is AddOtherDebtsPage;
  }
}
