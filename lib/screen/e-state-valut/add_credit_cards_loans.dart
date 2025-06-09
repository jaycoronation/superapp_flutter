import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/constant/colors.dart';
import 'package:superapp_flutter/model/CommanResponse.dart';
import 'package:superapp_flutter/utils/app_utils.dart';
import 'package:superapp_flutter/utils/my_toolbar.dart';
import '../../common_widget/common_widget.dart';
import '../../constant/api_end_point.dart';
import '../../constant/e-state-valut/api_end_point.dart';
import '../../constant/global_context.dart';
import '../../model/e-state-vault/CreditCardsLoansResponse.dart';
import '../../utils/base_class.dart';
import '../../widget/loading.dart';

class AddCreditCardsLoansPage extends StatefulWidget {
  CreditCardsAndLoans data;
  final bool isForEdit;

  AddCreditCardsLoansPage(this.data, this.isForEdit, {Key? key}) : super(key: key);

  @override
  BaseState<AddCreditCardsLoansPage> createState() => _AddCreditCardsLoansPageState();
}

class _AddCreditCardsLoansPageState extends BaseState<AddCreditCardsLoansPage> {
  bool _isLoading = false;
  bool isForEdit = false;
  bool isSubmitClick = false;
  var itemData = CreditCardsAndLoans();
  List<CreditCardsAndLoans> listData = List<CreditCardsAndLoans>.empty(growable: true);

