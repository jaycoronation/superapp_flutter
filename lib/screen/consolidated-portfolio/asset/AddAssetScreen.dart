import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/model/CommanResponse.dart';
import 'package:superapp_flutter/model/consolidated-portfolio/assets/AssetDetailResponseModel.dart';
import 'package:superapp_flutter/model/consolidated-portfolio/assets/AssetListResponseModel.dart';
import 'package:superapp_flutter/model/consolidated-portfolio/assets/SchemesResponseModel.dart';
import 'package:superapp_flutter/model/consolidated-portfolio/assets/SearchSchemeResponseModel.dart';
import 'package:superapp_flutter/model/consolidated-portfolio/assets/SearchSchemesSharesResponseModel.dart';
import 'package:superapp_flutter/utils/app_utils.dart';
import 'package:superapp_flutter/utils/base_class.dart';

import '../../../common_widget/common_widget.dart';
import '../../../constant/colors.dart';
import '../../../constant/consolidate-portfolio/api_end_point.dart';
import '../../../model/CommonModel.dart';
import '../../../model/consolidated-portfolio/assets/FamilyMembersResponseModel.dart';
import '../../../model/consolidated-portfolio/assets/InvestmentTypeResponseModel.dart';

class AddAssetScreen extends StatefulWidget {
  final Assets getSet;
  final bool isFromEdit;
  const AddAssetScreen(this.getSet, this.isFromEdit, {super.key,});

  @override
  BaseState<AddAssetScreen> createState() => _AddAssetScreenState();
}

class _AddAssetScreenState extends BaseState<AddAssetScreen> {

  bool isLoading = false;
  bool isFromEdit = false;

  Assets getSet = Assets();

  List<SearchSchemes> listSearchScheme = [];
  List<String> listSearchSchemeShares = [];
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
  List<CommonValueModel> listTransactionTypeTwo = [];
  String selectedTransactionType = '';

  List<CommonValueModel> listAssetType = [];
  String selectedAssetType = '';

  String showSection = '';

  String selectedInvestmentTypeName = '';
  String selectedInvestmentTypeId = '';

  TextEditingController selectInvestmentTypeController = TextEditingController();
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

  TextEditingController givenToWhomeController = TextEditingController();
  TextEditingController loadDateController = TextEditingController();
  TextEditingController loadAmountController = TextEditingController();

  Timer? _debounce;

  @override
  void initState() {
    getSet = (widget as AddAssetScreen).getSet;
    isFromEdit = (widget as AddAssetScreen).isFromEdit;

    getInvestmentType();
    getFamilyMembers();

    if(isFromEdit)
    {
      fetchAssetDetail(getSet.id ?? "");
    }

    setData();

    // schemeNameController.addListener(() {
    //   if (selectedScheme.schemeName == null)
    //     {
    //       _onSearchChanged(schemeNameController.text);
    //     }
    // });

    super.initState();
  }

