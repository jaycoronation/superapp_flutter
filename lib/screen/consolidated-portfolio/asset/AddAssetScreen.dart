import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/utils/app_utils.dart';
import 'package:superapp_flutter/utils/base_class.dart';

import '../../../common_widget/common_widget.dart';
import '../../../constant/colors.dart';
import '../../../constant/consolidate-portfolio/api_end_point.dart';
import '../../../model/consolidated-portfolio/assets/InvestmentTypeResponseModel.dart';

class AddAssetScreen extends StatefulWidget {


  const AddAssetScreen({super.key,});

  @override
  BaseState<AddAssetScreen> createState() => _AddAssetScreenState();
}

class _AddAssetScreenState extends BaseState<AddAssetScreen> {

  bool isLoading = false;
  List<InvestmentTypeList> listInvestmentType = [];

  String showSection = '';

  TextEditingController selectInvestmentTypeController = TextEditingController();
  String selectedInvestmentTypeName = '';
  String selectedInvestmentTypeId = '';

  TextEditingController selectedAssetClassController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController schemeNameController = TextEditingController();
  TextEditingController transactionTypeController = TextEditingController();
  TextEditingController transactionDateController = TextEditingController();
  TextEditingController amountInvestedController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController purchasePriceController = TextEditingController();
  TextEditingController currentPriceController = TextEditingController();
  TextEditingController currentValueController = TextEditingController();
  TextEditingController folioNoController = TextEditingController();
  TextEditingController ISINNoController = TextEditingController();
  TextEditingController firstHolderController = TextEditingController();
  TextEditingController secondHolderController = TextEditingController();
  TextEditingController nomineeController = TextEditingController();
  TextEditingController brokerController = TextEditingController();
  TextEditingController bankDetailsController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController interestRateController = TextEditingController();
  TextEditingController maturityDateController = TextEditingController();
  TextEditingController interestPayoutController = TextEditingController();
  TextEditingController propertyNameController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController totalValueController = TextEditingController();
  TextEditingController loanOutstandingController = TextEditingController();
  TextEditingController amountPendingController = TextEditingController();
  TextEditingController leasedController = TextEditingController();
  TextEditingController monthlyRentalController = TextEditingController();
  TextEditingController premiumController = TextEditingController();
  TextEditingController premiumStartDateController = TextEditingController();
  TextEditingController premiumEndDateController = TextEditingController();
  TextEditingController numberOfPremiumsPaidController = TextEditingController();
  TextEditingController totalPremiumsPaidController = TextEditingController();
  TextEditingController policyMaturityDateController = TextEditingController();
  TextEditingController sumAssuredController = TextEditingController();
  TextEditingController premiumFrequencyController = TextEditingController();
  TextEditingController policyNumberController = TextEditingController();
  TextEditingController policyHolderController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController vestedController = TextEditingController();
  TextEditingController stockOptionDateController = TextEditingController();
  TextEditingController numberofsharesController = TextEditingController();
  TextEditingController currencyNameController = TextEditingController();
  TextEditingController marketValueController = TextEditingController();
  TextEditingController cpController = TextEditingController();
  TextEditingController cryptoLTDController = TextEditingController();
  TextEditingController cryptoPLController = TextEditingController();
  TextEditingController cryptoPLFigController = TextEditingController();

