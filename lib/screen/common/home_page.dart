import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/screen/common/profile_page.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constant/colors.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/base_class.dart';
import '../../constant/api_end_point.dart';
import '../../model/CommanResponse.dart';
import '../../utils/session_manager_methods.dart';
import '../../widget/loading.dart';
import '../consolidated-portfolio/cp_home_page.dart';
import '../e-state-analysis/e_state_analysis_home_page.dart';
import '../e-state-valut/e_state_valut_home_page.dart';
import 'LoginScreen.dart';
import 'blogs_page.dart';
import 'contact_page.dart';
import 'login_screen.dart';
import 'meeting_page.dart';
import 'video_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage> {
  DateTime preBackPressTime = DateTime.now();
  final bool _isLoading = false;


  @override
  void initState() {
    super.initState();
    print("<><> SESS :: ${sessionManager.getUserId()} <><> ${sessionManagerPMS.getUserId()} <><> ${sessionManagerVault.getUserId()}");
  }

  @override
  Widget build(BuildContext context) {
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
                    child: Image.asset('assets/images/ic_profile.png', width: 40, height: 40),
                  ),
                ),
                Expanded(
                    child: Text(
                    "Hi ${sessionManagerPMS.getFirstName()} ${sessionManagerPMS.getLastName()}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18, color: blue, fontWeight: FontWeight.w600),
                  )
                ),
                GestureDetector(
                  onTap: () {
                    logoutFromApp();
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 8),
                    child: Image.asset('assets/images/ic_logout.png', width: 40, height: 40),
                  ),
                )
              ],
            )
        ),
        body: SafeArea(
          top: false,
          child: _isLoading
              ? const LoadingWidget()
              : Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: dashboardBg,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(22), topRight: Radius.circular(22))
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      homePageBlocks(),
                      Container(
                        alignment: Alignment.center,
                        child: Image.asset('assets/images/ic_login_logo.png', width: 200, height: 80, color: blue),
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
              Uri url = Uri.parse('https://api.whatsapp.com/send/?phone=%2B917400066608&text&type=phone_number');
              if (await canLaunchUrl(url))
                {
                  launchUrl(url,mode: LaunchMode.externalNonBrowserApplication);
                }
              else
                {
                  print("NOT LAUCHING");
                }
            },
            child: Image.asset('assets/images/ic_whatsapp.png',width: 50,height: 50,),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
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
                        child: Container(
                          padding: const EdgeInsets.only(left: 15,right: 15,top: 16,bottom: 16),
                          decoration: const BoxDecoration(color: white, borderRadius: BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/ic_portfolio.png', width: 40, height: 40),
                              const Spacer(),
                              const Text(
                                "Alpha Portfolio",
                                maxLines: 2,
                                style: TextStyle(color: black, fontSize: 18, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        )
                    ),
                    const Gap(15),
                    Expanded(
                        child: InkWell(
                          onTap: () async {
                             Navigator.push(context, MaterialPageRoute(builder: (context) => const CPHomePage()));
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 15, bottom: 16, top: 16, right: 2),
                            decoration: const BoxDecoration(color: white, borderRadius: BorderRadius.all(Radius.circular(15))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/ic_consolidated.png', width: 40, height: 40),
                                const Spacer(),
                                const Text(
                                  "Consolidated Portfolio",
                                  maxLines: 2,
                                  style: TextStyle(color: black, fontSize: 18, fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        )
                    )
                  ],
                )
            ),
            const Gap(15),
            Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const EStateAnalysisHomePage()),);
                            lastInsertedModule("login-estate-analysis");
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 15,right: 15,top: 16,bottom: 16),
                            decoration: const BoxDecoration(color: white, borderRadius: BorderRadius.all(Radius.circular(15))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/ic_estate_a.png', width: 40, height: 40),
                                const Spacer(),
                                const Text(
                                  "Financial Planning",
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
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const EStateVaultHomePage()),);
                            lastInsertedModule("login-estate-vault");
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 15,right: 15,top: 16,bottom: 16),
                            decoration: const BoxDecoration(color: white, borderRadius: BorderRadius.all(Radius.circular(15))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/ic_vault.png', width: 40, height: 40),
                                const Spacer(),
                                const Text(
                                  "Estate Vault",
                                  maxLines: 2,
                                  style: TextStyle(color: black, fontSize: 18, fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        )
                    )
                  ],
                )
            ),
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const MeetingPage()),);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 15,right: 15,top: 16,bottom: 16),
                            decoration: const BoxDecoration(color: white, borderRadius: BorderRadius.all(Radius.circular(15))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/ic_meeting.png', width: 40, height: 40),
                                const Spacer(),
                                const Text(
                                  "Fix Meeting",
                                  maxLines: 2,
                                  style: TextStyle(color: black, fontSize: 18, fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        )),
                    const Gap(15),
                    Expanded(
                        child: InkWell(
                          onTap: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactPage()),);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 15,right: 15,top: 16,bottom: 16),
                            decoration: const BoxDecoration(color: white, borderRadius: BorderRadius.all(Radius.circular(15))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/ic_contact.png', width: 40, height: 40),
                                const Spacer(),
                                const Text(
                                  "Contact",
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
            const Gap(15),
            Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const BlogsPage()),);
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
                                const Text("Blogs",
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const VideoListPage()),);
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
                                const Text("Videos",
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
            const Gap(15),
          ],
        )
    );
  }

  void lastInsertedModule(String module) async {

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(module == 'login-estate-vault' ? API_URL_ADD_VAULT + add : API_URL_ADD + add);

    Map<String, String> jsonBody = {
      'module': module,
      'user_id': module == 'login-estate-vault' ? sessionManagerVault.getUserId().toString().trim() : sessionManager.getUserId().toString().trim(),
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = CommanResponse.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {

    } else {

    }
  }

  Future<void> getDeviceToken() async {
    var fcmToken = await FirebaseMessaging.instance.getToken();
    sessionManager.setDeviceToken(fcmToken.toString());
    print("*************** $fcmToken");
    if (sessionManager.getDeviceToken().toString().trim().isNotEmpty) {
      // updateDeviceTokenData();
    }
  }

  void logoutFromApp() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      builder: (BuildContext context) {
        return Wrap(
          children: [
            Container(
              margin: const EdgeInsets.all(15),
              decoration:
                  const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)), color: white),
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
                      child: const Text('Logout from Alpha Capital Super App', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: black))),
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 15),
                    child: const Text('Are you sure you want to logout from app?',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: black)),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15, bottom: 12, top: 20),
                    child: Row(
                      children: [
                        Expanded(
                            child: SizedBox(
                                height: kButtonHeight,
                                child: TextButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          side: const BorderSide(width: 1, color: blue),
                                          borderRadius: BorderRadius.circular(kBorderRadius),
                                        ),
                                      ),
                                      backgroundColor: MaterialStateProperty.all<Color>(white)),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("No", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: blue)),
                                )
                            )
                        ),
                        const Gap(20),
                        Expanded(
                          child: SizedBox(
                            height: kButtonHeight,
                            child: TextButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(kBorderRadius),
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all<Color>(blue)),
                              onPressed: () {
                                Navigator.pop(context);
                                SessionManagerMethods.clear();
                                Navigator.pushAndRemoveUntil(
                                    context, MaterialPageRoute(builder: (context) => const LoginScreenNew()), (Route<dynamic> route) => false);
                              },
                              child: const Text("Yes", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: white)),
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
