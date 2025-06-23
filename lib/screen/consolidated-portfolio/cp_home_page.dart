import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:provider/provider.dart';
import 'package:superapp_flutter/model/consolidated-portfolio/GenerateReportResponseModel.dart';
import 'package:superapp_flutter/screen/consolidated-portfolio/cp_bs_movement.dart';
import 'package:superapp_flutter/screen/consolidated-portfolio/cp_capital_gain.dart';
import 'package:superapp_flutter/screen/consolidated-portfolio/cp_dashboard.dart';
import 'package:superapp_flutter/screen/consolidated-portfolio/cp_fund_house_allocation.dart';
import 'package:superapp_flutter/screen/consolidated-portfolio/cp_latest_sip.dart';
import 'package:superapp_flutter/screen/consolidated-portfolio/cp_latest_transaction.dart';
import 'package:superapp_flutter/screen/consolidated-portfolio/cp_networth.dart';
import 'package:superapp_flutter/screen/consolidated-portfolio/cp_portfolio.dart';
import 'package:superapp_flutter/screen/consolidated-portfolio/cp_scheme_allocation.dart';
import 'package:superapp_flutter/service/UpdateData.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common_widget/common_widget.dart';
import '../../constant/colors.dart';
import '../../constant/consolidate-portfolio/api_end_point.dart';
import '../../model/consolidated-portfolio/NetworthResponseModel.dart';
import '../../utils/base_class.dart';

class CPHomePage extends StatefulWidget {
  const CPHomePage({Key? key}) : super(key: key);

  @override
  CPHomePageState createState() => CPHomePageState();
}

class CPHomePageState extends BaseState<CPHomePage> {
  List<Widget> _pages = [];
  final List<BottomNavigationBarItem> itemsList = List<BottomNavigationBarItem>.empty(growable: true);
  late int _currentIndex = 0;
  late TabController tabController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _currentIndex = 0;

    _pages = [
      const CPDashboardPage(),
      const CPNetworthPage(),
      const CPPortfolioPage()
    ];

    itemsList.add(
        BottomNavigationBarItem(
          icon: Image.asset("assets/images/ic_home_disable.png", width: 24, height: 24),
          activeIcon: Image.asset("assets/images/ic_home_selected.png", width: 24, height: 24),
          label: 'Dashboard',
        )
    );

    itemsList.add(BottomNavigationBarItem(
      icon: Image.asset("assets/images/ic_networth_disable.png", width: 24, height: 24),
      activeIcon: Image.asset("assets/images/ic_networth_selected.png", width: 24, height: 24),
      label: 'Networth',
    ));

