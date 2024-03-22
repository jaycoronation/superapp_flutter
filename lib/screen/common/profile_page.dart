
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:superapp_flutter/screen/common/about_app.dart';
import 'package:superapp_flutter/screen/common/client_task_list.dart';
import 'package:superapp_flutter/screen/common/edit_profile_page.dart';
import 'package:superapp_flutter/common_widget/common_widget.dart';
import 'package:superapp_flutter/screen/common/locate_us.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constant/colors.dart';
import '../../utils/app_utils.dart';
import '../../utils/base_class.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

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
        height: MediaQuery.of(context).size.height,
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
                          toDisplayCase("${sessionManagerPMS.getFirstName()} ${sessionManagerPMS.getLastName()}"),
                          textAlign: TextAlign.start,
                          style: const TextStyle(fontWeight: FontWeight.w500, color: black, fontSize: 22, fontFamily: 'Colfax'),
                        ),
                        Container(
                          decoration: BoxDecoration(color: gray, borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.fromLTRB(6, 3, 6, 3),
                          margin: const EdgeInsets.only(top: 8),
                          child: Text(
                            sessionManagerPMS.getEmail(),
                            textAlign: TextAlign.start,
                            style: const TextStyle(fontWeight: FontWeight.w400, color: black, fontSize: 14, fontFamily: 'Colfax'),
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
                        startActivity(context, const ClientTaskListScreen());
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
                                const Text("My Tasks",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w500,color:  black,fontSize: 16),),
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
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        Uri urlData = Uri.parse('https://www.alphacapital.in/investor_charter/');
                        if (await canLaunchUrl(urlData))
                        {
                          launchUrl(urlData,mode: LaunchMode.externalApplication);
                        }
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
                                const Text("RIA Charter",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w500,color:  black,fontSize: 16),),
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
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(kEditTextCornerRadius),
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        Uri urlData = Uri.parse('https://www.alphacapital.in/privacy/');
                        if (await canLaunchUrl(urlData))
                        {
                          launchUrl(urlData,mode: LaunchMode.externalApplication);
                        }
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
                                const Text("Privacy Policy",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w500,color:  black,fontSize: 16),),
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
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        Uri urlData = Uri.parse('https://www.alphacapital.in/about/');
                        if (await canLaunchUrl(urlData))
                        {
                          launchUrl(urlData,mode: LaunchMode.externalApplication);
                        }
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
                                const Text("About Us",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w500,color:  black,fontSize: 16),),
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
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        startActivity(context, const LocateUsPage());
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
                                const Text("Locate us",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w500,color:  black,fontSize: 16),),
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
                    GestureDetector(
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
                  ],
                ),
              ),

              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void castStatefulWidget() {
    widget is ProfilePage;
  }

}