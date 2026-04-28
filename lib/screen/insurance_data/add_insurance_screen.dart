import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/model/CommanResponse.dart';
import 'package:superapp_flutter/utils/app_utils.dart';
import 'package:superapp_flutter/utils/base_class.dart';

import '../../common_widget/common_widget.dart';
import '../../constant/colors.dart';
import '../../constant/consolidate-portfolio/api_end_point.dart';
import '../../model/CommonModel.dart';
import '../../model/consolidated-portfolio/assets/FamilyMembersResponseModel.dart';
import '../../model/insurance/InsuranceListResponseModel.dart';

class AddInsuranceScreen extends StatefulWidget {
  final Insurances getSet;
  final bool isFromEdit;
  const AddInsuranceScreen(this.getSet, this.isFromEdit, {super.key});

  @override
  BaseState<AddInsuranceScreen> createState() => _AddInsuranceScreenState();
}

class _AddInsuranceScreenState extends BaseState<AddInsuranceScreen> {

  bool isLoading = false;
  bool isFromEdit = false;

  List<TabModel> listInsuranceType = [];
  List<TabModel> listPaymentFrequency = [];
  List<Members> listFamilyMember = [];
  Insurances getSet = Insurances();

  String documentUrl = "";

  PlatformFile? selectedDocumentFile;

  TextEditingController insuranceTypeController = TextEditingController();
  TextEditingController applicantController = TextEditingController();
  TextEditingController insuranceCompanyNameController = TextEditingController();
  TextEditingController policyNumberController = TextEditingController();
  TextEditingController sumAssuredController = TextEditingController();
  TextEditingController personCoveredController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController premiumAmountController = TextEditingController();
  TextEditingController maturityDateController = TextEditingController();
  TextEditingController lastPaymentDateController = TextEditingController();
  TextEditingController nextDuePaymentDateController = TextEditingController();
  TextEditingController policyTenureController = TextEditingController();
  TextEditingController premiumFrequencyController = TextEditingController();

  String selectedType = "";

  @override
  void initState() {
    getSet = (widget as AddInsuranceScreen).getSet;
    isFromEdit = (widget as AddInsuranceScreen).isFromEdit;
    getFamilyMembers();
    setData();
    super.initState();
  }