    itemsList.add(BottomNavigationBarItem(
      icon: Image.asset("assets/images/ic_portfolio_disable.png", width: 24, height: 24),
      activeIcon: Image.asset("assets/images/ic_portfolio_selected.png", width: 24, height: 24),
      label: 'Portfolio',
    ));
    itemsList.add(BottomNavigationBarItem(
      icon: Image.asset("assets/images/ic_more_unselected.png", width: 24, height: 24),
      activeIcon: Image.asset("assets/images/ic_more_selected.png", width: 24, height: 24),
      label: 'More',
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: kIsWeb ? 0 : Platform.isAndroid ? MediaQuery.of(context).padding.bottom : 0,),
      child: Scaffold(
        backgroundColor: appBg,
        appBar: AppBar(
            toolbarHeight: _currentIndex == 2 ? 60 : 60,
            automaticallyImplyLeading: false,
            backgroundColor: appBg,
            elevation: 0,
            leading: Visibility(
              visible: kIsWeb == false,
              child: GestureDetector(
                onTap: () {
                  if (_currentIndex == 0)
                    {

                      if(sessionManager.getUserType() == "client")
                      {
                        Navigator.pop(context);
                      }
                      else
                      {
                        sessionManagerPMS.createLoginSession('', '', '', '', '');
                        Navigator.pop(context);
                      }
                    }
                  else
                    {
                      final BottomNavigationBar bar = bottomWidgetKey.currentWidget as BottomNavigationBar;
                      bar.onTap!(0);
                    }
                },
                child: getBackArrow(),
              ),
            ),
            centerTitle: true,
            titleSpacing: 0,
            title: getTitle(
              _currentIndex == 0
                  ? "Dashboard"
                  : _currentIndex == 1
                  ? "Networth"
                  : "Portfolio",
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  generateReport();
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(right: 5),
                  padding: const EdgeInsets.all(3),
                  width: 32,
                  height:  32,
                  child: Image.asset('assets/images/vault_ic_share_pdf.png', width: 32, height: 32, color: blue),
                ),
              ),
            ]
        ),
        body: Column(
          children: [
            Visibility(visible: isLoading,child: LinearProgressIndicator(color: blue,backgroundColor: blue.withOpacity(0.3),)),
            Expanded(
              child: IndexedStack(
                index: _currentIndex,
                alignment: Alignment.center,
                sizing: StackFit.expand,
                children: const [
                  CPDashboardPage(),
                  CPNetworthPage(),
                  CPPortfolioPage()
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 15,
          key: bottomWidgetKey,
          items: itemsList,
          backgroundColor: white,
          selectedItemColor: black,
          selectedLabelStyle: const TextStyle(color: black, fontSize: 13, height: 1.5, fontWeight: FontWeight.w400),
          unselectedLabelStyle: const TextStyle(color: black, fontSize: 13, height: 1.5, fontWeight: FontWeight.w400),
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  void _onItemTapped(int value) {
    if (value == 3)
      {
        openDocumentShareSheet();
      }
    else
      {
        setState(() {
          _currentIndex = value;
        });
      }
  }

  void openDocumentShareSheet() {
    showModalBottomSheet(
        constraints: const BoxConstraints(
          maxWidth: 600,
        ),
        isScrollControlled: true,
        backgroundColor: white,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context, StateSetter setStatenew) {
            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 25),
              child: Wrap(
                children: <Widget>[
                  Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const CPBsMovementPage()));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Image.asset('assets/images/portfolio_ic_bs_movement.png', width: 24, height: 24,color: blue),
                                  Container(width: 12),
                                  const Text(
                                    "BS Movement",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: 18, color: blue, fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Gap(12),
                          const Divider(
                            height: 0.5,
                            thickness: 0.5,
                            color: divider_color,
                          ),
                          const Gap(12),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const CPLatestTransactionPage()));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Image.asset('assets/images/portfolio_ic_transaction.png', width: 24, height: 24,color: blue),
                                  Container(width: 12),
                                  const Text(
                                    "Last Month Transactions",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: 18, color: blue, fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Gap(12),
                          const Divider(
                            height: 0.5,
                            thickness: 0.5,
                            color: divider_color,
                          ),
                          const Gap(12),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const CPLatestSIPPage()));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Image.asset('assets/images/portfolio_ic_sip_stp.png', width: 24, height: 24,color: blue),
                                  Container(width: 12),
                                  const Text(
                                    "Last Month SIP",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: 18, color: blue, fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Gap(12),
                          const Divider(
                            height: 0.5,
                            thickness: 0.5,
                            color: divider_color,
                          ),
                          const Gap(12),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const CPSchemeAllocationPage()));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Image.asset('assets/images/portfolio_ic_scheme_name.png', width: 24, height: 24,color: blue),
                                  Container(width: 12),
                                  const Text(
                                    "Scheme Allocation",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: 18, color: blue, fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Gap(12),
                          const Divider(
                            height: 0.5,
                            thickness: 0.5,
                            color: divider_color,
                          ),
                          const Gap(12),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const CPFundHouseAllocationPage()));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Image.asset('assets/images/portfolio_ic_performance.png', width: 24, height: 24,color: blue),
                                  Container(width: 12),
                                  const Text(
                                    "Fund House Allocation",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: 18, color: blue, fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Gap(12),
                          const Divider(
                            height: 0.5,
                            thickness: 0.5,
                            color: divider_color,
                          ),
                          const Gap(12),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const CPCapitalGainPage()));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Image.asset('assets/images/portfolio_ic_capital_gain.png', width: 24, height: 24,color: blue),
                                  Container(width: 12),
                                  const Text(
                                    "Capital Gain",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: 18, color: blue, fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Gap(12),
                          const Divider(
                            height: 0.5,
                            thickness: 0.5,
                            color: divider_color,
                          ),

                          Image.asset('assets/images/portfolio_icon_logo_header_blue.png',fit: BoxFit.contain,color: blue, width: 250,height: 100,),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
        }
    );
  }

  generateReport() async {
    setState(() {
      isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_CP + generatePortfolioReport);

    Map<String, String> jsonBody = {
      'logged_in_id' : sessionManagerPMS.getUserId(),
      'send_mail' : "",
      'user_id' : sessionManagerPMS.getUserId()
    };

    final response = await http.post(url,body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = GenerateReportResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      try {
        setState(() async {
          isLoading = false;

          _showAlertDialog(context,dataResponse);
        });
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        if (kDebugMode) {
          print(e);
        }
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }

  }

  void _showAlertDialog(BuildContext context, GenerateReportResponseModel dataResponse) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Portfolio Report',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: black),),
        content: const Text('Your report is downloaded successfully please enter your PAN Number in capital as Password',style: TextStyle(color: black,fontWeight: FontWeight.w500,fontSize: 14),),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Dismiss',style: TextStyle(color: Colors.red,fontWeight: FontWeight.w600,fontSize: 16),),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () async {
              Navigator.pop(context);
              var reportURL = "${API_DOMAIN_CP}assets/saved_pdf/${dataResponse.pdfFileName}?ver=${DateTime.now().millisecondsSinceEpoch}";

              Uri reportUrl = Uri.parse(reportURL);

              if (await canLaunchUrl(reportUrl))
                {
                  launchUrl(reportUrl,mode: LaunchMode.externalApplication);
                }
            },
            child: const Text('Open',style: TextStyle(color: Colors.green,fontWeight: FontWeight.w600,fontSize: 16),),
          ),
        ],
      ),
    );
  }

  @override
  void castStatefulWidget() {
    widget is CPHomePage;
  }

}