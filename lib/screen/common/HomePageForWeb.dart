import 'dart:convert';

import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/screen/common/video_list_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constant/api_end_point.dart';
import '../../constant/colors.dart';
import '../../model/CommanResponse.dart';
import '../../utils/base_class.dart';
import '../../utils/session_manager_methods.dart';
import '../consolidated-portfolio/cp_home_page.dart';
import '../e-state-analysis/e_state_analysis_home_page.dart';
import '../e-state-valut/e_state_valut_home_page.dart';
import 'LoginScreen.dart';
import 'blogs_page.dart';
import 'contact_page.dart';
import 'meeting_page.dart';

class HomePageForWeb extends StatefulWidget {
  const HomePageForWeb({Key? key}) : super(key: key);

  @override
  BaseState<HomePageForWeb> createState() => _HomePageForWebState();
}

class _HomePageForWebState extends BaseState<HomePageForWeb> {
  int currentIndex = 0;
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();

  @override
  void initState() {
    sideMenu.addListener((index) {
      print("index === $index");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: appBg,
      statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      statusBarBrightness: Brightness.dark,
    ));

    return WillPopScope(
          child: Scaffold(
            backgroundColor: chart_color11,
            appBar: AppBar(
              backgroundColor: chart_color11,
              elevation: 0,
              centerTitle: false,
              toolbarHeight: 66,
              title: Padding(
                padding: const EdgeInsets.only( left: 28, right: 32),
                child: Image.asset('assets/images/ic_logo.png',  height: 40),
              ),
              actions: [
                GestureDetector(
                  onTap: (){
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
                                borderRadius: const BorderRadius.all(Radius.circular(22)),
                                border: currentIndex == 8 ? Border.all(color: blue, width: 1) : Border.all(width: 0, color: Colors.transparent),
                                color: chart_color12,
                              ),
                              child: Image.asset('assets/images/ic_logout.png', width: 35, height: 35)
                          ),
                          Container(width: 18,),
                          Text('Logout', style: TextStyle(fontWeight: FontWeight.w500, color: currentIndex == 8 ?white : black, fontSize: 18),
                          )
                        ],
                      )
                  ),
                ),
              ],
            ),
            body: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 18, bottom: 32, left: 32, right: 4),
                  width: 310,
                  height: MediaQuery.of(context).size.height,
                  child: Material(
                    color: white,
                    shadowColor: Colors.grey,
                    shape: const RoundedRectangleBorder(
                        side:  BorderSide(color: grayLight),
                        borderRadius: BorderRadius.all( Radius.circular(12))
                    ),
                    elevation: 10.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(height: 12,),
                          Padding(
                            padding: const EdgeInsets.all(18),
                            child: Text('Hello, ${sessionManagerPMS.getFirstName()}!', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 22)),
                          ),
                          GestureDetector(
                            onTap: (){
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
                                          border: currentIndex == 0 ? Border.all(color: blue, width: 1) : Border.all(width: 0, color: Colors.transparent),
                                          color: currentIndex == 0 ? listActionColor : chart_color12,

                                          borderRadius: const BorderRadius.all(Radius.circular(22)),
                                          // border: currentIndex == 0 ? Border.all(color: blue, width: 1) : Border.all(width: 0, color: Colors.transparent),
                                          // color: chart_color12,
                                        ),
                                      child: currentIndex == 0
                                          ? Image.asset('assets/images/ic_consolidated.png', width: 35, height: 35, color: white,)
                                          : Image.asset('assets/images/ic_consolidated.png', width: 35, height: 35, ) ,
                                    ),
                                    Container(width: 18,),
                                    Text('Consolidated Portfolio', style: TextStyle(fontWeight: FontWeight.w500, color: currentIndex == 0 ? white : black, fontSize: 18),
                                    )],
                                )
                            ),
                          ),
                          //Container(height: 18,),
                          GestureDetector(
                            onTap: (){
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
                                          borderRadius: const BorderRadius.all(Radius.circular(22)),
                                          border: currentIndex == 1 ? Border.all(color: blue, width: 1) : Border.all(width: 0, color: Colors.transparent),
                                          color: currentIndex == 1 ? listActionColor : chart_color12,
                                        ),
                                        child: currentIndex == 1
                                          ? Image.asset('assets/images/ic_estate_a.png', width: 35, height: 35, color: white,)
                                          : Image.asset('assets/images/ic_estate_a.png', width: 35, height: 35)
                                    ),
                                    Container(width: 18,),
                                    Text('Estate Analysis', style: TextStyle(fontWeight: FontWeight.w500, color: currentIndex == 1 ?white : black, fontSize: 18),
                                    )],
                                )
                            ),
                          ),
                          //Container(height: 18,),
                          GestureDetector(
                            onTap: (){
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
                                          borderRadius: const BorderRadius.all(Radius.circular(22)),
                                          border: currentIndex == 2 ? Border.all(color: blue, width: 1) : Border.all(width: 0, color: Colors.transparent),
                                          color: currentIndex == 2 ? listActionColor : chart_color12,
                                        ),
                                        child: currentIndex == 2
                                            ? Image.asset('assets/images/ic_vault.png', width: 35, height: 35, color: white,)
                                            : Image.asset('assets/images/ic_vault.png', width: 35, height: 35)
                                    ),
                                    Container(width: 18,),
                                    Text('Estate Vault', style: TextStyle(fontWeight: FontWeight.w500,color: currentIndex == 2 ? white : black, fontSize: 18),
                                    )],
                                )
                            ),
                          ),
                          //Container(height: 18,),
                          GestureDetector(
                            onTap: () async {
                              final Uri url = Uri.parse('https://alphacapital.coronation.in/calendly/index.html');
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
                                          borderRadius: const BorderRadius.all(Radius.circular(22)),
                                          border: currentIndex == 3 ? Border.all(color: blue, width: 1) : Border.all(width: 0, color: Colors.transparent),
                                          color: currentIndex == 3 ? listActionColor : chart_color12,
                                        ),
                                        child:   currentIndex == 3
                                        ? Image.asset('assets/images/ic_meeting.png', width: 35, height: 35, color: white,)
                                        : Image.asset('assets/images/ic_meeting.png', width: 35, height: 35)
                                    ),
                                    Container(width: 18,),
                                    Text('Fix Meeting', style: TextStyle(fontWeight: FontWeight.w500,color: currentIndex == 3 ? white : black, fontSize: 18),
                                    )
                                  ],
                                )
                            ),
                          ),
                          //Container(height: 18,),
                          GestureDetector(
                            onTap: (){
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
                                          borderRadius: const BorderRadius.all(Radius.circular(22)),
                                          border: currentIndex == 4 ? Border.all(color: blue, width: 1) : Border.all(width: 0, color: Colors.transparent),
                                          color: currentIndex == 4 ? listActionColor : chart_color12,
                                        ),
                                        child:  currentIndex == 4
                                            ? Image.asset('assets/images/ic_videos.png', width: 35, height: 35, color: white,)
                                            : Image.asset('assets/images/ic_videos.png', width: 35, height: 35)
                                    ),
                                    Container(width: 18,),
                                    Text('Videos', style: TextStyle(fontWeight: FontWeight.w500, color: currentIndex == 4 ?white : black, fontSize: 18),
                                    )
                                  ],
                                )
                            ),
                          ),
                          //Container(height: 18,),
                          GestureDetector(
                            onTap: (){
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
                                          borderRadius: const BorderRadius.all(Radius.circular(22)),
                                          border: currentIndex == 5 ? Border.all(color: blue, width: 1) : Border.all(width: 0, color: Colors.transparent),
                                          color: currentIndex == 5 ? listActionColor : chart_color12,
                                        ),
                                        child: currentIndex == 5
                                            ? Image.asset('assets/images/ic_blog.png', width: 35, height: 35,color: white,)
                                            : Image.asset('assets/images/ic_blog.png', width: 35, height: 35)
                                    ),
                                    Container(width: 18,),
                                    Text('Blogs', style: TextStyle(fontWeight: FontWeight.w500, color: currentIndex == 5 ?white : black, fontSize: 18),
                                    )
                                  ],
                                )
                            ),
                          ),
                          //Container(height: 18,),
                          GestureDetector(
                            onTap: (){
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
                                          borderRadius: const BorderRadius.all(Radius.circular(22)),
                                          border: currentIndex == 6 ? Border.all(color: blue, width: 1) : Border.all(width: 0, color: Colors.transparent),
                                          color: currentIndex == 6 ? listActionColor : chart_color12,
                                        ),
                                        child: currentIndex == 6
                                              ? Image.asset('assets/images/ic_contact.png', width: 35, height: 35, color: white,)
                                              : Image.asset('assets/images/ic_contact.png', width: 35, height: 35)
                                    ),
                                    Container(width: 18,),
                                    Text('Contact', style: TextStyle(fontWeight: FontWeight.w500, color: currentIndex == 6 ?white : black, fontSize: 18),
                                    )
                                  ],
                                )
                            ),
                          ),
                          //Container(height: 18,),

                        ],
                      )
                    ),
                  ),
                ),
                Container(width: 22,),
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    margin: const EdgeInsets.only(top: 18, bottom: 32, left: 4, right: 32),
                    decoration: BoxDecoration(
                      border:Border.all(color: grayLight, width: 0.5 ),
                      color: white,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Material(
                      shadowColor: Colors.grey,
                      shape: const RoundedRectangleBorder(
                          side:  BorderSide(color: grayLight),
                          borderRadius: BorderRadius.all( Radius.circular(14))
                      ),
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
  }

  void lastInsertedModule(String module) async {

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_ADD + add);

    Map<String, String> jsonBody = {
      'module':"",
      'user_id':sessionManagerPMS.getUserId().toString().trim(),
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

  void logoutFromApp() {
    showModalBottomSheet<void>(
      constraints: BoxConstraints(
        maxWidth: 600,
      ),
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
                      child: const Text('Logout from AlphaCapital Super App', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: black))),
                 Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 15),
                    child: const Text('Are you sure you want to logout from app?',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: black)),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 200, right: 200, bottom: 12, top: 20),
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
                                backgroundColor: MaterialStateProperty.all<Color>(white)
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("No", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: blue)),
                            )
                          )
                        ),
                        const Gap(60),
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

  @override
  void castStatefulWidget() {
    widget is HomePageForWeb;
  }


}