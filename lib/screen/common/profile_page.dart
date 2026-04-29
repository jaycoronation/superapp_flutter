
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:superapp_flutter/screen/common/about_app.dart';
import 'package:superapp_flutter/common_widget/common_widget.dart';
import 'package:superapp_flutter/screen/common/locate_us.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constant/colors.dart';
import '../../utils/Utils.dart';
import '../../utils/app_utils.dart';
import '../../utils/base_class.dart';
import '../../utils/session_manager_methods.dart';
import '../insurance_data/insurance_list_screen.dart';
import 'DocumentsScreen.dart';
import 'LoginScreen.dart';
import 'SuggestedActionsScreen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  BaseState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends BaseState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBg,
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
        title: getTitle("Profile",),
        centerTitle: true,
        elevation: 0,
        backgroundColor: white,
      ),
      body: Container(
        decoration: const BoxDecoration(
            color: dashboardBg,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(22), topRight: Radius.circular(22))
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Gap(22),
                    Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        //set border radius more than 50% of height and width to make circle
                      ),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(color: white, shape: BoxShape.circle),
                        padding: EdgeInsets.zero,
                        child: Image.asset('assets/images/vault_img_placeholder.png', fit: BoxFit.fill),
                      ),
                    ),
                    const Gap(12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          displayOrDash(getIsClient() ? toDisplayCase("${sessionManagerPMS.getFirstName()} ${sessionManagerPMS.getLastName()}") : toDisplayCase(sessionManager.getRMIDName())),
                          textAlign: TextAlign.start,
                          style: const TextStyle(fontWeight: FontWeight.w500, color: black, fontSize: 22, fontFamily: 'Colfax'),
                        ),
                        Visibility(
                          visible: getIsClient() ? (sessionManagerPMS.getEmail().isNotEmpty) :  sessionManager.getRMIDEmail().isNotEmpty,
                          child: Container(
                            decoration: BoxDecoration(color: gray, borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.fromLTRB(6, 3, 6, 3),
                            margin: const EdgeInsets.only(top: 8),
                            child: Text(
                              displayOrDash(getIsClient() ? sessionManagerPMS.getEmail() : sessionManager.getRMIDEmail()),
                              textAlign: TextAlign.start,
                              style: const TextStyle(fontWeight: FontWeight.w400, color: black, fontSize: 14, fontFamily: 'Colfax'),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 15,top: 22),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(kEditTextCornerRadius),
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        startActivity(context, const DocumentsScreen());
                      },
                      child: optionWidget("Document")
                    ),
                    // GestureDetector(
                    //   behavior: HitTestBehavior.opaque,
                    //   onTap: () {
                    //     Navigator.push(context, MaterialPageRoute(builder: (context) => const InsuranceListScreen()),);
                    //   },
                    //   child: optionWidget("Insurance")
                    // ),
                    GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const SuggestedActionsScreen()),);
                        },
                        child: optionWidget("Suggested Actions")
                    ),
                    // GestureDetector(
                    //   behavior: HitTestBehavior.opaque,
                    //   onTap: () {
                    //     Navigator.push(context, MaterialPageRoute(builder: (context) => const VideoListPage()));
                    //   },
                    //   child: optionWidget("Videos")
                    // ),
                    // GestureDetector(
                    //   behavior: HitTestBehavior.opaque,
                    //   onTap: () {
                    //     Navigator.push(context, MaterialPageRoute(builder: (context) => const BlogsPage()));
                    //   },
                    //   child: optionWidget("Blogs")
                    // ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        Uri urlData = Uri.parse('https://www.alphacapital.in/about/');
                        if (await canLaunchUrl(urlData))
                        {
                          launchUrl(urlData,mode: LaunchMode.externalApplication);
                        }
                      },
                      child: optionWidget("About Us")
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        Uri urlData = Uri.parse('https://www.alphacapital.in/investor_charter/');
                        if (await canLaunchUrl(urlData))
                        {
                          launchUrl(urlData,mode: LaunchMode.externalApplication);
                        }
                      },
                      child: optionWidget("RIA Charter")
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        Uri urlData = Uri.parse('https://www.alphacapital.in/privacy/');
                        if (await canLaunchUrl(urlData))
                        {
                          launchUrl(urlData,mode: LaunchMode.externalApplication);
                        }
                      },
                      child: optionWidget("Privacy Policy")
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        startActivity(context, const LocateUsPage());
                      },
                      child: optionWidget("Locate us")
                    ),

                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        logoutFromApp();
                      },
                      child: optionWidget("Logout", titleColor: red, isShowDivider: false)
                    ),
                  ],
                ),
              ),

              Visibility(
                visible: false,
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(kEditTextCornerRadius),
                  ),
                  child: Column(
                    children: [

                      Visibility(
                        visible: false,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () async {
                            startActivity(context, const AboutAppPage());
                          },
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Visibility(
                                      visible: false,
                                      child: SizedBox(
                                        width: 48,
                                        height: 48,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
                                          child: Image.asset('assets/images/ic_placeholder.png', width: 16, height: 16, color: black),
                                        ),
                                      ),
                                    ),
                                    const Text("About the app",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w500,color:  black,fontSize: 16),),
                                    const Spacer(),
                                    Image.asset(
                                      'assets/images/ic_arrow_right.png',
                                      width: 16,
                                      height: 16,
                                    ),
                                    const Gap(12)
                                  ],
                                ),
                              ),
                              const Divider(thickness: 0.7, height: 0.7, color: lightgrey,indent: 12,endIndent: 12,)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }

  Widget optionWidget(String title, {Color titleColor = black, bool isShowDivider = true}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
          child: Row(
            children: [
              Expanded(
                child: Text(title, style: getMediumTextStyle(fontSize: 16, color: titleColor),),
              ),
              Image.asset(
                'assets/images/ic_arrow_right.png',
                width: 16,
                height: 16,
                color: titleColor,
              ),
              const Gap(12)
            ],
          ),
        ),
        Visibility(
          visible: isShowDivider,
          child: const Divider(thickness: 1, height: 1, color: lightgrey, indent: 12, endIndent: 12,)
        )
      ],
    );
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
                  topRight: Radius.circular(12)
                ),
                color: white
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    getBottomSheetHeaderWithoutButton(context, "", isMargin: false),
                    Text(
                      'Logout from Alpha Capital Super App',
                      style: getBoldTextStyle(fontSize: 18, color: black)
                    ),
                    const Gap(16),
                    Text(
                      'Are you sure you want to logout from app?',
                      style: getMediumTextStyle(fontSize: 16, color: black)
                    ),
                    const Gap(30),
                    Row(
                      children: [
                        Expanded(
                          child: getCommonButtonBorder(
                            "No",
                            false,
                            () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          child: getCommonButton(
                            "Yes",
                            false,
                            () {
                              _logoutWork();
                            },
                            isUpperCaseText: false
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  _logoutWork(){

    sessionManagerPMS.savePerformanceList([]);

    sessionManagerPMS.saveNextYearList([]);

    sessionManagerPMS.savePerviousYearList([]);

    sessionManagerPMS.setReportDate('');

    sessionManagerPMS.saveApplicantsList([]);

    Navigator.pop(context);
    SessionManagerMethods.clear();
    _clearMintSDKData();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreenNew()), (Route<dynamic> route) => false);
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

  @override
  void castStatefulWidget() {
    widget is ProfilePage;
  }

}