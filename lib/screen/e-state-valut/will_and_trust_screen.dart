
import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/model/CommanResponse.dart';
import 'package:superapp_flutter/model/e-state-vault/SaveWillAndTrustResponseModel.dart';
import 'package:superapp_flutter/model/e-state-vault/WillAndTrustResponseModel.dart';
import 'package:superapp_flutter/utils/app_utils.dart';
import 'package:superapp_flutter/utils/base_class.dart';

import '../../common_widget/common_widget.dart';
import '../../constant/colors.dart';
import '../../constant/e-state-valut/api_end_point.dart';

class WillAndTrustScreen extends StatefulWidget {
  const WillAndTrustScreen({super.key});

  @override
  BaseState<WillAndTrustScreen> createState() => _WillAndTrustScreenState();
}

class _WillAndTrustScreenState extends BaseState<WillAndTrustScreen> {

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
    fetchWillTrustData();
    super.initState();
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
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child:  getBackArrow(),
        ),
        title: getTitle("Will & Trust",),
      ),body: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
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
                          requestSendWidget(1)
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
                          requestSendWidget(2)

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
                          requestSendWidget(3)
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
    );
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
          "has_will": "$haveWill",
          "original_will_located": willController.text,
          "has_living_will": "$haveLivingWill",
          "living_will_location": livingWillController.text,
          "has_trust": "$haveTrust",
          "trust_location": trustController.text,
          if(listRemoveId.isNotEmpty)
            "remove_doc_id" : listRemoveId.join(",")
        };

        print("Display json body : \n$jsonBody");

        final url = Uri.parse(API_URL_VAULT + saveWillAndTrustUrl);
        http.MultipartRequest request = http.MultipartRequest('POST', url,);

        if (selectedWillFile != null)
        {
          request.files.add(await http.MultipartFile.fromPath('upload_doc_will[]', selectedWillFile?.path ?? ""));
        }

        if (selectedLivingWillFile != null)
        {
          request.files.add(await http.MultipartFile.fromPath('upload_doc_living_will[]', selectedLivingWillFile?.path ?? ""));
        }

        if (selectedTrustFile != null)
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

  @override
  void castStatefulWidget() {
    widget as WillAndTrustScreen;
  }

}