  @override
  void initState()
  {
    super.initState();
    isForEdit = (widget as AddCreditCardsLoansPage).isForEdit;
    if (isForEdit)
    {
      itemData = (widget as AddCreditCardsLoansPage).data;
      itemData.typeController.text = checkValidString(itemData.type.toString().trim());
      itemData.accountNumberController.text = checkValidString(itemData.accountNumber.toString().trim());
      itemData.institutionController.text = checkValidString(itemData.institution.toString().trim());
      itemData.amountController.text = checkValidString(itemData.amount.toString().trim());

      String formattedDate = "";
      if(checkValidString(itemData.createdOn).toString().isNotEmpty)
      {
        formattedDate = universalDateConverter("MM/dd/yyyy", "dd/MM/yyyy", checkValidString(itemData.createdOn.toString().trim()));
      }
      itemData.createdOnController.text = formattedDate;
      itemData.contactPersonController.text = checkValidString(itemData.contactPerson.toString().trim());
      itemData.locationOfDocumentController.text = checkValidString(itemData.locationOfDocument.toString().trim());
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
      addMoreViews(CreditCardsAndLoans());
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
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: getBackArrow(),
          ),
          title: getTitle(isForEdit ? "Update Credit Cards and Loans" : "Add Credit Cards and Loans"),
          centerTitle: true,
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
                           if (isOnline) {
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
                          keyboardType: TextInputType.text,
                          cursorColor: black,
                          readOnly: true,
                          onTap: (){
                            showSelection(index);
                          },
                          controller: listData[index].typeController,
                          onChanged: (text) {
                            setState(() {
                              listData[index].setType = text;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Type',
                            errorText: isSubmitClick
                                ? checkValidString(listData[index].type).isNotEmpty
                                    ? null
                                    : 'Select Type'
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
                          controller: listData[index].accountNumberController,
                          onChanged: (text) {
                            setState(() {
                              listData[index].setAccountNumber = text;
                            });
                          },
                          decoration: InputDecoration(
                            counterText: "",
                            labelText: 'Account Number',
                            errorText: isSubmitClick
                                ? checkValidString(listData[index].accountNumber).isNotEmpty
                                ? null
                                : 'Account Number Can\'t Be Empty'
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
                          controller: listData[index].institutionController,
                          onChanged: (text) {
                            setState(() {
                              listData[index].setInstitution = text;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Institution',
                            errorText: isSubmitClick
                                ? checkValidString(listData[index].institution).isNotEmpty
                                ? null
                                : 'Institution Can\'t Be Empty'
                                : null,
                          ),
                          style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          cursorColor: black,
                          controller: listData[index].amountController,
                          onChanged: (text) {
                            setState(() {
                              listData[index].setAmount = text;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Amount',
                            counterText: '',
                            errorText: isSubmitClick
                                ? checkValidString(listData[index].institution).isNotEmpty
                                ? null
                                : 'Amount Can\'t Be Empty'
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
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          cursorColor: black,
                          controller: listData[index].contactPersonController,
                          onChanged: (text) {
                            setState(() {
                              listData[index].setContactPerson = text;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Contact Person',
                            errorText: isSubmitClick
                                ? checkValidString(listData[index].contactPerson).isNotEmpty
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
                          keyboardType: TextInputType.text,
                          cursorColor: black,
                          controller: listData[index].locationOfDocumentController,
                          onChanged: (text) {
                            setState(() {
                              listData[index].setLocationOfDocument = text;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Location of Document',
                            errorText: isSubmitClick
                                ? checkValidString(listData[index].locationOfDocument).isNotEmpty
                                ? null
                                : 'Location of Document Can\'t Be Empty'
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
                        addMoreViews(CreditCardsAndLoans());
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

  void addMoreViews(CreditCardsAndLoans data)
  {
    setState(() {
      data.setType = checkValidString(itemData.type.toString().trim());
      data.setAccountNumber = checkValidString(itemData.accountNumber.toString().trim());
      data.setInstitution = checkValidString(itemData.institution.toString().trim());
      data.setAmount = checkValidString(itemData.amount.toString().trim());
      String formattedDate = "";
      if(checkValidString(itemData.createdOn).toString().isNotEmpty)
      {
        formattedDate = universalDateConverter("MM/dd/yyyy", "dd/MM/yyyy", checkValidString(itemData.createdOn.toString().trim()));
      }
      data.setCreatedOn = checkValidString(formattedDate);
      data.setContactPerson = checkValidString(itemData.contactPerson.toString().trim());
      data.setLocationOfDocument = checkValidString(itemData.locationOfDocument.toString().trim());
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
      if (checkValidString(itemData.type).isNotEmpty &&
          checkValidString(itemData.accountNumber).isNotEmpty &&
          checkValidString(itemData.institution).isNotEmpty &&
          checkValidString(itemData.amount).isNotEmpty &&
          checkValidString(itemData.contactPerson).isNotEmpty &&
          checkValidString(itemData.createdOn).isNotEmpty &&
          checkValidString(itemData.locationOfDocument).isNotEmpty &&
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

    final url = Uri.parse(API_URL_VAULT + saveCreditCardsLoans);
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
      lastInsertedModule();
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

  void lastInsertedModule() async {

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_VAULT + add);

    Map<String, String> jsonBody = {
      'module':(widget as AddCreditCardsLoansPage).isForEdit ? "edit-credit_cards_loans" : "add-credit_cards_loans",
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


  void showSelection(int index) {
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
                      setState(() {
                        listData[index].setType = "Car Loan";
                        listData[index].typeController.text = "Car Loan";
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 10, bottom: 15),
                      child: const Text('Car Loan',
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
                      setState(() {
                        listData[index].typeController.text = "Credit Card";
                        listData[index].setType = "Credit Card";
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 10, bottom: 15),
                      child: const Text('Credit Card',
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
                      setState(() {
                        listData[index].typeController.text = "Home Loan";
                        listData[index].setType = "Home Loan";
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 10, bottom: 15),
                      child: const Text('Home Loan',
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
                      setState(() {
                        listData[index].typeController.text = "Lone money invested Equity";
                        listData[index].setType = "Lone money invested Equity";
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 10, bottom: 15),
                      child: const Text('Lone money invested Equity',
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
                      setState(() {
                        listData[index].typeController.text = "Other Loan";
                        listData[index].setType = "Other Loan";
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 10, bottom: 15),
                      child: const Text('Other Loan',
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
                      setState(() {
                        listData[index].typeController.text = "Lucknow Plot Loan";
                        listData[index].setType = "Lucknow Plot Loan";
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 10, bottom: 15),
                      child: const Text('Lucknow Plot Loan',
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
                      setState(() {
                        listData[index].typeController.text = "Insurance Premium";
                        listData[index].setType = "Insurance Premium";
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 10, bottom: 15),
                      child: const Text('Insurance Premium',
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
                      setState(() {
                        listData[index].typeController.text = "Others";
                        listData[index].setType = "Others";
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 10, bottom: 15),
                      child: const Text('Others',
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
    widget is AddCreditCardsLoansPage;
  }
}
