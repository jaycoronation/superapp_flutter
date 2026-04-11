import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/model/CommanResponse.dart';
import 'package:superapp_flutter/model/e-state-analysis/RMFpUserLeadResponseModel.dart';
import 'package:superapp_flutter/screen/e-state-analysis/rm_fp_add_lead_screen.dart';
import 'package:superapp_flutter/utils/app_utils.dart';
import 'package:superapp_flutter/utils/base_class.dart';

import '../../common_widget/common_widget.dart';
import '../../constant/analysis_api_end_point.dart';
import '../../constant/api_end_point.dart';
import '../../constant/colors.dart';
import '../../model/e-state-analysis/RmFpUserListResponseModel.dart';
import '../../widget/loading.dart';
import '../../widget/loading_more.dart';
import '../../widget/no_data.dart';
import 'e_state_analysis_home_page.dart';
import 'e_state_summary_screen.dart';

class RmFpLeadScreen extends StatefulWidget {
  const RmFpLeadScreen({super.key});

  @override
  BaseState<RmFpLeadScreen> createState() => _RmFpLeadScreenState();
}

class _RmFpLeadScreenState extends BaseState<RmFpLeadScreen> {

  bool isLoading = false;
  bool isSearchShow = false;
  bool isLoadingMore = false;
  bool isLastPage = false;
  bool isScrollingDown = false;

  int pageIndex = 1;
  final int pageResult = 20;

  String searchValue = "";
  String totalRecord = "";
  String selectedClientId = "";
  String selectedClientUserName = "";

  List<UserLeadData> listUserLead = [];
  List<RmFpUsers> listUserData = [];
  List<RmFpAllEmployees> listAllEmployee = [];

  TextEditingController clientNameController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  ScrollController _scrollViewController = ScrollController();

  @override
  void initState() {
    fetchRmUserLeadList(true);
    getUserList();
    _scrollViewController = ScrollController();
    _scrollViewController.addListener(() {
      if(_scrollViewController.position.userScrollDirection ==  ScrollDirection.reverse)
      {
        if(!isScrollingDown)
        {
          isScrollingDown = true;
          setState(() {});
        }
      }

      if(_scrollViewController.position.userScrollDirection == ScrollDirection.forward)
      {
        if(isScrollingDown)
        {
          isScrollingDown = false;
          setState(() {});
        }
      }
      pagination();
    },);
    super.initState();
  }