  void _onSearchChanged(String text, int isFor) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (text.isNotEmpty) {
        if(isFor == 1)
        {
          searchSchemeSharesApi(text);
        }
        else
        {
          searchSchemeApi(text);
        }
      } else {
        setState(() {
          if(isFor == 1)
          {
            listSearchSchemeShares.clear();
          }
          else
          {
            listSearchScheme.clear();
          }
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
      body: SafeArea(
        child: SingleChildScrollView(
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
                    suffixIcon: Icon(Icons.keyboard_arrow_down_outlined, size: 24, color: blackLight,),
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
                      else if(schemeNameController.text.isEmpty)
                      {
                        showToast("Please enter scheme name");
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
                      else if (currentPriceController.text.isEmpty)
                      {
                        showToast("Please enter current price");
                      }
                      else if (currentValueController.text.isEmpty)
                        {
                          showToast("Please enter current value");
                        }
                      else if(firstHolderController.text.isEmpty)
                      {
                        showToast("Please select 1st holder");
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
                  else if(showSection == "add_asset_3")
                  {
                    if (selectedAssetType.isEmpty)
                    {
                      showToast("Please select Asset class.");
                    }
                    else if(transactionTypeController.text.isEmpty)
                    {
                      showToast("Please Select transaction type");
                    }
                    else if(amountInvestedController.text.isEmpty)
                    {
                      showToast("Please enter amount invested");
                    }
                    else if(firstHolderController.text.isEmpty)
                    {
                      showToast("Please select 1st holder");
                    }
                    else
                    {
                      saveAssetsApi();
                    }
                  }
                  else if(showSection == "add_asset_4")
                  {
                    if (selectedAssetType.isEmpty)
                    {
                      showToast("Please select Asset class.");
                    }
                    else if(transactionTypeController.text.isEmpty)
                    {
                      showToast("Please Select transaction type");
                    }
                    else if(amountInvestedController.text.isEmpty)
                    {
                      showToast("Please enter amount invested");
                    }
                    else if(currentValueController.text.isEmpty)
                    {
                      showToast("Please enter current value");
                    }
                    else
                    {
                      saveAssetsApi();
                    }
                  }
                  else if(showSection == "add_asset_5")
                  {
                    if (selectedAssetType.isEmpty)
                    {
                      showToast("Please select Asset class.");
                    }
                    else if(currentValueController.text.isEmpty)
                    {
                      showToast("Please enter current value");
                    }
                    else if(firstHolderController.text.isEmpty)
                    {
                      showToast("Please select 1st holder");
                    }
                    else
                    {
                      saveAssetsApi();
                    }
                  }
                  else if(showSection == "add_asset_6")
                  {
                    if (selectedAssetType.isEmpty)
                    {
                      showToast("Please select Asset class.");
                    }
                    else if(amountInvestedController.text.isEmpty)
                    {
                      showToast("Please enter amount invested");
                    }
                    else if(firstHolderController.text.isEmpty)
                    {
                      showToast("Please select 1st holder");
                    }
                    else
                    {
                      saveAssetsApi();
                    }
                  }
                  else if(showSection == "add_asset_7")
                  {
                    if (selectedAssetType.isEmpty)
                    {
                      showToast("Please select Asset class.");
                    }
                    else if(firstHolderController.text.isEmpty)
                    {
                      showToast("Please select 1st holder");
                    }
                    else if(transactionTypeController.text.isEmpty)
                    {
                      showToast("Please select transaction type");
                    }
                    else if(currencyNameController.text.isEmpty)
                    {
                      showToast("Please enter currency name");
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

  fetchAssetDetail(String assetId) async{
    if(isOnline)
    {
      setState(() {
        isLoading = true;
      });

      try
      {
        HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
          HttpLogger(logLevel: LogLevel.BODY),
        ]);

        final url = Uri.parse(API_URL_CP_ASSETS + assetDetail);
        Map<String, String> jsonBody = {
          "assets_id" : assetId
        };

        final response = await http.post(url, body: jsonBody);
        final statusCode = response.statusCode;
        final body = response.body;
        Map<String, dynamic> user = jsonDecode(body);
        var dataResponse = AssetDetailResponseModel.fromJson(user);

        if(statusCode == 200 && dataResponse.success == 1)
        {
          if(dataResponse.assetsDetails != null)
          {

            final data = dataResponse.assetsDetails ?? AssetsDetails();

            print("Display assets data : ${data.investmentType}");

            selectedAssetType = data.assetClass ?? "";
            selectedInvestmentTypeId = data.investmentType ?? "";

            print("Display investment id : $selectedInvestmentTypeId");

            selectedInvestmentTypeName = getSet.investmentType ?? "";
            selectedFamilyMember = data.firstHolder ?? "";
            selectedTransactionType = data.transactionType ?? "";

            selectInvestmentTypeController.text = getSet.investmentType ?? ""; // add from get set data object
            selectedAssetClassController.text = data.assetClass ?? "";
            firstHolderController.text = data.firstHolder ?? "";
            transactionTypeController.text = data.transactionType ?? "";
            categoryController.text = data.category ?? "";
            schemeNameController.text = data.schemeName ?? "";
            transactionDateController.text = (data.transactionDate?.isEmpty ?? true) ? "" : universalDateConverter("MM-dd-yyyy", "dd MMM,yyyy", data.transactionDate ?? "");
            amountInvestedController.text = data.amountInvested ?? "";
            quantityController.text = "${data.quantity}";
            purchasePriceController.text = data.purchasePrice ?? "";
            currentPriceController.text = data.currentPrice ?? "";
            currentValueController.text = "${data.currentValue}";
            folioNoController.text = data.folioNoAccountNo ?? "";
            ISINNoController.text = data.isinNo ?? "";
            secondHolderController.text = data.secondHolder ?? "";
            nomineeController.text = data.nominee ?? "";
            brokerController.text = data.brokerAdvisor ?? "";
            bankDetailsController.text = data.bankDetails ?? "";
            notesController.text = data.notes ?? "";
            interestRateController.text = data.interestRate ?? "";
            maturityDateController.text = data.maturityDate ?? "";
            interestPayoutController.text = data.payoutCumulative ?? "";
            propertyNameController.text = data.propertyName ?? "";
            areaController.text = data.area ?? "";
            totalValueController.text = data.totalValue ?? "";
            loanOutstandingController.text = data.loanOutstanding ?? "";
            amountPendingController.text = data.amountPending ?? "";
            leasedController.text = data.leasedNotLeased ?? "";
            monthlyRentalController.text = data.monthlyRental ?? "";
            premiumController.text = data.premium ?? "";
            premiumStartDateController.text = (data.premiumStartDate?.isEmpty ?? true) ? "" : universalDateConverter("MM-dd-yyyy", "dd MMM,yyyy", data.premiumStartDate ?? "");
            premiumEndDateController.text = (data.premiumEndDate?.isEmpty ?? true) ? "" : universalDateConverter("MM-dd-yyyy", "dd MMM,yyyy", data.premiumEndDate ?? "");
            numberOfPremiumsPaidController.text = data.numberOfPremiumsPaid ?? "";
            totalPremiumsPaidController.text = data.totalPremiumsPaid ?? "";
            policyMaturityDateController.text = (data.maturityDate?.isEmpty ?? true) ? "" : universalDateConverter("MM-dd-yyyy", "dd MMM,yyyy", data.maturityDate ?? "");
            sumAssuredController.text = data.sumAssured ?? "";
            premiumFrequencyController.text = data.premiumFrequency ?? "";
            policyNumberController.text = data.policyNumber ?? "";
            policyHolderController.text = data.policyHolder ?? "";
            companyNameController.text = data.companyName ?? "";
            vestedController.text = data.vestedUnvested ?? "";
            stockOptionDateController.text = (data.date?.isEmpty ?? true) ? "" : universalDateConverter("MM-dd-yyyy", "dd MMM,yyyy", data.date ?? "");
            numberofsharesController.text = data.numberOfShares ?? "";
            // currencyNameController.text = ""; // value need from api
            marketValueController.text = "${data.currentValue}";
            // cpController.text = ""; // value need from api
            // cryptoLTDController.text = ""; // value need from api
            // cryptoPLController.text = ""; // value need from api
            // cryptoPLFigController.text = ""; // value need from api
            givenToWhomeController.text = data.givenToWhom ?? "";
            loadDateController.text = (data.date?.isEmpty ?? true) ? "" : universalDateConverter("MM-dd-yyyy", "dd MMM,yyyy", data.date ?? "");
            loadAmountController.text = data.loanAmount ?? "";

            selectInvestmentForm();
            setState(() {});
          }
        }
      }
      catch(e)
      {
        print("Failed to fetch asset Detail : $e");
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

    try
    {
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
        if(dataResponse.searchSchemes?.isNotEmpty ?? false)
        {
          listSearchScheme = dataResponse.searchSchemes ?? [];
        }
        else
        {
          listSearchScheme = [];
        }
      }
      else
      {
        listSearchScheme = [];
      }
    }
    catch(e)
    {
      print("Failed to search scheme : $e");
    }
    finally
    {
      if(mounted)
      {
        setState(() {
          isLoading = false;
        });
      }
    }

  }

  searchSchemeSharesApi(String text) async {
    setState(() {
      isLoading = true;
    });

    try
    {
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
      var dataResponse = SearchSchemesSharesResponseModel.fromJson(user);

      if (statusCode == 200 && dataResponse.success == 1) {
        if(dataResponse.searchSchemesShares?.isNotEmpty ?? false)
        {
          listSearchSchemeShares = dataResponse.searchSchemesShares ?? [];
        }
        else
        {
          listSearchSchemeShares = [];
        }
      }
      else
      {
        listSearchSchemeShares = [];
      }
    }
    catch(e)
    {
      print("Failed to search scheme : $e");
    }
    finally
    {
      if(mounted)
      {
        setState(() {
          isLoading = false;
        });
      }
    }

  }


  saveAssetsApi() async {
    setState(() {
      isLoading = true;
    });
    print("IS IN SAVE $saveAsset");
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(isFromEdit ? "https://portfolio.alphacapital.in/api/services/assets/update" : "https://portfolio.alphacapital.in/api/services/assets/add");

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
        Navigator.pop(context, "success");
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
      if(dataResponse.message?.isNotEmpty ?? false)
      {
        showToast(dataResponse.message);
      }

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

  void openTransactionTypeBottomSheet(int isFor) {
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
                        itemCount: isFor == 1 ? listTransactionType.length : listTransactionTypeTwo.length,
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              Navigator.pop(context);
                              setState(() {

                                if(isFor == 1)
                                {
                                  selectedTransactionType = listTransactionType[index].title;
                                  transactionTypeController.text = listTransactionType[index].title;
                                }
                                else
                                {
                                  selectedTransactionType = listTransactionTypeTwo[index].title;
                                  transactionTypeController.text = listTransactionTypeTwo[index].title;
                                }

                              });
                            },
                            child: isFor == 1
                            ? getBottomSheetItemWithoutSelection(listTransactionType[index].title , selectedTransactionType == listTransactionType[index].title, false)
                            : getBottomSheetItemWithoutSelection(listTransactionTypeTwo[index].title, selectedTransactionType == listTransactionTypeTwo[index].title, false),
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

    if(isFromEdit && (showSection == "add_asset_1" || showSection == "add_asset_12"))
    {
      calculateValues();
    }
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
                  labelText: 'Asset Class*',
                  suffixIcon: Icon(Icons.keyboard_arrow_down_outlined, size: 24, color: blackLight,),
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
              child: Column(
                children: [
                  TextField(
                    controller: schemeNameController,
                    cursorColor: black,
                    onChanged: (value) {
                      _onSearchChanged(value, 1);
                    },
                    style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
                    decoration: InputDecoration(
                      labelText: "Scheme Name*",
                      suffixIcon: isLoading ? const Padding(
                        padding: EdgeInsets.all(12),
                        child: SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2,color: blue,),
                        ),
                      ) : schemeNameController.text.isNotEmpty ?
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          setState(() {
                            schemeNameController.clear();
                          });
                        },
                        child: Icon(Icons.close, size: 18, color: black,),
                      ) : null,
                    ),
                  ),

                  /// Dropdown Result
                  if (listSearchSchemeShares.isNotEmpty)
                    Container(
                      constraints: const BoxConstraints(maxHeight: 250),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: listSearchSchemeShares.length,
                        itemBuilder: (context, index) {
                          final item = listSearchSchemeShares[index];

                          return ListTile(
                            title: Text(
                              item,
                              style: const TextStyle(fontSize: 14),
                            ),
                            onTap: () {
                              setState(() {
                                schemeNameController.text = item;
                                listSearchSchemeShares.clear();
                              });
                            },
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),

            // Container(
            //   margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
            //   child: TextField(
            //     keyboardType: TextInputType.text,
            //     cursorColor: black,
            //     controller: schemeNameController,
            //     textCapitalization: TextCapitalization.words,
            //     decoration: InputDecoration(
            //       counterText: "",
            //       labelText: 'Scheme Name',
            //     ),
            //     style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
            //   ),
            // ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: transactionTypeController,
                readOnly: true,
                onTap: () {
                  openTransactionTypeBottomSheet(1);
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Transaction Type*',
                  suffixIcon: Icon(Icons.keyboard_arrow_down_outlined, size: 24, color: blackLight,),
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
                  //openDatePicker(transactionDateController);
                  openDatePickerAllUse(transactionDateController, hintText: "Transaction Date");
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Transaction Date',
                  suffixIcon: Icon(Icons.calendar_today, size: 20, color: blackLight,),
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
                  labelText: 'Amount Invested (Purchase Value)*',
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
                onChanged: (value) {
                  calculateValues();
                },
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
                  calculateValues();
                  // if (quantityController.value.text.isNotEmpty)
                  //   {
                  //     var qty = num.parse(quantityController.value.text);
                  //     var purchasePrice = num.parse(purchasePriceController.value.text);
                  //
                  //     amountInvestedController.text = (qty * purchasePrice).toString();
                  //   }
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
                  calculateValues();
                  // if (quantityController.value.text.isNotEmpty)
                  // {
                  //   var qty = num.parse(quantityController.value.text);
                  //   var purchasePrice = num.parse(currentPriceController.value.text);
                  //
                  //   currentValueController.text = (qty * purchasePrice).toString();
                  // }
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
                  suffixIcon: Icon(Icons.keyboard_arrow_down_outlined, size: 24, color: blackLight,),
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
                    onChanged: (value) {
                      _onSearchChanged(value, 2);
                    },
                    style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
                    decoration: InputDecoration(
                      labelText: "Scheme Name*",
                      suffixIcon: isLoading
                          ? const Padding(
                        padding: EdgeInsets.all(12),
                        child: SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2,color: blue,),
                        ),
                      )
                          : schemeNameController.text.isNotEmpty ?
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          setState(() {
                            schemeNameController.clear();
                          });
                        },
                        child: Icon(Icons.close, size: 18, color: black,),
                      ) : null,
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
                  labelText: 'Asset Class*',
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
                  openTransactionTypeBottomSheet(1);
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Transaction Type',
                  suffixIcon: Icon(Icons.keyboard_arrow_down_outlined, size: 24, color: blackLight,),
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
                  //openDatePicker(transactionDateController);
                  openDatePickerAllUse(transactionDateController, hintText: "Transaction Date");
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Transaction Date',
                  suffixIcon: Icon(Icons.calendar_today, size: 20, color: blackLight,),
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
                onChanged: (value) {

                  calculateValues();

                  // if(value.isNotEmpty && purchasePriceController.text.isNotEmpty)
                  // {
                  //   var qty = num.parse(quantityController.value.text);
                  //   var purchasePrice = num.parse(purchasePriceController.value.text);
                  //
                  //   amountInvestedController.text = (qty * purchasePrice).toString();
                  //   setState(() {});
                  // }
                },
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

                  calculateValues();

                  // if (quantityController.value.text.isNotEmpty)
                  // {
                  //   var qty = num.parse(quantityController.value.text);
                  //   var purchasePrice = num.parse(purchasePriceController.value.text);
                  //
                  //   amountInvestedController.text = (qty * purchasePrice).toString();
                  //   setState(() {});
                  // }
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

                  calculateValues();

                  // if (quantityController.value.text.isNotEmpty)
                  // {
                  //   var qty = num.parse(quantityController.value.text);
                  //   var purchasePrice = num.parse(currentPriceController.value.text);
                  //
                  //   currentValueController.text = (qty * purchasePrice).toString();
                  // }
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Current Price*',
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
                //readOnly: true,
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
                  labelText: '1st Holder*',
                  suffixIcon: Icon(Icons.keyboard_arrow_down_outlined, size: 24, color: blackLight,),
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
                  labelText: 'Asset Class*',
                  suffixIcon: Icon(Icons.keyboard_arrow_down_outlined, size: 24, color: blackLight,),
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
                  openTransactionTypeBottomSheet(1);
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Transaction Type*',
                  suffixIcon: Icon(Icons.keyboard_arrow_down_outlined, size: 24, color: blackLight,),
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
                  //openDatePicker(transactionDateController);
                  openDatePickerAllUse(transactionDateController, hintText: "Transaction Date");
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Transaction Date',
                  suffixIcon: Icon(Icons.calendar_today, size: 20, color: blackLight,),
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
                  labelText: 'Amount Invested (Purchase Value)*',
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
                  labelText: 'Current Value*',
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
                  //openDatePicker(maturityDateController);
                  openDatePickerAllUse(maturityDateController, hintText: "Maturity Date");
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Maturity Date',
                  suffixIcon: Icon(Icons.calendar_today, size: 20, color: blackLight,),
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
                  labelText: '1st Holder*',
                  suffixIcon: Icon(Icons.keyboard_arrow_down_outlined, size: 24, color: blackLight,),
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
                //readOnly: true,
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
                //readOnly: true,
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
                //readOnly: true,
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
               // readOnly: true,
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
                  openAssetClassBottomSheet();
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Asset Class*',
                  suffixIcon: Icon(Icons.keyboard_arrow_down_outlined, size: 24, color: blackLight,),
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
                //readOnly: true,
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
                  openTransactionTypeBottomSheet(2);
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Transaction Type*',
                  suffixIcon: Icon(Icons.keyboard_arrow_down_outlined, size: 24, color: blackLight,),
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
                  openDatePickerAllUse(transactionDateController, hintText: "Transaction Date");
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Transaction Date',
                  suffixIcon: Icon(Icons.calendar_today, size: 20, color: blackLight,),
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
               // readOnly: true,
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
                keyboardType: TextInputType.number,
                cursorColor: black,
                controller: totalValueController,
                //readOnly: true,
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
                keyboardType: TextInputType.number,
                cursorColor: black,
                controller: amountInvestedController,
                //readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Amount Invested (Purchase Value)*',
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
               // readOnly: true,
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
                //readOnly: true,
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
               // readOnly: true,
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
               // readOnly: true,
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
              //  readOnly: true,
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
                  openFirstHolderBottomSheet();
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: '1st Holder*',
                  suffixIcon: Icon(Icons.keyboard_arrow_down_outlined, size: 24, color: blackLight,),
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
               // readOnly: true,
                onTap: () {
                },
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
               // readOnly: true,
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
              //  readOnly: true,
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
              //  readOnly: true,
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
             //   readOnly: true,
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
                  openAssetClassBottomSheet();
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Asset Class*',
                  suffixIcon: Icon(Icons.keyboard_arrow_down_outlined, size: 24, color: blackLight,),
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
              //  readOnly: true,
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
                  openTransactionTypeBottomSheet(2);
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Transaction Type*',
                  suffixIcon: Icon(Icons.keyboard_arrow_down_outlined, size: 24, color: blackLight,),
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
                  openDatePickerAllUse(transactionDateController, hintText: "Transaction Date");
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Transaction Date',
                  suffixIcon: Icon(Icons.calendar_today, size: 20, color: blackLight,),
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
              //  readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Amount Invested (Purchase Value)*',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.number,
                cursorColor: black,
                controller: premiumController,
             //   readOnly: true,
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
                  openDatePickerAllUse(premiumStartDateController, hintText: "Premium Start Date");
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Premium Start Date',
                  suffixIcon: Icon(Icons.calendar_today, size: 20, color: blackLight,),
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
                  openDatePickerAllUse(premiumEndDateController, hintText: "Premium End Date");
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Premium End Date',
                  suffixIcon: Icon(Icons.calendar_today, size: 20, color: blackLight,),
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.number,
                cursorColor: black,
                controller: numberOfPremiumsPaidController,
             //   readOnly: true,
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
                keyboardType: TextInputType.number,
                cursorColor: black,
                controller: totalPremiumsPaidController,
             //   readOnly: true,
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
                keyboardType: TextInputType.number,
                cursorColor: black,
                controller: currentValueController,
              //  readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Current Value*',
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
                  openDatePickerAllUse(policyMaturityDateController, hintText: "Policy Maturity Date");
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Policy Maturity Date',
                  suffixIcon: Icon(Icons.calendar_today, size: 20, color: blackLight,),
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.number,
                cursorColor: black,
                controller: sumAssuredController,
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
                controller: firstHolderController,
                readOnly: true,
                onTap: () {
                  openFirstHolderBottomSheet();
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: '1st Holder*',
                  suffixIcon: Icon(Icons.keyboard_arrow_down_outlined, size: 24, color: blackLight,),
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
              //  readOnly: true,
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
                  openAssetClassBottomSheet();
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Asset Class*',
                  suffixIcon: Icon(Icons.keyboard_arrow_down_outlined, size: 24, color: blackLight,),
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: black,
                controller: givenToWhomeController,
              //  readOnly: true,
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
                controller: loadDateController,
                readOnly: true,
                onTap: () {
                  openDatePickerAllUse(loadDateController, hintText: "Load Date");
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Loan Date',
                  suffixIcon: Icon(Icons.calendar_today, size: 20, color: blackLight,),
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.number,
                cursorColor: black,
                controller: loadAmountController,
              //  readOnly: true,
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
                controller: maturityDateController,
                readOnly: true,
                onTap: () {
                  openDatePickerAllUse(maturityDateController, hintText: "Maturity Date");
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Maturity Date',
                  suffixIcon: Icon(Icons.calendar_today, size: 20, color: blackLight,),
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
              //  readOnly: true,
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
                keyboardType: TextInputType.number,
                cursorColor: black,
                controller: currentValueController,
              //  readOnly: true,
                onTap: () {
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Current Value*',
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
                  labelText: '1st Holder*',
                  suffixIcon: Icon(Icons.keyboard_arrow_down_outlined, size: 24, color: blackLight,),
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
              //  readOnly: true,
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
              //  readOnly: true,
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
              //  readOnly: true,
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
                  openAssetClassBottomSheet();
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Asset Class*',
                  suffixIcon: Icon(Icons.keyboard_arrow_down_outlined, size: 24, color: blackLight,),
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
                  openDatePickerAllUse(stockOptionDateController, hintText: "Stock Option Date");
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Stock Option Date',
                  suffixIcon: Icon(Icons.keyboard_arrow_down_outlined, size: 24, color: blackLight,),
                ),
                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, left: 8, right: 8),
              child: TextField(
                keyboardType: TextInputType.number,
                cursorColor: black,
                controller: numberofsharesController,
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
                keyboardType: TextInputType.number,
                cursorColor: black,
                controller: amountInvestedController,
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Amount Invested (Purchase Value)*',
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
                controller: firstHolderController,
                readOnly: true,
                onTap: () {
                  openFirstHolderBottomSheet();
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: '1st Holder*',
                  suffixIcon: Icon(Icons.keyboard_arrow_down_outlined, size: 24, color: blackLight,),
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
                  openAssetClassBottomSheet();
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Asset Class',
                  suffixIcon: Icon(Icons.keyboard_arrow_down_outlined, size: 24, color: blackLight,),
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
                  labelText: '1st Holder*',
                  suffixIcon: Icon(Icons.keyboard_arrow_down_outlined, size: 24, color: blackLight,),
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
                  openTransactionTypeBottomSheet(2);
                },
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Transaction Type*',
                  suffixIcon: Icon(Icons.keyboard_arrow_down_outlined, size: 24, color: blackLight,),
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
                decoration: InputDecoration(
                  counterText: "",
                  labelText: 'Currency Name*',
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

  void calculateValues() {
    final qty = num.tryParse(quantityController.text) ?? 0;
    final purchasePrice = num.tryParse(purchasePriceController.text) ?? 0;
    final currentPrice = num.tryParse(currentPriceController.text) ?? 0;

    // Amount Invested = qty * purchase price
    amountInvestedController.text = (qty * purchasePrice).toString();

    // Current Value = qty * current price
    currentValueController.text = (qty * currentPrice).toString();
    setState(() {});
  }

  void setData() {
    listAssetType.add(CommonValueModel(title: "Alternate", description: '', image: "", id: ""));
    listAssetType.add(CommonValueModel(title: "Debt", description: '', image: "", id: ""));
    listAssetType.add(CommonValueModel(title: "Equity", description: '', image: "", id: ""));
    listAssetType.add(CommonValueModel(title: "Hybrid", description: '', image: "", id: ""));
    listAssetType.add(CommonValueModel(title: "Real Estate", description: '', image: "", id: ""));

    listTransactionType.add(CommonValueModel(title: "Div Reinvest", description: "", image: "", id: ""));
    listTransactionType.add(CommonValueModel(title: "Purchase", description: "", image: "", id: ""));
    listTransactionType.add(CommonValueModel(title: "Sell", description: "", image: "", id: ""));
    listTransactionType.add(CommonValueModel(title: "SIP", description: "", image: "", id: ""));
    listTransactionType.add(CommonValueModel(title: "SWP", description: "", image: "", id: ""));
    listTransactionType.add(CommonValueModel(title: "Switch In", description: "", image: "", id: ""));
    listTransactionType.add(CommonValueModel(title: "Switch Out", description: "", image: "", id: ""));

    listTransactionTypeTwo = [
      CommonValueModel(title: "Purchase", description: "", image: "", id: ""),
      CommonValueModel(title: "Sell", description: "", image: "", id: ""),
    ];
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

  Future<void> openDatePickerAllUse(TextEditingController controller, {String hintText = "Select Date"}) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: checkValidString(controller.text).isNotEmpty ? DateFormat("dd MMM,yyyy").parse(controller.text) : DateTime.now(),
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
          "user_id": sessionManagerPMS.getUserId(),
          if(isFromEdit) "assets_id": "${getSet.id}"
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
          if(isFromEdit) "assets_id": "${getSet.id}"
        };
      }
    else if(showSection == "add_asset_2")
    {
      jsonData = {
        "amount_invested": amountInvestedController.text,
        "asset_class": selectedAssetClassController.text,
        "bank_details": bankDetailsController.text,
        "broker_advisor": brokerController.text,
        "current_value": currentValueController.text,
        "first_holder": firstHolderController.text,
        "folio_no_account_no": folioNoController.text,
        "interest_rate": interestRateController.text,
        "investment_type": selectedInvestmentTypeId,
        "is_from_superapp": "yes",
        "maturity_date": maturityDateController.text.isEmpty ? "" : universalDateConverter("dd MMM,yyyy", "yyyy-MM-dd", maturityDateController.text),
        "nominee": nomineeController.text,
        "notes": notesController.text,
        "payout_cumulative": interestPayoutController.text,
        "scheme_name": schemeNameController.text,
        "second_holder": secondHolderController.text,
        "transaction_date": transactionDateController.text.isEmpty ? "" : universalDateConverter("dd MMM,yyyy", "yyyy-MM-dd", transactionDateController.text),
        "transaction_type": transactionTypeController.text,
        "user_id": sessionManagerPMS.getUserId(),
        if(isFromEdit) "assets_id": "${getSet.id}"
      };
    }
    else if(showSection == "add_asset_3")
    {
      jsonData = {
        "amount_invested": amountInvestedController.text,
        "amount_pending": amountPendingController.text,
        "area": areaController.text,
        "asset_class": selectedAssetClassController.text,
        "bank_details": bankDetailsController.text,
        "broker_advisor": brokerController.text,
        "current_value": currentValueController.text,
        "first_holder": firstHolderController.text,
        "second_holder": secondHolderController.text,
        "investment_type": selectedInvestmentTypeId,
        "is_from_superapp": "yes",
        "leased_not_leased": leasedController.text,
        "loan_outstanding": loanOutstandingController.text,
        "monthly_rental": monthlyRentalController.text,
        "nominee": nomineeController.text,
        "notes": notesController.text,
        "property_name": propertyNameController.text,
        "total_value": totalValueController.text,
        "transaction_date": transactionDateController.text.isEmpty ? "" : universalDateConverter("dd MMM,yyyy", "yyyy-MM-dd", transactionDateController.text),
        "transaction_type": transactionTypeController.text,
        "user_id": sessionManagerPMS.getUserId(),
        if(isFromEdit) "assets_id": "${getSet.id}"
      };
    }
    else if(showSection == "add_asset_4")
    {
      jsonData = {
        "amount_invested": amountInvestedController.text,
        "asset_class": selectedAssetClassController.text,
        "bank_details": bankDetailsController.text,
        "broker_advisor": brokerController.text,
        "current_value": currentValueController.text,
        "first_holder": firstHolderController.text,
        "second_holder": secondHolderController.text,
        "investment_type": selectedInvestmentTypeId,
        "is_from_superapp": "yes",
        "maturity_date": maturityDateController.text.isEmpty ? "" : universalDateConverter("dd MMM,yyyy", "yyyy-MM-dd", maturityDateController.text),
        "nominee": nomineeController.text,
        "notes": notesController.text,
        "number_of_premiums_paid": numberOfPremiumsPaidController.text,
        "policy_holder": policyHolderController.text,
        "policy_number": policyNumberController.text,
        "premium": premiumController.text,
        "premium_start_date": premiumStartDateController.text.isEmpty ? "" : universalDateConverter("dd MMM,yyyy", "yyyy-MM-dd", premiumStartDateController.text),
        "premium_end_date": premiumEndDateController.text.isEmpty ? "" : universalDateConverter("dd MMM,yyyy", "yyyy-MM-dd", premiumEndDateController.text),
        "premium_frequency": premiumFrequencyController.text,
        "scheme_name": schemeNameController.text,
        "total_premiums_paid": totalPremiumsPaidController.text,
        "transaction_date": transactionDateController.text.isEmpty ? "" : universalDateConverter("dd MMM,yyyy", "yyyy-MM-dd", transactionDateController.text),
        "transaction_type": transactionTypeController.text,
        "user_id": sessionManagerPMS.getUserId(),
        if(isFromEdit) "assets_id": "${getSet.id}"
      };
    }
    else if(showSection == "add_asset_5")
    {
      jsonData = {
        "asset_class": selectedAssetClassController.text,
        "bank_details": bankDetailsController.text,
        "broker_advisor": brokerController.text,
        "current_value": currentValueController.text,
        "date": loadDateController.text.isEmpty ? "" : universalDateConverter("dd MMM,yyyy", "yyyy-MM-dd", loadDateController.text),
        "first_holder": firstHolderController.text,
        "second_holder": secondHolderController.text,
        "given_to_whom": givenToWhomeController.text,
        "interest_rate": interestRateController.text,
        "investment_type": selectedInvestmentTypeId,
        "is_from_superapp": "yes",
        "loan_amount": loadAmountController.text,
        "maturity_date": maturityDateController.text.isEmpty ? "" : universalDateConverter("dd MMM,yyyy", "yyyy-MM-dd", maturityDateController.text),
        "notes": notesController.text,
        "user_id": sessionManagerPMS.getUserId(),
        if(isFromEdit) "assets_id": "${getSet.id}"
      };
    }
    else if(showSection == "add_asset_6")
    {
      jsonData = {
        "amount_invested": amountInvestedController.text,
        "asset_class": selectedAssetClassController.text,
        "bank_details": bankDetailsController.text,
        "broker_advisor": brokerController.text,
        "company_name": companyNameController.text,
        "current_price": currentPriceController.text,
        "current_value": currentValueController.text,
        "date": stockOptionDateController.text.isEmpty ? "" : universalDateConverter("dd MMM,yyyy", "yyyy-MM-dd", stockOptionDateController.text),
        "first_holder": firstHolderController.text,
        "second_holder": secondHolderController.text,
        "investment_type": selectedInvestmentTypeId,
        "is_from_superapp": "yes",
        "notes": notesController.text,
        "number_of_shares": numberofsharesController.text,
        "vested_unvested": vestedController.text,
        "user_id": sessionManagerPMS.getUserId(),
        if(isFromEdit) "assets_id": "${getSet.id}"
      };
    }
    else if(showSection == "add_asset_7")
    {
      jsonData = {
        "amount_invested": amountInvestedController.text,
        "asset_class": selectedAssetClassController.text,
        "crypto_cp": cpController.text,
        "crypto_ltd": cryptoLTDController.text,
        "crypto_pl_fig": cryptoPLController.text,
        "current_value": marketValueController.text,
        "first_holder": firstHolderController.text,
        "second_holder": secondHolderController.text,
        "investment_type": selectedInvestmentTypeId,
        "is_from_superapp": "yes",
        "notes": notesController.text,
        "quantity": quantityController.text,
        "scheme_name": schemeNameController.text,
        "transaction_type": selectedTransactionType,
        "user_id": sessionManagerPMS.getUserId(),
        if(isFromEdit) "assets_id": "${getSet.id}"
      };
    }
    return jsonData;
  }
  
  
  
}