import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:share_plus/share_plus.dart';
import 'package:superapp_flutter/common_widget/common_widget.dart';
import 'package:superapp_flutter/screen/e-state-valut/advisors_page_list.dart';
import 'package:superapp_flutter/screen/e-state-valut/bank_page_list.dart';
import 'package:superapp_flutter/screen/e-state-valut/constitution_value_page_list.dart';
import 'package:superapp_flutter/screen/e-state-valut/death_notification_page_list.dart';
import 'package:superapp_flutter/screen/e-state-valut/real_estate_page_list.dart';
import 'package:superapp_flutter/screen/e-state-valut/safe_deposite_box_page_list.dart';
import 'package:superapp_flutter/screen/e-state-valut/share_bonds_page_list.dart';
import '../../../constant/colors.dart';
import '../../../utils/base_class.dart';
import '../../constant/e-state-valut/api_end_point.dart';
import '../../constant/global_context.dart';
import '../../model/CommanResponse.dart';
import '../../model/e-state-vault/AccountHolderListResponse.dart';
import '../../model/e-state-vault/SaveWillAndTrustResponseModel.dart';
import '../../model/e-state-vault/ShareDataReportResponse.dart';
import '../../model/e-state-vault/WillAndTrustResponseModel.dart';
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
  const EStateVaultHomePage({super.key});

  @override
  _EStateVaultHomePageState createState() => _EStateVaultHomePageState();
}

class _EStateVaultHomePageState extends BaseState<EStateVaultHomePage> {
  bool _isLoading = false;
  bool isLoadingReport = false;
  bool isReportDownloading = false;
  List<HeaderGetSet> menuList = List<HeaderGetSet>.empty(growable: true);
  List<String> holderList = List<String>.empty(growable: true);
  List<Holders> accountHolder = List<Holders>.empty(growable: true);
  int headerPosition = 0;
  ScrollController _scrollController = ScrollController();

  bool isLoading = false;
  bool isLoadingSendRequest = false;
  bool isWillExpanded = false;
  bool isLivingWillExpanded = false;
  bool isTrustExpanded = false;

  int haveWill = 0;
  int haveLivingWill = 0;
  int haveTrust = 0;

  TextEditingController willController = TextEditingController();
  TextEditingController livingWillController = TextEditingController();
  TextEditingController trustController = TextEditingController();

  WillData willData = WillData();

  List<Documents> listWillDocuments = [];
  List<Documents> listLivingWillDocuments = [];
  List<Documents> listTrustDocuments = [];
  List<String> listRemoveId = [];

  PlatformFile? selectedWillFile;
  PlatformFile? selectedLivingWillFile;
  PlatformFile? selectedTrustFile;

