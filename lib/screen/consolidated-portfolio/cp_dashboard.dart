import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/model/consolidated-portfolio/PercentageResponse.dart';
import 'package:superapp_flutter/model/consolidated-portfolio/SinceInceptionResponse.dart';
import 'package:superapp_flutter/utils/app_utils.dart';
import '../../constant/colors.dart';
import '../../constant/consolidate-portfolio/api_end_point.dart';
import '../../model/consolidated-portfolio/NetworthResponse.dart';
import '../../utils/base_class.dart';
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

  List<Data> listSinceInception = List<Data>.empty(growable: true);
  List<Data> listCurrentYearXIRR = List<Data>.empty(growable: true);
  List<Data> listPreviousYearXIRR = List<Data>.empty(growable: true);
  var resultData = Result();
  var percentageResponse = PercentageResponse();
  int touchedIndexAsset = -1;
  int touchedIndexApplicant = -1;

  var strNetWorth = "";

  final List<Color> colorsAssetAllocation = <Color>[chart_color1, chart_color2,chart_color3,chart_color4,chart_color5,
    chart_color6,chart_color7,chart_color8,chart_color9,chart_color10];

  final List<Color> colorsApplicantAllocation = <Color>[chart_color6, chart_color10,chart_color3,chart_color4,chart_color5,
    chart_color1,chart_color7,chart_color8,chart_color9,chart_color2];

  @override
  void initState() {
    super.initState();

    print(jsonEncode(sessionManagerPMS.getNetworthData()));

    _getNetworthData();
    _getSinceInceptionData();
    _getCurrentYearXIRR();
    _getPreviousYearXIRR();

    if (sessionManagerPMS.getPercentageData().masterMarketPercentage?.isEmpty ?? false)
      {
        percentageResponse = sessionManagerPMS.getPercentageData();
      }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: _isLoading
          ? const LoadingWidget()
          : SingleChildScrollView(
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
                                  Gap(20),
                                  const Text('Networth',
                                      style: TextStyle(color: white, fontSize: 16, fontWeight: FontWeight.w400)),
                                  Gap(20),
                                  Text(getPrice(strNetWorth),
                                      style: TextStyle(color: white, fontSize: 26, fontWeight: FontWeight.w900)),
                                  Gap(20),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 16,right: 16),
                            child: Row(
                              children: [
                                const Text('Asset Allocation',
                                style: TextStyle(
                                    color: blue,
                                    fontSize: 16,
                                    fontWeight:
                                    FontWeight.w600)),
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
                          _isShowTopTable ? setUpAssetAllocationTopTableData() : SizedBox(
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
                                const Text('Applicants Allocation',
                                    style: TextStyle(
                                        color: blue,
                                        fontSize: 16,
                                        fontWeight:
                                        FontWeight.w600)),
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
                          _isShowTable ? setUpApplicantsData() : SizedBox(
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
                          _isShowTable ? Container() :Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: List.generate(resultData.applicantDetails!.length - 1, (i) {
                              return resultData.applicantDetails![i].absoluteReturn != 0 ? Container(
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
                              ) : Container();
                            }),
                          ),
                          const Gap(16),
                          Container(
                            margin: const EdgeInsets.only(left: 16),
                            child: const Text('Asset Allocation - Strategic',
                                style: TextStyle(
                                    color: blue,
                                    fontSize: 16,
                                    fontWeight:
                                    FontWeight.w600)),
                          ),
                          const Gap(16),
                          setUpAssetAllocationStrategicTab(),
                          _isVisibleStrategic ? setUpAssetAllocationStrategicMacroData() : setUpAssetAllocationStrategicMicroData(),
                          const Gap(16),
                          Container(
                            margin: const EdgeInsets.only(left: 16),
                            child: const Text('Asset Allocation - Tactical',
                                style: TextStyle(
                                    color: blue,
                                    fontSize: 16,
                                    fontWeight:
                                    FontWeight.w600)),
                          ),
                          const Gap(16),
                          setUpAssetAllocationTacticalTab(),
                          _isVisibleTactical ? setUpAssetAllocationTacticalMacroData() : setUpAssetAllocationTacticalMicroData(),
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
                            child: const Text('Performance',
                                style: TextStyle(
                                    color: blue,
                                    fontSize: 16,
                                    fontWeight:
                                    FontWeight.w600)),
                          ),
                          const Gap(16),
                          setUpPerformanceTab(),
                          _isSinceInceptionLoading ? const CPDashboardLoadingWidget() : _isVisibleSinceInception ? setUpSinceInceptionData() : _isCurrentYearXIRRLoading ? const CPDashboardLoadingWidget() : _isVisible2023_24 ? setUpCurrentYearXIRRData() : _isPreviousYearXIRRLoading ? const CPDashboardLoadingWidget() : setUpPreviousYearXIRRData(),
                          const Gap(16)
                        ],
                      ),))
    );
  }

  List<PieChartSectionData> generateAssetAllocationChart() {
    return List.generate(resultData.macroAssetStratagic!.length - 1, (i) {
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
    return List.generate(resultData.applicantDetails!.length - 1, (i) {
      final isTouched = i == touchedIndexApplicant;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      return PieChartSectionData(
        color: colorsApplicantAllocation[i],
        value: resultData.applicantDetails![i].absoluteReturn!.toDouble(),
        title: "${resultData.applicantDetails![i].absoluteReturn!}%",
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
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
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
                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
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
                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
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
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
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
                                  child:Text(convertCommaSeparatedAmount(resultData.applicantDetails![index].currentAmount.toString()),
                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
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
                                  child: Text(doubleUpto2Digit(resultData.applicantDetails![index].cagr!.toDouble()).toString(),
                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
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
          ]),
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
                    child:
                    const Text('Variation\n%', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
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
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
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
                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
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
                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
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
                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
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
                                  child: Text(resultData.macroAssetStratagic![index].variation.toString(),
                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
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
                    child:
                    const Text('Variation\n%', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
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
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
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
                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
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
                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
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
                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
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
                                  child: Text(resultData.microAssetStratagic![index].variation.toString(),
                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
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
                    const Text('Variation\n%', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
              ]),
            ),
            const Divider(height: 1.0, thickness: 1.0,color: blue, indent: 0.0, endIndent: 0.0),
            resultData.macroAssetTactical!.isNotEmpty
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
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
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
                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
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
                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
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
                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
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
                                  child: Text(resultData.macroAssetTactical![index].variation.toString(),
                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
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
                    const Text('Variation\n%', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
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
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
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
                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
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
                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
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
                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
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
                                  child: Text(resultData.microAssetTactical![index].variation.toString(),
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
                child: _isVisibleSinceInception ? const Text('Since\nInception', style:TextStyle(fontSize: 17, fontWeight: FontWeight.bold,color: blue)) :
                const Text('Since\nInception', style:TextStyle(fontSize: 17, fontWeight: FontWeight.bold,color: black)),
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
                child: _isVisible2023_24 ? const Text('2023-24',style:TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: blue)) :
                const Text('2023-24',style:TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: black)),
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
                child: _isVisible2022_23 ? const Text('2022-23',style:TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: blue)) :
                const Text('2022-23',style:TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: black)),
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
            listSinceInception.isNotEmpty
                ? ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: listSinceInception.length,
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
                                child: Text(listSinceInception[index].asset.toString(),
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
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
                                  child:Text(convertCommaSeparatedAmount(listSinceInception[index].gain.toString()),
                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
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
                                  child: Text(doubleUpto2Digit(listSinceInception[index].xirr!.toDouble()).toString(),
                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Visibility(
                          visible: index != listSinceInception.length - 1,
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
            listCurrentYearXIRR.isNotEmpty
                ? ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: listCurrentYearXIRR.length,
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
                                child: Text(listCurrentYearXIRR[index].asset.toString(),
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
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
                                  child:Text(convertCommaSeparatedAmount(listCurrentYearXIRR[index].gain.toString()),
                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
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
                                  child: Text(doubleUpto2Digit(listCurrentYearXIRR[index].xirr!.toDouble()).toString(),
                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Visibility(
                          visible: index != listCurrentYearXIRR.length - 1,
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
            listPreviousYearXIRR.isNotEmpty
                ? ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: listPreviousYearXIRR.length,
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
                                child: Text(listPreviousYearXIRR[index].asset.toString(),
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
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
                                  child:Text(convertCommaSeparatedAmount(listPreviousYearXIRR[index].gain.toString()),
                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
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
                                  child: Text(doubleUpto2Digit(listPreviousYearXIRR[index].xirr!.toDouble()).toString(),
                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: black),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Visibility(
                          visible: index != listPreviousYearXIRR.length - 1,
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


    if (sessionManagerPMS.getNetworthData() != null)
      {
        resultData = sessionManagerPMS.getNetworthData();
        strNetWorth = sessionManagerPMS.getTotalNetworth();
      }

    if (resultData.applicantDetails?.isEmpty ?? false)
      {
        setState(() {
          _isLoading = true;
        });
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
        var dataResponse = NetworthResponse.fromJson(user);

        if (statusCode == 200 && dataResponse.success == 1) {
          try {
            if (dataResponse.result != null)
            {
              resultData = dataResponse.result!;

              if (resultData.applicantDetails != null) {
                if(resultData.applicantDetails!.isNotEmpty) {
                  for (int i = 0; i < resultData.applicantDetails!.length ; i++) {
                    if (resultData.applicantDetails![i].applicant == "Total") {
                      strNetWorth = checkValidString(resultData.applicantDetails![i].currentAmount.toString());
                    }
                  }
                }
              }
            }
          } catch (e) {

            if (kDebugMode) {
              print(e);
            }
          }
        } else {

        }
        _getPercentageData();
      }

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

  _getSinceInceptionData() async {

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
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void castStatefulWidget() {
    widget is CPDashboardPage;
  }
}
