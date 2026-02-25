import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/common_widget/common_widget.dart';
import '../../constant/colors.dart';
import '../../constant/consolidate-portfolio/api_end_point.dart';
import '../../model/consolidated-portfolio/LatestTransactionResponse.dart';
import '../../model/consolidated-portfolio/NetworthResponseModel.dart';
import '../../model/consolidated-portfolio/PercentageResponse.dart';
import '../../model/consolidated-portfolio/SinceInceptionResponse.dart';
import '../../model/consolidated-portfolio/XIRRCommonResponseModel.dart';
import '../../utils/app_utils.dart';
import '../../utils/base_class.dart';
import '../../utils/responsive.dart';
import '../../widget/loading.dart';
import 'cp_dashboard_loading.dart';
import 'indicator.dart';

class CPDashboardPage extends StatefulWidget {
  const CPDashboardPage({Key? key}) : super(key: key);

  @override
  BaseState<CPDashboardPage> createState() => CPDashboardPageState();
}

class CPDashboardPageState extends BaseState<CPDashboardPage> {
  bool _isLoading = false;
  bool _isVisibleStrategic = true;
  bool _isVisibleTactical = true;
  bool _isShowTable = false;
  bool _isShowTopTable = false;

  bool _isVisibleSinceInception = true;
  bool _isVisible2023_24 = false;
  bool _isVisible2022_23 = false;

  bool _isSinceInceptionLoading = false;
  bool _isCurrentYearXIRRLoading = false;
  bool _isPreviousYearXIRRLoading = false;

  bool isShowMacroAssetGraph = true;
  bool isShowMicroAssetGraph = true;
  bool isShowApplicantGraph = true;
  bool isShowServiceProviderGraph = true;

  bool isShowSinceInception = true;
  bool isShowCurrentYear = false;
  bool isShowPreviousYear = false;

  /*List<Data> listSinceInception = List<Data>.empty(growable: true);
  List<Data> listCurrentYearXIRR = List<Data>.empty(growable: true);
  List<Data> listPreviousYearXIRR = List<Data>.empty(growable: true);*/

  List<Xirr> listSinceInceptionNew = [];
  List<Xirr> listCurrentYearXIRRNew = [];
  List<Xirr> listPreviousYearXIRRNew = [];

  List<TransactionDetails> listLast30DaysTransaction = [];

  var resultData = Result();
  var percentageResponse = PercentageResponse();
  int touchedIndexAsset = -1;
  int touchedIndexApplicant = -1;

  int touchedIndexMacroAsset = -1;
  int touchedIndexMicroAsset = -1;
  int touchedIndexApplicantDetail = -1;
  int touchedIndexServiceProvider = -1;

  var strNetWorth = "";
  String asPerDate = "";

  final List<Color> colorsAssetAllocation = <Color>[chart_color1, chart_color2,chart_color3,chart_color4,chart_color5,
    chart_color6,chart_color7,chart_color8,chart_color9,chart_color10];

  final List<Color> colorsApplicantAllocation = <Color>[chart_color6, chart_color10,chart_color3,chart_color4,chart_color5,
    chart_color1,chart_color7,chart_color8,chart_color9,chart_color2];

  final List<Color> colorMainAll = [tableLightOrange, tableLightBlue, tableLightGreen, tableLightYellow, tableLightPurple, tableLightPink];

