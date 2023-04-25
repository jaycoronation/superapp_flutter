import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:superapp/screen/consolidated-portfolio/cp_bs_movement.dart';
import 'package:superapp/screen/consolidated-portfolio/cp_capital_gain.dart';
import 'package:superapp/screen/consolidated-portfolio/cp_dashboard.dart';
import 'package:superapp/screen/consolidated-portfolio/cp_fund_house_allocation.dart';
import 'package:superapp/screen/consolidated-portfolio/cp_latest_sip.dart';
import 'package:superapp/screen/consolidated-portfolio/cp_latest_transaction.dart';
import 'package:superapp/screen/consolidated-portfolio/cp_networth.dart';
import 'package:superapp/screen/consolidated-portfolio/cp_portfolio.dart';
import 'package:superapp/screen/consolidated-portfolio/cp_scheme_allocation.dart';

import '../../constant/colors.dart';
import '../../utils/base_class.dart';

class CPHomePage extends StatefulWidget {
  const CPHomePage({Key? key}) : super(key: key);

  @override
  CPHomePageState createState() => CPHomePageState();
}

class CPHomePageState extends BaseState<CPHomePage> {
  final List<Widget> _pages = List<Widget>.empty(growable: true);
  final List<BottomNavigationBarItem> itemsList = List<BottomNavigationBarItem>.empty(growable: true);
  late int _currentIndex = 0;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _pages.add(const CPDashboardPage());
    _pages.add(const CPNetworthPage());
    _pages.add(const CPPortfolioPage());
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
          centerTitle: false,
          title: Row(
            children: [
              GestureDetector(
                onTap: () {
                  openDocumentShareSheet();
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(right: 8),
                  child: Image.asset('assets/images/ic_profile.png', width: 40, height: 40),
                ),
              ),
              const Expanded(
                  child: Text(
                    "Consolidated Portfolio",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 18, color: blue, fontWeight: FontWeight.w600),
                  )),
            ],
          )),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
                child: IndexedStack(
                  index: _currentIndex,
                  children: _pages,
                )),
          ],
        ),
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
    );
  }

  void _onItemTapped(int value) {
    setState(() {
      _currentIndex = value;
    });
  }

  void openDocumentShareSheet() {
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
                  SingleChildScrollView(
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
                        const Gap(18),
                        Row(
                          children: [
                            Expanded(flex: 1,child: Container()),
                            Expanded(flex:2,child: Image.asset('assets/images/portfolio_icon_logo_header_blue.png',fit: BoxFit.contain,color: blue),),
                            Expanded(flex:1,child: Container())
                          ],
                        ),
                        const Gap(18),
                      ],
                    ),
                  ),
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

  @override
  void dispose() {
    super.dispose();
  }
}