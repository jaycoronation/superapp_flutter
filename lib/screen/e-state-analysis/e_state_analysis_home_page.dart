import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:share_plus/share_plus.dart';
import 'package:superapp_flutter/common_widget/common_widget.dart';
import 'package:superapp_flutter/screen/e-state-analysis/e_state_aspiration_page.dart';
import 'package:superapp_flutter/screen/e-state-analysis/e_state_existing_assets_page.dart';
import 'package:superapp_flutter/screen/e-state-analysis/e_state_existing_liabilities_page.dart';
import 'package:superapp_flutter/screen/e-state-analysis/e_state_future_inflow_main_page.dart';
import 'package:superapp_flutter/screen/e-state-analysis/e_state_future_inflow_page.dart';
import 'package:superapp_flutter/screen/e-state-analysis/e_state_risk_profile_page.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constant/colors.dart';
import '../../../utils/base_class.dart';

import '../../constant/analysis_api_end_point.dart';
import '../../model/e-state-analysis/analysis_menu_model.dart';
import '../../utils/app_utils.dart';
import '../../widget/loading.dart';

class EStateAnalysisHomePage extends StatefulWidget {
  const EStateAnalysisHomePage({Key? key}) : super(key: key);

  @override
  _EStateAnalysisHomePageState createState() => _EStateAnalysisHomePageState();
}

class _EStateAnalysisHomePageState extends BaseState<EStateAnalysisHomePage> {
  final bool _isLoading = false;
  List<AnalysisMenuGetSet> menuList = List<AnalysisMenuGetSet>.empty(growable: true);
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    setMenuData();
    if(isOnline) {
      getListData();
    }else{
      noInterNet(context);
    }
  }

  void setMenuData() {
    menuList = [
      AnalysisMenuGetSet(
          idStatic : 1,
          itemPrefixIconStatic: 'assets/images/ic_aspiration.png',
          nameStatic: "Aspirations",
          itemPostIconStatic: "assets/images/ic_arrow_double_right.png"),
      AnalysisMenuGetSet(
          idStatic : 2,
          itemPrefixIconStatic: 'assets/images/ic_existing_asset.png',
          nameStatic: "Existing Assets",
          itemPostIconStatic: "assets/images/ic_arrow_double_right.png"),
      AnalysisMenuGetSet(
          idStatic : 3,
          itemPrefixIconStatic: 'assets/images/ic_existing_libaliti.png',
          nameStatic: "Existing Liabilities",
          itemPostIconStatic: "assets/images/ic_arrow_double_right.png"),
      AnalysisMenuGetSet(
          idStatic : 4,
          itemPrefixIconStatic: 'assets/images/ic_future_inflow.png',
          nameStatic: "Future Inflow",
          itemPostIconStatic: "assets/images/ic_arrow_double_right.png"),
      AnalysisMenuGetSet(
          idStatic : 5,
          itemPrefixIconStatic: 'assets/images/ic_final_report.png',
          nameStatic: sessionManager.getRiskProfile().toString().isEmpty ? "Risk Profile" : "Risk Profile(${sessionManager.getRiskProfile().toString()})",
          itemPostIconStatic: "assets/images/ic_arrow_double_right.png"),
    ];
  }

  //API call func..
  void getListData() async {
    if(isOnline) {

      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(API_URL_ANALYSIS + userProfile);

      Map<String, String> jsonBody = {
        'user_id': sessionManager.getUserId().toString().trim(),
      };

      final response = await http.post(url, body: jsonBody);
      final statusCode = response.statusCode;

      final body = response.body;
      Map<String, dynamic> user = jsonDecode(body);
    }else {
      noInterNet(context);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: appBg,
      appBar: AppBar(
          toolbarHeight: 60,
          automaticallyImplyLeading: false,
          backgroundColor: appBg,
          elevation: 0,
          centerTitle: true,
          leading: Visibility(
            visible: kIsWeb == false,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if(sessionManager.getUserType() == "client")
                {
                  Navigator.pop(context);
                }
                else
                {
                  sessionManagerPMS.createLoginSession('', '', '', '', '');
                  Navigator.pop(context);
                }
              },
              child: getBackArrow(),
            ),
          ),
          title: getTitle("Financial Planning",)
      ),
      body: SafeArea(
        top: false,
        child: _isLoading
            ? const LoadingWidget()
            : Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 12,right: 12),
              child: const Text("Please fill data to generate your Financial Plan presentation online :",
                textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16,color: black,fontWeight: FontWeight.w600,)
              ),
            ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            controller: _scrollController,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: menuList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  if (menuList[index].id == 1) {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const EStateAspirationPage()));
                                  }else if (menuList[index].id == 2) {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const EStateExistingAssetsPage()));
                                  }else if (menuList[index].id == 3) {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const EStateExistingLiabilitiesPage()));
                                  }else if (menuList[index].id == 4) {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const EStateFutureInflowPage(true)));
                                  }else if (menuList[index].id == 5) {
                                    _redirectToNextPage(context);
                                    // Navigator.push(context, MaterialPageRoute(builder: (context) => const EStateRiskProfilePage()));
                                  }

                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.only(bottom: 12),
                                  decoration: const BoxDecoration(color: semiBlue, borderRadius: BorderRadius.all(Radius.circular(10))),
                                  child: Row(
                                    children: [
                                      Container(
                                          margin: const EdgeInsets.only(right: 10,),
                                          child: Image.asset(menuList[index].itemPrefixIcon, height: 38, width: 38,)
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(right: 10, ),
                                        alignment: Alignment.topLeft,
                                        child: Text(menuList[index].name,
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(fontWeight: FontWeight.w600,
                                              color: blue, fontSize: 15.0),),
                                      ),
                                      const Spacer(),
                                      Container(
                                          alignment: Alignment.centerRight,
                                          margin: const EdgeInsets.only(left: 10,),
                                          child: Image.asset(menuList[index].itemPostIcon, height: 28, width: 28, color: blue,)
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                        InkWell(
                          onTap: () {
                            final bytes = utf8.encode(sessionManager.getUserId().toString().trim());
                            final base64Str = base64.encode(bytes);
                            print(base64Str);

                            var _url = API_URL_ANALYSIS + generateFinalReport + base64Str;
                            if(_url.isNotEmpty) {
                              launch(_url);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: const BoxDecoration(color: blue, borderRadius: BorderRadius.all(Radius.circular(10))),
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 10,),
                                  child: Image.asset("assets/images/ic_final_report_new.png", height: 38, width: 38,)
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 10,),
                                  alignment: Alignment.topLeft,
                                  child: const Text("Generate Final Report",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontWeight: FontWeight.w600,
                                        color: white, fontSize: 15.0),),
                                ),
                              ],
                            ),
                          ),
                        )

                      ],
                    ),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }


  Future<void> _redirectToNextPage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EStateRiskProfilePage()),
    );
    print("result ===== $result");
    if (result == "success") {
      setMenuData();

      setState(() {

      });
    }
  }

  @override
  void castStatefulWidget() {
    widget is EStateAnalysisHomePage;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

}
