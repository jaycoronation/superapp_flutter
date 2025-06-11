import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:superapp_flutter/constant/global_context.dart';
import 'package:superapp_flutter/model/UpdateDeviceTokenResponseModel.dart';
import 'package:superapp_flutter/screen/common/profile_page.dart';
import 'package:superapp_flutter/screen/common/rmid_user_select_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constant/colors.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/base_class.dart';
import '../../constant/api_end_point.dart';
import '../../constant/consolidate-portfolio/api_end_point.dart';
import '../../model/CommanResponse.dart';
import '../../utils/Utils.dart';
import '../../utils/session_manager_methods.dart';
import '../../widget/loading.dart';
import '../consolidated-portfolio/cp_home_page.dart';
import '../e-state-analysis/e_state_analysis_home_page.dart';
import '../e-state-valut/e_state_valut_home_page.dart';
import 'LoginScreen.dart';
import 'blogs_page.dart';
import 'contact_page.dart';
import 'meeting_page.dart';
import 'video_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage> {
  DateTime preBackPressTime = DateTime.now();
  bool _isLoading = false;

  String deviceName = '';
  String osVersion = '';

  int currentIndex = 0;
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();
  num isDisableConsolidatedPortfolio = 0;
  String userType = "";

  @override
  void initState() {
    super.initState();
    userType = sessionManager.getUserType();
    getDeviceData();
    getDeviceToken();
    print(
        "<><> SESS :: ${sessionManager.getUserId()} <><> ${sessionManagerPMS.getUserId()} <><> ${sessionManagerVault.getUserId()}");
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return WillPopScope(
        child: Scaffold(
          backgroundColor: chart_color11,
          appBar: AppBar(
            backgroundColor: chart_color11,
            elevation: 0,
            centerTitle: false,
            toolbarHeight: 66,
            title: Padding(
              padding: const EdgeInsets.only(left: 28, right: 32),
              child: Image.asset('assets/images/ic_logo.png', height: 40),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  logoutFromApp();
                },
                child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(right: 32),
                    // decoration: BoxDecoration(
                    //     border: currentIndex == 7 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                    //     color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                    // ),
                    child: Row(
                      children: [
                        Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(22)),
                              border: currentIndex == 8
                                  ? Border.all(color: blue, width: 1)
                                  : Border.all(
                                      width: 0, color: Colors.transparent),
                              color: chart_color12,
                            ),
                            child: Image.asset('assets/images/ic_logout.png',
                                width: 35, height: 35)),
                        Container(
                          width: 18,
                        ),
                        Text(
                          'Logout',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: currentIndex == 8 ? white : black,
                              fontSize: 18),
                        )
                      ],
                    )),
              ),
            ],
          ),
          body: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                    top: 18, bottom: 32, left: 32, right: 4),
                width: 310,
                height: MediaQuery.of(context).size.height,
                child: Material(
                  color: white,
                  shadowColor: Colors.grey,
                  shape: const RoundedRectangleBorder(
                      side: BorderSide(color: grayLight),
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  elevation: 10.0,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 12,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18),
                            child: Text(
                                'Hello, ${sessionManagerPMS.getFirstName()}!',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 22)),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                currentIndex = 0;
                              });
                            },
                            child: Container(
                                color: currentIndex == 0 ? blue : Colors.white,
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        border: currentIndex == 0
                                            ? Border.all(color: blue, width: 1)
                                            : Border.all(
                                                width: 0,
                                                color: Colors.transparent),
                                        color: currentIndex == 0
                                            ? listActionColor
                                            : chart_color12,

                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(22)),
                                        // border: currentIndex == 0 ? Border.all(color: blue, width: 1) : Border.all(width: 0, color: Colors.transparent),
                                        // color: chart_color12,
                                      ),
                                      child: currentIndex == 0
                                          ? Image.asset(
                                              'assets/images/ic_consolidated.png',
                                              width: 35,
                                              height: 35,
                                              color: white,
                                            )
                                          : Image.asset(
                                              'assets/images/ic_consolidated.png',
                                              width: 35,
                                              height: 35,
                                            ),
                                    ),
                                    Container(
                                      width: 18,
                                    ),
                                    Text(
                                      'Consolidated Portfolio',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color:
                                              currentIndex == 0 ? white : black,
                                          fontSize: 18),
                                    )
                                  ],
                                )),
                          ),
                          //Container(height: 18,),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                currentIndex = 1;
                              });
                            },
                            child: Container(
                                color: currentIndex == 1 ? blue : Colors.white,
                                padding: const EdgeInsets.all(12),
                                // decoration:  BoxDecoration(
                                //     border: currentIndex == 2 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                                //     color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                                // ),
                                child: Row(
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(22)),
                                          border: currentIndex == 1
                                              ? Border.all(
                                                  color: blue, width: 1)
                                              : Border.all(
                                                  width: 0,
                                                  color: Colors.transparent),
                                          color: currentIndex == 1
                                              ? listActionColor
                                              : chart_color12,
                                        ),
                                        child: currentIndex == 1
                                            ? Image.asset(
                                                'assets/images/ic_estate_a.png',
                                                width: 35,
                                                height: 35,
                                                color: white,
                                              )
                                            : Image.asset(
                                                'assets/images/ic_estate_a.png',
                                                width: 35,
                                                height: 35)),
                                    Container(
                                      width: 18,
                                    ),
                                    Text(
                                      'Estate Analysis',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color:
                                              currentIndex == 1 ? white : black,
                                          fontSize: 18),
                                    )
                                  ],
                                )),
                          ),
                          //Container(height: 18,),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                currentIndex = 2;
                              });
                            },
                            child: Container(
                                color: currentIndex == 2 ? blue : Colors.white,
                                padding: const EdgeInsets.all(12),
                                // decoration: BoxDecoration(
                                //     border: currentIndex == 3 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                                //     color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                                // ),
                                child: Row(
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(22)),
                                          border: currentIndex == 2
                                              ? Border.all(
                                                  color: blue, width: 1)
                                              : Border.all(
                                                  width: 0,
                                                  color: Colors.transparent),
                                          color: currentIndex == 2
                                              ? listActionColor
                                              : chart_color12,
                                        ),
                                        child: currentIndex == 2
                                            ? Image.asset(
                                                'assets/images/ic_vault.png',
                                                width: 35,
                                                height: 35,
                                                color: white,
                                              )
                                            : Image.asset(
                                                'assets/images/ic_vault.png',
                                                width: 35,
                                                height: 35)),
                                    Container(
                                      width: 18,
                                    ),
                                    Text(
                                      'Estate Vault',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color:
                                              currentIndex == 2 ? white : black,
                                          fontSize: 18),
                                    )
                                  ],
                                )),
                          ),
                          //Container(height: 18,),
                          GestureDetector(
                            onTap: () async {
                              final Uri url = Uri.parse(
                                  'https://alphacapital.coronation.in/calendly/index.html');
                              if (!await launchUrl(url)) {
                                throw Exception('Could not launch ');
                              }
                              setState(() {
                                currentIndex = 0;
                              });
                            },
                            child: Container(
                                color: currentIndex == 3 ? blue : Colors.white,
                                padding: const EdgeInsets.all(12),
                                // decoration:  BoxDecoration(
                                //     border: currentIndex == 4 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                                //     color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                                // ),
                                child: Row(
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(22)),
                                          border: currentIndex == 3
                                              ? Border.all(
                                                  color: blue, width: 1)
                                              : Border.all(
                                                  width: 0,
                                                  color: Colors.transparent),
                                          color: currentIndex == 3
                                              ? listActionColor
                                              : chart_color12,
                                        ),
                                        child: currentIndex == 3
                                            ? Image.asset(
                                                'assets/images/ic_meeting.png',
                                                width: 35,
                                                height: 35,
                                                color: white,
                                              )
                                            : Image.asset(
                                                'assets/images/ic_meeting.png',
                                                width: 35,
                                                height: 35)),
                                    Container(
                                      width: 18,
                                    ),
                                    Text(
                                      'Fix Meeting',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color:
                                              currentIndex == 3 ? white : black,
                                          fontSize: 18),
                                    )
                                  ],
                                )),
                          ),
                          //Container(height: 18,),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                currentIndex = 4;
                              });
                            },
                            child: Container(
                                color: currentIndex == 4 ? blue : Colors.white,
                                padding: const EdgeInsets.all(12),
                                // decoration: BoxDecoration(
                                //     border: currentIndex == 5 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                                //     color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                                // ),
                                child: Row(
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(22)),
                                          border: currentIndex == 4
                                              ? Border.all(
                                                  color: blue, width: 1)
                                              : Border.all(
                                                  width: 0,
                                                  color: Colors.transparent),
                                          color: currentIndex == 4
                                              ? listActionColor
                                              : chart_color12,
                                        ),
                                        child: currentIndex == 4
                                            ? Image.asset(
                                                'assets/images/ic_videos.png',
                                                width: 35,
                                                height: 35,
                                                color: white,
                                              )
                                            : Image.asset(
                                                'assets/images/ic_videos.png',
                                                width: 35,
                                                height: 35)),
                                    Container(
                                      width: 18,
                                    ),
                                    Text(
                                      'Videos',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color:
                                              currentIndex == 4 ? white : black,
                                          fontSize: 18),
                                    )
                                  ],
                                )),
                          ),
                          //Container(height: 18,),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                currentIndex = 5;
                              });
                            },
                            child: Container(
                                color: currentIndex == 5 ? blue : Colors.white,
                                padding: const EdgeInsets.all(12),
                                // decoration: BoxDecoration(
                                //     border: currentIndex == 6 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                                //     color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                                // ),
                                child: Row(
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(22)),
                                          border: currentIndex == 5
                                              ? Border.all(
                                                  color: blue, width: 1)
                                              : Border.all(
                                                  width: 0,
                                                  color: Colors.transparent),
                                          color: currentIndex == 5
                                              ? listActionColor
                                              : chart_color12,
                                        ),
                                        child: currentIndex == 5
                                            ? Image.asset(
                                                'assets/images/ic_blog.png',
                                                width: 35,
                                                height: 35,
                                                color: white,
                                              )
                                            : Image.asset(
                                                'assets/images/ic_blog.png',
                                                width: 35,
                                                height: 35)),
                                    Container(
                                      width: 18,
                                    ),
                                    Text(
                                      'Blogs',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color:
                                              currentIndex == 5 ? white : black,
                                          fontSize: 18),
                                    )
                                  ],
                                )),
                          ),
                          //Container(height: 18,),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                currentIndex = 6;
                              });
                            },
                            child: Container(
                                color: currentIndex == 6 ? blue : Colors.white,
                                padding: const EdgeInsets.all(12),
                                // decoration: BoxDecoration(
                                //     border: currentIndex == 7 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                                //     color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                                // ),
                                child: Row(
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(22)),
                                          border: currentIndex == 6
                                              ? Border.all(
                                                  color: blue, width: 1)
                                              : Border.all(
                                                  width: 0,
                                                  color: Colors.transparent),
                                          color: currentIndex == 6
                                              ? listActionColor
                                              : chart_color12,
                                        ),
                                        child: currentIndex == 6
                                            ? Image.asset(
                                                'assets/images/ic_contact.png',
                                                width: 35,
                                                height: 35,
                                                color: white,
                                              )
                                            : Image.asset(
                                                'assets/images/ic_contact.png',
                                                width: 35,
                                                height: 35)),
                                    Container(
                                      width: 18,
                                    ),
                                    Text(
                                      'Contact',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color:
                                              currentIndex == 6 ? white : black,
                                          fontSize: 18),
                                    )
                                  ],
                                )),
                          ),
                          //Container(height: 18,),
                        ],
                      )),
                ),
              ),
              Container(
                width: 22,
              ),
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  margin: const EdgeInsets.only(
                      top: 18, bottom: 32, left: 4, right: 32),
                  decoration: BoxDecoration(
                    border: Border.all(color: grayLight, width: 0.5),
                    color: white,
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Material(
                    shadowColor: Colors.grey,
                    shape: const RoundedRectangleBorder(
                        side: BorderSide(color: grayLight),
                        borderRadius: BorderRadius.all(Radius.circular(14))),
                    elevation: 10.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: IndexedStack(
                        index: currentIndex,
                        children: const [
                          CPHomePage(),
                          EStateAnalysisHomePage(),
                          EStateVaultHomePage(),
                          MeetingPage(),
                          VideoListPage(),
                          BlogsPage(),
                          ContactPage()
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        onWillPop: () {
          SystemNavigator.pop();
          return Future.value(true);
        },
      );
    } else {
      return WillPopScope(
        onWillPop: () {
          final timeGap = DateTime.now().difference(preBackPressTime);
          final cantExit = timeGap >= const Duration(seconds: 2);
          preBackPressTime = DateTime.now();
          if (cantExit) {
            showSnackBar('Press back button again to exit', context);
            return Future.value(false);
          } else {
            SystemNavigator.pop();
            return Future.value(true);
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: appBg,
          appBar: AppBar(
              toolbarHeight: 60,
              automaticallyImplyLeading: false,
              backgroundColor: appBg,
              elevation: 0,
              centerTitle: false,
              title: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      startActivity(context, const ProfilePage());
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(right: 8),
                      child: Image.asset('assets/images/ic_profile.png',
                          width: 40, height: 40),
                    ),
                  ),

                  Visibility(
                    visible: sessionManager.getUserType() == "client",
                    replacement: Expanded(
                        child: Text(
                          "Hi ${toDisplayCase(sessionManager.getRMIDName())}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 18, color: blue, fontWeight: FontWeight.w600),
                        )),
                    child: Expanded(
                        child: Text(
                          "Hi ${sessionManagerPMS.getFirstName()} ${sessionManagerPMS.getLastName()}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 18, color: blue, fontWeight: FontWeight.w600),
                        )),
                  ),

                  GestureDetector(
                    onTap: () {
                      logoutFromApp();
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 8),
                      child: Image.asset('assets/images/ic_logout.png',
                          width: 40, height: 40),
                    ),
                  )
                ],
              )),
          body: SafeArea(
            top: false,
            child: _isLoading
                ? const LoadingWidget()
                : Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: dashboardBg,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(22),
                            topRight: Radius.circular(22))),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          homePageBlocks(),
                          Container(
                            alignment: Alignment.center,
                            child: Image.asset(
                                'assets/images/ic_login_logo.png',
                                width: 200,
                                height: 80,
                                color: blue),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
          floatingActionButton: Container(
            margin: EdgeInsets.only(bottom: 22),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async {
                Uri url = Uri.parse(
                    'https://api.whatsapp.com/send/?phone=%2B917400066608&text&type=phone_number');
                if (await canLaunchUrl(url)) {
                  launchUrl(url,
                      mode: LaunchMode.externalNonBrowserApplication);
                } else {
                  print("NOT LAUCHING");
                }
              },
              child: Image.asset(
                'assets/images/ic_whatsapp.png',
                width: 50,
                height: 50,
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        ),
      );
    }
  }

  Widget homePageBlocks() {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Gap(10),
        Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                    child: InkWell(
                  onTap: () async {
                    // generateAuth('');

                    final result = await _checkNativeLibrary();
                    if (!result) {

                      if(sessionManager.getUserType() == "client")
                      {
                        // call SSOToken API
                        if (sessionManagerVault.getUserName().isNotEmpty)
                        {
                          generateAuth("");
                        }
                        else
                        {
                          showSnackBar("User name not found", context);
                        }
                      }
                      else
                      {
                        // call SSOToken API
                        if (sessionManager.getRMIUserName().isNotEmpty)
                        {
                          generateAuth("");
                        }
                        else
                        {
                          showSnackBar("User name not found", context);
                        }
                      }


                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 16, bottom: 16),
                    decoration: const BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/ic_portfolio.png',
                            width: 40, height: 40),
                        const Spacer(),
                        const Text(
                          "Alpha Portfolio",
                          maxLines: 2,
                          style: TextStyle(
                              color: black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                )),
                Visibility(
                    visible: isDisableConsolidatedPortfolio == 0,
                    child: const Gap(15)),
                Visibility(
                  visible: isDisableConsolidatedPortfolio == 0,
                  child: Expanded(
                      child: InkWell(
                    onTap: () async {

                      if(userType == "client")
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CPHomePage()));
                      }
                      else
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const RMIDUserSelectScreen("CP")));
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 15, bottom: 16, top: 16, right: 2),
                      decoration: const BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/ic_consolidated.png',
                              width: 40, height: 40),
                          const Spacer(),
                          const Text(
                            "Consolidated Portfolio",
                            maxLines: 2,
                            style: TextStyle(
                                color: black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  )),
                )
              ],
            )),
        const Gap(15),
        Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                    child: InkWell(
                  onTap: () {

                    if(userType == "client")
                    {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EStateAnalysisHomePage()),
                      );
                      lastInsertedModule("login-estate-analysis");
                    }
                    else
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const RMIDUserSelectScreen("FP")));
                    }

                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 16, bottom: 16),
                    decoration: const BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/ic_estate_a.png',
                            width: 40, height: 40),
                        const Spacer(),
                        const Text(
                          "Financial Planning",
                          maxLines: 2,
                          style: TextStyle(
                              color: black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                )),
                const Gap(15),
                Expanded(
                    child: InkWell(
                  onTap: () {

                    if(sessionManager.getUserType() == "client")
                    {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EStateVaultHomePage()),
                      );
                      lastInsertedModule("login-estate-vault");
                    }
                    else
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const RMIDUserSelectScreen("EV")));
                    }

                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 16, bottom: 16),
                    decoration: const BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/ic_vault.png',
                            width: 40, height: 40),
                        const Spacer(),
                        const Text(
                          "Estate Vault",
                          maxLines: 2,
                          style: TextStyle(
                              color: black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ))
              ],
            )),
        const Gap(15),
        /*Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const WebviewPage('https://www.alphacapital.in/investor_charter/')),);
                            },
                            child: Container(
                              padding: const EdgeInsets.only(left: 15,right: 15,top: 16,bottom: 16),
                              decoration: const BoxDecoration(color: white, borderRadius: BorderRadius.all(Radius.circular(15))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/images/ic_blog.png', width: 40, height: 40),
                                  const Spacer(),
                                  const Text("RIA Charter",
                                    maxLines: 2,
                                    style: TextStyle(color: black, fontSize: 18, fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                          )
                      ),
                      const Gap(15),
                      Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const ClientTaskListScreen()),);
                            },
                            child: Container(
                              padding: const EdgeInsets.only(left: 15,right: 15,top: 16,bottom: 16),
                              decoration: const BoxDecoration(color: white, borderRadius: BorderRadius.all(Radius.circular(15))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/images/ic_videos.png', width: 40, height: 40),
                                  const Spacer(),
                                  const Text("My Task",
                                    maxLines: 2,
                                    style: TextStyle(color: black, fontSize: 18, fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                          ))
                    ],
                  )
              ),
              const Gap(15),*/
        Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                    child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MeetingPage()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 16, bottom: 16),
                    decoration: const BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/ic_meeting.png',
                            width: 40, height: 40),
                        const Spacer(),
                        const Text(
                          "Fix Meeting",
                          maxLines: 2,
                          style: TextStyle(
                              color: black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                )),
                const Gap(15),
                Expanded(
                    child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ContactPage()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 16, bottom: 16),
                    decoration: const BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/ic_contact.png',
                            width: 40, height: 40),
                        const Spacer(),
                        const Text(
                          "Contact",
                          maxLines: 2,
                          style: TextStyle(
                              color: black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ))
              ],
            )),
        const Gap(15),
        Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                    child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BlogsPage()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 16, bottom: 16),
                    decoration: const BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/ic_blog.png',
                            width: 40, height: 40),
                        const Spacer(),
                        const Text(
                          "Blogs",
                          maxLines: 2,
                          style: TextStyle(
                              color: black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                )),
                const Gap(15),
                Expanded(
                    child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const VideoListPage()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 16, bottom: 16),
                    decoration: const BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/ic_videos.png',
                            width: 40, height: 40),
                        const Spacer(),
                        const Text(
                          "Videos",
                          maxLines: 2,
                          style: TextStyle(
                              color: black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ))
              ],
            )),
        const Gap(15),
      ],
    ));
  }

  Future<dynamic> generateAuth(String loginType) async {
    // Show progress indicator
    setState(() {
      //isLoading = true;
    });

    // API endpoint
    //final String url = "https://demo.investwell.app/api/aggregator/auth/getAuthorizationToken";
    final String url =
        "https://alphacapital.investwell.app/api/aggregator/auth/getAuthorizationToken";

    try {
      // Make POST request

      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      Map<String, String> jsonBody = {
        "authName": "alphacapitalapi",
        "password": "jdbvalrijb"
      };

      final urls = Uri.parse(url);
      final response = await http
          .post(urls, body: jsonBody, headers: {'User-Agent': "MintApp"});

      // Handle response
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        // Check response status
        if (jsonResponse['status'] == 0) {
          final result = jsonResponse['result'];
          final String token = result['token'];
          print('Success: ${jsonResponse.toString()}');
          // Call another function with token
          getAuthenticationKey(token, sessionManager.getUserType() == "client" ? "client"  : "broker");
        } else {
          print('Error: ${jsonResponse.toString()}');
          showSnackBar("Error: ${jsonResponse['message']}", context);
        }
      } else {
        showSnackBar("Error: ${response.reasonPhrase}", context);
        print('Success: ${response.reasonPhrase}');
      }
    } catch (error) {
      showSnackBar("Error: $error", context);
      print('Success: $error');
    } finally {
      // Hide progress indicator let me check sure
      setState(() {
        _isLoading = false;
      });
    }
  }

  Map<String, String> getParams(String token, String type) {
    Map<String, String> params = {
      "token": token,
      "username":
          type.isEmpty
              ? "alphacapital"
              :type == "client" ? sessionManagerVault.getUserName() : sessionManager.getRMIUserName()
    };

    return params;
  }

  Future<dynamic> getAuthenticationKey(String token, String type) async {
    // Show progress indicator
    setState(() {
      _isLoading = true;
    });

    // API endpoint
    final String url =
        "https://alphacapital.investwell.app/api/aggregator/auth/getAuthenticationKey";

    try {
      // Make POST request
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);
      final urls = Uri.parse(url);
      Map<String, String> jsonBody = getParams(token, type);
      final response = await http
          .post(urls, body: jsonBody, headers: {'User-Agent': "MintApp"});

      // Handle response
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        // Check response status
        if (jsonResponse['status'] == 0) {
          final result = jsonResponse['result'];
          final String SSOToken = result['SSOToken'];
          print(
              'Success 2 and openSDK: ${jsonResponse.toString()} === ${sessionManager.getDeviceToken()}');
          // invoke sdk
          //preprare jsonobject
          Map<String, String> jso = {
            'ssoToken': SSOToken,
            'fcmToken': '123',
            'domain': 'alphacapital'
          };
          print("jso == $jso");
          openMintLib(jso);
        } else {
          showSnackBar("Error: ${jsonResponse['message']}", context);
          print('Success: ${jsonResponse.toString()}');
        }
      } else {
        showSnackBar("Error: ${response.reasonPhrase}", context);
        print('Success: ${response.reasonPhrase}');
      }
    } catch (error) {
      showSnackBar("Error: $error", context);
      print('Success: $error');
    } finally {
      // Hide progress indicator
      setState(() {
        _isLoading = false;
      });
    }
  }

  void openMintLib(Map<String, String> jsonArray) async {
    try {
      if (Platform.isAndroid) {
        await MintUtils.platform.invokeMethod('openMintLib', jsonArray);
      } else {
        await MintUtils.platform.invokeMethod('openMintLibIOS', jsonArray);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void lastInsertedModule(String module) async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(module == 'login-estate-vault'
        ? API_URL_ADD_VAULT + add
        : API_URL_ADD + add);

    Map<String, String> jsonBody = {
      'module': module,
      'user_id': module == 'login-estate-vault'
          ? sessionManagerVault.getUserId().toString().trim()
          : sessionManager.getUserId().toString().trim(),
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = CommanResponse.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
    } else {}
  }

  Future<void> getDeviceToken() async {
    var fcmToken = await FirebaseMessaging.instance.getToken();
    sessionManager.setDeviceToken(fcmToken.toString());
    print("*************** $fcmToken");
    updateDeviceTokenData();
  }

  Future<void> getDeviceData() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      print('Running on ${androidInfo.model}'); // e.g. "Moto G (4)"
      deviceName = androidInfo.model;
      osVersion = androidInfo.version.release;
    } else {
      IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      deviceName = iosInfo.utsname.machine ?? '';
      osVersion = iosInfo.systemName;
    }
  }

  updateDeviceTokenData() async {
    // Show progress indicator
    setState(() {
      _isLoading = true;
    });

    try {
      // Make POST request
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      Map<String, String> jsonBody = {
        'user_id': sessionManager.getUserType() == "client" ? sessionManagerPMS.getUserId() : sessionManager.getRMIDAdminId(),
        'device_type': Platform.isAndroid ? 'android' : "IOS",
        'device_token': sessionManager.getDeviceToken(),
        'device_name': deviceName,
        'os_version': osVersion
      };

      final urls = Uri.parse(API_URL_CP + deviceTokenUpdateUrl);
      final response = await http.post(urls, body: jsonBody);
      final statusCode = response.statusCode;

      final body = response.body;
      Map<String, dynamic> user = jsonDecode(body);
      var dataResponse = UpdateDeviceTokenResponseModel.fromJson(user);

      if (statusCode == 200 && dataResponse.success == 1) {
        setState(() {
          isDisableConsolidatedPortfolio =
              dataResponse.disableConsolidatedPortfolio ?? 0;
        });
      } else {}
    } catch (error) {
      showSnackBar("Error: $error", context);
      print('Success: $error');
    } finally {
      // Hide progress indicator
      setState(() {
        _isLoading = false;
      });
    }
  }

  void logoutFromApp() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      builder: (BuildContext context) {
        return Wrap(
          children: [
            Container(
              margin: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
                  color: white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 2,
                    width: 40,
                    alignment: Alignment.center,
                    color: black,
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      child: const Text('Logout from Alpha Capital Super App',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: black))),
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 15),
                    child: const Text(
                        'Are you sure you want to logout from app?',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: black)),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 15, right: 15, bottom: 12, top: 20),
                    child: Row(
                      children: [
                        Expanded(
                            child: SizedBox(
                                height: kButtonHeight,
                                child: TextButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          side: const BorderSide(
                                              width: 1, color: blue),
                                          borderRadius: BorderRadius.circular(
                                              kBorderRadius),
                                        ),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              white)),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("No",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: blue)),
                                ))),
                        const Gap(20),
                        Expanded(
                          child: SizedBox(
                            height: kButtonHeight,
                            child: TextButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(kBorderRadius),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(blue)),
                              onPressed: () {
                                Navigator.pop(context);
                                SessionManagerMethods.clear();
                                _clearMintSDKData();
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreenNew()),
                                    (Route<dynamic> route) => false);
                              },
                              child: const Text("Yes",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: white)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(30)
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  //  add this class member function for check is available session or not
  // note in case of available session mint  will return true and will open the respective user logedin
  Future<bool> _checkNativeLibrary() async {
    try {
      final result = await MintUtils.platform.invokeMethod('isValidAuth');
      return result as bool;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  // note while app is logging-out call this function _clearMintSDKData
  Future<void> _clearMintSDKData() async {
    try {
      if (Platform.isAndroid) {
        await MintUtils.platform.invokeMethod('clearSession');
      } else {
        await MintUtils.platform.invokeMethod('clearSessionIos');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  /*updateDeviceTokenData() async {
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(API_URL + updateDeviceToken);

      var deviceType = "";
      if (Platform.isIOS) {
        deviceType = "IOS";
      } else {
        deviceType = "Android";
      }

      Map<String, String> jsonBody = {
        'logged_in_master_user_id': sessionManager.getMasterUserId().toString(),
        'device_type': deviceType,
        'token_id': sessionManager.getDeviceToken().toString().trim()
      };

      final response = await http.post(url, body: jsonBody, headers: {
        "Authorization": sessionManager.getAuthToken().toString().trim(),
      });

      final statusCode = response.statusCode;
      final body = response.body;
      Map<String, dynamic> apiResponse = jsonDecode(body);
      var dataResponse = CommanResponse.fromJson(apiResponse);
      if (statusCode == 200 && dataResponse.success == 1) {
      } else {}
    }*/

  @override
  void castStatefulWidget() {
    widget is HomePage;
  }
}
