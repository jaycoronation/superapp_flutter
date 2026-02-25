import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/model/CommanResponse.dart';
import 'package:superapp_flutter/model/consolidated-portfolio/assets/SchemesResponseModel.dart';
import 'package:superapp_flutter/model/consolidated-portfolio/assets/SearchSchemeResponseModel.dart';
import 'package:superapp_flutter/utils/app_utils.dart';
import 'package:superapp_flutter/utils/base_class.dart';

import '../../../common_widget/common_widget.dart';
import '../../../constant/colors.dart';
import '../../../constant/consolidate-portfolio/api_end_point.dart';
import '../../../model/CommonModel.dart';
import '../../../model/consolidated-portfolio/assets/FamilyMembersResponseModel.dart';
import '../../../model/consolidated-portfolio/assets/InvestmentTypeResponseModel.dart';

class AddAssetScreen extends StatefulWidget {


  const AddAssetScreen({super.key,});

  @override
  BaseState<AddAssetScreen> createState() => _AddAssetScreenState();
}

class _AddAssetScreenState extends BaseState<AddAssetScreen> {

  bool isLoading = false;

  List<SearchSchemes> listSearchScheme = [];
  SearchSchemes selectedScheme = SearchSchemes();

  List<InvestmentTypeList> listInvestmentType = [];
  List<InvestmentTypeList> listInvestmentTypeMain = [];

  List<SchemesFinal> listSchemesFinal = [];
  String selectedSchemeName = '';
  String selectedSchemeNameId = '';

  List<Members> listFamilyMember = [];
  String selectedFamilyMember = '';
  String selectedFamilyMemberId = '';

  List<CommonValueModel> listTransactionType = [];
  String selectedTransactionType = '';

  List<CommonValueModel> listAssetType = [];
  String selectedAssetType = '';

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

  Timer? _debounce;

  @override
  void initState() {
    getInvestmentType();
    getFamilyMembers();
    setData();

    schemeNameController.addListener(() {
      if (selectedScheme.schemeName == null)
        {
          _onSearchChanged(schemeNameController.text);
        }
    });

    super.initState();
  }

