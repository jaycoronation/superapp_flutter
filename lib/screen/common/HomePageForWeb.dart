import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:superapp/screen/common/video_list_page.dart';

import '../../constant/colors.dart';
import '../../utils/base_class.dart';
import '../../utils/responsive.dart';
import '../../utils/session_manager_methods.dart';
import '../consolidated-portfolio/cp_home_page.dart';
import '../e-state-analysis/e_state_analysis_home_page.dart';
import '../e-state-valut/e_state_valut_home_page.dart';
import 'blogs_page.dart';
import 'contact_page.dart';
import 'login_screen.dart';
import 'meeting_page.dart';

class HomePageForWeb extends StatefulWidget {
  const HomePageForWeb({Key? key}) : super(key: key);

  @override
  _HomePageForWebState createState() => _HomePageForWebState();
}

class _HomePageForWebState extends BaseState<HomePageForWeb> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    return ResponsiveWidget.isSmallScreen(context)
        ? WillPopScope(
      child: Scaffold(
        backgroundColor: chart_color11,
        body: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 310,
                height: MediaQuery.of(context).size.height -120,
                child: Material(
                  color: white,
                  shape: const RoundedRectangleBorder(
                      side:  BorderSide(color: grayLight),
                      borderRadius: BorderRadius.all( Radius.circular(14))
                  ),
                  elevation: 15.0,
                  child: SingleChildScrollView(
                    child: Material(
                      type: MaterialType.transparency,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(height: 12,),
                          Padding(
                            padding: const EdgeInsets.all(18),
                            child: Text('Hello, ${sessionManagerPMS.getFristName()}!', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 22)),
                          ),
                          InkWell(
                            hoverColor: Colors.lightBlue,
                            mouseCursor: MaterialStateMouseCursor.clickable,
                            canRequestFocus: true,
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
                                          borderRadius: const BorderRadius.all(Radius.circular(22)),
                                          border: currentIndex == 0 ? Border.all(color: blue, width: 1) : Border.all(width: 0, color: Colors.transparent),
                                          color: chart_color12,
                                        ),
                                        child: Image.asset('assets/images/ic_portfolio.png', width: 35, height: 35)
                                    ),
                                    Container(width: 18,),
                                    Text('Alpha Portfolio',
                                      style: TextStyle(fontWeight: FontWeight.w500, color: currentIndex == 0 ?white : black, fontSize: 18),
                                    )
                                  ],
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
                                //     border: currentIndex == 1 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                                //     color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                                // ),
                                child: Row(
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(Radius.circular(22)),
                                          border: currentIndex == 1 ? Border.all(color: blue, width: 1) : Border.all(width: 0, color: Colors.transparent),
                                          color: chart_color12,
                                        ),
                                        child: Image.asset('assets/images/ic_consolidated.png', width: 35, height: 35)
                                    ),
                                    Container(width: 18,),
                                    Text('Consolidated Portfolio', style: TextStyle(fontWeight: FontWeight.w500, color: currentIndex == 1 ?white : black, fontSize: 18),
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
                                          border: currentIndex == 2 ? Border.all(color: blue, width: 1) : Border.all(width: 0, color: Colors.transparent),
                                          color: chart_color12,
                                        ),
                                        child: Image.asset('assets/images/ic_estate_a.png', width: 35, height: 35)
                                    ),
                                    Container(width: 18,),
                                    Text('Estate Analysis', style: TextStyle(fontWeight: FontWeight.w500, color: currentIndex == 2 ?white : black, fontSize: 18),
                                    )],
                                )
                            ),
                          ),
                          //Container(height: 18,),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                currentIndex = 3;
                              });
                            },
                            child: Container(
                                color: currentIndex == 3 ? blue : Colors.white,
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
                                          border: currentIndex == 3 ? Border.all(color: blue, width: 1) : Border.all(width: 0, color: Colors.transparent),
                                          color: chart_color12,
                                        ),
                                        child: Image.asset('assets/images/ic_vault.png', width: 35, height: 35)
                                    ),
                                    Container(width: 18,),
                                    Text('Estate Vault', style: TextStyle(fontWeight: FontWeight.w500,color: currentIndex == 3 ?white : black, fontSize: 18),
                                    )],
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
                                // decoration:  BoxDecoration(
                                //     border: currentIndex == 4 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                                //     color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                                // ),
                                child: Row(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(22)),
                                          border: currentIndex == 4 ? Border.all(color: blue, width: 1) : Border.all(width: 0, color: Colors.transparent),
                                          color: chart_color12,
                                        ),
                                        child: Image.asset('assets/images/ic_meeting.png', width: 35, height: 35)
                                    ),
                                    Container(width: 18,),
                                    Text('Fix Meeting', style: TextStyle(fontWeight: FontWeight.w500,color: currentIndex == 4 ?white : black, fontSize: 18),
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
                                //     border: currentIndex == 5 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                                //     color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                                // ),
                                child: Row(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(22)),
                                          border: currentIndex == 5 ? Border.all(color: blue, width: 1) : Border.all(width: 0, color: Colors.transparent),
                                          color: chart_color12,
                                        ),
                                        child: Image.asset('assets/images/ic_videos.png', width: 35, height: 35)
                                    ),
                                    Container(width: 18,),
                                    Text('Videos', style: TextStyle(fontWeight: FontWeight.w500, color: currentIndex == 5 ?white : black, fontSize: 18),
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
                                //     border: currentIndex == 6 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                                //     color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                                // ),
                                child: Row(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(22)),
                                          border: currentIndex == 6 ? Border.all(color: blue, width: 1) : Border.all(width: 0, color: Colors.transparent),
                                          color: chart_color12,
                                        ),
                                        child: Image.asset('assets/images/ic_blog.png', width: 35, height: 35)
                                    ),
                                    Container(width: 18,),
                                    Text('Blogs', style: TextStyle(fontWeight: FontWeight.w500, color: currentIndex == 6 ?white : black, fontSize: 18),
                                    )
                                  ],
                                )
                            ),
                          ),
                          //Container(height: 18,),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                currentIndex = 7;
                              });
                            },
                            child: Container(
                                color: currentIndex == 7 ? blue : Colors.white,
                                padding: const EdgeInsets.all(12),
                                // decoration: BoxDecoration(
                                //     border: currentIndex == 7 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                                //     color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                                // ),
                                child: Row(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(22)),
                                          border: currentIndex == 7 ? Border.all(color: blue, width: 1) : Border.all(width: 0, color: Colors.transparent),
                                          color: chart_color12,
                                        ),
                                        child: Image.asset('assets/images/ic_contact.png', width: 35, height: 35)
                                    ),
                                    Container(width: 18,),
                                    Text('Contact', style: TextStyle(fontWeight: FontWeight.w500, color: currentIndex == 7 ?white : black, fontSize: 18),
                                    )
                                  ],
                                )
                            ),
                          ),
                          //Container(height: 18,),
                          GestureDetector(
                            onTap: (){
                              logoutFromApp();
                            },
                            child: Container(
                                color: currentIndex == 8 ? blue : Colors.white,
                                padding: const EdgeInsets.all(12),
                                // decoration: BoxDecoration(
                                //     border: currentIndex == 7 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                                //     color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                                // ),
                                child: Row(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(22)),
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
                    ),
                  ),
                ),
              ),
            ),
            Container(width: 22,),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height -120,
                margin: const EdgeInsets.only(top: 12, bottom: 12),
                decoration: BoxDecoration(
                  border:Border.all(color: grayLight, width: 0.5 ),
                  color: white,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2.0,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: currentIndex == 0
                      ? Container()
                      : currentIndex == 1
                      ? const CPHomePage()
                      : currentIndex == 2
                      ? const EStateAnalysisHomePage()
                      :currentIndex == 3
                      ? const EStateVaultHomePage()
                      :currentIndex == 4
                      ? const MeetingPage()
                      :currentIndex == 5
                      ? const VideoListPage()
                      :currentIndex == 6
                      ? const BlogsPage()
                      :currentIndex == 7
                      ? const ContactPage()
                      : Container(),
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
    )
        : WillPopScope(
      child: Scaffold(
        backgroundColor: chart_color11,
        body: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 310,
                height: MediaQuery.of(context).size.height -165,
                child: Material(
                  color: white,
                  shadowColor: Colors.grey,
                  shape: const RoundedRectangleBorder(
                      side:  BorderSide(color: grayLight),
                      borderRadius: BorderRadius.all( Radius.circular(14))
                  ),
                  elevation: 15.0,
                  child: SingleChildScrollView(
                    child: Material(
                      type: MaterialType.transparency,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(height: 12,),
                          Padding(
                            padding: const EdgeInsets.only(top: 18, bottom: 18, left: 32),
                            child: Text('Hello, ${sessionManagerPMS.getFristName()}!', style: const TextStyle(fontWeight: FontWeight.w800, color: Colors.black, fontSize: 22)),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                currentIndex = 0;
                              });
                            },
                            child: Container(
                                color: currentIndex == 0 ? blue : Colors.white,
                                padding: const EdgeInsets.only(top: 12, bottom: 12, left: 32),
                                child: Row(
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(Radius.circular(22)),
                                          border: currentIndex == 0 ? Border.all(color: blue, width: 1) : Border.all(width: 0, color: Colors.transparent),
                                          color: currentIndex == 0 ? listActionColor : chart_color12,
                                        ),
                                        child: currentIndex == 0
                                            ? Image.asset('assets/images/ic_portfolio.png', width: 35, height: 35, color: white, )
                                            : Image.asset('assets/images/ic_portfolio.png', width: 35, height: 35, ),
                                    ),
                                    Container(width: 18,),
                                    Text('Alpha Portfolio',
                                      style: TextStyle(fontWeight: FontWeight.w500, color: currentIndex == 0 ?white : black, fontSize: 18),
                                    )
                                  ],
                                )
                            ),
                          ),
                          Container(height: 8,),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                currentIndex = 1;
                              });
                            },
                            child: Container(
                                color: currentIndex == 1 ? blue : Colors.white,
                                padding: const EdgeInsets.only(top: 12, bottom: 12, left: 32),
                                // decoration:  BoxDecoration(
                                //     border: currentIndex == 1 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
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
                                            ? Image.asset('assets/images/ic_consolidated.png', width: 35, height: 35, color: white,)
                                            : Image.asset('assets/images/ic_consolidated.png', width: 35, height: 35),
                                    ),
                                    Container(width: 18,),
                                    Text('Consolidated Portfolio', style: TextStyle(fontWeight: FontWeight.w500, color: currentIndex == 1 ?white : black, fontSize: 18),
                                    )],
                                )
                            ),
                          ),
                          Container(height: 8,),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                currentIndex = 2;
                              });
                            },
                            child: Container(
                                color: currentIndex == 2 ? blue : Colors.white,
                                padding: const EdgeInsets.only(top: 12, bottom: 12, left: 32),
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
                                          border: currentIndex == 2 ? Border.all(color: blue, width: 1) : Border.all(width: 0, color: Colors.transparent),
                                          color: currentIndex == 2 ? listActionColor : chart_color12,

                                        ),
                                        child: currentIndex == 2
                                            ? Image.asset('assets/images/ic_estate_a.png', width: 35, height: 35, color: white,)
                                            : Image.asset('assets/images/ic_estate_a.png', width: 35, height: 35)
                                    ),
                                    Container(width: 18,),
                                    Text('Estate Analysis', style: TextStyle(fontWeight: FontWeight.w500, color: currentIndex == 2 ?white : black, fontSize: 18),
                                    )],
                                )
                            ),
                          ),
                          Container(height: 8,),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                currentIndex = 3;
                              });
                            },
                            child: Container(
                                color: currentIndex == 3 ? blue : Colors.white,
                                padding: const EdgeInsets.only(top: 12, bottom: 12, left: 32),
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
                                          border: currentIndex == 3 ? Border.all(color: blue, width: 1) : Border.all(width: 0, color: Colors.transparent),
                                          color: currentIndex == 3 ? listActionColor : chart_color12,
                                        ),
                                        child: currentIndex == 3
                                            ? Image.asset('assets/images/ic_vault.png', width: 35, height: 35, color: white,)
                                            : Image.asset('assets/images/ic_vault.png', width: 35, height: 35),
                                    ),
                                    Container(width: 18,),
                                    Text('Estate Vault', style: TextStyle(fontWeight: FontWeight.w500,color: currentIndex == 3 ?white : black, fontSize: 18),
                                    )],
                                )
                            ),
                          ),
                          Container(height: 8,),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                currentIndex = 4;
                              });
                            },
                            child: Container(
                                color: currentIndex == 4 ? blue : Colors.white,
                                padding: const EdgeInsets.only(top: 12, bottom: 12, left: 32),
                                // decoration:  BoxDecoration(
                                //     border: currentIndex == 4 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                                //     color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                                // ),
                                child: Row(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(22)),
                                          border: currentIndex == 4 ? Border.all(color: blue, width: 1) : Border.all(width: 0, color: Colors.transparent),
                                          color: currentIndex == 4 ? listActionColor : chart_color12,
                                        ),
                                        child: currentIndex == 4
                                            ? Image.asset('assets/images/ic_meeting.png', width: 35, height: 35, color: white,)
                                            : Image.asset('assets/images/ic_meeting.png', width: 35, height: 35)
                                    ),
                                    Container(width: 18,),
                                    Text('Fix Meeting', style: TextStyle(fontWeight: FontWeight.w500,color: currentIndex == 4 ?white : black, fontSize: 18),
                                    )
                                  ],
                                )
                            ),
                          ),
                          Container(height: 8,),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                currentIndex = 5;
                              });
                            },
                            child: Container(
                                color: currentIndex == 5 ? blue : Colors.white,
                                padding: const EdgeInsets.only(top: 12, bottom: 12, left: 32),
                                // decoration: BoxDecoration(
                                //     border: currentIndex == 5 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                                //     color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                                // ),
                                child: Row(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(22)),
                                          border: currentIndex == 5 ? Border.all(color: blue, width: 1) : Border.all(width: 0, color: Colors.transparent),
                                          color: currentIndex == 5 ? listActionColor : chart_color12,
                                        ),
                                        child: currentIndex == 5
                                            ? Image.asset('assets/images/ic_videos.png', width: 35, height: 35, color: white,)
                                            : Image.asset('assets/images/ic_videos.png', width: 35, height: 35)
                                    ),
                                    Container(width: 18,),
                                    Text('Videos', style: TextStyle(fontWeight: FontWeight.w500, color: currentIndex == 5 ?white : black, fontSize: 18),
                                    )
                                  ],
                                )
                            ),
                          ),
                          Container(height: 8,),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                currentIndex = 6;
                              });
                            },
                            child: Container(
                                color: currentIndex == 6 ? blue : Colors.white,
                                padding: const EdgeInsets.only(top: 12, bottom: 12, left: 32),
                                // decoration: BoxDecoration(
                                //     border: currentIndex == 6 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                                //     color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                                // ),
                                child: Row(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(22)),
                                          border: currentIndex == 6 ? Border.all(color: blue, width: 1) : Border.all(width: 0, color: Colors.transparent),
                                          color: currentIndex == 6 ? listActionColor : chart_color12,
                                        ),
                                        child: currentIndex == 6
                                            ? Image.asset('assets/images/ic_blog.png', width: 35, height: 35, color: white,)
                                            : Image.asset('assets/images/ic_blog.png', width: 35, height: 35)
                                    ),
                                    Container(width: 18,),
                                    Text('Blogs', style: TextStyle(fontWeight: FontWeight.w500, color: currentIndex == 6 ?white : black, fontSize: 18),
                                    )
                                  ],
                                )
                            ),
                          ),
                          Container(height: 8,),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                currentIndex = 7;
                              });
                            },
                            child: Container(
                                color: currentIndex == 7 ? blue : Colors.white,
                                padding: const EdgeInsets.only(top: 12, bottom: 12, left: 32),
                                // decoration: BoxDecoration(
                                //     border: currentIndex == 7 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                                //     color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                                // ),
                                child: Row(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(22)),
                                          border: currentIndex == 7 ? Border.all(color: blue, width: 1) : Border.all(width: 0, color: Colors.transparent),
                                          color: currentIndex == 7 ? listActionColor : chart_color12,
                                        ),
                                        child: currentIndex == 7
                                            ? Image.asset('assets/images/ic_contact.png', width: 35, height: 35, color: white,)
                                            : Image.asset('assets/images/ic_contact.png', width: 35, height: 35)
                                    ),
                                    Container(width: 18,),
                                    Text('Contact', style: TextStyle(fontWeight: FontWeight.w500, color: currentIndex == 7 ?white : black, fontSize: 18),
                                    )
                                  ],
                                )
                            ),
                          ),
                          Container(height: 8,),
                          GestureDetector(
                            onTap: (){
                              logoutFromApp();
                            },
                            child: Container(
                                color: currentIndex == 8 ? blue : Colors.white,
                                padding: const EdgeInsets.only(top: 12, bottom: 12, left: 32),
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
                                          color: currentIndex == 8 ? listActionColor : chart_color12,
                                        ),
                                        child: currentIndex == 8
                                            ? Image.asset('assets/images/ic_logout.png', width: 35, height: 35, color: white,)
                                            : Image.asset('assets/images/ic_logout.png', width: 35, height: 35)
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
                    ),
                  ),
                ),
              ),
            ),
            Container(width: 22,),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height -168,
                margin: const EdgeInsets.only(top: 12, bottom: 12),
                decoration: BoxDecoration(
                  border:Border.all(color: grayLight, width: 0.5 ),
                  color: white,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 1.0,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: currentIndex == 0
                      ? Container()
                      : currentIndex == 1
                      ? const CPHomePage()
                      : currentIndex == 2
                      ? const EStateAnalysisHomePage()
                      :currentIndex == 3
                      ? const EStateVaultHomePage()
                      :currentIndex == 4
                      ? const MeetingPage()
                      :currentIndex == 5
                      ? const VideoListPage()
                      :currentIndex == 6
                      ? const BlogsPage()
                      :currentIndex == 7
                      ? const ContactPage()
                      : Container(),
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
              BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)), color: white),
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
                                          side: BorderSide(width: 1, color: blue),
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
                                    context, MaterialPageRoute(builder: (context) => const LoginScreen()), (Route<dynamic> route) => false);
                              },
                              child: const Text("Yes", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: white)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(30)
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