import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:superapp/screen/e-state-analysis/e_state_aspiration_page.dart';
import '../../../constant/colors.dart';
import '../../../utils/base_class.dart';

import '../../model/e-state-analysis/analysis_menu_model.dart';
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
          nameStatic: "Risk Profile",
          itemPostIconStatic: "assets/images/ic_arrow_double_right.png"),
    ];

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
                onTap: () {},
                child: Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(right: 8),
                  child: Image.asset('assets/images/ic_profile.png', width: 40, height: 40),
                ),
              ),
              const Expanded(
                  child: Text("Estate Analysis",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: blue, fontWeight: FontWeight.w600),
                  )),
            ],
          )),
      body: SafeArea(
        top: false,
        child: _isLoading
            ? const LoadingWidget()
            : Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top: 15, left: 12),
              child: const Text("Enter Following Data:",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16, color: black, fontWeight: FontWeight.w600),
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
                )),
          ],
        ),
      ),
    );
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