  @override
  void initState() {
    super.initState();
    _getNetworthData();
    getCommonXirr();
    fetchLast30DaysTransaction();

    print("Financial Year === ${getFinancialYearFormated()}");
    print("Previous Financial Year === ${getPerviousFinancialYearFormated()}");

    DateTime today = DateTime.now();
    DateTime twoDaysAgo = today.subtract(const Duration(days: 2));
    asPerDate = DateFormat("dd MMM,yyyy").format(twoDaysAgo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dashboardBg,
      body: _isLoading
          ? const LoadingWidget()
          : ResponsiveWidget.isMediumScreen(context)
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 6, right: 6,top: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: strNetWorth.isNotEmpty,
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(left: 16,right: 16, bottom: 16),
                        decoration: BoxDecoration(
                            color: blue,
                            borderRadius: BorderRadius.circular(12),
                            border:Border.all(color: blue, width: 1,)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 12),
                                  child: const Text('Networth',
                                      style: TextStyle(color: white, fontSize: 16, fontWeight: FontWeight.w400)
                                  ),
                                ),
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    getCommonXirr();
                                    _getNetworthData();
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 12,top: 6),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: black.withOpacity(0.2)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Image.asset('assets/images/ic_refresh.png',width: 18,height: 18,color: white,),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                            Text((convertCommaSeparatedAmount(strNetWorth)),
                                style: const TextStyle(color: white, fontSize: 12, fontWeight: FontWeight.w900,letterSpacing: 5.8)),
                            const Gap(18),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                //Text("*As per $asPerDate",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: white),),
                                Text("*Some time lag",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: white),),
                                Gap(12)
                              ],
                            ),
                            const Gap(10),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 16,right: 16),
                      child: Row(
                        children: [
                          const Text('Asset Allocation :',
                          style: TextStyle(
                              color: blue,
                              fontSize: 18,
                              fontWeight:
                              FontWeight.bold)),
                          const Spacer(),
                          InkWell(
                            onTap: (){
                              setState(() {
                                _isShowTopTable = !_isShowTopTable;
                              });
                            },
                            child: Text(_isShowTopTable ? 'Graph' : 'Table',
                                style: const TextStyle(
                                    color: blue,
                                    fontSize: 16,
                                    fontWeight:
                                    FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                    const Gap(16),
                    _isShowTopTable
                        ? setUpAssetAllocationTopTableData()
                        : SizedBox(
                      height: 250,
                      child: PieChart(
                        PieChartData(
                          pieTouchData: PieTouchData(
                            touchCallback: (FlTouchEvent event, pieTouchResponse) {
                              setState(() {
                                if (!event.isInterestedForInteractions ||
                                    pieTouchResponse == null ||
                                    pieTouchResponse.touchedSection == null) {
                                  touchedIndexAsset = -1;
                                  return;
                                }
                                touchedIndexAsset = pieTouchResponse
                                    .touchedSection!.touchedSectionIndex;
                              });
                            },
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 0,
                          centerSpaceRadius: 60,
                          sections: generateAssetAllocationChart(),
                        ),
                      ),
                    ),
                    const Gap(16),
                    _isShowTopTable ? Container () : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(resultData.macroAssetStratagic!.length - 1, (i) {
                        return resultData.macroAssetStratagic![i].actual != 0 ? Container(
                          margin: const EdgeInsets.all(6),
                          child: Indicator(
                           color: colorsAssetAllocation[i],
                           text: resultData.macroAssetStratagic![i].asset.toString(),
                           isSquare: false,
                           size: touchedIndexAsset == i ? 18 : 16,
                           textColor: touchedIndexAsset == i
                               ? Colors.black
                               : Colors.black38,
                       ),
                        ) : Container();
                      }),
                    ),
                    const Gap(16),
                    Container(
                      margin: const EdgeInsets.only(left: 16,right: 16),
                      child: Row(
                        children: [
                          const Text('Applicants Allocation : ',
                              style: TextStyle(
                                  color: blue,
                                  fontSize: 18,
                                  fontWeight:
                                  FontWeight.bold)
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: (){
                              setState(() {
                                _isShowTable = !_isShowTable;
                              });
                            },
                            child: Text(_isShowTable ? 'Graph' : 'Table',
                                style: const TextStyle(
                                    color: blue,
                                    fontSize: 16,
                                    fontWeight:
                                    FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                    const Gap(16),
                    _isShowTable
                        ? setUpApplicantsData()
                        : SizedBox(
                          height: 250,
                          child: PieChart(
                            PieChartData(
                              pieTouchData: PieTouchData(
                                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                  setState(() {
                                    if (!event.isInterestedForInteractions ||
                                        pieTouchResponse == null || pieTouchResponse.touchedSection == null) {
                                      touchedIndexApplicant = -1;
                                      return;
                                    }
                                    touchedIndexApplicant = pieTouchResponse.touchedSection!.touchedSectionIndex;
                                  });
                                },
                              ),
                              borderData: FlBorderData(
                                show: false,
                              ),
                              sectionsSpace: 0,
                              centerSpaceRadius: 60,
                              sections: generateApplicantsChart(),
                            ),
                          ),
                        ),
                    const Gap(16),
                    _isShowTable
                        ? Container()
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(resultData.applicantDetails!.length - 1, (i) {
                        return resultData.applicantDetails![i].allocation != 0
                            ? Container(
                              margin: const EdgeInsets.all(6),
                              child: Indicator(
                                color: colorsApplicantAllocation[i],
                                text: resultData.applicantDetails![i].applicant.toString(),
                                isSquare: false,
                                size: touchedIndexApplicant == i ? 18 : 16,
                                textColor: touchedIndexApplicant == i
                                    ? Colors.black
                                    : Colors.black38,
                              ),
                            )
                            : Container();
                      }),
                    ),
                    const Gap(16),
                    Container(
                      margin: const EdgeInsets.only(left: 16),
                      child: const Text('Asset Allocation - Strategic : ',
                          style: TextStyle(
                              color: blue,
                              fontSize: 18,
                              fontWeight:
                              FontWeight.bold)),
                    ),
                    const Gap(16),
                    setUpAssetAllocationStrategicTab(),
                    _isVisibleStrategic
                        ? setUpAssetAllocationStrategicMacroData()
                        : setUpAssetAllocationStrategicMicroData(),
                    const Gap(16),
                    Container(
                      margin: const EdgeInsets.only(left: 16),
                      child: const Text('Asset Allocation - Tactical : ',
                          style: TextStyle(
                              color: blue,
                              fontSize: 18,
                              fontWeight:
                              FontWeight.bold)),
                    ),
                    const Gap(16),
                    setUpAssetAllocationTacticalTab(),
                    _isVisibleTactical
                        ? setUpAssetAllocationTacticalMacroData()
                        : setUpAssetAllocationTacticalMicroData(),
                    const Gap(16),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(left: 16),
                      child: Text('*Equity market is overvalued by ${percentageResponse.masterMarketPercentage}%',textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: blue,
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold)),
                    ),
                    const Gap(16),
                    Container(
                      margin: const EdgeInsets.only(left: 16),
                      child: const Text('Performance : ',
                          style: TextStyle(
                              color: blue,
                              fontSize: 18,
                              fontWeight:
                              FontWeight.bold)),
                    ),
                    const Gap(16),
                    setUpPerformanceTab(),
                    _isSinceInceptionLoading
                        ? const CPDashboardLoadingWidget()
                        : _isVisibleSinceInception
                        ? setUpSinceInceptionData()
                        : _isCurrentYearXIRRLoading
                        ? const CPDashboardLoadingWidget()
                        : _isVisible2023_24
                        ? setUpCurrentYearXIRRData()
                        : _isPreviousYearXIRRLoading
                        ? const CPDashboardLoadingWidget()
                        : setUpPreviousYearXIRRData(),
                    const Gap(16)
                  ],
                ),
              )
          )
          : SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(padding: const EdgeInsets.only(left: 6, right: 6,top: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: strNetWorth.isNotEmpty,
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(left: 16,right: 16, bottom: 16),
                        decoration: BoxDecoration(
                            color: blue,
                            borderRadius: BorderRadius.circular(12),
                            border:Border.all(color: blue, width: 1,)),
                        child: Column(
                          children: [
                            const Gap(20),
                            const Text('Networth',
                                style: TextStyle(color: white, fontSize: 16, fontWeight: FontWeight.w400)),
                            const Gap(20),
                            Text((convertCommaSeparatedAmount(strNetWorth)),
                                style: const TextStyle(color: white, fontSize: 26, fontWeight: FontWeight.w900,letterSpacing: 1.6)),
                            const Gap(10),
                            Visibility(
                              visible: false,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("*As On $asPerDate",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: white),),
                                  const Gap(12)
                                ],
                              ),
                            ),
                            const Gap(10),
                          ],
                        ),
                      ),
                    ),

                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(8)
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Macro Asset Allocation - Strategic:",
                                  style: getMediumTextStyle(fontSize: 14, color: blue),
                                ),
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  setState(() {
                                    isShowMacroAssetGraph = !isShowMacroAssetGraph;
                                  });
                                },
                                child: Text(
                                  isShowMacroAssetGraph ? "Table" : "Graph",
                                  style: getBoldTextStyle(fontSize: 14, color: blue),
                                ),
                              )
                            ],
                          ),
                          const Gap(8),
                          Divider(color: gray,),
                          const Gap(8),
                          Visibility(
                            visible: isShowMacroAssetGraph,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 20, bottom: 10),
                                  height: 170,
                                  child: PieChart(
                                    PieChartData(
                                      sectionsSpace: 2,
                                      centerSpaceRadius: 0,
                                      startDegreeOffset: -100,
                                      pieTouchData: PieTouchData(
                                        touchCallback: (event, response) {
                                          setState(() {
                                            if (!event.isInterestedForInteractions || response == null || response.touchedSection == null)
                                            {
                                              touchedIndexMacroAsset = -1;
                                              return;
                                            }
                                            touchedIndexMacroAsset = response.touchedSection!.touchedSectionIndex;
                                          });
                                        },
                                      ),
                                      sections: List.generate(
                                        (resultData.macroAssetStratagic ?? [])
                                            .where((e) => (e.asset ?? "") != "Total")
                                            .length,
                                            (i) {

                                          final filteredList = (resultData.macroAssetStratagic ?? []).where((e) => (e.asset ?? "") != "Total").toList();
                                          final value = filteredList[i];
                                          final isTouched = i == touchedIndexMacroAsset;
                                          final percentValue = (value.actual ?? 0).toDouble();

                                          if (percentValue == 0)
                                          {
                                            return PieChartSectionData(value: 0);
                                          }

                                          return PieChartSectionData(
                                            showTitle: percentValue > 1,
                                            titlePositionPercentageOffset:
                                            percentValue < 1 ? 1.1 : 0.7,
                                            color: isTouched ? colorMainAll[i % colorMainAll.length].withValues(alpha: 0.8) :
                                            colorMainAll[i % colorMainAll.length],
                                            value: percentValue,
                                            radius: isTouched ? 120 : 100,
                                            title: isTouched
                                                ? "${value.actual}%"
                                                : "${percentValue.toStringAsFixed(0)}%",
                                            titleStyle: getSemiBoldTextStyle(
                                                fontSize: 12, color: white),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                const Gap(16),
                                Visibility(
                                  visible: (resultData.macroAssetStratagic?.isNotEmpty ?? false),
                                  child: Center(
                                    child: Wrap(
                                      spacing: 12,
                                      runSpacing: 8,
                                      alignment: WrapAlignment.center,
                                      children: (resultData.macroAssetStratagic ?? []).where((e) => (e.asset ?? "") != "Total").toList().asMap().entries.map((entry) {

                                        final index = entry.key;
                                        final item = entry.value;

                                        return Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 14,
                                              height: 14,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: colorMainAll[index % colorMainAll.length],
                                              ),
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              item.asset ?? "",
                                              style: getMediumTextStyle(fontSize: 12, color: black),
                                            ),
                                          ],
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                                const Gap(20),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: !isShowMacroAssetGraph && (resultData.macroAssetStratagic?.isNotEmpty ?? false),
                            child: macroAssetAllocationListWidget()
                          ),
                        ],
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(8)
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Micro Asset Allocation - Strategic:",
                                  style: getMediumTextStyle(fontSize: 14, color: blue),
                                ),
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  setState(() {
                                    isShowMicroAssetGraph = !isShowMicroAssetGraph;
                                  });
                                },
                                child: Text(
                                  isShowMicroAssetGraph ? "Table" : "Graph",
                                  style: getBoldTextStyle(fontSize: 14, color: blue),
                                ),
                              )
                            ],
                          ),
                          const Gap(8),
                          Divider(color: gray,),
                          const Gap(8),
                          Visibility(
                            visible: isShowMicroAssetGraph,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 20, bottom: 10),
                                  height: 170,
                                  child: PieChart(
                                    PieChartData(
                                      sectionsSpace: 2,
                                      centerSpaceRadius: 0,
                                      startDegreeOffset: -100,
                                      pieTouchData: PieTouchData(
                                        touchCallback: (event, response) {
                                          setState(() {
                                            if (!event.isInterestedForInteractions || response == null || response.touchedSection == null)
                                            {
                                              touchedIndexMicroAsset = -1;
                                              return;
                                            }
                                            touchedIndexMicroAsset = response.touchedSection!.touchedSectionIndex;
                                          });
                                        },
                                      ),
                                      sections: List.generate(
                                        (resultData.microAssetStratagic ?? [])
                                            .where((e) => (e.asset ?? "") != "Total")
                                            .length,
                                            (i) {

                                          final filteredList = (resultData.microAssetStratagic ?? []).where((e) => (e.asset ?? "") != "Total").toList();
                                          final value = filteredList[i];
                                          final isTouched = i == touchedIndexMicroAsset;
                                          final percentValue = (value.actual ?? 0).toDouble();

                                          if (percentValue == 0)
                                          {
                                            return PieChartSectionData(value: 0);
                                          }

                                          return PieChartSectionData(
                                            showTitle: percentValue > 1,
                                            titlePositionPercentageOffset:
                                            percentValue < 1 ? 1.1 : 0.7,
                                            color: isTouched ? colorMainAll[i % colorMainAll.length].withValues(alpha: 0.8) :
                                            colorMainAll[i % colorMainAll.length],
                                            value: percentValue,
                                            radius: isTouched ? 120 : 100,
                                            title: isTouched
                                                ? "${value.actual}%"
                                                : "${percentValue.toStringAsFixed(0)}%",
                                            titleStyle: getSemiBoldTextStyle(
                                                fontSize: 12, color: white),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                const Gap(16),
                                Visibility(
                                  visible: (resultData.microAssetStratagic?.isNotEmpty ?? false),
                                  child: Center(
                                    child: Wrap(
                                      spacing: 12,
                                      runSpacing: 8,
                                      alignment: WrapAlignment.center,
                                      children: (resultData.microAssetStratagic ?? []).where((e) => (e.asset ?? "") != "Total").toList().asMap().entries.map((entry) {

                                        final index = entry.key;
                                        final item = entry.value;

                                        return Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 14,
                                              height: 14,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: colorMainAll[index % colorMainAll.length],
                                              ),
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              item.asset ?? "",
                                              style: getMediumTextStyle(fontSize: 12, color: black),
                                            ),
                                          ],
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                                const Gap(20),
                              ],
                            ),
                          ),
                          Visibility(
                              visible: !isShowMicroAssetGraph && (resultData.macroAssetStratagic?.isNotEmpty ?? false),
                              child: microAssetAllocationListWidget()
                          ),
                        ],
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(8)
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Holder Allocation:",
                                  style: getMediumTextStyle(fontSize: 14, color: blue),
                                ),
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  setState(() {
                                    isShowApplicantGraph = !isShowApplicantGraph;
                                  });
                                },
                                child: Text(
                                  isShowApplicantGraph ? "Table" : "Graph",
                                  style: getBoldTextStyle(fontSize: 14, color: blue),
                                ),
                              )
                            ],
                          ),
                          const Gap(8),
                          Divider(color: gray,),
                          const Gap(8),
                          Visibility(
                            visible: isShowApplicantGraph,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 20, bottom: 10),
                                  height: 170,
                                  child: PieChart(
                                    PieChartData(
                                      sectionsSpace: 2,
                                      centerSpaceRadius: 0,
                                      startDegreeOffset: -100,
                                      pieTouchData: PieTouchData(
                                        touchCallback: (event, response) {
                                          setState(() {
                                            if (!event.isInterestedForInteractions || response == null || response.touchedSection == null)
                                            {
                                              touchedIndexApplicantDetail = -1;
                                              return;
                                            }
                                            touchedIndexApplicantDetail = response.touchedSection!.touchedSectionIndex;
                                          });
                                        },
                                      ),
                                      sections: List.generate(
                                        (resultData.applicantDetails ?? [])
                                            .where((e) => (e.applicant ?? "") != "Amount Total")
                                            .length,
                                            (i) {

                                          final filteredList = (resultData.applicantDetails ?? []).where((e) => (e.applicant ?? "") != "Amount Total").toList();
                                          final value = filteredList[i];
                                          final isTouched = i == touchedIndexApplicantDetail;
                                          final percentValue = (value.allocation ?? 0).toDouble();

                                          if (percentValue == 0)
                                          {
                                            return PieChartSectionData(value: 0);
                                          }

                                          return PieChartSectionData(
                                            showTitle: percentValue > 1,
                                            titlePositionPercentageOffset:
                                            percentValue < 1 ? 1.1 : 0.7,
                                            color: isTouched ? colorMainAll[i % colorMainAll.length].withValues(alpha: 0.8) :
                                            colorMainAll[i % colorMainAll.length],
                                            value: percentValue,
                                            radius: isTouched ? 120 : 100,
                                            title: isTouched
                                                ? "${value.allocation}%"
                                                : "${percentValue.toStringAsFixed(0)}%",
                                            titleStyle: getSemiBoldTextStyle(
                                                fontSize: 12, color: white),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                const Gap(16),
                                Visibility(
                                  visible: (resultData.applicantDetails?.isNotEmpty ?? false),
                                  child: Center(
                                    child: Wrap(
                                      spacing: 12,
                                      runSpacing: 8,
                                      alignment: WrapAlignment.center,
                                      children: (resultData.applicantDetails ?? []).where((e) => (e.applicant ?? "") != "Amount Total").toList().asMap().entries.map((entry) {

                                        final index = entry.key;
                                        final item = entry.value;

                                        return Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 14,
                                              height: 14,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: colorMainAll[index % colorMainAll.length],
                                              ),
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              item.applicant ?? "",
                                              style: getMediumTextStyle(fontSize: 12, color: black),
                                            ),
                                          ],
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                                const Gap(20),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: !isShowApplicantGraph && (resultData.applicantDetails?.isNotEmpty ?? false),
                            child: applicantAllocationListWidget()
                          ),
                        ],
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(8)
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Service Provider Diversification:",
                                  style: getMediumTextStyle(fontSize: 14, color: blue),
                                ),
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  setState(() {
                                    isShowServiceProviderGraph = !isShowServiceProviderGraph;
                                  });
                                },
                                child: Text(
                                  isShowServiceProviderGraph ? "Table" : "Graph",
                                  style: getBoldTextStyle(fontSize: 14, color: blue),
                                ),
                              )
                            ],
                          ),
                          const Gap(8),
                          Divider(color: gray,),
                          const Gap(8),
                          Visibility(
                            visible: isShowServiceProviderGraph,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 20, bottom: 10),
                                  height: 170,
                                  child: PieChart(
                                    PieChartData(
                                      sectionsSpace: 2,
                                      centerSpaceRadius: 0,
                                      startDegreeOffset: -100,
                                      pieTouchData: PieTouchData(
                                        touchCallback: (event, response) {
                                          setState(() {
                                            if (!event.isInterestedForInteractions || response == null || response.touchedSection == null)
                                            {
                                              touchedIndexServiceProvider = -1;
                                              return;
                                            }
                                            touchedIndexServiceProvider = response.touchedSection!.touchedSectionIndex;
                                          });
                                        },
                                      ),
                                      sections: List.generate(
                                        (resultData.serviceProviders ?? [])
                                            .where((e) => (e.serviceProvider ?? "") != "Total")
                                            .length,
                                            (i) {

                                          final filteredList = (resultData.serviceProviders ?? []).where((e) => (e.serviceProvider ?? "") != "Total").toList();
                                          final value = filteredList[i];
                                          final isTouched = i == touchedIndexServiceProvider;
                                          final percentValue = (value.allocation ?? 0).toDouble();

                                          if (percentValue == 0)
                                          {
                                            return PieChartSectionData(value: 0);
                                          }

                                          return PieChartSectionData(
                                            showTitle: percentValue > 1,
                                            titlePositionPercentageOffset:
                                            percentValue < 1 ? 1.1 : 0.7,
                                            color: isTouched ? colorMainAll[i % colorMainAll.length].withValues(alpha: 0.8) :
                                            colorMainAll[i % colorMainAll.length],
                                            value: percentValue,
                                            radius: isTouched ? 120 : 100,
                                            title: isTouched
                                                ? "${value.allocation}%"
                                                : "${percentValue.toStringAsFixed(0)}%",
                                            titleStyle: getSemiBoldTextStyle(
                                                fontSize: 12, color: white),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                const Gap(16),
                                Visibility(
                                  visible: (resultData.serviceProviders?.isNotEmpty ?? false),
                                  child: Center(
                                    child: Wrap(
                                      spacing: 12,
                                      runSpacing: 8,
                                      alignment: WrapAlignment.center,
                                      children: (resultData.serviceProviders ?? []).where((e) => (e.serviceProvider ?? "") != "Total").toList().asMap().entries.map((entry) {

                                        final index = entry.key;
                                        final item = entry.value;

                                        return Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 14,
                                              height: 14,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: colorMainAll[index % colorMainAll.length],
                                              ),
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              item.serviceProvider ?? "",
                                              style: getMediumTextStyle(fontSize: 12, color: black),
                                            ),
                                          ],
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                                const Gap(20),
                              ],
                            ),
                          ),
                          Visibility(
                              visible: !isShowServiceProviderGraph && (resultData.serviceProviders?.isNotEmpty ?? false),
                              child: serviceProviderAllocationListWidget()
                          ),
                        ],
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(8)
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Performance:",
                            style: getMediumTextStyle(fontSize: 14, color: blue),
                          ),
                          const Gap(8),
                          Divider(color: gray,),
                          const Gap(8),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    setState(() {
                                      isShowSinceInception = true;
                                      isShowCurrentYear = false;
                                      isShowPreviousYear = false;
                                    });
                                  },
                                  child: Text(
                                    "Since Inception",
                                    style: getMediumTextStyle(fontSize: 14, color: isShowSinceInception ? blue : black),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              const Gap(8),
                              Expanded(
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    setState(() {
                                      isShowCurrentYear = true;
                                      isShowSinceInception = false;
                                      isShowPreviousYear = false;
                                    });
                                  },
                                  child: Text(
                                    getCurrentFinancialYear(),
                                    style: getMediumTextStyle(fontSize: 14, color:  isShowCurrentYear ? blue : black),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              const Gap(8),
                              Expanded(
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    setState(() {
                                      isShowPreviousYear = true;
                                      isShowSinceInception = false;
                                      isShowCurrentYear = false;
                                    });
                                  },
                                  child: Text(
                                    getPreviousFinancialYear(),
                                    style: getMediumTextStyle(fontSize: 14, color: isShowPreviousYear ? blue : black),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Gap(4),
                          Row(
                            children: [
                              Expanded(
                                child: Divider(color: isShowSinceInception ? blue : Colors.transparent, height: 1, thickness: 1,),
                              ),
                              const Gap(8),
                              Expanded(
                                child: Divider(color: isShowCurrentYear ? blue : Colors.transparent, height: 1, thickness: 1,),
                              ),
                              const Gap(8),
                              Expanded(
                                child: Divider(color: isShowPreviousYear ? blue : Colors.transparent, height: 1, thickness: 1,),
                              ),
                            ],
                          ),
                          const Gap(16),
                          Visibility(
                            visible: isShowSinceInception,
                            child: performanceWidget(1),
                          ),
                          Visibility(
                            visible: isShowCurrentYear,
                            child: performanceWidget(2),
                          ),
                          Visibility(
                            visible: isShowPreviousYear,
                            child: performanceWidget(3),
                          )
                        ],
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(8)
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Allocation by Fund Houses:",
                            style: getMediumTextStyle(fontSize: 14, color: blue),
                          ),
                          const Gap(8),
                          Divider(color: gray,),
                          const Gap(8),
                          Visibility(
                            visible: resultData.fundHouseAllocation?.isNotEmpty ?? false,
                            child: fundHouseAllocationWidget()
                          ),
                          const Gap(10),
                          Text(
                            "*3 Fund houses with allocation below 2% should be sold or allocation should be increased in them if they are good to make the exposure meaningful.",
                            style: getMediumTextStyle(fontSize: 12, color: blackLight),
                          ),
                          const Gap(12),
                        ],
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(8)
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Allocation by Schemes:",
                            style: getMediumTextStyle(fontSize: 14, color: blue),
                          ),
                          const Gap(8),
                          Divider(color: gray,),
                          const Gap(8),
                          Visibility(
                            visible: resultData.schemeAllocation?.isNotEmpty ?? false,
                            child: schemeAllocationWidget(),
                          ),
                          const Gap(10),
                          Text(
                            "*35 Schemes with allocation below 2% should be sold or allocation should be increased in them if they are good to make the exposure meaningful.",
                            style: getMediumTextStyle(fontSize: 12, color: blackLight),
                          ),
                          const Gap(12),
                        ],
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(8)
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Last 30 Days Transactions:",
                            style: getMediumTextStyle(fontSize: 14, color: blue),
                          ),
                          const Gap(8),
                          Divider(color: gray,),
                          const Gap(8),
                          Visibility(
                            visible: listLast30DaysTransaction.isNotEmpty,
                            child: last30DaysTransactionWidget(),
                          ),
                          const Gap(12),
                        ],
                      ),
                    ),


                    // Container(
                    //   margin: const EdgeInsets.only(left: 16,right: 16),
                    //   child: Row(
                    //     children: [
                    //       const Text('Asset Allocation',
                    //           style: TextStyle(
                    //               color: blue,
                    //               fontSize: 16,
                    //               fontWeight:
                    //               FontWeight.w600)),
                    //       const Spacer(),
                    //       InkWell(
                    //         onTap: (){
                    //           setState(() {
                    //             _isShowTopTable = !_isShowTopTable;
                    //           });
                    //         },
                    //         child: Text(_isShowTopTable ? 'Graph' : 'Table',
                    //             style: const TextStyle(
                    //                 color: blue,
                    //                 fontSize: 16,
                    //                 fontWeight:
                    //                 FontWeight.w600)),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // const Gap(16),
                    // _isShowTopTable
                    //     ? setUpAssetAllocationTopTableData()
                    //     : SizedBox(
                    //   height: 250,
                    //   child: PieChart(
                    //     PieChartData(
                    //       pieTouchData: PieTouchData(
                    //         touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    //           setState(() {
                    //             if (!event.isInterestedForInteractions ||
                    //                 pieTouchResponse == null ||
                    //                 pieTouchResponse.touchedSection == null) {
                    //               touchedIndexAsset = -1;
                    //               return;
                    //             }
                    //             touchedIndexAsset = pieTouchResponse
                    //                 .touchedSection!.touchedSectionIndex;
                    //           });
                    //         },
                    //       ),
                    //       borderData: FlBorderData(
                    //         show: false,
                    //       ),
                    //       sectionsSpace: 0,
                    //       centerSpaceRadius: 60,
                    //       sections: generateAssetAllocationChart(),
                    //     ),
                    //   ),
                    // ),
                    // const Gap(16),
                    // _isShowTopTable ? Container () : Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: List.generate(resultData.macroAssetStratagic?.isNotEmpty ?? false ? (resultData.macroAssetStratagic?.length ?? 0) - 1 : 0, (i) {
                    //     return resultData.macroAssetStratagic![i].actual != 0 ? Container(
                    //       margin: const EdgeInsets.all(6),
                    //       child: Indicator(
                    //         color: colorsAssetAllocation[i],
                    //         text: resultData.macroAssetStratagic![i].asset.toString(),
                    //         isSquare: false,
                    //         size: touchedIndexAsset == i ? 18 : 16,
                    //         textColor: touchedIndexAsset == i
                    //             ? Colors.black
                    //             : Colors.black38,
                    //       ),
                    //     ) : Container();
                    //   }),
                    // ),
                    // const Gap(16),
                    // Container(
                    //   margin: const EdgeInsets.only(left: 16,right: 16),
                    //   child: Row(
                    //     children: [
                    //       const Text('Applicants Allocation : ',
                    //           style: TextStyle(
                    //               color: blue,
                    //               fontSize: 16,
                    //               fontWeight:
                    //               FontWeight.w600)),
                    //       const Spacer(),
                    //       InkWell(
                    //         onTap: (){
                    //           setState(() {
                    //             _isShowTable = !_isShowTable;
                    //           });
                    //         },
                    //         child: Text(_isShowTable ? 'Graph' : 'Table',
                    //             style: const TextStyle(
                    //                 color: blue,
                    //                 fontSize: 16,
                    //                 fontWeight:
                    //                 FontWeight.w600)),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // const Gap(16),
                    // _isShowTable ? setUpApplicantsData() : SizedBox(
                    //   height: 250,
                    //   child: PieChart(
                    //     PieChartData(
                    //       pieTouchData: PieTouchData(
                    //         touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    //           setState(() {
                    //             if (!event.isInterestedForInteractions ||
                    //                 pieTouchResponse == null || pieTouchResponse.touchedSection == null) {
                    //               touchedIndexApplicant = -1;
                    //               return;
                    //             }
                    //             touchedIndexApplicant = pieTouchResponse.touchedSection!.touchedSectionIndex;
                    //           });
                    //         },
                    //       ),
                    //       borderData: FlBorderData(
                    //         show: false,
                    //       ),
                    //       sectionsSpace: 0,
                    //       centerSpaceRadius: 60,
                    //       sections: generateApplicantsChart(),
                    //     ),
                    //   ),
                    // ),
                    // const Gap(16),
                    // _isShowTable ? Container() :Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: List.generate(resultData.applicantDetails?.isNotEmpty ?? false ? (resultData.applicantDetails?.length ?? 0) - 1 : 0, (i) {
                    //     return resultData.applicantDetails![i].allocation != 0 ? Container(
                    //       margin: const EdgeInsets.all(6),
                    //       child: Indicator(
                    //         color: colorsApplicantAllocation[i],
                    //         text: resultData.applicantDetails![i].applicant.toString(),
                    //         isSquare: false,
                    //         size: touchedIndexApplicant == i ? 18 : 16,
                    //         textColor: touchedIndexApplicant == i
                    //             ? Colors.black
                    //             : Colors.black38,
                    //       ),
                    //     ) : Container();
                    //   }),
                    // ),
                    // const Gap(16),
                    // Container(
                    //   margin: const EdgeInsets.only(left: 16),
                    //   child: const Text('Asset Allocation - Strategic : ',
                    //       style: TextStyle(
                    //           color: blue,
                    //           fontSize: 16,
                    //           fontWeight:
                    //           FontWeight.w600)),
                    // ),
                    // const Gap(16),
                    // setUpAssetAllocationStrategicTab(),
                    // _isVisibleStrategic
                    //     ? setUpAssetAllocationStrategicMacroData()
                    //     : setUpAssetAllocationStrategicMicroData(),
                    // const Gap(16),
                    // Container(
                    //   margin: const EdgeInsets.only(left: 16),
                    //   child: const Text('Asset Allocation - Tactical : ',
                    //       style: TextStyle(
                    //           color: blue,
                    //           fontSize: 16,
                    //           fontWeight:
                    //           FontWeight.w600)),
                    // ),
                    // const Gap(16),
                    // setUpAssetAllocationTacticalTab(),
                    // _isVisibleTactical
                    //     ? setUpAssetAllocationTacticalMacroData()
                    //     : setUpAssetAllocationTacticalMicroData(),
                    // const Gap(16),
                    // Container(
                    //   width: double.infinity,
                    //   margin: const EdgeInsets.only(left: 16),
                    //   child: Text('*Equity market is overvalued by ${percentageResponse.masterMarketPercentage}%',textAlign: TextAlign.center,
                    //       style: const TextStyle(
                    //           color: blue,
                    //           fontSize: 16,
                    //           fontStyle: FontStyle.italic,
                    //           fontWeight: FontWeight.bold)),
                    // ),
                    // const Gap(16),
                    // Container(
                    //   margin: const EdgeInsets.only(left: 16),
                    //   child: const Text('Performance : ',
                    //       style: TextStyle(
                    //           color: blue,
                    //           fontSize: 16,
                    //           fontWeight:
                    //           FontWeight.w600)),
                    // ),
                    // const Gap(16),
                    // setUpPerformanceTab(),
                    // _isSinceInceptionLoading
                    //     ? const CPDashboardLoadingWidget()
                    //     : _isVisibleSinceInception
                    //     ? setUpSinceInceptionData()
                    //     : _isCurrentYearXIRRLoading
                    //     ? const CPDashboardLoadingWidget()
                    //     : _isVisible2023_24
                    //     ? setUpCurrentYearXIRRData()
                    //     : _isPreviousYearXIRRLoading
                    //     ? const CPDashboardLoadingWidget()
                    //     : setUpPreviousYearXIRRData(),
                    // const Gap(16)
                  ],
                ),))
    );
  }

  Widget macroAssetAllocationListWidget(){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Container(
        width: 462,
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: gray), left: BorderSide(color: gray), right: BorderSide(color: gray)),
          borderRadius: BorderRadius.circular(4)
        ),
        child: Column(
          children: [
            Row(
              children: [
                rowCellTitle("Asset Class", white, alignment: Alignment.centerLeft, isPadding: true, width: 100),
                rowCellTitle("Actual Amount", white, width: 120),
                rowCellTitle("Actual%", white, width: 80),
                rowCellTitle("Policy%", white, width: 80),
                rowCellTitle("Variance", white, width: 80),
              ],
            ),
            ListView.builder(
              itemCount: resultData.macroAssetStratagic?.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              itemBuilder: (context, index) {
                final macroData = resultData.macroAssetStratagic?[index];
                final isTotal = (macroData?.asset ?? "") == "Total";
                final variationValue = double.tryParse("${macroData?.variation}") ?? 0;
                return Row(
                  children: [
                    rowCell(index, "${macroData?.asset}", alignment: Alignment.centerLeft, isPadding: true, width: 100, isBold: isTotal),
                    rowCell(index, convertCommaSeparatedAmount("${macroData?.amount}") , width: 120, isBold: isTotal),
                    rowCell(index, "${macroData?.actual}%", titleColor: black, width: 80, isBold: isTotal),
                    rowCell(index, "${macroData?.policy}%", titleColor: black, width: 80, isBold: isTotal),
                    rowCell(index, "${macroData?.variation}%", titleColor: getValueColor(variationValue), width: 80, isBold: isTotal),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget microAssetAllocationListWidget(){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Container(
        width: 462,
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: gray), left: BorderSide(color: gray), right: BorderSide(color: gray)),
            borderRadius: BorderRadius.circular(4)
        ),
        child: Column(
          children: [
            Row(
              children: [
                rowCellTitle("Asset Class", white, alignment: Alignment.centerLeft, isPadding: true, width: 100),
                rowCellTitle("Actual Amount", white, width: 120),
                rowCellTitle("Actual%", white, width: 80),
                rowCellTitle("Policy%", white, width: 80),
                rowCellTitle("Variance", white, width: 80),
              ],
            ),
            ListView.builder(
              itemCount: resultData.microAssetStratagic?.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              itemBuilder: (context, index) {
                final microData = resultData.microAssetStratagic?[index];
                final isTotal = (microData?.asset ?? "") == "Total";
                final variationValue = double.tryParse("${microData?.variation}") ?? 0;
                return Row(
                  children: [
                    rowCell(index, "${microData?.asset}", alignment: Alignment.centerLeft, isPadding: true, width: 100, isBold: isTotal),
                    rowCell(index, convertCommaSeparatedAmount("${microData?.amount}") , width: 120, isBold: isTotal),
                    rowCell(index, "${microData?.actual}%", titleColor: black, width: 80, isBold: isTotal),
                    rowCell(index, "${microData?.policy}%", titleColor: black, width: 80, isBold: isTotal),
                    rowCell(index, "${microData?.variation}%", titleColor: getValueColor(variationValue), width: 80, isBold: isTotal),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget applicantAllocationListWidget(){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Container(
        width: 452,
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: gray), left: BorderSide(color: gray), right: BorderSide(color: gray)),
          borderRadius: BorderRadius.circular(4)
        ),
        child: Column(
          children: [
            Row(
              children: [
                rowCellTitle("Holder Name", white, alignment: Alignment.centerLeft, isPadding: true, width: 160),
                rowCellTitle("Amount", white, width: 140),
                rowCellTitle("Allocation%", white, width: 150),
              ],
            ),
            ListView.builder(
              itemCount: resultData.applicantDetails?.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              itemBuilder: (context, index) {
                final applicantData = resultData.applicantDetails?[index];
                final isTotal = (applicantData?.applicant ?? "") == "Amount Total";
                return Row(
                  children: [
                    rowCell(index, "${applicantData?.applicant}", alignment: Alignment.centerLeft, isPadding: true, width: 160, isBold: isTotal),
                    rowCell(index, convertCommaSeparatedAmount("${applicantData?.amount}") , width: 140, isBold: isTotal),
                    rowCell(index, "${applicantData?.allocation}%", titleColor: black, width: 150, isBold: isTotal),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget serviceProviderAllocationListWidget(){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Container(
        width: 452,
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: gray), left: BorderSide(color: gray), right: BorderSide(color: gray)),
            borderRadius: BorderRadius.circular(4)
        ),
        child: Column(
          children: [
            Row(
              children: [
                rowCellTitle("Holder Name", white, alignment: Alignment.centerLeft, isPadding: true, width: 160),
                rowCellTitle("Amount", white, width: 140),
                rowCellTitle("Allocation%", white, width: 150),
              ],
            ),
            ListView.builder(
              itemCount: resultData.serviceProviders?.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              itemBuilder: (context, index) {
                final serviceProvider = resultData.serviceProviders?[index];
                final isTotal = (serviceProvider?.serviceProvider ?? "") == "Total";
                return Row(
                  children: [
                    rowCell(index, "${serviceProvider?.serviceProvider}", alignment: Alignment.centerLeft, isPadding: true, width: 160, isBold: isTotal),
                    rowCell(index, convertCommaSeparatedAmount("${serviceProvider?.amount}") , width: 140, isBold: isTotal),
                    rowCell(index, "${serviceProvider?.allocation}%", titleColor: black, width: 150, isBold: isTotal),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget performanceWidget(int isFor){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Container(
        width: 672,
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: gray), left: BorderSide(color: gray), right: BorderSide(color: gray)),
            borderRadius: BorderRadius.circular(4)
        ),
        child: Column(
          children: [
            Row(
              children: [
                rowCellTitle("Assets", white, alignment: Alignment.centerLeft, isPadding: true, width: 130),
                rowCellTitle("Invested Amount", white, width: 140),
                rowCellTitle("Current Value", white, width: 140),
                rowCellTitle("Gain", white, width: 140),
                rowCellTitle("XIRR", white, width: 120),
              ],
            ),
            isFor == 1 ?
            ListView.builder(
              itemCount: listSinceInceptionNew.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              itemBuilder: (context, index) {
                final performanceData = listSinceInceptionNew[index];
                final isTotal = (performanceData.asset ?? "") == "Overall";
                final gainValue = double.tryParse("${performanceData.xirr}") ?? 0;
                return Row(
                  children: [
                    rowCell(index, "${performanceData.asset}", alignment: Alignment.centerLeft, isPadding: true, width: 130, isBold: isTotal),
                    rowCell(index, convertCommaSeparatedAmount("${performanceData.investedAmount}") , width: 140, isBold: isTotal),
                    rowCell(index, convertCommaSeparatedAmount("${performanceData.currentValue}") , width: 140, isBold: isTotal),
                    rowCell(index, convertCommaSeparatedAmount("${performanceData.gain}") , width: 140, isBold: isTotal),
                    rowCell(index, "${performanceData.xirr}%", titleColor: getValueColor(gainValue), width: 120, isBold: isTotal),
                  ],
                );
              },
            ) :
            isFor == 2 ?
            ListView.builder(
              itemCount: listCurrentYearXIRRNew.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              itemBuilder: (context, index) {
                final performanceData = listCurrentYearXIRRNew[index];
                final isTotal = (performanceData.asset ?? "") == "Overall";
                final gainValue = double.tryParse("${performanceData.xirr}") ?? 0;
                return Row(
                  children: [
                    rowCell(index, "${performanceData.asset}", alignment: Alignment.centerLeft, isPadding: true, width: 130, isBold: isTotal),
                    rowCell(index, convertCommaSeparatedAmount("${performanceData.investedAmount}") , width: 140, isBold: isTotal),
                    rowCell(index, convertCommaSeparatedAmount("${performanceData.currentValue}") , width: 140, isBold: isTotal),
                    rowCell(index, convertCommaSeparatedAmount("${performanceData.gain}") , width: 140, isBold: isTotal),
                    rowCell(index, "${performanceData.xirr}%", titleColor: getValueColor(gainValue), width: 120, isBold: isTotal),
                  ],
                );
              },
            ) :
            ListView.builder(
              itemCount: listPreviousYearXIRRNew.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              itemBuilder: (context, index) {
                final performanceData = listPreviousYearXIRRNew[index];
                final isTotal = (performanceData.asset ?? "") == "Overall";
                final gainValue = double.tryParse("${performanceData.xirr}") ?? 0;
                return Row(
                  children: [
                    rowCell(index, "${performanceData.asset}", alignment: Alignment.centerLeft, isPadding: true, width: 130, isBold: isTotal),
                    rowCell(index, convertCommaSeparatedAmount("${performanceData.investedAmount}") , width: 140, isBold: isTotal),
                    rowCell(index, convertCommaSeparatedAmount("${performanceData.currentValue}") , width: 140, isBold: isTotal),
                    rowCell(index, convertCommaSeparatedAmount("${performanceData.gain}") , width: 140, isBold: isTotal),
                    rowCell(index, "${performanceData.xirr}%", titleColor: getValueColor(gainValue), width: 120, isBold: isTotal),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget fundHouseAllocationWidget(){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Container(
        width: 532,
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: gray), left: BorderSide(color: gray), right: BorderSide(color: gray)),
            borderRadius: BorderRadius.circular(4)
        ),
        child: Column(
          children: [
            Row(
              children: [
                rowCellTitle("Fund Name", white, alignment: Alignment.centerLeft, isPadding: true, width: 240),
                rowCellTitle("Present Value", white, width: 140),
                rowCellTitle("Allocation%", white, width: 150),
              ],
            ),
            ListView.builder(
              itemCount: resultData.fundHouseAllocation?.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              itemBuilder: (context, index) {
                final fundAllocationData = resultData.fundHouseAllocation?[index];
                final isTotal = (fundAllocationData?.fundHouse ?? "") == "Total";
                final allocationValue = double.tryParse("${fundAllocationData?.allocation}") ?? 0;
                return Row(
                  children: [
                    rowCell(index, "${fundAllocationData?.fundHouse}", alignment: Alignment.centerLeft, titleColor: getValueColorFundHouse(allocationValue), isPadding: true, width: 240, isBold: isTotal),
                    rowCell(index, convertCommaSeparatedAmount("${fundAllocationData?.currentValue}"), titleColor: getValueColorFundHouse(allocationValue), width: 140, isBold: isTotal),
                    rowCell(index, "${fundAllocationData?.allocation}%", titleColor: getValueColorFundHouse(allocationValue), width: 150, isBold: isTotal),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget schemeAllocationWidget(){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Container(
        width: 682,
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: gray), left: BorderSide(color: gray), right: BorderSide(color: gray)),
            borderRadius: BorderRadius.circular(4)
        ),
        child: Column(
          children: [
            Row(
              children: [
                rowCellTitle("Scheme Name", white, alignment: Alignment.centerLeft, isPadding: true, width: 240),
                rowCellTitle("Type", white, width: 150),
                rowCellTitle("Present Value", white, width: 150),
                rowCellTitle("Allocation%", white, width: 140),
              ],
            ),
            ListView.builder(
              itemCount: resultData.schemeAllocation?.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              itemBuilder: (context, index) {
                final schemeAllocationData = resultData.schemeAllocation?[index];
                final isTotal = (schemeAllocationData?.schemeName ?? "") == "Total";
                final allocationValue = double.tryParse("${schemeAllocationData?.allocation}") ?? 0;
                return Row(
                  children: [
                    rowCell(index, "${schemeAllocationData?.schemeName}", alignment: Alignment.centerLeft, titleColor: getValueColorFundHouse(allocationValue), isPadding: true, width: 240, isBold: isTotal, maxLine: 2),
                    rowCell(index, "${schemeAllocationData?.category}", titleColor: getValueColorFundHouse(allocationValue), width: 150, isBold: isTotal, maxLine: 2),
                    rowCell(index, convertCommaSeparatedAmount("${schemeAllocationData?.currentValue}"), titleColor: getValueColorFundHouse(allocationValue), width: 150, isBold: isTotal, maxLine: 2),
                    rowCell(index, "${schemeAllocationData?.allocation}%", titleColor: getValueColorFundHouse(allocationValue), width: 140, isBold: isTotal, maxLine: 2),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget last30DaysTransactionWidget(){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Container(
        width: 1132,
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: gray), left: BorderSide(color: gray), right: BorderSide(color: gray)),
            borderRadius: BorderRadius.circular(4)
        ),
        child: Column(
          children: [
            Row(
              children: [
                rowCellTitle("Fund Name", white, alignment: Alignment.centerLeft, isPadding: true, width: 240),
                rowCellTitle("Folio No", white, width: 150),
                rowCellTitle("Tran Date", white, width: 150),
                rowCellTitle("Amount", white, width: 150),
                rowCellTitle("Holder", white, width: 160),
                rowCellTitle("Status", white, width: 140),
                rowCellTitle("Type", white, width: 140),
              ],
            ),
            ListView.builder(
              itemCount: listLast30DaysTransaction.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              itemBuilder: (context, index) {
                final transactionData = listLast30DaysTransaction[index];
                final isTotal = (transactionData.schemeName ?? "") == "Total";
                return Row(
                  children: [
                    rowCell(index, "${transactionData.schemeName}", alignment: Alignment.centerLeft, isPadding: true, width: 240, isBold: isTotal, maxLine: 2),
                    rowCell(index, "${transactionData.folioNo}", width: 150, isBold: isTotal, maxLine: 2),
                    rowCell(index, "${transactionData.tranDate}", width: 150, isBold: isTotal, maxLine: 2),
                    rowCell(index, convertCommaSeparatedAmount("${transactionData.amount}"), width: 150, isBold: isTotal, maxLine: 2),
                    rowCell(index, "${transactionData.applicant}", width: 160, isBold: isTotal, maxLine: 2),
                    rowCell(index, "${transactionData.nature}", width: 140, isBold: isTotal, maxLine: 2),
                    rowCell(index, "${transactionData.type}", width: 140, isBold: isTotal, maxLine: 2),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> generateAssetAllocationChart() {
    return List.generate(resultData.macroAssetStratagic?.isNotEmpty ?? false ? (resultData.macroAssetStratagic?.length ?? 0) - 1 : 0, (i) {
      final isTouched = i == touchedIndexAsset;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      return PieChartSectionData(
        color: colorsAssetAllocation[i],
        value: resultData.macroAssetStratagic![i].actual!.toDouble(),
        title: "${resultData.macroAssetStratagic![i].actual!}%",
        radius: radius,
        borderSide: isTouched
            ?  const BorderSide(
            color: Colors.white, width: 2)
            : BorderSide(
            color: Colors.white.withOpacity(0)),
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: white,
          shadows: shadows,
        ),
      );
    });
  }

  List<PieChartSectionData> generateApplicantsChart() {
    return List.generate(
        resultData.applicantDetails?.isNotEmpty ?? false ? (resultData.applicantDetails?.length ?? 0) - 1 : 0,
            (i) {
      final isTouched = i == touchedIndexApplicant;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      return PieChartSectionData(
        color: colorsApplicantAllocation[i],
        value: resultData.applicantDetails![i].allocation?.toDouble(),
        title: "${resultData.applicantDetails?[i].allocation ?? 0}%",
        radius: radius,
        borderSide: isTouched
            ?  const BorderSide(
            color: Colors.white, width: 2)
            : BorderSide(
            color: Colors.white.withOpacity(0)),
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: white,
          shadows: shadows,
        ),
      );
    },
    );
  }

  Widget setUpAssetAllocationTopTableData() {
    return Center(
        child: Container(
          margin: const EdgeInsets.only(top: 10, left: 12, right: 12),
          decoration: BoxDecoration(
            border: Border.all(width: 0.8, color: blue),
            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
          ),
          child: Column(children: <Widget>[
            IntrinsicHeight(
              child: Row(children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(3),
                    child:
                    const Text('Asset', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
                const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(3),
                    child:
                    const Text('Actual\nAmount', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
                const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(3),
                    child:
                    const Text('Allocation%', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
              ]),
            ),
            const Divider(height: 1.0, thickness: 1.0,color: blue, indent: 0.0, endIndent: 0.0),
            resultData.macroAssetStratagic!.isNotEmpty
                ? ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: resultData.macroAssetStratagic!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(3),
                                child: Text(resultData.macroAssetStratagic![index].asset.toString(),
                                    style: resultData.macroAssetStratagic![index].asset.toString().toLowerCase() == "total" ? const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: black) : const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                            const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                            Flexible(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(3),
                                child: Container(
                                  margin: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
                                  child:Text(convertCommaSeparatedAmount(resultData.macroAssetStratagic![index].amount.toString()),
                                      style: resultData.macroAssetStratagic![index].asset.toString().toLowerCase() == "total" ? const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: black) : const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            ),
                            const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                            Flexible(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(3),
                                child: Container(
                                  margin: const EdgeInsets.only(left: 8, right:8, top: 8, bottom: 8),
                                  child: Text(resultData.macroAssetStratagic![index].actual.toString(),
                                      style: resultData.macroAssetStratagic![index].asset.toString().toLowerCase() == "total" ? const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: black) : const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                          visible: index != resultData.macroAssetStratagic!.length - 1,
                          child: const Divider(height: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0)),
                    ],
                  );
                })
                : Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(100),
              child: const Text("No data found",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: black),
                  textAlign: TextAlign.center),
            ),
          ]),
        )
    );
  }

  Widget setUpApplicantsData() {
    return Center(
        child: Container(
          margin: const EdgeInsets.only(top: 10, left: 12, right: 12),
          decoration: BoxDecoration(
            border: Border.all(width: 0.8, color: blue),
            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
          ),
          child: Column(children: <Widget>[
            IntrinsicHeight(
              child: Row(children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.all(6),
                    child:
                    const Text('Name', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
                const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.all(6),
                    child:
                    const Text('Current Amount', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
                const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.all(6),
                    child:
                    const Text('Allocation%', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
              ]),
            ),
            const Divider(height: 1.0, thickness: 1.0,color: blue, indent: 0.0, endIndent: 0.0),
            resultData.applicantDetails!.isNotEmpty
                ? ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: resultData.applicantDetails!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(3),
                                child: Text(resultData.applicantDetails![index].applicant.toString(),
                                    style: resultData.applicantDetails![index].applicant.toString().toLowerCase() == "amount total" ? const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: black) : const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                            const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                            Flexible(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(3),
                                child: Container(
                                  margin: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
                                  child:Text(convertCommaSeparatedAmount(resultData.applicantDetails![index].amount.toString()),
                                      style: resultData.applicantDetails![index].applicant.toString().toLowerCase() == "amount total" ? const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: black) : const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            ),
                            const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                            Flexible(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(3),
                                child: Container(
                                  margin: const EdgeInsets.only(left: 8, right:8, top: 8, bottom: 8),
                                  child: Text(doubleUpto2Digit(resultData.applicantDetails?[index].allocation?.toDouble() ?? 0.0).toString(),
                                      style: resultData.applicantDetails![index].applicant.toString().toLowerCase() == "amount total" ? const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: black) : const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Visibility(
                          visible: index != resultData.applicantDetails!.length - 1,
                          child: const Divider(height: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0)),
                    ],
                  );
                })
                : Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(100),
                    child: const Text("No data found",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: black),
                        textAlign: TextAlign.center),
                  ),
                ]
                ),
              )
    );
  }

  Widget setUpAssetAllocationStrategicTab() {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8),
      child: Row(
        children: [
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border(
                  bottom: _isVisibleStrategic ? const BorderSide(color: blue) : const BorderSide(color: Colors.transparent),
                ),
              ),
              child: TextButton(
                onPressed: () {
                  _changedStrategic(true);
                },
                child: _isVisibleStrategic ? const Text('Macro', style:TextStyle(fontSize: 17, fontWeight: FontWeight.bold,color: blue)) :
                const Text('Macro', style:TextStyle(fontSize: 17, fontWeight: FontWeight.bold,color: black)),
              ),
            ),
          ),
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border(
                  bottom: !_isVisibleStrategic ? const BorderSide(color: blue) : const BorderSide(color: Colors.transparent),
                ),
              ),
              child: TextButton(
                onPressed: () {
                  _changedStrategic(false);
                },
                child: !_isVisibleStrategic ? const Text('Micro',style:TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: blue)) :
                const Text('Micro',style:TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: black)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget setUpAssetAllocationStrategicMacroData() {
    return Center(
        child: Container(
          margin: const EdgeInsets.only(top: 10, left: 12, right: 12),
          decoration: BoxDecoration(
            border: Border.all(width: 0.8, color: blue),
            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
          ),
          child: Column(children: <Widget>[
            IntrinsicHeight(
              child: Row(children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(3),
                    child:
                    const Text('Asset', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
                const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                Flexible(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(3),
                    child:
                    const Text('Actual\nAmount', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
                const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(3),
                    child:
                    const Text('Actual\n%', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
                const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(3),
                    child:
                    const Text('Policy\n%', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
                const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(3),
                    child: const Text('Variance', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
              ]),
            ),
            const Divider(height: 1.0, thickness: 1.0,color: blue, indent: 0.0, endIndent: 0.0),
            resultData.macroAssetStratagic?.isNotEmpty ?? false
                ? ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: resultData.macroAssetStratagic!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(3),
                                child: Text(resultData.macroAssetStratagic?[index].asset ?? "",
                                    style: resultData.macroAssetStratagic?[index].asset.toString().toLowerCase() == "total" ? const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: black) : const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                            const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                            Flexible(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(3),
                                child: Container(
                                  margin: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
                                  child:Text(convertCommaSeparatedAmount(resultData.macroAssetStratagic![index].amount.toString()),
                                      style: resultData.macroAssetStratagic?[index].asset.toString().toLowerCase() == "total" ? const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: black) :  const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            ),
                            const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                            Flexible(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(3),
                                child: Container(
                                  margin: const EdgeInsets.only(left: 8, right:8, top: 8, bottom: 8),
                                  child: Text(resultData.macroAssetStratagic![index].actual.toString(),
                                      style: resultData.macroAssetStratagic?[index].asset.toString().toLowerCase() == "total" ? const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: black) : const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            ),
                            const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                            Flexible(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(3),
                                child: Container(
                                  margin: const EdgeInsets.only(left:8, right:8, top: 8, bottom: 8),
                                  child: Text(resultData.macroAssetStratagic![index].policy.toString(),
                                      style: resultData.macroAssetStratagic?[index].asset.toString().toLowerCase() == "total" ? const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: black) : const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            ),
                            const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                            Flexible(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(3),
                                child: Container(
                                  margin: const EdgeInsets.only(left:8, right:8, top: 8, bottom: 8),
                                  child: Text("${resultData.macroAssetStratagic![index].variation.toString()}%",
                                      style:resultData.macroAssetStratagic?[index].asset.toString().toLowerCase() == "total" ? const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: black) :  const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                          visible: index != resultData.macroAssetStratagic!.length - 1,
                          child: const Divider(height: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0)),
                    ],
                  );
                })
                : Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(100),
                  child: const Text("No data found",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: black),
                      textAlign: TextAlign.center),
                ),
          ]),
        )
    );
  }

  Widget setUpAssetAllocationStrategicMicroData() {
    return Center(
        child: Container(
          margin: const EdgeInsets.only(top: 10, left: 12, right: 12),
          decoration: BoxDecoration(
            border: Border.all(width: 0.8, color: blue),
            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
          ),
          child: Column(children: <Widget>[
            IntrinsicHeight(
              child: Row(children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(3),
                    child:
                    const Text('Asset', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
                const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                Flexible(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(3),
                    child:
                    const Text('Actual\nAmount', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
                const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(3),
                    child:
                    const Text('Actual\n%', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
                const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(3),
                    child:
                    const Text('Policy\n%', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
                const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(3),
                    child: const Text('Variance', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
              ]),
            ),
            const Divider(height: 1.0, thickness: 1.0,color: blue, indent: 0.0, endIndent: 0.0),
            resultData.microAssetStratagic!.isNotEmpty
                ? ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: resultData.microAssetStratagic!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(3),
                                child: Text(resultData.microAssetStratagic![index].asset.toString(),
                                    style: resultData.microAssetStratagic?[index].asset.toString().toLowerCase() == "total" ? const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: black) : const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                            const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                            Flexible(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(3),
                                child: Container(
                                  margin: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
                                  child:Text(convertCommaSeparatedAmount(resultData.microAssetStratagic![index].amount.toString()),
                                      style: resultData.microAssetStratagic?[index].asset.toString().toLowerCase() == "total" ? const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: black) : const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            ),
                            const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                            Flexible(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(3),
                                child: Container(
                                  margin: const EdgeInsets.only(left: 8, right:8, top: 8, bottom: 8),
                                  child: Text(resultData.microAssetStratagic![index].actual.toString(),
                                      style: resultData.microAssetStratagic?[index].asset.toString().toLowerCase() == "total" ? const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: black) : const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            ),
                            const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                            Flexible(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(3),
                                child: Container(
                                  margin: const EdgeInsets.only(left:8, right:8, top: 8, bottom: 8),
                                  child: Text(resultData.microAssetStratagic![index].policy.toString(),
                                      style: resultData.microAssetStratagic?[index].asset.toString().toLowerCase() == "total" ? const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: black) : const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            ),
                            const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                            Flexible(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(3),
                                child: Container(
                                  margin: const EdgeInsets.only(left:8, right:8, top: 8, bottom: 8),
                                  child: Text("${resultData.microAssetStratagic![index].variation.toString()}%",
                                      style: resultData.microAssetStratagic?[index].asset.toString().toLowerCase() == "total"
                                          ? const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: black)
                                          : const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                          visible: index != resultData.microAssetStratagic!.length - 1,
                          child: const Divider(height: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0)),
                      // Visibility(
                      //     visible: index != categoryAnalysisResponse.data!.length - 1 ? true : false,
                      //     child: const Divider(height: 1.0, color: kPurple700Color, indent: 0.0, endIndent: 0.0),
                      // ),
                    ],
                  );
                })
                : Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(100),
              child: const Text("No data found",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: black),
                  textAlign: TextAlign.center),
            ),
          ]),
        )
    );
  }

  Widget setUpAssetAllocationTacticalTab() {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8),
      child: Row(
        children: [
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border(
                  bottom: _isVisibleTactical ? const BorderSide(color: blue) : const BorderSide(color: Colors.transparent),
                ),
              ),
              child: TextButton(
                onPressed: () {
                  _changedTactical(true);
                },
                child: _isVisibleTactical ? const Text('Macro', style:TextStyle(fontSize: 17, fontWeight: FontWeight.bold,color: blue)) :
                const Text('Macro', style:TextStyle(fontSize: 17, fontWeight: FontWeight.bold,color: black)),
              ),
            ),
          ),
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border(
                  bottom: !_isVisibleTactical ? const BorderSide(color: blue) : const BorderSide(color: Colors.transparent),
                ),
              ),
              child: TextButton(
                onPressed: () {
                  _changedTactical(false);
                },
                child: !_isVisibleTactical ? const Text('Micro',style:TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: blue)) :
                const Text('Micro',style:TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: black)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget setUpAssetAllocationTacticalMacroData() {
    return Center(
        child: Container(
          margin: const EdgeInsets.only(top: 10, left: 12, right: 12),
          decoration: BoxDecoration(
            border: Border.all(width: 0.8, color: blue),
            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
          ),
          child: Column(children: <Widget>[
            IntrinsicHeight(
              child: Row(
                  children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(3),
                    child:
                    const Text('Asset', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
                const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                Flexible(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(3),
                    child:
                    const Text('Actual\nAmount', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
                const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(3),
                    child:
                    const Text('Actual\n%', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
                const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(3),
                    child:
                    const Text('Policy\n%', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
                const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(3),
                    child:
                    const Text('Variance', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
              ]
              ),
            ),
            const Divider(height: 1.0, thickness: 1.0,color: blue, indent: 0.0, endIndent: 0.0),
            resultData.macroAssetTactical?.isNotEmpty ?? false
                ? ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: resultData.macroAssetTactical!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(3),
                                child: Text(resultData.macroAssetTactical![index].asset.toString(),
                                    style: resultData.macroAssetTactical?[index].asset.toString().toLowerCase() == "total" ? const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: black) :  const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                            const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                            Flexible(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(3),
                                child: Container(
                                  margin: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
                                  child:Text(convertCommaSeparatedAmount(resultData.macroAssetTactical![index].amount.toString()),
                                      style:resultData.macroAssetTactical?[index].asset.toString().toLowerCase() == "total" ? const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: black) :  const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            ),
                            const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                            Flexible(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(3),
                                child: Container(
                                  margin: const EdgeInsets.only(left: 8, right:8, top: 8, bottom: 8),
                                  child: Text(resultData.macroAssetTactical![index].actual.toString(),
                                      style: resultData.macroAssetTactical?[index].asset.toString().toLowerCase() == "total" ? const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: black) : const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            ),
                            const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                            Flexible(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(3),
                                child: Container(
                                  margin: const EdgeInsets.only(left:8, right:8, top: 8, bottom: 8),
                                  child: Text(resultData.macroAssetTactical![index].policy.toString(),
                                      style: resultData.macroAssetTactical?[index].asset.toString().toLowerCase() == "total" ? const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: black) : const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            ),
                            const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                            Flexible(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(3),
                                child: Container(
                                  margin: const EdgeInsets.only(left:8, right:8, top: 8, bottom: 8),
                                  child: Text("${resultData.macroAssetTactical![index].variation.toString()}%",
                                      style: resultData.macroAssetTactical?[index].asset.toString().toLowerCase() == "total" ? const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: black) : const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                          visible: index != resultData.macroAssetTactical!.length - 1,
                          child: const Divider(height: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0)),
                    ],
                  );
                })
                : Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(100),
                    child: const Text("No data found",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: black),
                        textAlign: TextAlign.center),
                  ),
          ]),
        )
    );
  }

  Widget setUpAssetAllocationTacticalMicroData() {
    return Center(
        child: Container(
          margin: const EdgeInsets.only(top: 10, left: 12, right: 12),
          decoration: BoxDecoration(
            border: Border.all(width: 0.8, color: blue),
            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
          ),
          child: Column(children: <Widget>[
            IntrinsicHeight(
              child: Row(children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(3),
                    child:
                    const Text('Asset', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
                const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                Flexible(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(3),
                    child:
                    const Text('Actual\nAmount', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
                const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(3),
                    child:
                    const Text('Actual\n%', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
                const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(3),
                    child:
                    const Text('Policy\n%', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
                const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(3),
                    child:
                    const Text('Variance', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
              ]),
            ),
            const Divider(height: 1.0, thickness: 1.0,color: blue, indent: 0.0, endIndent: 0.0),
            resultData.microAssetTactical!.isNotEmpty
                ? ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: resultData.microAssetTactical!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(3),
                                child: Text(resultData.microAssetTactical![index].asset.toString(),
                                    style: resultData.microAssetTactical?[index].asset.toString().toLowerCase() == "total" ? const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: black) : const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                            const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                            Flexible(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(3),
                                child: Container(
                                  margin: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
                                  child:Text(convertCommaSeparatedAmount(resultData.microAssetTactical![index].amount.toString()),
                                      style: resultData.microAssetTactical?[index].asset.toString().toLowerCase() == "total" ? const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: black) : const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            ),
                            const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                            Flexible(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(3),
                                child: Container(
                                  margin: const EdgeInsets.only(left: 8, right:8, top: 8, bottom: 8),
                                  child: Text(resultData.microAssetTactical![index].actual.toString(),
                                      style: resultData.microAssetTactical?[index].asset.toString().toLowerCase() == "total" ? const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: black) : const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            ),
                            const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                            Flexible(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(3),
                                child: Container(
                                  margin: const EdgeInsets.only(left:8, right:8, top: 8, bottom: 8),
                                  child: Text(resultData.microAssetTactical![index].policy.toString(),
                                      style: resultData.microAssetTactical?[index].asset.toString().toLowerCase() == "total" ? const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: black) : const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            ),
                            const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                            Flexible(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(3),
                                child: Container(
                                  margin: const EdgeInsets.only(left:8, right:8, top: 8, bottom: 8),
                                  child: Text("${resultData.microAssetTactical![index].variation.toString()}%",
                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                          visible: index != resultData.microAssetTactical!.length - 1,
                          child: const Divider(height: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0)),
                      // Visibility(
                      //     visible: index != categoryAnalysisResponse.data!.length - 1 ? true : false,
                      //     child: const Divider(height: 1.0, color: kPurple700Color, indent: 0.0, endIndent: 0.0),
                      // ),
                    ],
                  );
                })
                : Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(100),
                    child: const Text("No data found",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: black),
                        textAlign: TextAlign.center),
                  ),
          ]),
        )
    );
  }

  Widget setUpPerformanceTab() {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8),
      child: Row(
        children: [
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border(
                  bottom: _isVisibleSinceInception ? const BorderSide(color: blue) : const BorderSide(color: Colors.transparent),
                ),
              ),
              child: TextButton(
                onPressed: () {
                 setState(() {
                    _isVisibleSinceInception = true;
                    _isVisible2023_24 = false;
                    _isVisible2022_23 = false;
                 });
                },
                child: _isVisibleSinceInception ? const Text( kIsWeb ? "Since Inception" : 'Since\nInception', style:TextStyle(fontSize: 17, fontWeight: FontWeight.bold,color: blue)) :
                const Text(kIsWeb ? "Since Inception" : 'Since\nInception', style:TextStyle(fontSize: 17, fontWeight: FontWeight.bold,color: black)),
              ),
            ),
          ),
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border(
                  bottom: _isVisible2023_24 ? const BorderSide(color: blue) : const BorderSide(color: Colors.transparent),
                ),
              ),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _isVisibleSinceInception = false;
                    _isVisible2023_24 = true;
                    _isVisible2022_23 = false;
                  });
                },
                child: _isVisible2023_24
                    ? Text(getCurrentFinancialYear(),style:const TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: blue))
                    : Text(getCurrentFinancialYear(),style:const TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: black)),
              ),
            ),
          ),
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border(
                  bottom: _isVisible2022_23 ? const BorderSide(color: blue) : const BorderSide(color: Colors.transparent),
                ),
              ),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _isVisibleSinceInception = false;
                    _isVisible2023_24 = false;
                    _isVisible2022_23 = true;
                  });
                },
                child: _isVisible2022_23
                    ? Text(getPreviousFinancialYear(),style:const TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: blue))
                    : Text(getPreviousFinancialYear(),style:const TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: black)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget setUpSinceInceptionData() {
    return Center(
        child: Container(
          margin: const EdgeInsets.only(top: 10, left: 12, right: 12),
          decoration: BoxDecoration(
            border: Border.all(width: 0.8, color: blue),
            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
          ),
          child: Column(children: <Widget>[
            IntrinsicHeight(
              child: Row(children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.all(6),
                    child:
                    const Text('Asset', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
                const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                Flexible(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.all(6),
                    child:
                    const Text('Current\nValue', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
                const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                Flexible(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.all(6),
                    child:
                    const Text('Gain', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
                const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.all(6),
                    child:
                    const Text('XIRR', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
              ]),
            ),
            const Divider(height: 1.0, thickness: 1.0,color: blue, indent: 0.0, endIndent: 0.0),
            listSinceInceptionNew.isNotEmpty
                ? ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: listSinceInceptionNew.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(3),
                                child: Text(listSinceInceptionNew[index].asset.toString(),
                                    style: listSinceInceptionNew[index].asset.toString().toLowerCase() == "overall" ? const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: black) : const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                            const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                            Flexible(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(3),
                                child: Text(convertCommaSeparatedAmount(listSinceInceptionNew[index].currentValue.toString()),
                                    style: listSinceInceptionNew[index].asset.toString().toLowerCase() == "overall" ? const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: black) : const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                            const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                            Flexible(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(3),
                                child: Container(
                                  margin: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
                                  child:Text(convertCommaSeparatedAmount(listSinceInceptionNew[index].gain.toString()),
                                      style: listSinceInceptionNew[index].asset.toString().toLowerCase() == "overall" ? const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: black) : const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            ),
                            const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                            Flexible(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(3),
                                child: Container(
                                  margin: const EdgeInsets.only(left: 8, right:8, top: 8, bottom: 8),
                                  child: Text("${doubleUpto2Digit(listSinceInceptionNew[index].xirr!.toDouble()).toString()}%",
                                      style: listSinceInceptionNew[index].asset.toString().toLowerCase() == "overall" ? const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: black) : const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Visibility(
                          visible: index != listSinceInceptionNew.length - 1,
                          child: const Divider(height: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0)),
                    ],
                  );
                })
                : Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(100),
                    child: const Text("No data found",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: black),
                        textAlign: TextAlign.center),
            ),
          ]),
        )
    );
  }

  Widget setUpCurrentYearXIRRData() {
    return Center(
        child: Container(
          margin: const EdgeInsets.only(top: 10, left: 12, right: 12),
          decoration: BoxDecoration(
            border: Border.all(width: 0.8, color: blue),
            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
          ),
          child: Column(children: <Widget>[
            IntrinsicHeight(
              child: Row(children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.all(6),
                    child:
                    const Text('Asset', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
                const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                Flexible(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.all(6),
                    child:
                    const Text('Current\nValue', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
                const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                Flexible(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.all(6),
                    child:
                    const Text('Gain', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
                const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.all(6),
                    child:
                    const Text('XIRR', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
              ]),
            ),
            const Divider(height: 1.0, thickness: 1.0,color: blue, indent: 0.0, endIndent: 0.0),
            listCurrentYearXIRRNew.isNotEmpty
                ? ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: listCurrentYearXIRRNew.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(3),
                                child: Text(listCurrentYearXIRRNew[index].asset.toString(),
                                    style: listCurrentYearXIRRNew[index].asset.toString().toLowerCase() == "overall" ? const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: black) :  const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                            const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                            Flexible(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(3),
                                child: Container(
                                  margin: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
                                  child:Text(convertCommaSeparatedAmount(listCurrentYearXIRRNew[index].currentValue.toString()),
                                      style:listCurrentYearXIRRNew[index].asset.toString().toLowerCase() == "overall" ? const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: black) :   const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            ),
                            const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                            Flexible(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(3),
                                child: Container(
                                  margin: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
                                  child:Text(convertCommaSeparatedAmount(listCurrentYearXIRRNew[index].gain.toString()),
                                      style:listCurrentYearXIRRNew[index].asset.toString().toLowerCase() == "overall" ? const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: black) :   const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            ),
                            const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                            Flexible(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(3),
                                child: Container(
                                  margin: const EdgeInsets.only(left: 8, right:8, top: 8, bottom: 8),
                                  child: Text("${doubleUpto2Digit(listCurrentYearXIRRNew[index].xirr!.toDouble()).toString()}%",
                                      style: listCurrentYearXIRRNew[index].asset.toString().toLowerCase() == "overall" ? const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: black) :  const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Visibility(
                          visible: index != listCurrentYearXIRRNew.length - 1,
                          child: const Divider(height: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0)),
                    ],
                  );
                })
                : Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(100),
                    child: const Text("No data found",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: black),
                        textAlign: TextAlign.center),
            ),
          ]),
        )
    );
  }

  Widget setUpPreviousYearXIRRData() {
    return Center(
        child: Container(
          margin: const EdgeInsets.only(top: 10, left: 12, right: 12),
          decoration: BoxDecoration(
            border: Border.all(width: 0.8, color: blue),
            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
          ),
          child: Column(children: <Widget>[
            IntrinsicHeight(
              child: Row(children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.all(6),
                    child:
                    const Text('Asset', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
                const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                Flexible(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.all(6),
                    child:
                    const Text('Current\nValue', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
                const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                Flexible(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.all(6),
                    child:
                    const Text('Gain', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
                const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.all(6),
                    child:
                    const Text('XIRR', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
              ]),
            ),
            const Divider(height: 1.0, thickness: 1.0,color: blue, indent: 0.0, endIndent: 0.0),
            listPreviousYearXIRRNew.isNotEmpty
                ? ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: listPreviousYearXIRRNew.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(3),
                                  child: Text(listPreviousYearXIRRNew[index].asset.toString(),
                                      style: listPreviousYearXIRRNew[index].asset.toString().toLowerCase() == "overall" ? const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: black) :  const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                              const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                              Flexible(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(3),
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
                                    child:Text(convertCommaSeparatedAmount(listPreviousYearXIRRNew[index].currentValue.toString()),
                                        style: listPreviousYearXIRRNew[index].asset.toString().toLowerCase() == "overall" ? const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: black) :  const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
                                        textAlign: TextAlign.center),
                                  ),
                                ),
                              ),
                              const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                              Flexible(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(3),
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
                                    child:Text(convertCommaSeparatedAmount(listPreviousYearXIRRNew[index].gain.toString()),
                                        style: listPreviousYearXIRRNew[index].asset.toString().toLowerCase() == "overall" ? const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: black) :  const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
                                        textAlign: TextAlign.center),
                                  ),
                                ),
                              ),
                              const VerticalDivider(width: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0),
                              Flexible(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(3),
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 8, right:8, top: 8, bottom: 8),
                                    child: Text("${doubleUpto2Digit(listPreviousYearXIRRNew[index].xirr!.toDouble()).toString()}%",
                                        style: listPreviousYearXIRRNew[index].asset.toString().toLowerCase() == "overall" ? const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: black) :  const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
                                        textAlign: TextAlign.center),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Visibility(
                            visible: index != listPreviousYearXIRRNew.length - 1,
                            child: const Divider(height: 1.0, thickness: 1.0, color: blue, indent: 0.0, endIndent: 0.0)),
                      ],
                    );
                  }
                )
                : Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(100),
                    child: const Text("No data found",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: black),
                        textAlign: TextAlign.center),
            ),
          ]),
        )
    );
  }

  void _changedStrategic(bool visibility) {
    setState(() {
      _isVisibleStrategic = visibility;
    });
  }

  void _changedTactical(bool visibility) {
    setState(() {
      _isVisibleTactical = visibility;
    });
  }

  _getNetworthData() async {

    if ((sessionManagerPMS.getNetworthData() != null))
      {
        print("IS FIRST IF");
        if (sessionManagerPMS.getNetworthData().applicantDetails?.isNotEmpty ?? false)
          {
            print("IS IN IF");
            resultData = sessionManagerPMS.getNetworthData();
            print(jsonEncode(resultData.macroAssetStratagic?[0]));
          }
        else
          {
            print("IS IN ELSE");
            print(resultData.applicantDetails?.isEmpty ?? false);
            print(resultData.applicantDetails?.length);
            resultData = Result();
            strNetWorth = "";
          }
      }
    else
      {
        print("IS IN ELSE ELSE");
        resultData = Result();
        strNetWorth = "";
      }

    strNetWorth = sessionManagerPMS.getTotalNetworth();

    if ((sessionManagerPMS.getPercentageData() != null) || (sessionManagerPMS.getPercentageData().masterMarketPercentage?.isNotEmpty ?? false))
      {
        percentageResponse = sessionManagerPMS.getPercentageData();
      }
    else
      {
        _getPercentageData();
      }

    if ((resultData.applicantDetails == null) || (resultData.applicantDetails?.isEmpty ?? false))
      {
        setState(() {
          _isLoading = true;
        });
      }

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_CP + networth);
    Map<String, String> jsonBody = {
      'user_id': sessionManagerPMS.getUserId().trim(),
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = NetworthResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1)
    {
      try {
        if (dataResponse.result != null)
        {
          setState(() {
            resultData = dataResponse.result ?? Result();

            sessionManagerPMS.saveNetworthData(resultData);

            if (resultData.applicantDetails != null) {
              if(resultData.applicantDetails!.isNotEmpty) {
                for (int i = 0; i < resultData.applicantDetails!.length ; i++) {
                  if (resultData.applicantDetails![i].applicant == "Amount Total") {
                    strNetWorth = checkValidString(resultData.applicantDetails![i].amount.toString());
                    sessionManagerPMS.setTotalNetworth(strNetWorth);
                    print("strNetWorth In For Loop === $strNetWorth");
                  }
                }
              }
            }
          });
        }
      } catch (e) {

        if (kDebugMode) {
          print(e);
        }
      }
    }
    else
    {

    }


    _getPercentageData();


  }

  _getPercentageData() async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_CP + percentage);

    final response = await http.get(url);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = PercentageResponse.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      try {
          setState(() {
            _isLoading = false;
          });
          setState(() {
            percentageResponse = dataResponse;
            sessionManagerPMS.savePercentageData(percentageResponse);
          });
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        if (kDebugMode) {
          print(e);
        }
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }

  }

  /*_getSinceInceptionData() async {

    if (sessionManagerPMS.getPerformanceList().isNotEmpty)
    {
      listSinceInception = sessionManagerPMS.getPerformanceList();
    }

    print("listSinceInception ==== ${listSinceInception.length}");

    if (listSinceInception.isEmpty)
      {
        setState(() {
          _isSinceInceptionLoading = true;
        });
        HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
          HttpLogger(logLevel: LogLevel.BODY),
        ]);

        final url = Uri.parse(API_URL_CP + performance);
        Map<String, String> jsonBody = {
          'user_id': sessionManagerPMS.getUserId().trim(),
        };

        final response = await http.post(url, body: jsonBody);
        final statusCode = response.statusCode;
        final body = response.body;
        Map<String, dynamic> user = jsonDecode(body);
        var dataResponse = SinceInceptionResponse.fromJson(user);

        if (statusCode == 200 && dataResponse.success == 1) {
          try {
            if (dataResponse.result != null) {
              setState(() {
                _isSinceInceptionLoading = false;
              });
              setState(() {
                listSinceInception = dataResponse.result!.data!;
                sessionManagerPMS.savePerformanceList(listSinceInception);
              });
            }
          } catch (e) {
            setState(() {
              _isSinceInceptionLoading = false;
            });
            if (kDebugMode) {
              print(e);
            }
          }
        } else {
          setState(() {
            _isSinceInceptionLoading = false;
          });
        }
      }
  }

  _getCurrentYearXIRR() async {

    if (sessionManagerPMS.getNextYearList().isNotEmpty)
      {
        listCurrentYearXIRR = sessionManagerPMS.getNextYearList();
      }

    print("listCurrentYearXIRR ==== ${listCurrentYearXIRR.length}");

    if (listCurrentYearXIRR.isEmpty)
      {
        setState(() {
          _isCurrentYearXIRRLoading = true;
        });
        HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
          HttpLogger(logLevel: LogLevel.BODY),
        ]);

        final url = Uri.parse(API_URL_CP + xirr);
        Map<String, String> jsonBody = {
          'user_id': sessionManagerPMS.getUserId().trim(),
        };

        final response = await http.post(url, body: jsonBody);
        final statusCode = response.statusCode;
        final body = response.body;
        Map<String, dynamic> user = jsonDecode(body);
        var dataResponse = SinceInceptionResponse.fromJson(user);

        if (statusCode == 200 && dataResponse.success == 1) {
          try {
            setState(() {
              _isCurrentYearXIRRLoading = false;
            });
            if (dataResponse.result != null) {
              setState(() {
                listCurrentYearXIRR = dataResponse.result!.data!;
              });
              sessionManagerPMS.saveNextYearList(listCurrentYearXIRR);
            }
          } catch (e) {
            setState(() {
              _isCurrentYearXIRRLoading = false;
            });
            if (kDebugMode) {
              print(e);
            }
          }
        } else {
          setState(() {
            _isCurrentYearXIRRLoading = false;
          });
        }
      }

  }

  _getPreviousYearXIRR() async {

    if (sessionManagerPMS.getPerviousYearList().isNotEmpty)
      {
        listPreviousYearXIRR = sessionManagerPMS.getPerviousYearList();
      }

    print("listPreviousYearXIRR ==== ${listPreviousYearXIRR.length}");

    if (listPreviousYearXIRR.isEmpty)
      {
        setState(() {
          _isPreviousYearXIRRLoading = true;
        });
        HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
          HttpLogger(logLevel: LogLevel.BODY),
        ]);

        final url = Uri.parse(API_URL_CP + xirrPrevious);
        Map<String, String> jsonBody = {
          'user_id': sessionManagerPMS.getUserId().trim(),
        };

        final response = await http.post(url, body: jsonBody);
        final statusCode = response.statusCode;
        final body = response.body;
        Map<String, dynamic> user = jsonDecode(body);
        var dataResponse = SinceInceptionResponse.fromJson(user);

        if (statusCode == 200 && dataResponse.success == 1) {
          try {
            if (dataResponse.result != null) {
              setState(() {
                _isPreviousYearXIRRLoading = false;
              });
              setState(() {
                listPreviousYearXIRR = dataResponse.result!.data!;
              });
              sessionManagerPMS.savePerviousYearList(listPreviousYearXIRR);
            }
          } catch (e) {
            setState(() {
              _isPreviousYearXIRRLoading = false;
            });

            if (kDebugMode) {
              print(e);
            }
          }
        } else {
          setState(() {
            _isPreviousYearXIRRLoading = false;
          });
        }
      }
  }*/

  void getCommonXirr() async {

    if (sessionManagerPMS.getPerformanceList().isNotEmpty)
      {
        listSinceInceptionNew = sessionManagerPMS.getPerformanceList();
      }

    print("listSinceInceptionNew ==== ${listSinceInceptionNew.length}");

    if (sessionManagerPMS.getNextYearList().isNotEmpty)
      {
        listCurrentYearXIRRNew = sessionManagerPMS.getNextYearList();
      }

    print("listCurrentYearXIRR ==== ${listCurrentYearXIRRNew.length}");

    if (sessionManagerPMS.getPerviousYearList().isNotEmpty)
      {
        listPreviousYearXIRRNew = sessionManagerPMS.getPerviousYearList();
      }

    print("listPreviousYearXIRR ==== ${listPreviousYearXIRRNew.length}");

    if (sessionManagerPMS.getReportDate().isNotEmpty)
      {
        asPerDate = sessionManagerPMS.getReportDate();
      }

    if ((listSinceInceptionNew.isEmpty) || (listCurrentYearXIRRNew.isEmpty) || (listPreviousYearXIRRNew.isEmpty))
      {
        setState(() {
          _isSinceInceptionLoading = true;
          _isCurrentYearXIRRLoading = true;
          _isPreviousYearXIRRLoading = true;
        });
      }

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_CP + xirrCommon);
    Map<String, String> jsonBody = {
      'user_id': sessionManagerPMS.getUserId().trim(),
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = XirrCommonResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1)
    {
      listSinceInceptionNew = dataResponse.performance ?? [];
      sessionManagerPMS.savePerformanceList(listSinceInceptionNew);

      listCurrentYearXIRRNew = dataResponse.xirr ?? [];
      sessionManagerPMS.saveNextYearList(listCurrentYearXIRRNew);

      listPreviousYearXIRRNew = dataResponse.xirrPrevious ?? [];
      sessionManagerPMS.savePerviousYearList(listPreviousYearXIRRNew);

      asPerDate = universalDateConverter("dd-MM-yyyy", 'dd MMM,yyyy', dataResponse.reportDate ?? '');
      sessionManagerPMS.setReportDate(asPerDate);
    }
    setState(() {
      _isSinceInceptionLoading = false;
      _isCurrentYearXIRRLoading = false;
      _isPreviousYearXIRRLoading = false;
    });

  }

  void fetchLast30DaysTransaction() async{
    if (sessionManagerPMS.getLast30DaysTransactionList().isNotEmpty)
    {
      listLast30DaysTransaction = sessionManagerPMS.getLast30DaysTransactionList();
    }

    if(isOnline)
    {
      try
      {
        HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
          HttpLogger(logLevel: LogLevel.BODY),
        ]);

        final url = Uri.parse(API_URL_CP + latestTransaction);
        Map<String, String> jsonBody = {
          'user_id': sessionManagerPMS.getUserId().trim(),
        };

        final response = await http.post(url, body: jsonBody);
        final statusCode = response.statusCode;
        final body = response.body;
        Map<String, dynamic> user = jsonDecode(body);
        var dataResponse = LatestTransactionResponse.fromJson(user);

        if(statusCode == 200 && dataResponse.success == 1)
        {
          if(dataResponse.transactionDetails?.isNotEmpty ?? false)
          {
            sessionManagerPMS.saveLast30DaysTransactionList(dataResponse.transactionDetails ?? []);
            listLast30DaysTransaction = dataResponse.transactionDetails ?? [];
          }
          else
          {
            listLast30DaysTransaction = [];
          }
          setState(() {});
          print("Display last 30 days transaction list : ${listLast30DaysTransaction.length}");
        }

      }
      catch(e)
      {
        print("Failed to fetch last 30 days transaction : $e");
      }
    }
    else
    {
      noInterNet(context);
    }

  }

  @override
  void castStatefulWidget() {
    widget is CPDashboardPage;
  }
}