  @override
  void initState() {
    super.initState();
    fetchWillTrustData();
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
                if(sessionManager.getUserType() == "client")
                {
                  Navigator.pop(context);
                }
                else
                {
                  sessionManagerPMS.createLoginSession('', '', '', '', '');
                  Navigator.pop(context);
                }
              },
              child:  getBackArrow(),
            ),
          ),
          title: getTitle("Legacy Planning",),
        actions: [
          GestureDetector(
            onTap: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context) =>  ShareReportPage()));
              _saveDataCall("","");
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
            : Column(
              children: [
                Visibility(visible: isReportDownloading,child: LinearProgressIndicator(color: blue,backgroundColor: blue.withOpacity(0.3),)),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 6,right: 12),
                              child: const Text("Please enter data to store important information related to Succession Planning : ",
                                  style: TextStyle(fontSize: 16,color: black,fontWeight: FontWeight.w600,)
                              ),
                            ),
                            _headerList(),
                          ],
                        ),
                      )),
                ),
              ],
            ),
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

              // if(headerPosition == 0)
              // {
              //   Navigator.push(context, MaterialPageRoute(builder: (context) => const WillAndTrustScreen()));
              // }

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
                    visible: headerPosition == index && index == 0,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: borderGray, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: white,
                                border: Border.all(color: gray),
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    setState(() {
                                      isWillExpanded = !isWillExpanded;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 16),
                                    decoration: BoxDecoration(
                                        color: bgFpLead,
                                        borderRadius: isWillExpanded ?
                                        BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)):
                                        BorderRadius.circular(8)
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "1. Do you have a Will?",
                                            style: getSemiBoldTextStyle(fontSize: 14, color: black),
                                          ),
                                        ),
                                        const Gap(8),
                                        Image.asset(
                                          isWillExpanded ? "assets/images/ic_arrow_double_down.png" : "assets/images/ic_arrow_double_right.png",
                                          height: 20,
                                          width: 20,
                                          color: black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: isWillExpanded,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: white,
                                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))
                                    ),
                                    padding: const EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            GestureDetector(
                                                behavior: HitTestBehavior.opaque,
                                                onTap: () {
                                                  setState(() {
                                                    haveWill = 1;
                                                  });
                                                },
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Image.asset(
                                                      haveWill == 1 ? "assets/images/ic_radio_selected.png" : "assets/images/ic_radio_unselected.png",
                                                      height: 20,
                                                      width: 20,
                                                      color: blue,
                                                    ),
                                                    const Gap(10),
                                                    Text("Yes", style: getMediumTextStyle(fontSize: 12, color: black),),
                                                  ],
                                                )
                                            ),
                                            const Gap(20),
                                            GestureDetector(
                                                behavior: HitTestBehavior.opaque,
                                                onTap: () {
                                                  setState(() {
                                                    haveWill = 0;
                                                  });
                                                },
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Image.asset(
                                                      haveWill == 0 ?  "assets/images/ic_radio_selected.png" : "assets/images/ic_radio_unselected.png",
                                                      height: 20,
                                                      width: 20,
                                                      color: blue,
                                                    ),
                                                    const Gap(10),
                                                    Text("No", style: getMediumTextStyle(fontSize: 12, color: black),),
                                                  ],
                                                )
                                            ),
                                          ],
                                        ),
                                        const Gap(16),
                                        haveWill == 1 ?
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Where is your original Will located?",
                                              style: getMediumTextStyle(fontSize: 14, color: black),
                                            ),
                                            const Gap(10),
                                            TextField(
                                              cursorColor: black,
                                              controller: willController,
                                              style: getMediumTextStyle(fontSize: 14, color: black),
                                              keyboardType: TextInputType.multiline,
                                              textInputAction: TextInputAction.newline,
                                              maxLines: 4,
                                              minLines: 2,
                                            ),
                                            const Gap(16),
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
                                                      chooseFile(1);
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
                                                        selectedWillFile == null ? "No file chosen" : "${selectedWillFile?.name}",
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: getMediumTextStyle(fontSize: 12, color: blackLight),
                                                      ),
                                                    ),
                                                  ),
                                                  Visibility(
                                                      visible: selectedWillFile != null,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            selectedWillFile = null;
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
                                              visible: listWillDocuments.isNotEmpty,
                                              child: Container(
                                                margin: const EdgeInsets.only(top: 10),
                                                child: ListView.builder(
                                                  itemCount: listWillDocuments.length,
                                                  shrinkWrap: true,
                                                  physics: NeverScrollableScrollPhysics(),
                                                  padding: const EdgeInsets.all(0),
                                                  itemBuilder: (context, index) {
                                                    return Container(
                                                      margin: const EdgeInsets.only(bottom: 10),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: GestureDetector(
                                                              onTap: () {
                                                                if(listWillDocuments[index].fileUrl != "")
                                                                {
                                                                  openFileFromURL(listWillDocuments[index].fileUrl ?? "", context);
                                                                }
                                                              },
                                                              child: Text(
                                                                "${listWillDocuments[index].fileName}",
                                                                style: getMediumTextStyle(fontSize: 12, color: blue),
                                                              ),
                                                            ),
                                                          ),
                                                          const Gap(10),
                                                          GestureDetector(
                                                            behavior: HitTestBehavior.opaque,
                                                            onTap: () {
                                                              setState(() {
                                                                if(listWillDocuments[index].docId != "")
                                                                {
                                                                  listRemoveId.add(listWillDocuments[index].docId ?? "");
                                                                }
                                                                listWillDocuments.removeAt(index);
                                                              });
                                                            },
                                                            child: Image.asset("assets/images/fin_plan_ic_delete_black.png", color: red, height: 20, width: 20,),
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            )
                                          ],
                                        ) :
                                        haveWill == 0 ?
                                        requestSendWidget(1) : Container()
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const Gap(10),
                          Container(
                            decoration: BoxDecoration(
                                color: white,
                                border: Border.all(color: gray),
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    setState(() {
                                      isLivingWillExpanded = !isLivingWillExpanded;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 16),
                                    decoration: BoxDecoration(
                                        color: bgFpLead,
                                        borderRadius: isLivingWillExpanded ?
                                        BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)):
                                        BorderRadius.circular(8)
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "2. Do you have a Living Will?",
                                            style: getSemiBoldTextStyle(fontSize: 14, color: black),
                                          ),
                                        ),
                                        const Gap(8),
                                        Image.asset(
                                          isLivingWillExpanded ? "assets/images/ic_arrow_double_down.png" : "assets/images/ic_arrow_double_right.png",
                                          height: 20,
                                          width: 20,
                                          color: black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: isLivingWillExpanded,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: white,
                                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))
                                    ),
                                    padding: const EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            GestureDetector(
                                                behavior: HitTestBehavior.opaque,
                                                onTap: () {
                                                  setState(() {
                                                    haveLivingWill = 1;
                                                  });
                                                },
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Image.asset(
                                                      haveLivingWill == 1 ? "assets/images/ic_radio_selected.png" : "assets/images/ic_radio_unselected.png",
                                                      height: 20,
                                                      width: 20,
                                                      color: blue,
                                                    ),
                                                    const Gap(10),
                                                    Text("Yes", style: getMediumTextStyle(fontSize: 12, color: black),),
                                                  ],
                                                )
                                            ),
                                            const Gap(20),
                                            GestureDetector(
                                                behavior: HitTestBehavior.opaque,
                                                onTap: () {
                                                  setState(() {
                                                    haveLivingWill = 0;
                                                  });
                                                },
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Image.asset(
                                                      haveLivingWill == 0 ?  "assets/images/ic_radio_selected.png" : "assets/images/ic_radio_unselected.png",
                                                      height: 20,
                                                      width: 20,
                                                      color: blue,
                                                    ),
                                                    const Gap(10),
                                                    Text("No", style: getMediumTextStyle(fontSize: 12, color: black),),
                                                  ],
                                                )
                                            ),

                                          ],
                                        ),
                                        const Gap(16),
                                        haveLivingWill == 1 ?
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Where is your original Living Will located?",
                                              style: getMediumTextStyle(fontSize: 14, color: black),
                                            ),
                                            const Gap(10),
                                            TextField(
                                              cursorColor: black,
                                              controller: livingWillController,
                                              style: getMediumTextStyle(fontSize: 14, color: black),
                                              keyboardType: TextInputType.multiline,
                                              textInputAction: TextInputAction.newline,
                                              maxLines: 4,
                                              minLines: 2,
                                            ),
                                            const Gap(16),
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
                                                      chooseFile(2);
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
                                                        selectedLivingWillFile == null ? "No file chosen" : "${selectedLivingWillFile?.name}",
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: getMediumTextStyle(fontSize: 12, color: blackLight),
                                                      ),
                                                    ),
                                                  ),
                                                  Visibility(
                                                      visible: selectedLivingWillFile != null,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            selectedLivingWillFile = null;
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
                                              visible: listLivingWillDocuments.isNotEmpty,
                                              child: Container(
                                                margin: const EdgeInsets.only(top: 10),
                                                child: ListView.builder(
                                                  itemCount: listLivingWillDocuments.length,
                                                  shrinkWrap: true,
                                                  physics: NeverScrollableScrollPhysics(),
                                                  padding: const EdgeInsets.all(0),
                                                  itemBuilder: (context, index) {
                                                    return Container(
                                                      margin: const EdgeInsets.only(bottom: 10),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                              child: GestureDetector(
                                                                onTap: () {
                                                                  if(listLivingWillDocuments[index].fileUrl != "")
                                                                  {
                                                                    openFileFromURL(listLivingWillDocuments[index].fileUrl ?? "", context);
                                                                  }
                                                                },
                                                                child: Text(
                                                                  "${listLivingWillDocuments[index].fileName}",
                                                                  style: getMediumTextStyle(fontSize: 12, color: blue),
                                                                ),
                                                              )
                                                          ),
                                                          const Gap(10),
                                                          GestureDetector(
                                                            behavior: HitTestBehavior.opaque,
                                                            onTap: () {
                                                              setState(() {
                                                                if(listLivingWillDocuments[index].docId != "")
                                                                {
                                                                  listRemoveId.add(listLivingWillDocuments[index].docId ?? "");
                                                                }
                                                                listLivingWillDocuments.removeAt(index);
                                                              });
                                                            },
                                                            child: Image.asset("assets/images/fin_plan_ic_delete_black.png", color: red, height: 20, width: 20,),
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            )
                                          ],
                                        ) :
                                        haveLivingWill == 0 ?
                                        requestSendWidget(2) : Container()
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const Gap(10),
                          Container(
                            decoration: BoxDecoration(
                                color: white,
                                border: Border.all(color: gray),
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    setState(() {
                                      isTrustExpanded = !isTrustExpanded;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 16),
                                    decoration: BoxDecoration(
                                        color: bgFpLead,
                                        borderRadius: isTrustExpanded ?
                                        BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)):
                                        BorderRadius.circular(8)
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "3. Do you have a Trust?",
                                            style: getSemiBoldTextStyle(fontSize: 14, color: black),
                                          ),
                                        ),
                                        const Gap(8),
                                        Image.asset(
                                          isTrustExpanded ? "assets/images/ic_arrow_double_down.png" : "assets/images/ic_arrow_double_right.png",
                                          height: 20,
                                          width: 20,
                                          color: black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: isTrustExpanded,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: white,
                                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))
                                    ),
                                    padding: const EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            GestureDetector(
                                              behavior: HitTestBehavior.opaque,
                                              onTap: () {
                                                setState(() {
                                                  haveTrust = 1;
                                                });
                                              },
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Image.asset(
                                                    haveTrust == 1 ? "assets/images/ic_radio_selected.png" : "assets/images/ic_radio_unselected.png",
                                                    height: 20,
                                                    width: 20,
                                                    color: blue,
                                                  ),
                                                  const Gap(10),
                                                  Text("Yes", style: getMediumTextStyle(fontSize: 12, color: black),),
                                                ],
                                              ),
                                            ),
                                            const Gap(20),
                                            GestureDetector(
                                              behavior: HitTestBehavior.opaque,
                                              onTap: () {
                                                setState(() {
                                                  haveTrust = 0;
                                                });
                                              },
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Image.asset(
                                                    haveTrust == 0 ?  "assets/images/ic_radio_selected.png" : "assets/images/ic_radio_unselected.png",
                                                    height: 20,
                                                    width: 20,
                                                    color: blue,
                                                  ),
                                                  const Gap(10),
                                                  Text("No", style: getMediumTextStyle(fontSize: 12, color: black),),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        const Gap(16),
                                        haveTrust == 1 ?
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Where is your original Trust located?",
                                              style: getMediumTextStyle(fontSize: 14, color: black),
                                            ),
                                            const Gap(10),
                                            TextField(
                                              cursorColor: black,
                                              controller: trustController,
                                              style: getMediumTextStyle(fontSize: 14, color: black),
                                              keyboardType: TextInputType.multiline,
                                              textInputAction: TextInputAction.newline,
                                              maxLines: 4,
                                              minLines: 2,
                                            ),
                                            const Gap(16),
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
                                                      chooseFile(3);
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
                                                        selectedTrustFile == null ? "No file chosen" : "${selectedTrustFile?.name}",
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: getMediumTextStyle(fontSize: 12, color: blackLight),
                                                      ),
                                                    ),
                                                  ),
                                                  Visibility(
                                                      visible: selectedTrustFile != null,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            selectedTrustFile = null;
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
                                              visible: listTrustDocuments.isNotEmpty,
                                              child: Container(
                                                margin: const EdgeInsets.only(top: 10),
                                                child: ListView.builder(
                                                  itemCount: listTrustDocuments.length,
                                                  shrinkWrap: true,
                                                  physics: NeverScrollableScrollPhysics(),
                                                  padding: const EdgeInsets.all(0),
                                                  itemBuilder: (context, index) {
                                                    return Container(
                                                      margin: const EdgeInsets.only(bottom: 10),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: GestureDetector(
                                                              onTap: () {
                                                                if(listTrustDocuments[index].fileUrl != "")
                                                                {
                                                                  openFileFromURL(listTrustDocuments[index].fileUrl ?? "", context);
                                                                }
                                                              },
                                                              child: Text(
                                                                "${listTrustDocuments[index].fileName}",
                                                                style: getMediumTextStyle(fontSize: 12, color: blue),
                                                              ),
                                                            ),
                                                          ),
                                                          const Gap(10),
                                                          GestureDetector(
                                                            behavior: HitTestBehavior.opaque,
                                                            onTap: () {
                                                              setState(() {
                                                                if(listTrustDocuments[index].docId != "")
                                                                {
                                                                  listRemoveId.add(listTrustDocuments[index].docId ?? "");
                                                                }
                                                                listTrustDocuments.removeAt(index);
                                                              });
                                                            },
                                                            child: Image.asset("assets/images/fin_plan_ic_delete_black.png", color: red, height: 20, width: 20,),
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            )
                                          ],
                                        ) :
                                        haveTrust == 0 ?
                                        requestSendWidget(3) : Container()
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 30, bottom: 10),
                            width: MediaQuery.of(context).size.width,
                            child: getCommonButton(
                              "Save All ",
                              isLoading,
                              () {
                                saveWillAndTrustData();
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  Visibility(
                      visible: headerPosition == index,
                      child: Container(
                        margin: menuList[index].menuItems.isNotEmpty ? const EdgeInsets.only(top: 6, bottom: 6) : EdgeInsets.zero,
                        child: _menuList(menuList[index].menuItems),
                      )
                  )
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
    HeaderGetSet headerGetSet0 = HeaderGetSet();
    headerGetSet0.setName = "Will & Trust";
    menuList.add(headerGetSet0);

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
      //MenuGetSet(idStatic: 9, nameStatic: "Will", itemIconStatic: "assets/images/vault_ic_will.png"),
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

  Widget requestSendWidget(int isFor){
    return Container(
      decoration: BoxDecoration(
          color: bgLightBlue,
          borderRadius: BorderRadius.circular(8)
      ),
      padding: const EdgeInsets.only(left: 8, right: 8, top: 14, bottom: 14),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Request Alpha Capital Team to help you prepare a Trust.",
              style: getMediumTextStyle(fontSize: 12, color: black),
            ),
          ),
          const Gap(10),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              //1 = will, 2 = living_will, 3 = trust
              if(isFor == 1)
              {
                sendRequestWillAndTrust("will");
              }
              else if(isFor == 2)
              {
                sendRequestWillAndTrust("living_will");
              }
              else
              {
                sendRequestWillAndTrust("trust");
              }
            },
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
              decoration: BoxDecoration(
                  color: blue,
                  borderRadius: BorderRadius.circular(6)
              ),
              child: isLoadingSendRequest ?
              Container(
                height: 16,
                width: 16,
                margin: const EdgeInsets.only(left: 4, right: 4),
                child: CircularProgressIndicator(color: white, strokeWidth: 2,),
              ) :
              Text("Send", style: getMediumTextStyle(fontSize: 12, color: white),),
            ),
          )
        ],
      ),
    );
  }

  Future<void> chooseFile(int isFor) async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
    );

    if (result != null)
    {
      PlatformFile file = result.files.first;

      setState(() {
        if(isFor == 1)
        {
          selectedWillFile = file;

          // listWillDocuments.add(
          //   Documents(
          //     docId: "",
          //     fileName: file.name,
          //     fileUrl: file.path ?? "",
          //     documentType: "will",
          //     uploadedAt: DateTime.now().millisecondsSinceEpoch.toString(),
          //   ),
          // );
        }
        else if(isFor == 2)
        {
          selectedLivingWillFile = file;
          // listLivingWillDocuments.add(
          //   Documents(
          //     docId: "",
          //     fileName: file.name,
          //     fileUrl: file.path ?? "",
          //     documentType: "living_will",
          //     uploadedAt: DateTime.now().millisecondsSinceEpoch.toString(),
          //   ),
          // );
        }
        else
        {
          selectedTrustFile = file;
          // listTrustDocuments.add(
          //   Documents(
          //     docId: "",
          //     fileName: file.name,
          //     fileUrl: file.path ?? "",
          //     documentType: "trust",
          //     uploadedAt: DateTime.now().millisecondsSinceEpoch.toString(),
          //   ),
          // );
        }
      });
    }
  }

  sendRequestWillAndTrust(String typePass) async{
    if(isOnline)
    {
      setState(() {
        isLoadingSendRequest = true;
      });

      try
      {
        HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
          HttpLogger(logLevel: LogLevel.BODY),
        ]);

        final url = Uri.parse(sendRequestWillAndTrustUrl);
        Map<String, String> jsonBody = {
          "user_id": sessionManagerVault.getUserId().trim(),
          "type": typePass
        };

        final response = await http.post(url, body: jsonBody);
        final statusCode = response.statusCode;
        final body = response.body;
        Map<String, dynamic> user = jsonDecode(body);
        var dataResponse = CommanResponse.fromJson(user);

        if(statusCode == 200 && dataResponse.success == 1)
        {
          showToast(dataResponse.message);
          isWillExpanded = false;
          isLivingWillExpanded = false;
          isTrustExpanded = false;
          fetchWillTrustData();
        }
        else
        {
          showToast(dataResponse.message);
        }

      }
      catch(e)
      {
        print("Failed to send request : $e");
      }
      finally
      {
        setState(() {
          isLoadingSendRequest = false;
        });
      }
    }
    else
    {
      noInterNet(context);
    }
  }

  fetchWillTrustData() async{
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

        final url = Uri.parse(API_URL_VAULT + willAndTrustDetailUrl);
        Map<String, String> jsonBody = {'user_id': sessionManagerVault.getUserId().trim()};

        final response = await http.post(url, body: jsonBody);
        final statusCode = response.statusCode;
        final body = response.body;
        Map<String, dynamic> user = jsonDecode(body);
        var dataResponse = WillAndTrustResponseModel.fromJson(user);

        if(statusCode == 200 && dataResponse.success == 1)
        {
          willData = dataResponse.willData ?? WillData();
          haveWill = int.tryParse("${willData.hasWill}") ?? 0;
          haveLivingWill = int.tryParse("${willData.hasLivingWill}") ?? 0;
          haveTrust = int.tryParse("${willData.hasTrust}") ?? 0;

          willController.text = willData.originalWillLocated ?? "";
          livingWillController.text = willData.livingWillLocation ?? "";
          trustController.text = willData.trustLocation ?? "";

          listWillDocuments = (willData.documents ?? []).where((doc) => doc.documentType == "will").toList();
          listLivingWillDocuments = (willData.documents ?? []).where((doc) => doc.documentType == "living_will").toList();
          listTrustDocuments = (willData.documents ?? []).where((doc) => doc.documentType == "trust").toList();

          setState(() {});
        }
        else
        {
          haveWill = -1;
          haveLivingWill = -1;
          haveTrust = -1;
          print("Else work will and trust api");
        }

      }
      catch(e)
      {
        print("Failed to fetch will trust data : $e");
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

  saveWillAndTrustData() async{
    if(isOnline)
    {
      setState(() {
        isLoading = true;
      });

      try
      {

        Map<String, String> jsonBody;

        jsonBody = {
          "user_id": sessionManagerVault.getUserId(),
          "will_id": willData.willId ?? "",
          "has_will": haveWill == -1 ? "" : "$haveWill",
          "original_will_located": willController.text,
          "has_living_will": haveLivingWill == -1 ? "" : "$haveLivingWill",
          "living_will_location": livingWillController.text,
          "has_trust": haveTrust == -1 ? "" : "$haveTrust",
          "trust_location": trustController.text,
          if(listRemoveId.isNotEmpty)
            "remove_doc_id" : listRemoveId.join(",")
        };

        print("Display json body : \n$jsonBody");

        final url = Uri.parse(API_URL_VAULT + saveWillAndTrustUrl);
        http.MultipartRequest request = http.MultipartRequest('POST', url,);

        if (haveWill == 1 && selectedWillFile != null)
        {
          request.files.add(await http.MultipartFile.fromPath('upload_doc_will[]', selectedWillFile?.path ?? ""));
        }

        if (haveLivingWill == 1 && selectedLivingWillFile != null)
        {
          request.files.add(await http.MultipartFile.fromPath('upload_doc_living_will[]', selectedLivingWillFile?.path ?? ""));
        }

        if (haveTrust == 1 && selectedTrustFile != null)
        {
          request.files.add(await http.MultipartFile.fromPath('upload_doc_trust[]', selectedTrustFile?.path ?? ""));
        }

        print("Display json body : $jsonBody");
        request.fields.addAll(jsonBody);
        print("Display all request : $request");
        http.StreamedResponse response = await request.send();
        var responseBytes = await response.stream.toBytes();
        var responseString = utf8.decode(responseBytes);

        final statusCode = response.statusCode;
        Map<String, dynamic> user = jsonDecode(responseString);
        var dataResponse = SaveWillAndTrustResponseModel.fromJson(user);

        if(statusCode == 200 && dataResponse.success == 1)
        {
          showToast(dataResponse.message ?? "");
          selectedWillFile = null;
          selectedLivingWillFile = null;
          selectedTrustFile = null;

          if(listRemoveId.isNotEmpty)
          {
            listRemoveId.clear();
          }

          isWillExpanded = false;
          isLivingWillExpanded = false;
          isTrustExpanded = false;

          fetchWillTrustData();
        }
        else
        {
          showToast(dataResponse.message ?? "");
        }
      }
      catch(e)
      {
        print("Failed to save will and trust : $e");
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

  _saveDataCall(String data, String isFor) async {

    setState(() {
      isReportDownloading = true;
    });

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_VAULT + generatePDF);
    Map<String, String> jsonBody = {
      'user_id': sessionManagerVault.getUserId().trim(),
      'email_addresses' : data,
      'password' : ""
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = ShareDataReportResponse.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1)
    {
      setState(() {
        isReportDownloading = false;
      });
      showSnackBar(dataResponse.message, context);
      if (isFor == 'SAVE')
      {
        Share.share('Hey there, \n\nPlease check out the important information related to my succession planning \n\n ${dataResponse.urlData} \n\n -Team Alpha Capital');
      }
      else
      {
        if(checkValidString(dataResponse.urlData).toString().isNotEmpty)
        {
          _getDownloadDirectory(context,dataResponse.urlData.toString());
        }
      }
    }
    else {
      showSnackBar(dataResponse.message, context);
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<String> _getDownloadDirectory(BuildContext context, String fileUrlServer) async {
    String? directory;
    try {

      if (Platform.isIOS)
      {
        var pathMain = await getApplicationDocumentsDirectory();
        directory = pathMain.path;
      }
      else
      {
        directory = await FilePicker.platform.getDirectoryPath();
      }

      _downloadFile(directory ?? '',fileUrlServer);
    } catch (e) {
      print("Error while picking directory: $e");
    }
    if (directory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No directory selected!")),
      );
      return "";
    }
    return directory;
  }

  Future<void> _downloadFile(String downloadPath, String fileUrlServer) async {
    // Example using `http` package
    String fileUrl = fileUrlServer;
    String fileName = '${sessionManagerPMS.getFirstName()}_${sessionManagerPMS.getLastName()}_${DateTime.now().millisecondsSinceEpoch / 1000}.pdf';

    if (Platform.isIOS)
    {
      var permissionStatus = await Permission.storage.status;
      if (permissionStatus.isDenied)
      {
        await Permission.storage.request();
      }
    }

    HttpClient().getUrl(Uri.parse(fileUrl))
        .then((HttpClientRequest request) {
      return request.close(); // Return the result of request.close()
    })
        .catchError((error, stackTrace) {
      print("error === ${error}");
      print("stackTrace === ${stackTrace}");
      return error;
    },)
        .then((HttpClientResponse response) async {
      File file = File('$downloadPath/$fileName');

      await response.pipe(file.openWrite(mode: FileMode.write))
          .catchError((error, stackTrace) {
        print("error === ${error}");
        print("stackTrace === ${stackTrace}");
      },);

      print('File Path ==== ${file.path}');

      if (Platform.isAndroid)
      {
        final result = await OpenFile.open(file.path);
        setState(() {
          var openResult = "type=${result.type}  message=${result.message}";
          print("openResult === $openResult");
        });
        //Navigator.pop(context);
      }
      else
      {
        final result = await OpenFile.open(file.path);
        var openResult = "type=${result.type}  message=${result.message}";
        print("openResult === $openResult");
      }
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
