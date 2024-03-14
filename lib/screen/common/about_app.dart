import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:superapp_flutter/common_widget/common_widget.dart';
import 'package:superapp_flutter/constant/colors.dart';

import '../../utils/base_class.dart';

class AboutAppPage extends StatefulWidget {
  const AboutAppPage({Key? key}) : super(key: key);

  @override
  BaseState<AboutAppPage> createState() => _AboutAppPageState();
}

class _AboutAppPageState extends BaseState<AboutAppPage> {

  String appName = '';
  String packageName = '';
  String version = '';
  String buildNumber = '';

  @override
  void initState(){
    super.initState();
    getAppVersion();
  }

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
            child: getBackArrow()
        ),
        title: getTitle("About the app",),
        centerTitle: true,
        elevation: 0,
        backgroundColor: white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(22),
                child: Image.asset('assets/images/app_icon.png',width: 120,height: 120,)
            ),
            const Gap(50),
            Text("Version $version ($buildNumber)",style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: black),),
            const Gap(12),
            const Text("© 2024 ALPHA CAPITAL",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,color: grayDark),),
        
          ],
        ),
      ),
    );
  }

  Future<void> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    appName = packageInfo.appName;
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
  }

  @override
  void castStatefulWidget() {
    widget is AboutAppPage;
  }

}