  setData() {
    listInsuranceType = [
      TabModel(id: "1", title: "Life Insurance"),
      TabModel(id: "2", title: "Medical Insurance"),
      TabModel(id: "3", title: "Auto Insurance"),
      TabModel(id: "4", title: "Other Insurance"),
    ];

    listPaymentFrequency = [
      TabModel(id: "1", title: "Monthly"),
      TabModel(id: "2", title: "Quarterly"),
      TabModel(id: "3", title: "Half-Yearly"),
      TabModel(id: "4", title: "Yearly"),
    ];

    if(isFromEdit)
    {
      insuranceCompanyNameController.text = getSet.insuranceCompany ?? "";
      policyNumberController.text = getSet.policyNumber ?? "";
      sumAssuredController.text = getSet.sumAssured ?? "";
      personCoveredController.text = getSet.personCovered ?? "";
      startDateController.text = getSet.startDate != null ? universalDateConverter("dd-MM-yyyy", "dd MMM, yyyy", getSet.startDate ?? "") : "";
      endDateController.text = getSet.endDate != null ? universalDateConverter("dd-MM-yyyy", "dd MMM, yyyy", getSet.endDate ?? "") : "";
      premiumAmountController.text = getSet.premiumAmount ?? "";
      maturityDateController.text = getSet.maturityDate != null ? timestampToDate(getSet.maturityDate ?? "") : "";
      lastPaymentDateController.text = getSet.lastPaymentDate != null ? timestampToDate(getSet.lastPaymentDate ?? "") : "";
      nextDuePaymentDateController.text = getSet.nextDueDate != null ? timestampToDate(getSet.nextDueDate ?? "") : "";
      selectedType = getSet.type ?? "";
      documentUrl = getSet.fileUrl ?? "";

      listInsuranceType.forEach((element) {
        if(selectedType.contains(element.id))
        {
          insuranceTypeController.text = element.title;
        }
      },);
      setState(() {});
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        toolbarHeight: 55,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: getBackArrow(),
        ),
        title: getTitle("Add Insurances"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select Insurance Type",
                  style: getMediumTextStyle(fontSize: 14, color: black),
                ),
                const Gap(10),
                TextField(
                  keyboardType: TextInputType.text,
                  cursorColor: black,
                  controller: insuranceTypeController,
                  readOnly: true,
                  onTap: () {
                    if(!isFromEdit)
                    {
                      openDialog(1);
                    }
                  },
                  decoration: InputDecoration(
                    counterText: "",
                    hintText: 'Select Insurance Type',
                    suffixIcon: Icon(Icons.keyboard_arrow_down_outlined, size: 24, color: blackLight,),
                  ),
                  style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
                ),
                Visibility(
                  visible: insuranceTypeController.text.isNotEmpty,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(20),
                      Text(
                        "Select Applicant",
                        style: getMediumTextStyle(fontSize: 14, color: black),
                      ),
                      const Gap(10),
                      TextField(
                        keyboardType: TextInputType.text,
                        cursorColor: black,
                        controller: applicantController,
                        decoration: InputDecoration(
                          hintText: '-- Select --',
                          suffixIcon: Icon(Icons.keyboard_arrow_down_outlined, size: 24, color: blackLight,),
                        ),
                        readOnly: true,
                        onTap: () {
                          if(listFamilyMember.isNotEmpty)
                          {
                            openDialog(2);
                          }
                          else
                          {
                            showToast("Applicant Data Not Found");
                          }
                        },
                        style: getBoldTextStyle(fontSize: 16, color: black),
                      ),
                      const Gap(20),
                      Text(
                        "Name of Insurance Company",
                        style: getMediumTextStyle(fontSize: 14, color: black),
                      ),
                      const Gap(10),
                      TextField(
                        keyboardType: TextInputType.text,
                        cursorColor: black,
                        controller: insuranceCompanyNameController,
                        decoration: InputDecoration(
                          hintText: '',
                        ),
                        style: getBoldTextStyle(fontSize: 16, color: black),
                      ),
                      const Gap(20),
                      Text(
                        "Policy Number",
                        style: getMediumTextStyle(fontSize: 14, color: black),
                      ),
                      const Gap(10),
                      TextField(
                        keyboardType: TextInputType.text,
                        cursorColor: black,
                        controller: policyNumberController,
                        decoration: InputDecoration(
                          hintText: '',
                        ),
                        style: getBoldTextStyle(fontSize: 16, color: black),
                      ),

                      const Gap(20),
                      Text(
                        "Sum Assured",
                        style: getMediumTextStyle(fontSize: 14, color: black),
                      ),
                      const Gap(10),
                      TextField(
                        keyboardType: TextInputType.number,
                        cursorColor: black,
                        controller: sumAssuredController,
                        decoration: InputDecoration(
                          hintText: '',
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        style: getBoldTextStyle(fontSize: 16, color: black),
                      ),
                      const Gap(20),
                      Text(
                        "Person Covered",
                        style: getMediumTextStyle(fontSize: 14, color: black),
                      ),
                      const Gap(10),
                      TextField(
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        cursorColor: black,
                        controller: personCoveredController,
                        decoration: InputDecoration(
                          hintText: '',
                        ),
                        maxLines: 3,
                        style: getBoldTextStyle(fontSize: 16, color: black),
                      ),
                      const Gap(4),
                      Text("Add members comma (,) separated", style: getRegularTextStyle(fontSize: 12, color: grayDark),),
                      const Gap(20),
                      Text(
                        "Start Date",
                        style: getMediumTextStyle(fontSize: 14, color: black),
                      ),
                      const Gap(10),
                      TextField(
                        keyboardType: TextInputType.text,
                        cursorColor: black,
                        controller: startDateController,
                        readOnly: true,
                        onTap: () {
                          openDatePicker(startDateController, hintText: "Select Start Date");
                        },
                        decoration: InputDecoration(
                          hintText: 'dd MMM, yyyy',
                          suffixIcon: Icon(Icons.calendar_today, size: 20, color: blackLight,),
                        ),
                        style: getBoldTextStyle(fontSize: 16, color: black),
                      ),
                      const Gap(20),
                      Text(
                        "End Date",
                        style: getMediumTextStyle(fontSize: 14, color: black),
                      ),
                      const Gap(10),
                      TextField(
                        keyboardType: TextInputType.text,
                        cursorColor: black,
                        controller: endDateController,
                        readOnly: true,
                        onTap: () {
                          openDatePicker(endDateController, hintText: "Select End Date");
                        },
                        decoration: InputDecoration(
                          hintText: 'dd MMM, yyyy',
                          suffixIcon: Icon(Icons.calendar_today, size: 20, color: blackLight,),
                        ),
                        style: getBoldTextStyle(fontSize: 16, color: black),
                      ),
                      const Gap(20),
                      Text(
                        "Premium amount",
                        style: getMediumTextStyle(fontSize: 14, color: black),
                      ),
                      const Gap(10),
                      TextField(
                        keyboardType: TextInputType.number,
                        cursorColor: black,
                        controller: premiumAmountController,
                        decoration: InputDecoration(
                          hintText: '',
                        ),
                        style: getBoldTextStyle(fontSize: 16, color: black),
                      ),

                      const Gap(20),
                      Text(
                        "Policy Tenure(In Years)",
                        style: getMediumTextStyle(fontSize: 14, color: black),
                      ),
                      const Gap(10),
                      TextField(
                        keyboardType: TextInputType.number,
                        cursorColor: black,
                        controller: policyTenureController,
                        decoration: InputDecoration(
                          hintText: '',
                        ),
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        style: getBoldTextStyle(fontSize: 16, color: black),
                      ),
                      const Gap(20),
                      Text(
                        "Premium Payment Frequency",
                        style: getMediumTextStyle(fontSize: 14, color: black),
                      ),
                      const Gap(10),
                      TextField(
                        keyboardType: TextInputType.number,
                        cursorColor: black,
                        controller: premiumFrequencyController,
                        decoration: InputDecoration(
                          hintText: '--Select--',
                          suffixIcon: Icon(Icons.keyboard_arrow_down_outlined, size: 24, color: blackLight,),
                        ),
                        readOnly: true,
                        onTap: () {
                          openDialog(3);
                        },
                        style: getBoldTextStyle(fontSize: 16, color: black),
                      ),
                      const Gap(20),
                      Text(
                        "Upload Documents",
                        style: getMediumTextStyle(fontSize: 14, color: black),
                      ),
                      const Gap(10),
                      Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(color: borderGray)
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                chooseFile();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: graySemiDark,
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(2), bottomLeft: Radius.circular(2)),
                                    border: Border(right: BorderSide(color: borderGray))
                                ),
                                padding: const EdgeInsets.only(left: 20, right: 20, top: 14, bottom: 14),
                                child: Text(
                                  "Choose File",
                                  style: getMediumTextStyle(fontSize: 12, color: black),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                color: white,
                                padding: const EdgeInsets.only(left: 16, right: 8, top: 14, bottom: 14),
                                child: Text(
                                  selectedDocumentFile == null ? "No file chosen" : "${selectedDocumentFile?.name}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: getMediumTextStyle(fontSize: 12, color: blackLight),
                                ),
                              ),
                            ),
                            Visibility(
                                visible: selectedDocumentFile != null,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedDocumentFile = null;
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 8),
                                    child: Image.asset("assets/images/ic_close.png", height: 18, width: 18,),
                                  ),
                                )
                            )
                          ],
                        ),
                      ),
                      Visibility(
                        visible: documentUrl.isNotEmpty,
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              openFileFromURL(documentUrl, context);
                            },
                            child: Text(
                              "View Document",
                              style: getMediumTextStyle(fontSize: 16, color: blue),
                            ),
                          ),
                        ),
                      ),


                      // const Gap(20),
                      // Text(
                      //   "Maturity Date",
                      //   style: getMediumTextStyle(fontSize: 14, color: black),
                      // ),
                      // const Gap(10),
                      // TextField(
                      //   keyboardType: TextInputType.text,
                      //   cursorColor: black,
                      //   controller: maturityDateController,
                      //   readOnly: true,
                      //   onTap: () {
                      //     openDatePicker(maturityDateController, hintText: "Select Maturity Date");
                      //   },
                      //   decoration: InputDecoration(
                      //     hintText: 'dd MMM, yyyy',
                      //     suffixIcon: Icon(Icons.calendar_today, size: 20, color: blackLight,),
                      //   ),
                      //   style: getBoldTextStyle(fontSize: 16, color: black),
                      // ),
                      // const Gap(20),
                      // Text(
                      //   "Last Payment Date",
                      //   style: getMediumTextStyle(fontSize: 14, color: black),
                      // ),
                      // const Gap(10),
                      // TextField(
                      //   keyboardType: TextInputType.text,
                      //   cursorColor: black,
                      //   controller: lastPaymentDateController,
                      //   readOnly: true,
                      //   onTap: () {
                      //     openDatePicker(lastPaymentDateController, hintText: "Select Last Payment Date");
                      //   },
                      //   decoration: InputDecoration(
                      //     hintText: 'dd MMM, yyyy',
                      //     suffixIcon: Icon(Icons.calendar_today, size: 20, color: blackLight,),
                      //   ),
                      //   style: getBoldTextStyle(fontSize: 16, color: black),
                      // ),
                      // const Gap(20),
                      // Text(
                      //   "Next Due Payment Date",
                      //   style: getMediumTextStyle(fontSize: 14, color: black),
                      // ),
                      // const Gap(10),
                      // TextField(
                      //   keyboardType: TextInputType.text,
                      //   cursorColor: black,
                      //   controller: nextDuePaymentDateController,
                      //   readOnly: true,
                      //   onTap: () {
                      //     openDatePicker(nextDuePaymentDateController, hintText: "Select Next Due Payment Date");
                      //   },
                      //   decoration: InputDecoration(
                      //     hintText: 'dd MMM, yyyy',
                      //     suffixIcon: Icon(Icons.calendar_today, size: 20, color: blackLight,),
                      //   ),
                      //   style: getBoldTextStyle(fontSize: 16, color: black),
                      // ),
                      Container(
                        margin: const EdgeInsets.only(top: 30, bottom: 20),
                        width: MediaQuery.of(context).size.width,
                        child: getCommonButton(
                          "Save",
                          isLoading,
                          () {
                            if(insuranceTypeController.text.isEmpty)
                            {
                              showToast("Please enter insurance type");
                            }
                            else if(insuranceCompanyNameController.text.isEmpty)
                            {
                              showToast("Please enter company name");
                            }
                            else if(policyNumberController.text.isEmpty)
                            {
                              showToast("Please enter policy number");
                            }
                            else if(sumAssuredController.text.isEmpty)
                            {
                              showToast("Please enter sum assured");
                            }
                            else if(personCoveredController.text.isEmpty)
                            {
                              showToast("Please enter person covered");
                            }
                            else if(startDateController.text.isEmpty)
                            {
                              showToast("Please enter start date");
                            }
                            else if(endDateController.text.isEmpty)
                            {
                              showToast("Please enter end date");
                            }
                            else if(premiumAmountController.text.isEmpty)
                            {
                              showToast("Please enter premium amount");
                            }
                            // else if(maturityDateController.text.isEmpty)
                            // {
                            //   showToast("Please enter maturity date");
                            // }
                            // else if(lastPaymentDateController.text.isEmpty)
                            // {
                            //   showToast("Please enter last payment date");
                            // }
                            // else if(nextDuePaymentDateController.text.isEmpty)
                            // {
                            //   showToast("Please enter next due payment date");
                            // }
                            else
                            {
                              if(isOnline)
                              {
                                addUpdateInsurance();
                              }
                              else
                              {
                                noInterNet(context);
                              }
                            }
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> chooseFile() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
    );

    if (result != null)
    {
      PlatformFile file = result.files.first;

      setState(() {
        selectedDocumentFile = file;
      });
    }
  }

  openDialog(int isFor){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.85,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  getBottomSheetHeaderWithoutButton(context, isFor == 1 ? "Select Type" : isFor == 2 ? "Select Applicant" : "Select Payment Frequency"),
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: isFor == 1 ? listInsuranceType.length : isFor == 2 ? listFamilyMember.length : listPaymentFrequency.length,
                      physics: BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(0),
                      itemBuilder: (context, index) {
                        final bool isLastItem = isFor == 1 ? (index == listInsuranceType.length - 1) : isFor == 2 ? (index == listFamilyMember.length - 1) : (index == listPaymentFrequency.length - 1);
                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            setState(() {
                              if(isFor == 1)
                              {
                                selectedType = listInsuranceType[index].id;
                                insuranceTypeController.text = listInsuranceType[index].title;
                              }
                              else if(isFor == 2)
                              {
                                applicantController.text = listFamilyMember[index].applicantName ?? "";
                              }
                              else
                              {
                                premiumFrequencyController.text = listPaymentFrequency[index].title;
                              }
                            });
                            Navigator.pop(context);
                          },
                          child: isFor == 1 ? getBottomSheetItemWithoutSelection(listInsuranceType[index].title, selectedType == listInsuranceType[index].id, isLastItem ? true : false) :
                                 isFor == 2 ? getBottomSheetItemWithoutSelection(listFamilyMember[index].applicantName ?? "", applicantController.text == listFamilyMember[index].applicantName, isLastItem ? true : false) :
                                 getBottomSheetItemWithoutSelection(listPaymentFrequency[index].title, premiumFrequencyController.text == listPaymentFrequency[index].title, isLastItem ? true : false),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> openDatePicker(TextEditingController controller, {String hintText = "Select Date"}) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: checkValidString(controller.text).isNotEmpty ? DateFormat("dd MMM, yyyy").parse(controller.text) : DateTime.now(),
        firstDate: DateTime(1901),
        lastDate:  DateTime(2040),
        helpText: hintText,
        builder: (context, Widget? child) => Theme(
          data: Theme.of(context).copyWith(appBarTheme: Theme.of(context).appBarTheme.copyWith(
              backgroundColor: black, iconTheme: Theme.of(context).appBarTheme.iconTheme?.copyWith(color: white)
          ),
          scaffoldBackgroundColor: white,
          colorScheme: const ColorScheme.light(onPrimary: white, primary: black)),
          child: child!,
        ));
    if (pickedDate != null)
    {
      String formattedDate = DateFormat('dd MMM, yyyy').format(pickedDate);
      setState(() {
        controller.text = formattedDate;
      });
    }
  }

  getFamilyMembers() async {

    setState(() {
      isLoading = true;
    });

    try
    {
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(API_URL_CP_ASSETS + getFamilyMembersApi);
      Map<String, String> jsonBody = {
        "user_id" : sessionManagerPMS.getUserId()
      };

      final response = await http.post(url, body: jsonBody);
      final statusCode = response.statusCode;
      final body = response.body;
      Map<String, dynamic> user = jsonDecode(body);
      var dataResponse = FamilyMembersResponseModel.fromJson(user);

      if(statusCode == 200 && dataResponse.success == 1)
      {
        listFamilyMember = dataResponse.members ?? [];
      }
      else
      {
        listFamilyMember = [];
      }
    }
    catch(e)
    {
      print("display error family member: $e");
    }
    finally
    {
      setState(() {
        isLoading = false;
      });
    }
  }

  addUpdateInsurance() async{
    if(isOnline)
    {
      setState(() {
        isLoading = true;
      });

      try
      {

        final url = Uri.parse(API_URL_CP + addInsuranceApi);
        http.MultipartRequest request = http.MultipartRequest('POST', url,);

        Map<String, String> jsonBody;
        jsonBody = {
          if(isFromEdit) "insurance_id": "${getSet.insuranceId}",
          if(isFromEdit) "timestamp": "${getSet.timestamp}",
          if(isFromEdit && (getSet.document?.isNotEmpty ?? false)) "document": "${getSet.document}",
          if(isFromEdit && (getSet.fileUrl?.isNotEmpty ?? false)) "file_url": "${getSet.fileUrl}",
          "type": selectedType,
          "insurance_company": insuranceCompanyNameController.text,
          "policy_number": policyNumberController.text,
          "sum_assured": sumAssuredController.text,
          "person_covered": personCoveredController.text,
          "start_date": universalDateConverter("dd MMM, yyyy", "yyyy-MM-dd", startDateController.text),
          "end_date": universalDateConverter("dd MMM, yyyy", "yyyy-MM-dd", endDateController.text),
          "premium_amount": premiumAmountController.text,
          // "maturity_date": universalDateConverter("dd MMM, yyyy", "yyyy-MM-dd", maturityDateController.text),
          // "last_payment_date": universalDateConverter("dd MMM, yyyy", "yyyy-MM-dd", lastPaymentDateController.text),
          // "next_due_date": universalDateConverter("dd MMM, yyyy", "yyyy-MM-dd", nextDuePaymentDateController.text),
          "nominee": "",
          "premium_payment_tenure": premiumFrequencyController.text,
          "applicant_name": applicantController.text,
          "policy_tenure": policyTenureController.text,
          "user_id" : sessionManagerPMS.getUserId(),
        };

        print("Display json body insurance : $jsonBody");

        if (selectedDocumentFile != null)
        {
          request.files.add(await http.MultipartFile.fromPath('upload_doc', selectedDocumentFile?.path ?? ""));
        }

        request.fields.addAll(jsonBody);
        http.StreamedResponse response = await request.send();
        var responseBytes = await response.stream.toBytes();
        var responseString = utf8.decode(responseBytes);

        final statusCode = response.statusCode;
        Map<String, dynamic> user = jsonDecode(responseString);
        var dataResponse = CommanResponse.fromJson(user);

        if(statusCode == 200 && dataResponse.success == 1)
        {
          showToast("${dataResponse.message}");
          Navigator.pop(context, "success");
        }
        else
        {
          showToast("${dataResponse.message}");
        }
      }
      catch(e)
      {
        print("Failed to add insurance");
      }
      finally
      {
       setState(() {
         isLoading = false;
       });
      }
    }
    else
    {
      noInterNet(context);
    }
  }

  @override
  void castStatefulWidget() {
    widget as AddInsuranceScreen;
  }
}
