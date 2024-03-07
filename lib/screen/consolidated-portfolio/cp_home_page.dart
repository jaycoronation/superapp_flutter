import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
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

import '../../constant/colors.dart';
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
  List<ApplicantDetails> listApplicants = [];
  String selectedApplicant = '';

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _pages = [
      const CPDashboardPage(),
      const CPNetworthPage(),
      const CPPortfolioPage()
    ];
    itemsList.add(BottomNavigationBarItem(
      icon: Image.asset("assets/images/ic_home_disable.png", width: 24, height: 24),
      activeIcon: Image.asset("assets/images/ic_home_selected.png", width: 24, height: 24),
      label: 'Dashboard',
    ));
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

    listApplicants = sessionManagerPMS.getNetworthData().applicantDetails ?? [];
    if (listApplicants.isNotEmpty)
      {
        selectedApplicant = listApplicants[0].applicant ?? '';
      }

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: kIsWeb ? 0 : Platform.isAndroid ? MediaQuery.of(context).padding.bottom : 0,),
      child: Scaffold(
        backgroundColor: appBg,
        appBar: AppBar(
            toolbarHeight: _currentIndex == 2 ? 0 : 60,
            automaticallyImplyLeading: false,
            backgroundColor: appBg,
            elevation: 0,
            leading: Visibility(
              visible: kIsWeb == false,
              child: GestureDetector(
                onTap: () {
                  if (_currentIndex == 0)
                    {
                      Navigator.pop(context);
                    }
                  else
                    {
                      final BottomNavigationBar bar = bottomWidgetKey.currentWidget as BottomNavigationBar;
                      bar.onTap!(0);
                    }
                },
                child: Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Image.asset('assets/images/ic_back_arrow.png', width: 32, height: 32),
                  ),
                ),
              ),
            ),
            centerTitle: false,
            titleSpacing: 0,
            title: Text(
              _currentIndex == 0
                  ? "Dashboard"
                  : _currentIndex == 1
                  ? "Networth"
                  : "Portfolio",
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 18, color: blue, fontWeight: FontWeight.w600),
            ),
        ),
        body: IndexedStack(
          index: _currentIndex,
          alignment: Alignment.center,
          sizing: StackFit.expand,
          children: const [
            CPDashboardPage(),
            CPNetworthPage(),
            CPPortfolioPage()
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
        constraints: BoxConstraints(
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
                                    "Latest Transactions",
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
                                    "Latest SIP",
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

  void openApplicantSelection() {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: white,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context, StateSetter setStatenew) {
            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 60),
              child: Wrap(
                children: <Widget>[
                  ListView.builder(
                    itemCount: listApplicants.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            Navigator.pop(context);
                            context.read<UpdateData>().setSelectedApplicant(listApplicants[index].applicant ?? '');
                              print(context.read<UpdateData>().selectedApplicant);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(listApplicants[index].applicant ?? '',style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: blue),),
                              const Divider(color: black,thickness: 0.6,height: 0.6,)
                            ],
                          ),
                        );
                      },
                  )
                ],
              ),
            );
          });
        }
    );
  }

  @override
  void castStatefulWidget() {
    widget is CPHomePage;
  }

}