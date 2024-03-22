import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/common_widget/common_widget.dart';
import 'package:superapp_flutter/screen/e-state-valut/advisors_page_list.dart';
import 'package:superapp_flutter/screen/e-state-valut/bank_page_list.dart';
import 'package:superapp_flutter/screen/e-state-valut/constitution_value_page_list.dart';
import 'package:superapp_flutter/screen/e-state-valut/death_notification_page_list.dart';
import 'package:superapp_flutter/screen/e-state-valut/real_estate_page_list.dart';
import 'package:superapp_flutter/screen/e-state-valut/safe_deposite_box_page_list.dart';
import 'package:superapp_flutter/screen/e-state-valut/share_bonds_page_list.dart';
import 'package:superapp_flutter/screen/e-state-valut/share_report_page.dart';
import '../../../constant/colors.dart';
import '../../../utils/base_class.dart';
import '../../constant/e-state-valut/api_end_point.dart';
import '../../constant/global_context.dart';
import '../../model/e-state-vault/AccountHolderListResponse.dart';
import '../../model/e-state-vault/header_model.dart';
import '../../model/e-state-vault/menu_model.dart';
import '../../utils/app_utils.dart';
import '../../widget/loading.dart';
import 'add_business_page.dart';
import 'add_dependent_children.dart';
import 'add_domestic_employee.dart';
import 'add_medical_funeral.dart';
import 'add_will_page.dart';
import 'charity_page_list.dart';
import 'credit_cards_loans_page_list.dart';
import 'employment_related_page_list.dart';
import 'fiduciary_obligations_page_list.dart';
import 'former_spouse_page_list.dart';
import 'government_related_page_list.dart';
import 'imp_doc_page_list.dart';
import 'insurance_policy_page_list.dart';
import 'intellectual_property_page_list.dart';
import 'key_to_residence_page_list.dart';
import 'mutual_funds_page_list.dart';
import 'other_asset_page_list.dart';
import 'other_debts_page_list.dart';
import 'other_financial_assets_page_list.dart';

class EStateVaultHomePage extends StatefulWidget {
  const EStateVaultHomePage({Key? key}) : super(key: key);

  @override
  _EStateVaultHomePageState createState() => _EStateVaultHomePageState();
}