  void _onSearchChanged(String text) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (text.isNotEmpty) {
        searchSchemeApi(text);
      } else {
        setState(() {
          listSearchScheme.clear();
        });
      }
    });
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
                  labelText: 'Select Investment Type * ',
                  suffix: Icon(Icons.keyboard_arrow_down_outlined,size: 20,),
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            getSelectedGroupFields(),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: getCommonButton("Submit", isLoading, () {

                if (showSection.isEmpty)
                  {
                    showToast("Please select Investment Type");
                    return;
                  }

                if (showSection == "add_asset_1")
                  {
                    if (selectedAssetType.isEmpty)
                      {
                        showToast("Please select Asset Type.");
                      }
                    else if (selectedTransactionType.isEmpty)
                      {
                        showToast("Please select Transaction Type");
                      }
                    else if (amountInvestedController.text.isEmpty)
                      {
                        showToast("Please enter Amount Invested.");
                      }
                    else if (currentValueController.text.isEmpty)
                      {
                        showToast("Please enter Current Value.");
                      }
                    else
                      {
                        saveAssetsApi();
                      }
                  }
                else if (showSection == "add_asset_12")
                  {
                    if (schemeNameController.text.isEmpty)
                      {
                        showToast("Please select Scheme Name");
                      }
                    else if (selectedAssetClassController.text.isEmpty)
                      {
                        showToast("Please select Asset Type.");
                      }
                    else if (categoryController.text.isEmpty)
                      {
                        showToast("Please enter category.");
                      }
                    else if (selectedTransactionType.isEmpty)
                      {
                        showToast("Please select Transaction Type");
                      }
                    else if (amountInvestedController.text.isEmpty)
                      {
                        showToast("Please enter amount invested");
                      }
                    else if (currentValueController.text.isEmpty)
                      {
                        showToast("Please enter current value");
                      }
                    else
                      {
                        saveAssetsApi();
                      }
                  }
                else if (showSection == "add_asset_2")
                  {
                    if (amountInvestedController.text.isEmpty)
                      {
                        showToast("Please enter invested amount");
                      }
                    else if (currentValueController.text.isEmpty)
                      {
                        showToast("Please enter current value");
                      }
                    else
                      {
                        saveAssetsApi();
                      }
                  }
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
        listInvestmentTypeMain = listInvestmentType;
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

  getFamilyMembers() async {
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

    if (statusCode == 200 && dataResponse.success == 1) {
      try
      {
        setState(() {
          listFamilyMember = dataResponse.members ?? [];
        });
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

  getSchemeApi() async {
    setState(() {
      isLoading = true;
    });

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_CP + getFamilyMembersApi);
    Map<String, String> jsonBody = {
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = SchemesResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      try
      {
        listSchemesFinal = dataResponse.schemesFinal ?? [];
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

  searchSchemeApi(String text) async {
    setState(() {
      isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_CP_ASSETS + searchScheme);

    Map<String, String> jsonBody = {
      "investment_type" : selectedInvestmentTypeId,
      "search_schemes" : text
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = SearchSchemeResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      try
      {
        listSearchScheme = dataResponse.searchSchemes ?? [];
      }
      catch(error)
      {
        print("display error : $error");
        setState(() {
          isLoading = false;
        });
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

  saveAssetsApi() async {
    setState(() {
      isLoading = true;
    });
    print("IS IN SAVE ${saveAsset}");
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse("https://portfolio.alphacapital.in/api/services/assets/add");

    Map<String, String> jsonBody = getPayloads();

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = CommanResponse.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      try
      {
        showToast(dataResponse.message);
        Navigator.pop(context);
      }
      catch(error)
      {
        print("display error : $error");
        setState(() {
          isLoading = false;
        });
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

    TextEditingController searchController = TextEditingController();

    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: white,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.88
        ),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setStateNew) {
            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 22),
              child: Column(
                children: [
                  getBottomSheetHeaderWithoutButton(context, "Select Investment Type"),
                  TextField(
                    cursorColor: black,
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.search,
                    style: TextStyle(
                        fontSize: 16,
                        color: black,
                        fontWeight: FontWeight.w400
                    ),
                    onChanged: (value) {
                      setStateNew((){
                        if (value.isNotEmpty)
                        {
                          listInvestmentType = [];
                          for (var i=0; i < listInvestmentTypeMain.length; i++)
                          {
                            if (listInvestmentTypeMain[i].name?.toLowerCase().contains(value.toLowerCase()) ?? false)
                            {
                              listInvestmentType.add(listInvestmentTypeMain[i]);
                            }
                          }
                        }
                        else
                        {
                          listInvestmentType = listInvestmentTypeMain;
                        }
                      });

                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent,
                      hintText: 'Search Investment Type...',
                      // enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(0.0), borderSide: BorderSide.none),
                      // border: OutlineInputBorder(borderRadius: BorderRadius.circular(0.0), borderSide: BorderSide.none),
                      // focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(0.0), borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.only(left: 12, right: 12),
                      prefixIcon: const InkWell(
                        onTap: null,
                        child: Icon(Icons.search_rounded, size: 26, color: black),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: listInvestmentType.length,
                      physics: const BouncingScrollPhysics(),
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
                  ),
                ],
              ),
            );
          },);
        }
    );
  }

  void openFirstHolderBottomSheet() {
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
                      getBottomSheetHeaderWithoutButton(context, "Select 1st Holder"),
                      ListView.builder(
                        itemCount: listFamilyMember.length,
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              Navigator.pop(context);
                              setState(() {
                                selectedFamilyMember = listFamilyMember[index].applicantName ?? '';
                                selectedFamilyMemberId = listFamilyMember[index].userId ?? '';
                                firstHolderController.text = listFamilyMember[index].applicantName ?? '';
                              });
                            },
                            child: getBottomSheetItemWithoutSelection(listFamilyMember[index].applicantName ?? '',selectedFamilyMember == listFamilyMember[index].applicantName, false),
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

  void openAssetClassBottomSheet() {
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
                      getBottomSheetHeaderWithoutButton(context, "Select Asset Class"),
                      ListView.builder(
                        itemCount: listAssetType.length,
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              Navigator.pop(context);
                              setState(() {
                                selectedAssetType = listAssetType[index].title ?? '';
                                selectedAssetClassController.text = listAssetType[index].title ?? '';
                              });
                            },
                            child: getBottomSheetItemWithoutSelection(listAssetType[index].title ?? '',selectedAssetType == listAssetType[index].title, false),
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

  void openTransactionTypeBottomSheet() {
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
                      getBottomSheetHeaderWithoutButton(context, "Select Transaction Type"),
                      ListView.builder(
                        itemCount: listTransactionType.length,
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              Navigator.pop(context);
                              setState(() {
                                selectedTransactionType = listTransactionType[index].title ?? '';
                                transactionTypeController.text = listTransactionType[index].title ?? '';
                              });
                            },
                            child: getBottomSheetItemWithoutSelection(listTransactionType[index].title ?? '',selectedTransactionType == listTransactionType[index].title, false),
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

      print("showSection == $showSection");
    });
  }

  Widget getSelectedGroupFields() {

    Widget getDataView = Column();

    if (showSection == "add_asset_1")
      {
        getDataView = Column(
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
                  openAssetClassBottomSheet();
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Asset Class *',
                  suffix: Icon(Icons.keyboard_arrow_down_outlined,size: 20,),
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
                textCapitalization: TextCapitalization.words,
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
                textCapitalization: TextCapitalization.words,
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
                  openTransactionTypeBottomSheet();
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Transaction Type *',
                  suffix: Icon(Icons.keyboard_arrow_down_outlined,size: 20,),
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
                  openDatePicker(transactionDateController);
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
                keyboardType: TextInputType.number,
                cursorColor: black,
                controller: amountInvestedController,
                readOnly: true,
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
                cursorColor: black,
                controller: quantityController,
                keyboardType: TextInputType.number,
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
                keyboardType: TextInputType.number,
                cursorColor: black,
                controller: purchasePriceController,
                onChanged: (value) {
                  if (quantityController.value.text.isNotEmpty)
                    {
                      var qty = num.parse(quantityController.value.text);
                      var purchasePrice = num.parse(purchasePriceController.value.text);

                      amountInvestedController.text = (qty * purchasePrice).toString();
                    }
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
                keyboardType: TextInputType.number,
                cursorColor: black,
                controller: currentPriceController,
                onChanged: (value) {
                  if (quantityController.value.text.isNotEmpty)
                  {
                    var qty = num.parse(quantityController.value.text);
                    var purchasePrice = num.parse(currentPriceController.value.text);

                    currentValueController.text = (qty * purchasePrice).toString();
                  }
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
                  openFirstHolderBottomSheet();
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: '1st Holder *',
                  suffix: Icon(Icons.keyboard_arrow_down_outlined,size: 20,),
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
                decoration: InputDecoration(
                  counterText: "",
                  labelText: '2nd Holder',
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
        getDataView = Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: Column(
                children: [
                  TextField(
                    controller: schemeNameController,
                    cursorColor: black,
                    decoration: InputDecoration(
                      labelText: "Scheme Name",
                      suffixIcon: isLoading
                          ? const Padding(
                        padding: EdgeInsets.all(12),
                        child: SizedBox(
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2,color: blue,),
                          width: 18,
                        ),
                      )
                          : null,
                    ),
                  ),

                  /// Dropdown Result
                  if (listSearchScheme.isNotEmpty)
                    Container(
                      constraints: const BoxConstraints(maxHeight: 250),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: listSearchScheme.length,
                        itemBuilder: (context, index) {
                          final item = listSearchScheme[index];

                          return ListTile(
                            title: Text(
                              item.schemeName ?? "",
                              style: const TextStyle(fontSize: 14),
                            ),
                            subtitle: Text(item.category ?? ""),
                            onTap: () {
                              setState(() {
                                selectedScheme = item;
                                schemeNameController.text = item.schemeName ?? "";
                                selectedAssetClassController.text = item.assetClass ?? "";
                                categoryController.text = item.category ?? "";
                                ISINNoController.text = item.isinNo ?? "";
                                listSearchScheme.clear();
                              });
                            },
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: selectedAssetClassController,
                readOnly: true,
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
                  openTransactionTypeBottomSheet();
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
                  openDatePicker(transactionDateController);
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
                keyboardType: TextInputType.number,
                cursorColor: black,
                controller: amountInvestedController,
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
                cursorColor: black,
                controller: quantityController,
                keyboardType: TextInputType.number,
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
                keyboardType: TextInputType.number,
                cursorColor: black,
                controller: purchasePriceController,
                onChanged: (value) {
                  if (quantityController.value.text.isNotEmpty)
                  {
                    var qty = num.parse(quantityController.value.text);
                    var purchasePrice = num.parse(purchasePriceController.value.text);

                    amountInvestedController.text = (qty * purchasePrice).toString();
                  }
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
                keyboardType: TextInputType.number,
                cursorColor: black,
                controller: currentPriceController,
                onChanged: (value) {
                  if (quantityController.value.text.isNotEmpty)
                  {
                    var qty = num.parse(quantityController.value.text);
                    var purchasePrice = num.parse(currentPriceController.value.text);

                    currentValueController.text = (qty * purchasePrice).toString();
                  }
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
                  openFirstHolderBottomSheet();
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
                textCapitalization: TextCapitalization.words,
                cursorColor: black,
                controller: secondHolderController,
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
                textCapitalization: TextCapitalization.words,
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
                textCapitalization: TextCapitalization.words,
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
        getDataView = Column(
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
                  openAssetClassBottomSheet();
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
                textCapitalization: TextCapitalization.sentences,
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
                  openTransactionTypeBottomSheet();
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
                  openDatePicker(transactionDateController);
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
                keyboardType: TextInputType.number,
                cursorColor: black,
                controller: amountInvestedController,
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
                keyboardType: TextInputType.number,
                cursorColor: black,
                controller: interestRateController,
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
                keyboardType: TextInputType.number,
                cursorColor: black,
                controller: currentValueController,
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
                  openDatePicker(maturityDateController);
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
                  openFirstHolderBottomSheet();
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
                textCapitalization: TextCapitalization.words,
                cursorColor: black,
                controller: secondHolderController,
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
                textCapitalization: TextCapitalization.words,
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
        getDataView = Column(
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
        getDataView = Column(
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
        getDataView = Column(
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
        getDataView = Column(
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
        getDataView = Column(
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

    return getDataView;
  }

  void setData() {
    listAssetType.add(CommonValueModel(title: "Alternate", description: '', image: "", id: ""));
    listAssetType.add(CommonValueModel(title: "Debt", description: '', image: "", id: ""));
    listAssetType.add(CommonValueModel(title: "Equity", description: '', image: "", id: ""));
    listAssetType.add(CommonValueModel(title: "Hybrid", description: '', image: "", id: ""));
    listAssetType.add(CommonValueModel(title: "Real Estate", description: '', image: "", id: ""));


    //  <ng-option value="Switch Out">Div Reinvest</ng-option>
    //                             <ng-option value="Purchase">Purchase</ng-option>
    //                             <ng-option value="Sell">Sell</ng-option>
    //                             <ng-option value="SIP">SIP</ng-option>
    //                             <!-- <ng-option value="STP">STP</ng-option> -->
    //                             <ng-option value="SWP">SWP</ng-option>
    //                             <ng-option value="Switch In">Switch In</ng-option>
    //                             <ng-option value="Switch Out">Switch Out</ng-option>

    listTransactionType.add(CommonValueModel(title: "Div Reinvest", description: "", image: "", id: ""));
    listTransactionType.add(CommonValueModel(title: "Purchase", description: "", image: "", id: ""));
    listTransactionType.add(CommonValueModel(title: "Sell", description: "", image: "", id: ""));
    listTransactionType.add(CommonValueModel(title: "SIP", description: "", image: "", id: ""));
    listTransactionType.add(CommonValueModel(title: "SWP", description: "", image: "", id: ""));
    listTransactionType.add(CommonValueModel(title: "Switch In", description: "", image: "", id: ""));
    listTransactionType.add(CommonValueModel(title: "Switch Out", description: "", image: "", id: ""));
  }

  Future<void> openDatePicker(TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: checkValidString(controller.text).isNotEmpty ? DateFormat("dd MMM,yyyy").parse(controller.text) : DateTime.now(),
        firstDate: DateTime(1901),
        lastDate:  DateTime.now().subtract(const Duration(days: 0)),
        helpText: 'Transaction Date',
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
      String formattedDate = DateFormat('dd MMM,yyyy').format(pickedDate);
      setState(() {
        controller.text = formattedDate; //set output date to TextField value.
        // listData[index].setCreatedOn = formattedDate;
      });
    }
  }

  Map<String, String> getPayloads() {
    Map<String, String> jsonData = {};

    if (showSection == "add_asset_1")
      {
        jsonData = {
          "amount_invested": amountInvestedController.text,
          "asset_class": selectedAssetType,
          "bank_details": bankDetailsController.text,
          "broker_advisor": brokerController.text,
          "category": categoryController.text,
          "current_price": currentPriceController.text,
          "current_value": currentValueController.text,
          "first_holder": selectedFamilyMember,
          "folio_no_account_no": folioNoController.text,
          "investment_type": selectedInvestmentTypeId,
          "is_from_superapp": "yes",
          "isin_no": ISINNoController.text,
          "nominee": nomineeController.text,
          "notes": notesController.text,
          "purchase_price": purchasePriceController.text,
          "quantity": quantityController.text, // converted to string
          "scheme_name": schemeNameController.text,
          "second_holder": secondHolderController.text,
          "transaction_type": selectedTransactionType,
          "user_id": sessionManagerPMS.getUserId() ,
        };
      }
    else if (showSection == "add_asset_12")
      {
        jsonData = {
          "amount_invested": amountInvestedController.text, // 10000.00
          "asset_class": selectedAssetClassController.text, // Equity
          "bank_details": bankDetailsController.text, // asd
          "broker_advisor": brokerController.text, // asd
          "category": categoryController.text, // Equity: Sectoral/ Thematic
          "current_price": currentPriceController.text, // 35280
          "current_value": currentValueController.text, // 282240.00
          "first_holder": selectedFamilyMember, // MUKESH JINDAL
          "folio_no_account_no": folioNoController.text, // test
          "investment_type": selectedInvestmentTypeId, // 2
          "is_from_superapp": "yes",
          "isin_no": ISINNoController.text, // INF109KC1RG1
          "nominee": nomineeController.text, // asd
          "notes": notesController.text, // asd
          "purchase_price": purchasePriceController.text, // 1250
          "quantity": quantityController.text, // 8 (string)
          "scheme_name": schemeNameController.text,
          "second_holder": secondHolderController.text, // ads
          "transaction_date": transactionDateController.text, // 2026-03-06
          "transaction_type": selectedTransactionType, // Sell
          "user_id": sessionManagerPMS.getUserId(), // 500
        };
      }

    return jsonData;
  }
  
  
  
}