  void pagination(){
    if(!isLastPage && !isLoadingMore && listUserLead.isNotEmpty)
    {
      if(_scrollViewController.position.pixels ==  _scrollViewController.position.maxScrollExtent)
      {
        setState(() {
          isLoadingMore = true;
          fetchRmUserLeadList(false);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dashboardBg,
      appBar: AppBar(
        toolbarHeight: 55,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child:  getBackArrow(),
        ),
        title: getTitle("Financial Planning Leads",),
        centerTitle: true,
        elevation: 0,
        backgroundColor: white,
        actions: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if (isOnline)
              {
                setState(() {
                  if(searchValue != "" && isSearchShow == true)
                  {
                    searchValue = "";
                    searchController.text = "";

                    fetchRmUserLeadList(true);
                  }
                  isSearchShow = !isSearchShow;
                });
              }
              else
              {
                noInterNet(context);
              }
            },
            child: Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(right: 4),
              padding: const EdgeInsets.all(8.0),
              child: Icon(isSearchShow ? Icons.search_off : Icons.search, size: 24),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: isSearchShow,
              child: searchView(),
            ),
            Expanded(
              child: isLoading ?
              Center(
                child: LoadingWidget(),
              ) :
              listUserLead.isEmpty ? const Center(child: MyNoDataWidget(msg: 'No lead data found')) :
              ListView.builder(
                controller: _scrollViewController,
                itemCount: listUserLead.length,
                shrinkWrap: true,
                padding: const EdgeInsets.all(0),
                itemBuilder: (context, index) {

                  final listData = listUserLead[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${listData.name ?? ""} (${listData.age}Yrs)",
                                style: getMediumTextStyle(fontSize: 14, color: black),
                              ),
                            ),
                            const Gap(8),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                _redirectToNextPage(context, listData, true);
                              },
                              child: Image.asset(
                                "assets/images/fin_plan_ic_edit_gray.png",
                                height: 20,
                                width: 20,
                                color: tableLightGreen,
                              ),
                            ),
                            const Gap(10),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                deleteListData(1, listData, index);
                              },
                              child: Image.asset(
                                "assets/images/fin_plan_ic_delete_black.png",
                                height: 24,
                                width: 24,
                                color: redLight,
                              ),
                            ),
                          ],
                        ),
                        const Gap(8),
                        Divider(),
                        const Gap(8),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("RM", style: getMediumTextStyle(fontSize: 12, color: black),),
                                  const Gap(2),
                                  Text("${listData.portfolioRmName}", style: getMediumTextStyle(fontSize: 12, color: blue),)
                                ],
                              ),
                            ),
                            const Gap(8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("City", style: getMediumTextStyle(fontSize: 12, color: black),),
                                  const Gap(2),
                                  Text("${listData.city}", style: getMediumTextStyle(fontSize: 12, color: blue),)
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Gap(8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Prepare Plan", style: getMediumTextStyle(fontSize: 12, color: black),),
                                  const Gap(2),
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => EStateSummaryScreen(listData.userId ?? "")));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: grayLight,
                                        borderRadius: BorderRadius.circular(6)
                                      ),
                                      child: Text(
                                        "Prepare Financial Plan",
                                        style: getMediumTextStyle(fontSize: 12, color: blackLight),
                                      )
                                    ),
                                  ),
                                ],
                              )
                            ),
                            const Gap(8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Linked With Client", style: getMediumTextStyle(fontSize: 12, color: black),),
                                  const Gap(2),
                                  (listData.isLinked != "1") ?
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      openLinkClientDialog(listData);
                                    },
                                    child: Text(
                                      "Link",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: blue,
                                        decoration: TextDecoration.underline,
                                        decorationColor: blue,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ) :
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${listData.linkedPortfolioName ?? ""} (${listData.linkedPortfolioUsername ?? ""})",
                                        style: getMediumTextStyle(fontSize: 12, color: blackLight),
                                      ),
                                      const Gap(10),
                                      GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () {
                                          deleteListData(2, listData, index);
                                        },
                                        child: Text(
                                          "UnLink",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: blue,
                                            decoration: TextDecoration.underline,
                                            decorationColor: blue,
                                            fontWeight: FontWeight.w500
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            Visibility(visible: isLoadingMore, child: const LoadingMoreWidget()),
            const Gap(20)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _redirectToNextPage(context, UserLeadData(), false);
        },
        backgroundColor: blue,
        child: const Icon(Icons.add, color: white,),
      )
    );
  }

  Future<void> _redirectToNextPage(BuildContext context, UserLeadData getSet, bool isFromEdit) async {
    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => RmFpAddLeadScreen(getSet, isFromEdit, listAllEmployee[0])),);
    print("result ===== $result");
    if (result == "success") {
      setState(() {

      });
      fetchRmUserLeadList(true);
    }
  }

  Widget searchView(){
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: commonSearchTextField(
        searchController,
        "Search here...",
        //on change
        (value) {
          if(value.isEmpty)
          {
            setState(() {
              searchValue = "";
            });
            fetchRmUserLeadList(true);
          }
          else
          {
            setState(() {});
          }
        },
        // on submit
            (value) {
          if(value.isNotEmpty)
          {
            setState(() {
              searchValue = value;
            });
            fetchRmUserLeadList(true);
          }
        },
        //close clear
            () {
          hideKeyboard(context);
          if (searchValue.isNotEmpty)
          {
            setState(() {
              searchValue = "";
              searchController.text = "";
            });

            if (isOnline)
            {
              fetchRmUserLeadList(true);
            }
            else
            {
              noInterNet(context);
            }
          }
          else
          {
            setState(() {
              searchValue = "";
              searchController.text = "";
            });
          }
        },
      ),
    );
  }

  openLinkClientDialog(UserLeadData getSet){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        bool isLoadingLinkUser = false;
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 12,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.65,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    getBottomSheetHeaderWithCloseIcon(context, "Link Client - ${getSet.name}", fontSize: 14, () {
                      Navigator.pop(context);
                    },),
                    Text("Client*", style: getMediumTextStyle(fontSize: 14, color: blackLight),),
                    const Gap(8),
                    TextField(
                      cursorColor: black,
                      controller: clientNameController,
                      keyboardType: TextInputType.text,
                      style: getMediumTextStyle(fontSize: 14, color: black),
                      readOnly: true,
                      decoration: const InputDecoration(
                        hintText: 'Select Client',
                        suffixIcon: Icon(Icons.keyboard_arrow_down_outlined, size: 24, color: blackLight,)
                      ),
                      onTap: () {
                        openClientSelectionDialog(setStateDialog);
                      },
                    ),
                    const Gap(20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: getCommonButton(
                        "Link",
                        isLoadingLinkUser,
                        () async{
                          setStateDialog(() {
                            isLoadingLinkUser = true;
                          });
                          await linkClientUser(clientNameController.text, selectedClientUserName, getSet.userId ?? "");
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void openClientSelectionDialog(StateSetter setStateDialog) async{
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.85,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                getBottomSheetHeaderWithoutButton(context, "Select Client"),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: listUserData.length,
                    physics: BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (context, index) {
                      final bool isLastItem = index == listUserData.length - 1;
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          setStateDialog(() {
                            clientNameController.text = "${listUserData[index].firstName}";
                            selectedClientId = "${listUserData[index].userId}";
                            selectedClientUserName = "${listUserData[index].userName}";
                            Navigator.pop(context);
                          });
                        },
                        child: getBottomSheetItemWithoutSelection("${listUserData[index].firstName}", selectedClientId == "${listUserData[index].userId}", isLastItem ? true : false),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  deleteListData(int isFor, UserLeadData listData, int index){
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      builder: (BuildContext context) {
        bool isDeleteLoading = false;

        return StatefulBuilder(
          builder: (context, setStateSheet) {
            return Wrap(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)), color: white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      getBottomSheetHeaderWithoutButton(context, isFor == 1 ? "Delete" : "Unlink?"),
                      Text(
                        isFor == 1 ? "Are you sure want to delete?" : "Are you sure want to unlink?",
                        style: getMediumTextStyle(fontSize: 14, color: black),textAlign: TextAlign.center,
                      ),
                      const Gap(20),
                      Row(
                        children: [
                          Expanded(
                            child: getCommonButtonBorder(
                              "Cancel",
                              false,
                              () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          const Gap(20),
                          Expanded(
                            child: getCommonButton(
                                isFor == 1 ? "Delete" : "Yes",
                                isDeleteLoading,
                                () async{
                                  setStateSheet(() {
                                    isDeleteLoading = true;
                                  });
                                  if(isFor == 1)
                                  {
                                    await deleteLeadData(listData.userId ?? "");
                                  }
                                  else
                                  {
                                    await unLinkClient(listData.userId ?? "");
                                  }
                                  Navigator.pop(context);
                                }
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  linkClientUser(String clientName, String clientUserName, String userId) async{
    if(isOnline)
    {
      try
      {
        HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
          HttpLogger(logLevel: LogLevel.BODY),
        ]);

        final url = Uri.parse(API_URL_ANALYSIS + linkFPUserLead);

        Map<String, String> jsonBody = {
          "linked_portfolio_name": clientName,
          "linked_portfolio_username": clientUserName,
          "user_id": userId,
        };

        final response = await http.post(url, body: jsonBody);
        final statusCode = response.statusCode;
        final body = response.body;
        Map<String, dynamic> user = jsonDecode(body);
        var dataResponse = CommanResponse.fromJson(user);

        if(statusCode == 200 && dataResponse.success == 1)
        {
          showToast(dataResponse.message);
          fetchRmUserLeadList(true);
        }
        else
        {
          showToast(dataResponse.message);
        }
      }
      catch(e)
      {
        print("Failed link client : $e");
      }
    }
    else
    {
      noInterNet(context);
    }
  }

  fetchRmUserLeadList(bool isFirstTime) async {
    if(isOnline)
    {
      if(isFirstTime)
      {
        setState(() {
          listUserLead = [];
          pageIndex = 1;
          isLoading = true;
        });
      }

      try
      {
        HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
          HttpLogger(logLevel: LogLevel.BODY),
        ]);

        final url = Uri.parse(API_URL_ANALYSIS + fPUserLeadAPI);
        Map<String, String> jsonBody = {
          "admin_id": sessionManager.getRMIDAdminId(),
          "limit": pageResult.toString(),
          "page": pageIndex.toString(),
          "only_basics": "true",
          "portfolio_rm_id": sessionManager.getRMIDAdminId(),
          "search_string": searchValue
        };
        final response = await http.post(url, body: jsonBody);
        final statusCode = response.statusCode;
        final body = response.body;
        Map<String, dynamic> user = jsonDecode(body);
        var dataResponse = RmFpUserLeadResponseModel.fromJson(user);

        if(statusCode == 200 && dataResponse.success == 1)
        {
          totalRecord = "${dataResponse.totalRecords}";

          List<UserLeadData>? tempList = [];
          tempList = dataResponse.userLeadData;
          listUserLead.addAll(tempList ?? []);

          if(tempList?.isNotEmpty ?? false)
          {
            pageIndex += 1;
            if((tempList?.isEmpty ?? false) || (tempList?.length ?? 0) % pageResult != 0)
            {
              isLastPage = true;
            }
          }
        }
        else
        {
          showToast(dataResponse.message);
          totalRecord = "0";
        }
      }
      catch(e)
      {
        print("Failed to fetch user lead list : $e");
      }
      finally
      {
        setState(() {
          isLoading = false;
          isLoadingMore = false;
        });
      }
    }
    else
    {
      noInterNet(context);
    }
  }

  Future<void> getUserList() async{
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

        final url = Uri.parse(API_URL + userListAPI);

        Map<String, String> jsonBody = {
          'admin_id': sessionManager.getRMIDAdminId(),
          'page': "1",
          'limit': "1000",
          'only_basics': "true",
          'portfolio_rm_id': sessionManager.getRMIDAdminId(),
          'search_string': "",
        };

        final response = await http.post(url, body: jsonBody);

        final statusCode = response.statusCode;
        final body = response.body;
        Map<String, dynamic> user = jsonDecode(body);
        var dataResponse = RmFpUserListResponseModel.fromJson(user);

        if(statusCode == 200 && dataResponse.success == 1)
        {
          listAllEmployee = dataResponse.allEmployees ?? [];
          listUserData = dataResponse.rmFpUsers ?? [];
        }
        else
        {
          listUserData = [];
        }
      }
      catch(e)
      {
        print("Failed to fetch user list : $e");
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

  unLinkClient(String userID) async{
    if(isOnline)
    {
      try
      {
        HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
          HttpLogger(logLevel: LogLevel.BODY),
        ]);

        final url = Uri.parse(API_URL_ANALYSIS + unLinkFPUserLead);

        Map<String, String> jsonBody = {
          "user_id": userID,
        };

        final response = await http.post(url, body: jsonBody);
        final statusCode = response.statusCode;
        final body = response.body;
        Map<String, dynamic> user = jsonDecode(body);
        var dataResponse = CommanResponse.fromJson(user);

        if(statusCode == 200 && dataResponse.success == 1)
        {
          showToast(dataResponse.message);
          fetchRmUserLeadList(true);
        }
        else
        {
          showToast(dataResponse.message);
        }
      }
      catch(e)
      {
        print("Failed to delete lead : $e");
      }
    }
    else
    {
      noInterNet(context);
    }
  }

  deleteLeadData(String userID) async{
    if(isOnline)
    {
      try
      {
        HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
          HttpLogger(logLevel: LogLevel.BODY),
        ]);

        final url = Uri.parse(API_URL_ANALYSIS + deleteFPUserLead);

        Map<String, String> jsonBody = {
          "user_id": userID,
        };

        final response = await http.post(url, body: jsonBody);
        final statusCode = response.statusCode;
        final body = response.body;
        Map<String, dynamic> user = jsonDecode(body);
        var dataResponse = CommanResponse.fromJson(user);

        if(statusCode == 200 && dataResponse.success == 1)
        {
          showToast(dataResponse.message);
          fetchRmUserLeadList(true);
        }
        else
        {
          showToast(dataResponse.message);
        }
      }
      catch(e)
      {
        print("Failed to delete lead : $e");
      }
    }
    else
    {
      noInterNet(context);
    }
  }

  @override
  void castStatefulWidget() {
    widget as RmFpLeadScreen;
  }
}