class _EStateVaultHomePageState extends BaseState<EStateVaultHomePage> {
  bool _isLoading = false;
  List<HeaderGetSet> menuList = List<HeaderGetSet>.empty(growable: true);
  List<String> holderList = List<String>.empty(growable: true);
  List<Holders> accountHolder = List<Holders>.empty(growable: true);
  int headerPosition = 0;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    setListData();
    callApis();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: appBg,
      appBar: AppBar(
          toolbarHeight: kToolbarHeight,
          automaticallyImplyLeading: false,
          backgroundColor: appBg,
          elevation: 0,
          centerTitle: true,
          leading: Visibility(
            visible: kIsWeb == false,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child:  getBackArrow(),
            ),
          ),
          title: getTitle("Estate Vault",),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  ShareReportPage()));
            },
            child: Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(right: 5),
              padding: const EdgeInsets.all(3),
              width: 32,
              height: 32,
              child: Image.asset('assets/images/vault_ic_share_pdf.png', width: 32, height: 32, color: blue),
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: _isLoading
            ? const LoadingWidget()
            : Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 6,bottom: 6),
                        child: const Text("Please enter data to store important information related to Succession Planning",
                          style: TextStyle(fontSize: 16, color: black, fontWeight: FontWeight.w600),
                        ),
                      ),
                      _headerList(),
                    ],
                  ),
                )),
      ),
    );
  }

  ListView _headerList() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        controller: _scrollController,
        physics: const NeverScrollableScrollPhysics(),
        primary: false,
        padding: EdgeInsets.zero,
        itemCount: menuList.length,
        itemBuilder: (ctx, index) => (GestureDetector(
            onTap: () async {
              setState(() {
                headerPosition = index;
              });
            },
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              color: white,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(top: 8, bottom: 8),
                    decoration: BoxDecoration(color: headerPosition == index ? blue : semiBlue, borderRadius: const BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text(
                          menuList[index].name,
                          style: TextStyle(color: headerPosition == index ? white : blue, fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        Image.asset(headerPosition == index ? 'assets/images/ic_arrow_double_down.png' : 'assets/images/ic_arrow_double_right.png',
                            width: 24, height: 24, color: headerPosition == index ? white : blue),
                      ],
                    ),
                  ),
                  Visibility(
                      visible: headerPosition == index,
                      child: Container(
                        margin: const EdgeInsets.only(top: 6, bottom: 6),
                        child: _menuList(menuList[index].menuItems),
                      ))
                ],
              ),
            ))));
  }

  GridView _menuList(List<MenuGetSet> menuItems) {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 120, crossAxisSpacing: 10, mainAxisSpacing: 10),
      controller: _scrollController,
      itemCount: menuItems.length,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      primary: false,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          hoverColor: Colors.white.withOpacity(0.0),
          onTap: () async {},
          child: InkWell(
            onTap: (){
              if(menuItems[index].id == 1)
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ConstitutionValuesPage()));
              }
              else if(menuItems[index].id == 2)
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const DeathNotificationPage()));
              }
              else if(menuItems[index].id == 3)
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AdvisorsListPage()));
              }
              else if(menuItems[index].id == 4)
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const KeyToResidencePageList()));
              }
              else if(menuItems[index].id == 5)
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SafeDepositeBoxPageList()));
              }
              else if(menuItems[index].id == 6)
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ImpDocPageList()));
              }
              else if(menuItems[index].id == 7)
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddMedicalFuneralPage()));
              }
              else if(menuItems[index].id == 8)
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddDependentChildrenPage()));
              }
              else if(menuItems[index].id == 9)
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddWillPage()));
              }
              else if(menuItems[index].id == 10)
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddBusinessPage()));
              }
              else if(menuItems[index].id == 11)
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddDomesticEmployee()));
              }
              else if(menuItems[index].id == 12)
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const GovernmentRelatedListPage()));
              }
              else if(menuItems[index].id == 13)
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const EmploymentRelatedListPage()));
              }
              else if(menuItems[index].id == 14)
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const InsurancePolicyListPage()));
              }
              else if(menuItems[index].id == 15)
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const MutualFundsListPage()));
              }
              else if(menuItems[index].id == 16)
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ShareBondsListPage()));
              }
              else if(menuItems[index].id == 17)
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const OtherFinancialAssetsListPage()));
              }
              else if(menuItems[index].id == 18)
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const BankListPage()));
              }
              else if(menuItems[index].id == 19)
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const IntellectualPropertyListPage()));
              }
              else if(menuItems[index].id == 20)
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const RealEstateListPage()));
              }
              else if(menuItems[index].id == 21)
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const OtherAssetListPage()));
              }
              else if(menuItems[index].id == 22)
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CreditCardsLoansListPage()));
              }
              else if(menuItems[index].id == 23)
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const FormerSpouseListPage()));
              }
              else if(menuItems[index].id == 24)
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CharityRelatedListPage()));
              }
              else if(menuItems[index].id == 25)
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const FiduciaryObligationsListPage()));
              }
              else if(menuItems[index].id == 26)
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const OtherDebtsListPage()));
              }

          },
            child: Container(
              padding: const EdgeInsets.only(left: 5, right: 5),
              decoration: const BoxDecoration(color: semiBlue, borderRadius: BorderRadius.all(Radius.circular(10))),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(menuItems[index].itemIcon, color: blue, height: 32, width: 32),
                  const Gap(18),
                  Text(
                    menuItems[index].name,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: black, fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void setListData() {
    HeaderGetSet headerGetSet = HeaderGetSet();
    headerGetSet.setName = "General Information";
    List<MenuGetSet> temp1 = List<MenuGetSet>.empty(growable: true);
    temp1 = [
      MenuGetSet(idStatic: 1, nameStatic: "Constitution And Values", itemIconStatic: "assets/images/vault_ic_account_holder.png"),
      MenuGetSet(idStatic: 2, nameStatic: "Death Notifications", itemIconStatic: "assets/images/vault_ic_death_notification.png"),
      MenuGetSet(idStatic: 3, nameStatic: "Advisors", itemIconStatic: "assets/images/vault_ic_advisor.png"),
      MenuGetSet(idStatic: 4, nameStatic: "Keys to Residence", itemIconStatic: "assets/images/vault_ic_key_to_residences.png"),
      MenuGetSet(idStatic: 5, nameStatic: "Safe Deposit Boxes", itemIconStatic: "assets/images/vault_ic_safe_deposit_box.png"),
      MenuGetSet(idStatic: 6, nameStatic: "Important Documents", itemIconStatic: "assets/images/vault_ic_important_documents.png")
    ];
    headerGetSet.setList = temp1;
    menuList.add(headerGetSet);

    HeaderGetSet headerGetSet1 = HeaderGetSet();
    headerGetSet1.setName = "Directions and Instructions";
    List<MenuGetSet> temp2 = List<MenuGetSet>.empty(growable: true);
    temp2 = [
      MenuGetSet(idStatic: 7, nameStatic: "Medical & Funeral", itemIconStatic: "assets/images/vault_ic_generally.png"),
      MenuGetSet(idStatic: 8, nameStatic: "Dependent Children", itemIconStatic: "assets/images/vault_ic_dependant.png"),
      MenuGetSet(idStatic: 9, nameStatic: "Will", itemIconStatic: "assets/images/vault_ic_will.png"),
      MenuGetSet(idStatic: 10, nameStatic: "Business(es)", itemIconStatic: "assets/images/vault_ic_business.png"),
      MenuGetSet(idStatic: 11, nameStatic: "Domestic Employees", itemIconStatic: "assets/images/vault_ic_domestic_employee.png")
    ];
    headerGetSet1.setList = temp2;
    menuList.add(headerGetSet1);

    HeaderGetSet headerGetSet2 = HeaderGetSet();
    headerGetSet2.setName = "Assets";
    List<MenuGetSet> temp3 = List<MenuGetSet>.empty(growable: true);
    temp3 = [
      MenuGetSet(idStatic: 12, nameStatic: "Government Related", itemIconStatic: "assets/images/vault_ic_goverment.png"),
      MenuGetSet(idStatic: 13, nameStatic: "Employment-Related", itemIconStatic: "assets/images/vault_ic_employee.png"),
      MenuGetSet(idStatic: 14, nameStatic: "Insurance Policies", itemIconStatic: "assets/images/vault_ic_instruction.png"),
      MenuGetSet(idStatic: 15, nameStatic: "Mutual Funds", itemIconStatic: "assets/images/vault_ic_finance.png"),
      MenuGetSet(idStatic: 16, nameStatic: "Shares Bonds", itemIconStatic: "assets/images/vault_ic_finance.png"),
      MenuGetSet(idStatic: 17, nameStatic: "Other Financial Assets", itemIconStatic: "assets/images/vault_ic_finance.png"),
      MenuGetSet(idStatic: 18, nameStatic: "Bank Accounts", itemIconStatic: "assets/images/vault_ic_bank.png"),
      MenuGetSet(idStatic: 19, nameStatic: "Intellectual Property", itemIconStatic: "assets/images/vault_ic_property.png"),
      MenuGetSet(idStatic: 20, nameStatic: "Real Estate", itemIconStatic: "assets/images/vault_ic_real_estate.png"),
      MenuGetSet(idStatic: 21, nameStatic: "Other Assets", itemIconStatic: "assets/images/vault_ic_other_assests.png")
    ];
    headerGetSet2.setList = temp3;
    menuList.add(headerGetSet2);

    HeaderGetSet headerGetSet3 = HeaderGetSet();
    headerGetSet3.setName = "Obligation & Debt";
    List<MenuGetSet> temp4 = List<MenuGetSet>.empty(growable: true);
    temp4 = [
      MenuGetSet(idStatic: 22, nameStatic: "Credit Cards and Loans", itemIconStatic: "assets/images/vault_ic_credit_card.png"),
      MenuGetSet(idStatic: 23, nameStatic: "Former Spouse/ Children from previous marriage", itemIconStatic: "assets/images/vault_ic_former_spouse.png"),
      MenuGetSet(idStatic: 24, nameStatic: "Charity Related", itemIconStatic: "assets/images/vault_ic_charity.png"),
      MenuGetSet(idStatic: 25, nameStatic: "Fiduciary Obligations", itemIconStatic: "assets/images/vault_ic_fiduciary_obligations.png"),
      MenuGetSet(idStatic: 26, nameStatic: "Other Debts", itemIconStatic: "assets/images/vault_ic_debts.png")
    ];
    headerGetSet3.setList = temp4;
    menuList.add(headerGetSet3);
  }

  void callApis() {
    if (isOnline) {
      _getHolder();
      _getAccountHolders();
    } else {
      noInterNet(context);
    }
  }

  _getHolder() async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_VAULT + holders);
    final response = await http.get(url);
    final statusCode = response.statusCode;
    final body = response.body;
    List<String> dataResponse = (jsonDecode(body) as List<dynamic>).cast<String>();

    try {
      if (statusCode == 200) {
        try {
          holderList = dataResponse;
          NavigationService.holderList = holderList;
        } catch (e) {
          print(e);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  _getAccountHolders() async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_VAULT + accountHolders);
    Map<String, String> jsonBody = {'user_id': sessionManagerVault.getUserId().trim()};

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = AccountHolderListResponse.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      try {
        if (dataResponse.holders != null) {
          accountHolder = dataResponse.holders!;
          NavigationService.accountHolder = accountHolder;
        }
      } catch (e) {
        print(e);
      }
    } else {
      showSnackBar(dataResponse.message, context);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void castStatefulWidget() {
    widget is EStateVaultHomePage;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