  @override
  void initState() {
    getInvestmentType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 60,
          automaticallyImplyLeading: false,
          backgroundColor: appBg,
          elevation: 0,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: getBackArrow(),
          ),
          title: getTitle("Add Assets",)
      ),
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: selectInvestmentTypeController,
                readOnly: true,
                onTap: () {
                  openInvestmentTypeBottomSheet();
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Select Investment Type',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            getSelectedGroupFields(),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: getCommonButton("Submit", isLoading, () {

              },),
            )

          ],
        ),
      ),
    );
  }

  getInvestmentType() async {
    setState(() {
      isLoading = true;
    });

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_CP + investmentTypes);
    Map<String, String> jsonBody = {
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = InvestmentTypeResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      try
      {
        listInvestmentType = dataResponse.investmentTypeList ?? [];
        listInvestmentType.sort((a, b) => a.name!.compareTo(b.name ?? ''),);
      }
      catch(error)
      {
        print("display error : $error");
      }

      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void castStatefulWidget() {
    widget is AddAssetScreen;
  }

  void openInvestmentTypeBottomSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: white,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.88
        ),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context, StateSetter setStatenew) {
            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 22),
              child: Wrap(
                children: <Widget>[
                  Column(
                    children: [
                      getBottomSheetHeaderWithoutButton(context, "Select Investment Type"),
                      ListView.builder(
                        itemCount: listInvestmentType.length,
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              Navigator.pop(context);
                              setState(() {
                                selectedInvestmentTypeId = listInvestmentType[index].itId ?? '';
                                selectedInvestmentTypeName = listInvestmentType[index].name ?? '';
                                selectInvestmentTypeController.text = listInvestmentType[index].name ?? '';
                                selectInvestmentForm();
                              });
                            },
                            child: getBottomSheetItemWithoutSelection(listInvestmentType[index].name ?? '',selectedInvestmentTypeId == listInvestmentType[index].itId, false),
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            );
          });
        }
    );
  }

  void selectInvestmentForm() {
    Map<String, List<String>> sectionGroups = {
      'add_asset_1': ['1', '3', '4', '5', '6', '7', '8', '9', '10', '11', '36'],
      'add_asset_12': ['2'],
      'add_asset_2': ['12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22'],
      'add_asset_3': ['23', '24', '25', '26', '27', '28'],
      'add_asset_4': ['29', '30', '31', '32'],
      'add_asset_5': ['33', '35'],
      'add_asset_6': ['34'],
      'add_asset_7': ['37'],
    };

    setState(() {
      showSection = '';

      sectionGroups.forEach((section, values) {
        if (values.contains(selectedInvestmentTypeId)) {
          showSection = section;
        }
      });

      print("showSection == ${showSection}");
    });
  }

  getSelectedGroupFields() {
    if (showSection == "add_asset_1")
      {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: selectedAssetClassController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Asset Class',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: categoryController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Category',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: schemeNameController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Scheme Name',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: transactionTypeController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Transaction Type',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: transactionDateController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Transaction Date',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: amountInvestedController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Amount Invested (Purchase Value)',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: quantityController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Quantity',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: purchasePriceController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Purchase Price',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: currentPriceController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Current Price *',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: currentValueController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Current Value *',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: folioNoController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Folio No / Account No',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: ISINNoController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'ISIN No',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: firstHolderController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: '1st Holder *',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: secondHolderController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: '2nd Holder *',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: nomineeController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Nominee',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: brokerController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Broker / Advisor',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: bankDetailsController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Bank Details',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: notesController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Notes',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
          ],
        );
      }
    else if (showSection == "add_asset_12")
      {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: schemeNameController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Scheme Name',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: selectedAssetClassController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Asset Class',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: categoryController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Category',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: transactionTypeController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Transaction Type',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: transactionDateController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Transaction Date',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: amountInvestedController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Amount Invested (Purchase Value)',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: quantityController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Quantity',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: purchasePriceController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Purchase Price',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: currentPriceController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Current Price *',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: currentValueController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Current Value',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: folioNoController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Folio No / Account No',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: ISINNoController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'ISIN No',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: firstHolderController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: '1st Holder *',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: secondHolderController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: '2nd Holder *',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: nomineeController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Nominee',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: brokerController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Broker / Advisor',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: bankDetailsController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Bank Details',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: notesController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Notes',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
          ],
        );
      }
    else if (showSection == "add_asset_2")
      {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: selectedAssetClassController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Asset Class',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: schemeNameController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Scheme / Bank Name',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: transactionTypeController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Transaction Type',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: transactionDateController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Transaction Date',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: amountInvestedController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Amount Invested (Purchase Value)',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: interestRateController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Interest Rate',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: currentValueController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Current Value',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: maturityDateController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Maturity Date',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: folioNoController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Folio No / Account No',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: firstHolderController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: '1st Holder *',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: secondHolderController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: '2nd Holder *',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: nomineeController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Nominee',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: brokerController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Broker / Advisor',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: bankDetailsController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Bank Details',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: notesController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Notes',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: interestPayoutController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Interest - Payout / Cumulative',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
          ],
        );
      }
    else if (showSection == "add_asset_3")
      {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: selectedAssetClassController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Asset Class',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: propertyNameController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Property Name',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: transactionTypeController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Transaction Type',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: transactionDateController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Transaction Date',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: areaController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Area',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: totalValueController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Total Value',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: amountInvestedController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Amount Invested (Purchase Value)',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: loanOutstandingController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Loan Outstanding',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: amountPendingController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Amount Pending',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: currentValueController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Current Value',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: leasedController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Leased/ Not Leased',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: monthlyRentalController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Monthly Rental',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: firstHolderController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: '1st Holder *',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: secondHolderController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: '2nd Holder *',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: nomineeController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Nominee',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: brokerController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Broker / Advisor',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: bankDetailsController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Bank Details',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: notesController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Notes',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),

          ],
        );
      }
    else if (showSection == "add_asset_4")
      {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: selectedAssetClassController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Asset Class',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: schemeNameController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Scheme / Bank Name',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: transactionTypeController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Transaction Type',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: transactionDateController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Transaction Date',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: amountInvestedController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Amount Invested (Purchase Value)',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: premiumController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Premium',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: premiumStartDateController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Premium Start Date',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: premiumEndDateController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Premium End Date',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: numberOfPremiumsPaidController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Number of Premiums Paid',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: totalPremiumsPaidController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Total Premiums Paid',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: currentValueController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Current Value',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: policyMaturityDateController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Policy Maturity Date',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: sumAssuredController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Sum Assured',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: premiumFrequencyController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Premium Frequency',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: policyNumberController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Policy Number',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: policyHolderController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Policy Holder',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: nomineeController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Nominee',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: brokerController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Broker / Advisor',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: bankDetailsController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Bank Details',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: notesController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Notes',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
          ],
        );
      }
    else if (showSection == "add_asset_5")
      {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: selectedAssetClassController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Asset Class',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: categoryController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Given to Whom',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: schemeNameController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Loan Date',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: transactionTypeController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Loan Amount',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: transactionDateController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Maturity Date',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: amountInvestedController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Interest Rate',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: currentValueController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Current Value *',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: firstHolderController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: '1st Holder *',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: brokerController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Broker / Advisor',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: bankDetailsController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Bank Details',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: notesController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Notes',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
          ],
        );
      }
    else if (showSection == "add_asset_6")
      {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: selectedAssetClassController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Asset Class',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: companyNameController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Company Name',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: vestedController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Vested/ Unvested',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: stockOptionDateController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Stock Option Date',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: numberofsharesController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Number of shares',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: amountInvestedController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Amount Invested (Purchase Value) *',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: currentPriceController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Current Price',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: currentValueController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Current Value',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: firstHolderController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: '1st Holder *',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: brokerController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Broker / Advisor',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: bankDetailsController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Bank Details',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: notesController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Notes',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
          ],
        );
      }
    else if (showSection == "add_asset_7")
      {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: selectedAssetClassController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Asset Class',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: firstHolderController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: '1st Holder *',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: transactionTypeController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Transaction Type *',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: currencyNameController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Currency Name *',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: quantityController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Quantity',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: marketValueController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Market/Current Value',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: cpController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'CP',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: cryptoLTDController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Crypto LTD',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: cryptoPLController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Crypto PL',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: cryptoPLFigController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Crypto PL/FIG',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: notesController,
                readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Notes',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
          ],
        );
      }

  }
}