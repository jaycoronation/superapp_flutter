import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:superapp/screen/common/video_list_page.dart';

import '../../constant/colors.dart';
import '../../utils/base_class.dart';
import '../consolidated-portfolio/cp_home_page.dart';
import '../e-state-analysis/e_state_analysis_home_page.dart';
import '../e-state-valut/e_state_valut_home_page.dart';
import 'blogs_page.dart';
import 'contact_page.dart';
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
    return WillPopScope(
        child: Scaffold(
          body: Row(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 22, top: 12),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            currentIndex = 0;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: currentIndex == 0 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                                boxShadow: const [
                                    BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 8.0,
                                  ),
                                ],
                                color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                            ),
                            child: Image.asset('assets/images/ic_portfolio.png', width: 60, height: 60)
                        ),
                      ),
                      Container(height: 18,),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            currentIndex = 1;
                          });
                        },
                        child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration:  BoxDecoration(
                                border: currentIndex == 1 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 8.0,
                                  ),
                                ],
                                color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                            ),
                            child: Image.asset('assets/images/ic_consolidated.png', width: 60, height: 60)
                        ),
                      ),
                      Container(height: 18,),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            currentIndex = 2;
                          });
                        },
                        child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration:  BoxDecoration(
                                border: currentIndex == 2 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 8.0,
                                  ),
                                ],
                                color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                            ),
                            child: Image.asset('assets/images/ic_estate_a.png', width: 60, height: 60)
                        ),
                      ),
                      Container(height: 18,),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            currentIndex = 3;
                          });
                        },
                        child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                border: currentIndex == 3 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 8.0,
                                  ),
                                ],
                                color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                            ),
                            child: Image.asset('assets/images/ic_vault.png', width: 60, height: 60)
                        ),
                      ),
                      Container(height: 18,),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            currentIndex = 4;
                          });
                        },
                        child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration:  BoxDecoration(
                                border: currentIndex == 4 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 8.0,
                                  ),
                                ],
                                color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                            ),
                            child: Image.asset('assets/images/ic_meeting.png', width: 60, height: 60)
                        ),
                      ),
                      Container(height: 18,),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            currentIndex = 5;
                          });
                        },
                        child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                border: currentIndex == 5 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 8.0,
                                  ),
                                ],
                                color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                            ),
                            child: Image.asset('assets/images/ic_contact.png', width: 60, height: 60)
                        ),
                      ),
                      Container(height: 18,),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            currentIndex = 6;
                          });
                        },
                        child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                border: currentIndex == 6 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 8.0,
                                  ),
                                ],
                                color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                            ),
                            child: Image.asset('assets/images/ic_blog.png', width: 60, height: 60)
                        ),
                      ),
                      Container(height: 18,),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            currentIndex = 7;
                          });
                        },
                        child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                border: currentIndex == 7 ? Border.all(color: blue, width: 1) : Border.all(width: 0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 8.0,
                                  ),
                                ],
                                color: white, borderRadius: BorderRadius.all(Radius.circular(15))
                            ),
                            child: Image.asset('assets/images/ic_videos.png', width: 60, height: 60)
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(width: 22,),
              Expanded(
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
                    ? const ContactPage()
                    :currentIndex == 6
                    ? const BlogsPage()
                    :currentIndex == 7
                    ? const VideoListPage()
                    : Container(),
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

  @override
  void castStatefulWidget() {
    widget is HomePageForWeb;
  }


}