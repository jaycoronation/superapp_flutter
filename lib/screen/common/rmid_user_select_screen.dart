import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/common_widget/common_widget.dart';
import 'package:superapp_flutter/constant/api_end_point.dart';
import 'package:superapp_flutter/constant/colors.dart';
import 'package:superapp_flutter/model/LoginResponseModel.dart';
import 'package:superapp_flutter/model/UserListResponseModel.dart';
import 'package:superapp_flutter/screen/consolidated-portfolio/cp_home_page.dart';
import 'package:superapp_flutter/screen/e-state-analysis/e_state_analysis_home_page.dart';
import 'package:superapp_flutter/screen/e-state-valut/e_state_valut_home_page.dart';
import 'package:superapp_flutter/service/JobService.dart';
import 'package:superapp_flutter/utils/base_class.dart';
import 'package:superapp_flutter/widget/loading.dart';
import 'package:superapp_flutter/widget/loading_more.dart';
import 'package:superapp_flutter/widget/no_data.dart';
import 'package:superapp_flutter/widget/no_internet.dart';

import '../../utils/app_utils.dart';

class RMIDUserSelectScreen extends StatefulWidget {
  final String isFor;
  const RMIDUserSelectScreen(this.isFor, {super.key});

  @override
  BaseState<RMIDUserSelectScreen> createState() => _RMIDUserSelectScreenState();
}

class _RMIDUserSelectScreenState extends BaseState<RMIDUserSelectScreen> {

  late ScrollController _scrollViewController;
  bool isLoading = false;
  bool isLoadingMore = false;
  int pageIndex = 1;
  int pageResult = 20;
  bool isLastPage = false;
  bool isScrollingDown = false;
  bool isSearchShow = false;

  String searchText = "";
  TextEditingController searchController = TextEditingController();

  String isFor = "";

  List<Users> listUserData = [];

  @override
  void initState() {
    isFor = (widget as RMIDUserSelectScreen).isFor;
    print("Display is for type : $isFor");
    getUserList(true);
    _scrollViewController = ScrollController();
    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection == ScrollDirection.reverse)
      {
        if (!isScrollingDown)
        {
          isScrollingDown = true;
          setState(() => {});
        }
      }

