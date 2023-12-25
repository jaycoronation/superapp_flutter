import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/constant/colors.dart';
import 'package:superapp_flutter/model/CommanResponse.dart';
import 'package:superapp_flutter/utils/app_utils.dart';
import 'package:superapp_flutter/utils/my_toolbar.dart';
import '../../constant/api_end_point.dart';
import '../../constant/e-state-valut/api_end_point.dart';
import '../../constant/global_context.dart';
import '../../model/e-state-vault/InsurancePolicyResponse.dart';
import '../../utils/base_class.dart';
import '../../widget/loading.dart';

class AddInsurancePolicyPage extends StatefulWidget {
  InsurancePoliciesDetails data;
  final bool isForEdit;

  AddInsurancePolicyPage(this.data, this.isForEdit, {Key? key}) : super(key: key);

  @override
  BaseState<AddInsurancePolicyPage> createState() => _AddInsurancePolicyPageState();
}

class _AddInsurancePolicyPageState extends BaseState<AddInsurancePolicyPage> {
  bool _isLoading = false;
  bool isForEdit = false;
  bool isSubmitClick = false;
  var itemData = InsurancePoliciesDetails();
  List<InsurancePoliciesDetails> listData = List<InsurancePoliciesDetails>.empty(growable: true);

  @override
  void initState()
  {
    super.initState();
    isForEdit = (widget as AddInsurancePolicyPage).isForEdit;
    if (isForEdit)
    {
      itemData = (widget as AddInsurancePolicyPage).data;
      itemData.insuranceCompanyController.text = checkValidString(itemData.insuranceCompany.toString().trim());
      itemData.typeOfPolicyController.text = checkValidString(itemData.typeOfPolicy.toString().trim());
      itemData.policyNumberController.text = checkValidString(itemData.policyNumber.toString().trim());
      itemData.personThingInsuredController.text = checkValidString(itemData.personThingInsured.toString().trim());
      itemData.sumAssuredController.text = checkValidString(itemData.sumAssured.toString().trim());
      itemData.currentValueController.text = checkValidString(itemData.currentValue.toString().trim());
      itemData.purchasedOnController.text = checkValidString(itemData.purchasedOn.toString().trim());
      itemData.agentNameController.text = checkValidString(itemData.agentName.toString().trim());
      itemData.agentPhoneController.text = checkValidString(itemData.agentPhone.toString().trim());
      itemData.agentAddressController.text = checkValidString(itemData.agentAddress.toString().trim());
      itemData.locationOfDocumentController.text = checkValidString(itemData.locationOfDocument.toString().trim());
      itemData.notesController.text = checkValidString(itemData.notes.toString().trim());
      itemData.nomineeNameController.text = checkValidString(itemData.nomineeName.toString().trim());
      if(checkValidString(itemData.uploadDoc).toString().isNotEmpty)
      {
        var fileName = checkValidString(itemData.uploadDoc).split(Platform.pathSeparator).last;
        itemData.uploadDocController.text = fileName;
      }

      addMoreViews(itemData);
    }
    else
    {
      addMoreViews(InsurancePoliciesDetails());
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
          title: MyToolBar(pageName: isForEdit ? "Update Insurance Policy" : "Add Insurance Policy"),
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
                          keyboardType: TextInputType.text,
                          cursorColor: black,
                          controller: listData[index].insuranceCompanyController,
                          onChanged: (text) {
                            setState(() {
                              listData[index].setInsuranceCompany = text;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Insurance Company',
                            errorText: isSubmitClick
                                ? checkValidString(listData[index].insuranceCompany).isNotEmpty
                                    ? null
                                    : 'Insurance Company Can\'t Be Empty'
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
                          controller: listData[index].typeOfPolicyController,
                          onChanged: (text) {
                            setState(() {
                              listData[index].setTypeOfPolicy = text;
                            });
                          },
                          decoration: InputDecoration(
                            counterText: "",
                            labelText: 'Type of Policy',
                            errorText: isSubmitClick
                                ? checkValidString(listData[index].typeOfPolicy).isNotEmpty
                                ? null
                                : 'Type of Policy Can\'t Be Empty'
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
                          controller: listData[index].policyNumberController,
                          onChanged: (text) {
                            setState(() {
                              listData[index].setPolicyNumber = text;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Policy Number',
                            errorText: isSubmitClick
                                ? checkValidString(listData[index].policyNumber).isNotEmpty
                                ? null
                                : 'Policy Number Can\'t Be Empty'
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
                          controller: listData[index].personThingInsuredController,
                          onChanged: (text) {
                            setState(() {
                              listData[index].setPersonThingInsured = text;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Person/Thing Insured',
                            errorText: isSubmitClick
                                ? checkValidString(listData[index].personThingInsured).isNotEmpty
                                ? null
                                : 'Person/Thing Insured Can\'t Be Empty'
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
                          controller: listData[index].sumAssuredController,
                          onChanged: (text) {
                            setState(() {
                              listData[index].setSumAssured = text;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Sum Assured',
                            errorText: isSubmitClick
                                ? checkValidString(listData[index].sumAssured).isNotEmpty
                                ? null
                                : 'Sum Assured Can\'t Be Empty'
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
                          controller: listData[index].currentValueController,
                          onChanged: (text) {
                            setState(() {
                              listData[index].setCurrentValue = text;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Current Value',
                            errorText: isSubmitClick
                                ? checkValidString(listData[index].currentValue).isNotEmpty
                                ? null
                                : 'Current Value Can\'t Be Empty'
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
                                initialDate: checkValidString(listData[index].purchasedOn).isNotEmpty ? DateFormat("dd/MM/yyyy").parse(checkValidString(listData[index].purchasedOn)) : DateTime.now(),
                                firstDate: DateTime(1901),
                                lastDate:  DateTime.now().subtract(const Duration(days: 0)),
                                helpText: 'Purchased on',
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
                                listData[index].purchasedOnController.text = formattedDate; //set output date to TextField value.
                                listData[index].setPurchasedOn = formattedDate;
                              });
                            }
                          },
                          controller: listData[index].purchasedOnController,
                          onChanged: (text) {
                            setState(() {
                              listData[index].setPurchasedOn = text;
                            });
                          },
                          decoration: InputDecoration(
                            counterText: "",
                            labelText: 'Purchased on',
                            errorText: isSubmitClick
                                ? checkValidString(listData[index].purchasedOn).isNotEmpty
                                ? null
                                : 'Purchased on Can\'t Be Empty'
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
                          controller: listData[index].agentNameController,
                          onChanged: (text) {
                            setState(() {
                              listData[index].setAgentName = text;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Agent Name',
                            errorText: isSubmitClick
                                ? checkValidString(listData[index].agentName).isNotEmpty
                                ? null
                                : 'Agent Name Can\'t Be Empty'
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
                          controller: listData[index].agentPhoneController,
                          onChanged: (text) {
                            setState(() {
                              listData[index].setAgentPhone = text;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Agent Phone',
                            counterText: '',
                            errorText: isSubmitClick
                                ? checkValidString(listData[index].agentPhone).isNotEmpty
                                ? null
                                : 'Agent Phone Can\'t Be Empty'
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
                          controller: listData[index].agentAddressController,
                          onChanged: (text) {
                            setState(() {
                              listData[index].setAgentAddress = text;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Agent Address',
                            errorText: isSubmitClick
                                ? checkValidString(listData[index].agentAddress).isNotEmpty
                                ? null
                                : 'Agent Address Can\'t Be Empty'
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
                            labelText: 'Location Of Document',
                            errorText: isSubmitClick
                                ? checkValidString(listData[index].locationOfDocument).isNotEmpty
                                ? null
                                : 'Location Of Document Can\'t Be Empty'
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
                      Container(
                        margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
                        child: TextField(
                          keyboardType: TextInputType.text,
                          cursorColor: black,
                          controller: listData[index].nomineeNameController,
                          onChanged: (text) {
                            setState(() {
                              listData[index].setNomineeName = text;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Nominee Name',
                            errorText: isSubmitClick
                                ? checkValidString(listData[index].nomineeName).isNotEmpty
                                ? null
                                : 'Nominee Name Can\'t Be Empty'
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
                        addMoreViews(InsurancePoliciesDetails());
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

  void addMoreViews(InsurancePoliciesDetails data)
  {
    setState(() {
      data.setInsuranceCompany = checkValidString(itemData.insuranceCompany.toString().trim());
      data.setTypeOfPolicy = checkValidString(itemData.typeOfPolicy.toString().trim());
      data.setPolicyNumber = checkValidString(itemData.policyNumber.toString().trim());
      data.setPersonThingInsured = checkValidString(itemData.personThingInsured.toString().trim());
      data.setSumAssured = checkValidString(itemData.sumAssured.toString().trim());
      data.setCurrentValue = checkValidString(itemData.currentValue.toString().trim());
      data.setPurchasedOn = checkValidString(itemData.purchasedOn.toString().trim());
      data.setAgentName = checkValidString(itemData.agentName.toString().trim());
      data.setAgentPhone = checkValidString(itemData.agentPhone.toString().trim());
      data.setAgentAddress = checkValidString(itemData.agentAddress.toString().trim());
      data.setNomineeName = checkValidString(itemData.nomineeName.toString().trim());
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
      if (checkValidString(itemData.insuranceCompany).isNotEmpty &&
          checkValidString(itemData.typeOfPolicy).isNotEmpty &&
          checkValidString(itemData.policyNumber).isNotEmpty &&
          checkValidString(itemData.personThingInsured).isNotEmpty &&
          checkValidString(itemData.sumAssured).isNotEmpty &&
          checkValidString(itemData.currentValue).isNotEmpty &&
          checkValidString(itemData.purchasedOn).isNotEmpty &&
          checkValidString(itemData.agentName).isNotEmpty &&
          checkValidString(itemData.agentPhone).isNotEmpty &&
          checkValidString(itemData.agentAddress).isNotEmpty &&
          checkValidString(itemData.locationOfDocument).isNotEmpty &&
          checkValidString(itemData.notes).isNotEmpty &&
          checkValidString(itemData.uploadDoc).isNotEmpty &&
          checkValidString(itemData.nomineeName).isNotEmpty)
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

    final url = Uri.parse(API_URL_VAULT + saveInsurancePolicies);
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
      'module':(widget as AddInsurancePolicyPage).isForEdit ? "edit-insurance_policy" : "add-insurance_policy",
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
    widget is AddInsurancePolicyPage;
  }
}
