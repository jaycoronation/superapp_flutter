
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:superapp_flutter/common_widget/common_widget.dart';
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
      backgroundColor: white,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(12),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        //set border radius more than 50% of height and width to make circle
                      ),
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: const BoxDecoration(color: white, shape: BoxShape.circle),
                        padding: EdgeInsets.zero,
                        child: Image.asset('assets/images/ic_user_placeholder.png', fit: BoxFit.fill),
                      ),
                    ),
                    const Gap(12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              toDisplayCase(sessionManagerPMS.getFristName() + " " + sessionManagerPMS.getLastName()),
                              textAlign: TextAlign.start,
                              style: const TextStyle(fontWeight: FontWeight.w500, color: black, fontSize: 22, fontFamily: 'Colfax'),
                            ),
                            const Gap(12),
                            InkWell(
                              customBorder: const CircleBorder(),
                              onTap: () async {
                                final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
                                if (result == "success") {
                                  if (isOnline) {

                                  } else {
                                    noInterNet(context);
                                  }
                                } else {
                                  setState(() {});
                                }
                              },
                              child: Container(
                                width: 34,
                                height: 34,
                                decoration: const BoxDecoration(color: grayLight, shape: BoxShape.circle),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.asset('assets/images/ic_edit_pencil.png', width: 28, height: 28, color: black),
                                ),
                              ),
                            )
                          ],
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
            ),

            Column(
              children: [
                const Gap(12),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(kButtonCornerRadius),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1), //color of shadow
                        spreadRadius: 5, //spread radius
                        blurRadius: 9, // blur radius
                        offset: const Offset(0, 2), // changes position of shadow
                      )
                    ],
                  ),
                  child: Column(
                    children: [
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 48,
                                  height: 48,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
                                    child: Image.asset('assets/images/ic_info.png', width: 16, height: 16, color: black),
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
                            const Divider(thickness: 0.7, height: 0.7, color: lightgrey,indent: 12,endIndent: 12,)
                          ],
                        ),
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
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 48,
                                  height: 48,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
                                    child: Image.asset('assets/images/ic_info.png', width: 16, height: 16, color: black),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 48,
                                  height: 48,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
                                    child: Image.asset('assets/images/ic_info.png', width: 16, height: 16, color: black),
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
                            const Divider(thickness: 0.7, height: 0.7, color: lightgrey,indent: 12,endIndent: 12,)
                          ],
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () async {
                          //startActivity(context, screen)
                        },
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 48,
                                  height: 48,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
                                    child: Image.asset('assets/images/ic_info.png', width: 16, height: 16, color: black),
                                  ),
                                ),
                                const Text("About App",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w500,color:  black,fontSize: 16),),
                                const Spacer(),
                                Image.asset(
                                  'assets/images/ic_arrow_right.png',
                                  width: 16,
                                  height: 16,
                                ),
                                const Gap(12)
                              ],
                            ),
                            const Divider(thickness: 0.7, height: 0.7, color: lightgrey,indent: 12,endIndent: 12,)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const Gap(20),
          ],
        ),
      ),
    );
  }

  @override
  void castStatefulWidget() {
    widget is ProfilePage;
  }

}