      if (_scrollViewController.position.userScrollDirection == ScrollDirection.forward)
      {
        if (isScrollingDown)
        {
          isScrollingDown = false;
          setState(() => {});
        }
      }
      pagination();
    });
    super.initState();
  }

  void pagination() {
    if (!isLastPage && !isLoadingMore && listUserData.isNotEmpty)
    {
      if ((_scrollViewController.position.pixels == _scrollViewController.position.maxScrollExtent))
      {
        setState(() {
          isLoadingMore = true;
        });
        getUserList(false);
      }
    }
  }

  void reload(){
    if (isOnline)
    {
      getUserList(true);
    }
    else
    {
      noInterNet(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dashboardBg,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: 55,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.pop(context);
          },
          child: getBackArrow(),
        ),
        title: getTitle("Client"),
        centerTitle: false,
        elevation: 0,
        backgroundColor: white,
        actions: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if (isOnline)
              {
                setState(() {
                  isSearchShow = !isSearchShow;

                  if(searchController.text.isNotEmpty)
                  {
                    searchText = "";
                    searchController.text = "";
                  }

                  if(!isSearchShow){
                    getUserList(true);
                  }

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
      body: isOnline
          ? _setData()
          : NoInternetWidget(() {
              if (isOnline)
              {
               getUserList(true);
              }
              else
              {
                noInterNet(context);
              }
          },),
    );
  }

  Widget _setData(){
    return RefreshIndicator(
      color: black,
      onRefresh: _refresh,
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [

            Visibility(
              visible: isSearchShow && !isLoading,
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: gray,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  cursorColor: black,
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.search,
                  style: TextStyle(
                      fontSize: 16,
                      color: black,
                      fontWeight: FontWeight.w400
                  ),
                  onSubmitted: (value) {
                    if(value.isEmpty)
                    {
                      setState(() {
                        searchText = '';
                        searchController.text = "";
                      });
                      getUserList(true);
                    }
                    else
                    {
                      setState(() {
                        searchText = value;
                      });
                      getUserList(true);
                    }
                  },
                  onChanged: (value) {
                    if(searchController.text.isEmpty)
                    {
                      setState(() {
                        searchText = '';
                        searchController.text = "";
                      });
                      getUserList(true);
                    }
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent,
                    hintText: 'Search user...',
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(0.0), borderSide: BorderSide.none),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(0.0), borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(0.0), borderSide: BorderSide.none),
                    contentPadding: const EdgeInsets.only(left: 12, right: 12),
                    prefixIcon: const InkWell(
                      onTap: null,
                      child: Icon(Icons.search_rounded, size: 26, color: black),
                    ),
                    suffixIcon: searchText.isNotEmpty
                        ? GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        hideKeyboard(context);
                        if (searchText.isNotEmpty)
                        {
                          setState(() {
                            searchText = "";
                            searchController.text = "";
                          });

                          if (isOnline)
                          {
                            getUserList(true);
                          }
                          else {
                            noInterNet(context);
                          }
                        }
                        else
                        {
                          setState(() {
                            searchText = "";
                            searchController.text = "";
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Image.asset('assets/images/ic_close.png', height: 12, width: 12, color: gray),
                      ),
                    )
                        : null,
                  ),
                ),
              ),
            ),

            const Gap(10),

            Expanded(child: isLoading ? LoadingWidget() : setUserList()),

            Visibility(visible: isLoadingMore, child: const LoadingMoreWidget()),
            const Gap(20)

          ],
        ),
      ),
    );
  }

  Widget setUserList(){
    return listUserData.isEmpty ? const Center(child: MyNoDataWidget(msg: 'No any users data found')) :
      ListView.builder(
      itemCount: listUserData.length,
      shrinkWrap: true,
      controller: _scrollViewController,
      itemBuilder: (context, index) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            // makeLoginRequest(listUserData[index].firstName ?? "", listUserData[index].email ?? "", listUserData[index].userName ?? "", listUserData[index].contactNo ?? "", listUserData[index].panNo1 ?? "", );
            makeLoginRequest(listUserData[index]);
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.only(left: 15, right: 15, top: 16, bottom: 16),
            decoration: const BoxDecoration(
                color: white,
                borderRadius: BorderRadius.all(Radius.circular(15))
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        toDisplayCase(listUserData[index].firstName ?? ""),
                        textAlign: TextAlign.start,
                        style: const TextStyle(fontSize: 16, color: black, fontWeight: FontWeight.bold),
                      ),
                      const Gap(10),
                      Text(
                        listUserData[index].email ?? "",
                        textAlign: TextAlign.start,
                        style: const TextStyle(fontSize: 14, color: black, fontWeight: FontWeight.bold),
                      ),
                      Visibility(
                        visible: listUserData[index].contactNo?.isNotEmpty ?? false,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            listUserData[index].contactNo ?? "",
                            textAlign: TextAlign.start,
                            style: const TextStyle(fontSize: 14, color: black, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(4),
                Visibility(
                  visible: listUserData[index].isLoading ?? false,
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(color: blue,),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<bool> _refresh() {
    return Future.value(true);
  }

  Future<void> getUserList(bool isFirstTime) async{
    if(isOnline)
    {

      if (isFirstTime)
      {
        setState(() {
          isLastPage = false;
          pageIndex = 1;
          isLoadingMore = false;
          isLoading = true;
        });
      }

      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(API_URL + userListAPI);

      Map<String, String> jsonBody = {
        'admin_id': sessionManager.getRMIDAdminId(),
        'page': pageIndex.toString(),
        'limit': pageResult.toString(),
        'onlyEstateAnalysis': "no",
        'onlySuperApp': "no",
        'onlyVaultUsers': "no",
        'search_string': searchText,
      };

      final response = await http.post(url, body: jsonBody);

      final statusCode = response.statusCode;
      final body = response.body;
      Map<String, dynamic> user = jsonDecode(body);
      var dataResponse = UserListResponseModel.fromJson(user);

      if (isFirstTime)
      {
        listUserData = [];
      }

      if(statusCode == 200 && dataResponse.success == 1)
      {
        try
        {
          List<Users>? _tempList = dataResponse.users ?? [];
          listUserData.addAll(_tempList);

          if (_tempList.isNotEmpty)
          {
            pageIndex += 1;
            if (_tempList.isEmpty || _tempList.length % pageResult != 0)
            {
              isLastPage = true;
            }
          }
        }
        catch(error)
        {
          print("display error : $error");
        }

        setState(() {
          isLoading = false;
          isLoadingMore = false;
        });
      }
      else
      {

      }

      setState(() {
        isLoading = false;
        isLoadingMore = false;
      });

    }
    else
    {
      noInterNet(context);
    }
  }

  // Future<void> makeLoginRequest(String firstName, String email, String userName, String contactNo, String panNo) async{
  Future<void> makeLoginRequest(Users getSet) async{

    setState(() {
      getSet.isLoading = true;
    });

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL+login);

    Map<String, String> jsonBody = {
      'first_name': getSet.firstName ?? "",
      'email': getSet.email ?? "",
      'username': getSet.userName ?? "",
      'phone_number': getSet.contactNo ?? "",
      'pan_no': '',
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = LoginResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {

      setState(() {
        getSet.isLoading = false;
      });

      try {
        sessionManagerPMS.setIsLoggedIn(true);
        await sessionManagerPMS.createLoginSession(
            dataResponse.portfolio?.userId ?? '',
            dataResponse.portfolio?.firstName ?? '',
            dataResponse.portfolio?.lastName ?? '',
            dataResponse.portfolio?.email ?? '',
            dataResponse.portfolio?.panNo ?? ''
        );

        JobService().getCommonXirr();
        JobService().getNetworthData();

        openPage();

      } catch (e) {
        print(e);
      }
    }
    else
    {
      if(mounted)
      {
        setState(() {
          getSet.isLoading = false;
        });
      }
    }

  }

  void openPage(){

    //Consolidated Portfolio
    if(isFor == "CP")
    {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const CPHomePage()));
    }
    //Financial Planning
    else if(isFor == "FP")
    {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const EStateAnalysisHomePage()),);
    }
    //Estate Vault
    else if(isFor == "EV")
    {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const EStateVaultHomePage()),);
    }
    else{}

  }

  @override
  void castStatefulWidget() {
    widget is RMIDUserSelectScreen;
  }
}
