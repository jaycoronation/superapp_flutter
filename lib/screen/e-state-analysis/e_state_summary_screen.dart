import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/utils/app_utils.dart';
import 'package:superapp_flutter/utils/base_class.dart';

import '../../common_widget/chart_scale.dart';
import '../../common_widget/common_widget.dart';
import '../../constant/analysis_api_end_point.dart';
import '../../constant/colors.dart';
import '../../model/CommanResponse.dart';
import '../../model/e-state-analysis/FPSummaryDataResponseModel.dart' hide FutureInflows;
import '../../model/e-state-analysis/aspiration_response_model.dart';
import '../../model/e-state-analysis/existing_assets_response_model.dart';
import '../../model/e-state-analysis/existing_liabilities_response_model.dart';
import '../../widget/loading.dart';
import 'e_state_add_existing_assets_page.dart';
import 'e_state_add_existing_liabilities_page.dart';
import 'e_state_add_future_expense_page.dart';
import 'e_state_add_future_inflow_page.dart';
import '../../model/e-state-analysis/FutureInflowListResponseModel.dart';

class EStateSummaryScreen extends StatefulWidget {
  const EStateSummaryScreen({super.key});

  @override
  BaseState<EStateSummaryScreen> createState() => _EStateSummaryScreenState();
}

class _EStateSummaryScreenState extends BaseState<EStateSummaryScreen> {

  bool isLoading = false;
  bool isExpandedBalanceSheet =  false;

  int balanceSheetCount = 0;

  SummaryData summaryData = SummaryData();
  List<RiskProfileAllocation> listRiskProfileAllocation = [];
  List<RangeOfReturn> listReturnOfRisk = [];
  final List<Color> colorMainAll = [tableLightOrange, tableLightBlue, tableLightGreen, tableLightYellow, tableLightPurple, tableLightPink];
  List<String> listRiskProfileType = ["Conservative", "Moderately Conservative", "Moderate", "Moderately Aggressive", "Aggressive", "Highly Aggressive"];
  List<BalanceSheet> listBalanceSheetData = [];
  List<MacroAllocation> listMacroAllocation = [];
  List<Components> listOurRecommendation = [];
  List<FutureInflowsList> listFutureInflow = [];
  FutureInflowsTotal futureInflowTotal = FutureInflowsTotal();
  List<LiabilitiesList> listLiabilities = [];
  List<AspirationsSummaryList> listAspirationSummary = [];
  AspirationsSummaryTotal aspirationsSummaryTotal = AspirationsSummaryTotal();
  List<NetworthList> listNetWorth = [];
  NetworthTotal listNetWorthTotal = NetworthTotal();

  String selectedRiskProfileType = "";

  double maxY = 0.0;
  double minY = 0.0;
  double interval = 0.0;

  double maxYCurrent = 0.0;
  double minYCurrent = 0.0;
  double intervalCurrent = 0.0;
  String currentRsValue = "";
  double difference = 0.0;

  double maxYFuture = 0.0;
  double minYFuture = 0.0;
  double intervalFuture = 0.0;
  String futureRsValue = "";
  double differenceFuture = 0.0;

  ChartAmountFormatter amountFormatter = ChartAmountFormatter(1, "");

  double requiredWealthCurrent = 0;
  double existingWealthCurrent = 0;

  double requiredWealthFuture = 0;
  double totalWealthFuture = 0;

  String userId = "";

  @override
  void initState() {
    userId = sessionManager.getUserId().toString().trim();
    fetchFPSummaryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dashboardBg,
      appBar: AppBar(
        toolbarHeight: 0,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: getBackArrow(),
        ),
        title: getTitle("Summary",),
        centerTitle: true,
        elevation: 0,
        backgroundColor: white,
      ),
      body: SafeArea(
        child: isLoading ?
        Center(
          child: LoadingWidget(),
        ):
        RefreshIndicator(
          onRefresh: _refresh,
          color: blue,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(top: 16, bottom: 16, left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
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
                                "Aspiration Calculations :",
                                style: getBoldTextStyle(fontSize: 14, color: blue),
                              ),
                            ),
                            const Gap(8),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () async{
                                final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => EStateAddFutureExpensePage(ListData(), false)),);
                                print("result ===== $result");
                                if (result == "success") {
                                  _refresh();
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: blue,
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                padding: const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
                                child: Text("+ Add Aspiration", style: getMediumTextStyle(fontSize: 12, color: white),),
                              ),
                            )
                          ],
                        ),
                        const Gap(16),
                        aspirationCalculationWidget(),
                        const Gap(16),
                        Center(
                          child: Text(
                            "*Target Return may or may not be delivered due to market risk.",
                            style: getMediumTextStyle(fontSize: 12, color: blackLight),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Gap(10),
                      ],
                    ),
                  ),
                  const Gap(20),
                  Container(
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
                                "Existing Assets :",
                                style: getBoldTextStyle(fontSize: 14, color: blue),
                              ),
                            ),
                            const Gap(8),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () async{
                                final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => EStateAddExistingAssetsPage(ExistingAssets(), false)),);
                                print("result ===== $result");
                                if (result == "success") {
                                  _refresh();
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: blue,
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                padding: const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
                                child: Text("+ Add Assets", style: getMediumTextStyle(fontSize: 12, color: white),),
                              ),
                            )
                          ],
                        ),
                        const Gap(16),
                        existingAssetWidget(),
                        const Gap(16),
                        Center(
                          child: Text(
                            "*Expected return may or may not come in future due to market risk",
                            style: getMediumTextStyle(fontSize: 12, color: blackLight),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Gap(10),
                      ],
                    ),
                  ),
                  const Gap(20),
                  Container(
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
                                "Existing Liabilities :",
                                style: getBoldTextStyle(fontSize: 14, color: blue),
                              ),
                            ),
                            const Gap(8),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () async{
                                final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => EStateAddExistingLiabilitiesPage(ExistingLiabilities(), false)),);
                                print("result ===== $result");
                                if (result == "success") {
                                  _refresh();
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: blue,
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                padding: const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
                                child: Text("+ Add Liabilities", style: getMediumTextStyle(fontSize: 12, color: white),),
                              ),
                            )
                          ],
                        ),
                        const Gap(16),
                        existingLiabilitiesWidget(),
                        const Gap(10),
                      ],
                    ),
                  ),
                  const Gap(20),
                  Container(
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
                                "Future Inflow Calculation :",
                                style: getBoldTextStyle(fontSize: 14, color: blue),
                              ),
                            ),
                            const Gap(8),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () async{
                                final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => EStateAddFutureInflowPage(FutureInflows(), false)),);
                                print("result ===== $result");
                                if (result == "success") {
                                  _refresh();
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: blue,
                                  borderRadius: BorderRadius.circular(8)
                                ),
                                padding: const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
                                child: Text("+ Add Future Inflow", style: getMediumTextStyle(fontSize: 12, color: white),),
                              ),
                            )
                          ],
                        ),
                        const Gap(16),
                        futureInflowWidget(),
                        const Gap(10),
                        Center(
                          child: Text(
                            "*There will be future infolow of ${convertCommaSeparatedAmount(summaryData.futureInflows?.futureInflowsTotal?.pvOfIncome ?? "")}",
                            style: getRegularTextStyle(fontSize: 12, color: blackLight),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Gap(10),
                      ],
                    ),
                  ),
                  const Gap(20),
                  Container(
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
                            Text(
                              "Risk Profile :",
                              style: getBoldTextStyle(fontSize: 14, color: blue),
                            ),
                            const Gap(8),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                openRiskProfileOptionDialog();
                              },
                              child: Container(
                                padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                                decoration: BoxDecoration(
                                    border: Border.all(color: blue),
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        selectedRiskProfileType,
                                        style: getMediumTextStyle(fontSize: 12, color: blue),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    const Gap(8),
                                    Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 20,
                                      color: blue,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(16),
                        Text(
                          "Suggested Asset Allocation",
                          style: getSemiBoldTextStyle(fontSize: 12, color: blue),
                        ),
                        const Gap(12),
                        listRiskProfileAllocation.isEmpty ?
                        SizedBox(
                          height: 300,
                          child: Center(
                            child: Text("No Data Found"),
                          ),
                        ) :
                        suggestedAssetAllocationWidget(),
                        const Gap(16),
                        Text(
                          "Range of Return with 95% Probability",
                          style: getSemiBoldTextStyle(fontSize: 12, color: blue),
                        ),
                        const Gap(12),
                        listReturnOfRisk.isEmpty ?
                        SizedBox(
                          height: 300,
                          child: Center(
                            child: Text("No Data Found"),
                          ),
                        ) :
                        rangeOfReturnWidget(),
                        Container(
                          height: 350,
                          margin: const EdgeInsets.only(top: 24, bottom: 16),
                          child: BarChart(
                            BarChartData(
                              alignment: BarChartAlignment.spaceAround,
                              minY: minY,
                              maxY: maxY,
                              gridData: FlGridData(
                                show: true,
                                horizontalInterval: listReturnOfRisk.isNotEmpty ? interval : null,
                              ),
                              borderData: FlBorderData(show: false),
                              titlesData: FlTitlesData(
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    interval: listReturnOfRisk.isNotEmpty ? interval : null,
                                    reservedSize: 45,
                                    getTitlesWidget: (value, meta) {
                                      final isTopValue = value == meta.max;
                                      return Padding(
                                        padding: EdgeInsets.only(top: isTopValue ? 10 : 0, left: 10),
                                        child: Text(
                                          value.toStringAsFixed(0),
                                          style: getMediumTextStyle(fontSize: 12, color: black),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                rightTitles: AxisTitles(),
                                topTitles: AxisTitles(),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      if (value.toInt() >= listReturnOfRisk.length)
                                      {
                                        return const SizedBox();
                                      }

                                      return Padding(
                                        padding: const EdgeInsets.only(bottom: 4),
                                        child: Text(
                                          "${listReturnOfRisk[value.toInt()].rangeOfReturn}",
                                          style: getMediumTextStyle(fontSize: 12, color: blackLight),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              barGroups: List.generate(listReturnOfRisk.length, (index) {
                                final item = listReturnOfRisk[index];
                                return BarChartGroupData(
                                  x: index,
                                  barsSpace: 6,
                                  barRods: [
                                    BarChartRodData(
                                      toY: item.oneYearValue,
                                      width: 24,
                                      color: tableLightOrange,
                                      borderRadius: BorderRadius.circular(0),
                                      rodStackItems: [
                                        BarChartRodStackItem(
                                            0,
                                            item.oneYearValue,
                                            tableLightOrange,
                                            label: "${item.oneYearValue}",
                                            labelStyle: getMediumTextStyle(fontSize: 6, color: black)
                                        ),
                                      ],
                                    ),
                                    BarChartRodData(
                                      toY: item.threeYearValue,
                                      width: 24,
                                      color: tableLightBlue,
                                      borderRadius: BorderRadius.circular(0),
                                      rodStackItems: [
                                        BarChartRodStackItem(
                                            0,
                                            item.threeYearValue,
                                            tableLightBlue,
                                            label: "${item.threeYearValue}",
                                            labelStyle: getMediumTextStyle(fontSize: 6, color: black)
                                        ),
                                      ],
                                    ),
                                    BarChartRodData(
                                      toY: item.fiveYearValue,
                                      width: 24,
                                      color: tableLightGreen,
                                      borderRadius: BorderRadius.circular(0),
                                      rodStackItems: [
                                        BarChartRodStackItem(
                                            0,
                                            item.fiveYearValue,
                                            tableLightGreen,
                                            label: "${item.fiveYearValue}",
                                            labelStyle: getMediumTextStyle(fontSize: 6, color: black)
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              }),
                            ),
                          ),
                        ),
                        Center(
                          child: Wrap(
                            spacing: 16,
                            runSpacing: 8,
                            alignment: WrapAlignment.center,
                            children: [
                              wrapValueItem(tableLightOrange, "One Year"),
                              wrapValueItem(tableLightBlue, "Three Year"),
                              wrapValueItem(tableLightGreen, "Five Year"),
                            ],
                          ),
                        ),
                        const Gap(10),
                        Center(
                          child: Text(
                            "*Expected profit growth may or may not happen in future",
                            style: getRegularTextStyle(fontSize: 12, color: blackLight),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Gap(10),
                      ],
                    ),
                  ),
                  const Gap(20),
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
                        Text(
                          "Need Gap Analysis - Current :",
                          style: getBoldTextStyle(fontSize: 14, color: blue),
                        ),
                        Container(
                          height: 350,
                          margin: const EdgeInsets.only(top: 24, bottom: 16),
                          child: BarChart(
                            BarChartData(
                              alignment: BarChartAlignment.spaceAround,
                              minY: minYCurrent,
                              maxY: maxYCurrent,
                              gridData: FlGridData(
                                show: true,
                                horizontalInterval: intervalCurrent != 0.0 ? intervalCurrent : null,
                              ),
                              borderData: FlBorderData(show: false),
                              titlesData: FlTitlesData(
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    interval: intervalCurrent != 0.0 ? intervalCurrent : null,
                                    reservedSize: 45,
                                    getTitlesWidget: (value, meta) {
                                      return Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Text(
                                          "${value.toStringAsFixed(0)} ${amountFormatter.suffix}",
                                          style: getMediumTextStyle(fontSize: 12, color: black),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                rightTitles: AxisTitles(),
                                topTitles: AxisTitles(),
                                bottomTitles: AxisTitles(),
                              ),
                              barGroups: List.generate(1, (index) {
                                return BarChartGroupData(
                                  x: index,
                                  barsSpace: 0,
                                  barRods: [
                                    BarChartRodData(
                                      toY: requiredWealthCurrent,
                                      width: 120,
                                      color: tableMediumBlue,
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    BarChartRodData(
                                      toY: existingWealthCurrent,
                                      width: 120,
                                      color: tableDarkBlue,
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                  ],
                                );
                              }),
                            ),
                          ),
                        ),
                        Center(
                          child: Wrap(
                            spacing: 16,
                            runSpacing: 8,
                            alignment: WrapAlignment.center,
                            children: [
                              wrapValueItem(tableMediumBlue, "Wealth Required"),
                              wrapValueItem(tableDarkBlue, "Existing Wealth"),
                            ],
                          ),
                        ),
                        const Gap(10),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                difference > 0 ? "There will be a deficit of" : "There will be a surplus of",
                                style: getSemiBoldTextStyle(fontSize: 14, color: blue),
                                textAlign: TextAlign.center,
                              ),
                              const Gap(8),
                              Text(
                                currentRsValue,
                                style: getSemiBoldTextStyle(fontSize: 14, color: difference > 0 ? red : green),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                        const Gap(16),
                        Text(
                          "Need Gap Analysis - Future :",
                          style: getSemiBoldTextStyle(fontSize: 14, color: blue),
                        ),
                        Container(
                          height: 350,
                          margin: const EdgeInsets.only(top: 24, bottom: 16),
                          child: BarChart(
                            BarChartData(
                              alignment: BarChartAlignment.spaceAround,
                              minY: minYFuture,
                              maxY: maxYFuture,
                              gridData: FlGridData(
                                show: true,
                                horizontalInterval: intervalFuture != 0.0 ? intervalFuture : null,
                              ),
                              borderData: FlBorderData(show: false),
                              titlesData: FlTitlesData(
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    interval: intervalFuture != 0.0 ? intervalFuture : null,
                                    reservedSize: 45,
                                    getTitlesWidget: (value, meta) {
                                      return Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Text(
                                          "${value.toStringAsFixed(0)} ${amountFormatter.suffix}",
                                          style: getMediumTextStyle(fontSize: 12, color: black),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                rightTitles: AxisTitles(),
                                topTitles: AxisTitles(),
                                bottomTitles: AxisTitles(),
                              ),
                              barGroups: List.generate(1, (index) {
                                return BarChartGroupData(
                                  x: index,
                                  barsSpace: 0,
                                  barRods: [
                                    BarChartRodData(
                                      toY: requiredWealthFuture,
                                      width: 120,
                                      color: tableMediumBlue,
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    BarChartRodData(
                                      toY: totalWealthFuture,
                                      width: 120,
                                      color: tableDarkBlue,
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                  ],
                                );
                              }),
                            ),
                          ),
                        ),
                        Center(
                          child: Wrap(
                            spacing: 16,
                            runSpacing: 8,
                            alignment: WrapAlignment.center,
                            children: [
                              wrapValueItem(tableMediumBlue, "Wealth Required"),
                              wrapValueItem(tableDarkBlue, "Total Wealth"),
                            ],
                          ),
                        ),
                        const Gap(10),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                differenceFuture > 0 ? "There will be a surplus of" : "There will be a deficit of",
                                style: getSemiBoldTextStyle(fontSize: 14, color: blue),
                                textAlign: TextAlign.center,
                              ),
                              const Gap(8),
                              Text(
                                futureRsValue,
                                style: getSemiBoldTextStyle(fontSize: 14, color: differenceFuture > 0 ? green : red),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                        const Gap(10),
                      ],
                    ),
                  ),
                  const Gap(20),
                  Container(
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(8)
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Our Recommendation :",
                          style: getBoldTextStyle(fontSize: 14, color: blue),
                        ),
                        const Gap(16),
                        ourRecommendationWidget(),
                        const Gap(10),
                        Center(
                          child: Text(
                            "*Expected return may or may not come in future due to market risk",
                            style: getRegularTextStyle(fontSize: 12, color: blackLight),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Gap(10),
                      ],
                    ),
                  ),
                  const Gap(20),
                  Container(
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Balance Sheet Projection :",
                          style: getBoldTextStyle(fontSize: 14, color: blue),
                        ),
                        const Gap(16),
                        balanceSheetDataWidget(),
                        Visibility(
                          visible: listBalanceSheetData.isNotEmpty && listBalanceSheetData.length > 25,
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              setState(() {
                                isExpandedBalanceSheet = !isExpandedBalanceSheet;
                                if(isExpandedBalanceSheet)
                                {
                                  balanceSheetCount = listBalanceSheetData.length;
                                }
                                else
                                {
                                  balanceSheetCount = 25;
                                }
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 10),
                              padding: const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
                              decoration: BoxDecoration(
                                color: blue,
                                borderRadius: BorderRadius.circular(8)
                              ),
                              child: Icon(
                                isExpandedBalanceSheet ? Icons.remove : Icons.add,
                                size: 18,
                                color: white,
                              ),
                            ),
                          ),
                        ),
                        const Gap(10),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("*Inflation is assumed at 6%", style: getMediumTextStyle(fontSize: 12, color: blackLight), textAlign: TextAlign.center,),
                              const Gap(2),
                              Text("**Expected profit growth is 12%", style: getMediumTextStyle(fontSize: 12, color: blackLight), textAlign: TextAlign.center,),
                              const Gap(2),
                              Text("***Expected growth in fresh inflow is 10%", style: getMediumTextStyle(fontSize: 12, color: blackLight), textAlign: TextAlign.center,),
                              const Gap(2),
                              Text("**Expected profit growth may or may not happen in future due to market risk.", style: getMediumTextStyle(fontSize: 12, color: blackLight), textAlign: TextAlign.center,),
                            ],
                          ),
                        ),
                        const Gap(10),
                      ],
                    ),
                  ),
                  const Gap(20),
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
                        Text(
                          "Suggested Change in Asset Allocation :",
                          style: getSemiBoldTextStyle(fontSize: 14, color: blue),
                        ),
                        const Gap(16),
                        suggestedChangeAssetWidget(),
                        const Gap(10),
                      ],
                    ),
                  ),
                  const Gap(20),
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
                        Text(
                          "Action points :",
                          style: getSemiBoldTextStyle(fontSize: 14, color: blue),
                        ),
                        const Gap(16),
                        actionPointWidget("We can efficiently attain our goals within the stipulated timeframe."),
                        actionPointWidget("We are overexposed in volatile asset class and need to decrease exposure"),
                        actionPointWidget("Suggested to increase the SIP in alignment with monthly savings."),
                        actionPointWidget("Suggesting to take enough Life and Health Insurance coverage for protecting against unwanted risk. Our Advisor will help you with recommended amounts."),
                        actionPointWidget("This Financial Plan is initial draft and machine generated. Plan needs to be verified by our advisor before taking any action."),
                        const Gap(8),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _refresh() async{
    if(isOnline)
    {
      fetchFPSummaryData();
    }
  }

  Widget aspirationCalculationWidget(){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Container(
        width: 719,
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: blue), left: BorderSide(color: blue), right: BorderSide(color: blue)),
            borderRadius: BorderRadius.circular(14)
        ),
        child: Column(
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  rowCellTitle("Aspiration Type", white, alignment: Alignment.centerLeft, isPadding: true, width: 100, maxLine: 2),
                  showLineDivider(),
                  rowCellTitle("Start-End Year", white, width: 80, maxLine: 2),
                  showLineDivider(),
                  rowCellTitle("Total Outflow", white, width: 90, maxLine: 2),
                  showLineDivider(),
                  rowCellTitle("Inflation adjusted outflow", white, width: 100, maxLine: 3),
                  showLineDivider(),
                  rowCellTitle("Wealth required today", white, width: 100, maxLine: 3),
                  showLineDivider(),
                  rowCellTitle("Volatile Component", white, width: 80, maxLine: 3),
                  showLineDivider(),
                  rowCellTitle("Target Return", white, width: 70, maxLine: 2),
                  showLineDivider(),
                  rowCellTitle("Monthly SIP", white, width: 90, maxLine: 2),
                ],
              ),
            ),
            ListView.builder(
              itemCount: listAspirationSummary.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              itemBuilder: (context, index) {
                final aspirationData = listAspirationSummary[index];
                bool isLastIndex = index == listAspirationSummary.length - 1;
                return IntrinsicHeight(
                  child: Row(
                    children: [
                      rowCell(index, aspirationData.aspirationType ?? "", alignment: Alignment.centerLeft, isPadding: true, width: 100, maxLine: 3),
                      showLineDivider(),
                      rowCell(index, "${aspirationData.startYear} - ${aspirationData.endYear}", width: 80, maxLine: 2),
                      showLineDivider(),
                      rowCell(index, "${convertCommaSeparatedAmount(aspirationData.totalOutflow ?? "")}", width: 90, maxLine: 2),
                      showLineDivider(),
                      rowCell(index, "${convertCommaSeparatedAmount(aspirationData.totalInflationAdjustedExpense ?? "")}", width: 100, maxLine: 2),
                      showLineDivider(),
                      rowCell(index, "${convertCommaSeparatedAmount(aspirationData.wealthRequiredTodayTotal ?? "")}", width: 100, maxLine: 2),
                      showLineDivider(),
                      rowCell(index, aspirationData.volatileComponent ?? "", width: 80, maxLine: 2),
                      showLineDivider(),
                      rowCell(index, aspirationData.targetReturn ?? "", width: 70, maxLine: 2),
                      showLineDivider(),
                      rowCell(index, "${convertCommaSeparatedAmount("${aspirationData.requiredSip}")}", width: 90, maxLine: 2),
                    ],
                  ),
                );
              },
            ),
            IntrinsicHeight(
              child: Row(
                children: [
                  rowCell(listAspirationSummary.length, "Total", alignment: Alignment.centerLeft, isPadding: true, width: 100, maxLine: 1, isBold: true, isLastIndexLeft: true),
                  showLineDivider(),
                  rowCell(listAspirationSummary.length, "", width: 80, maxLine: 1, isBold: true),
                  showLineDivider(),
                  rowCell(listAspirationSummary.length, "${convertCommaSeparatedAmount(aspirationsSummaryTotal.totalOutflow ?? "")}", width: 90, maxLine: 1, isBold: true),
                  showLineDivider(),
                  rowCell(listAspirationSummary.length, "${convertCommaSeparatedAmount(aspirationsSummaryTotal.totalInflationAdjustedExpense ?? "")}", width: 100, maxLine: 1, isBold: true),
                  showLineDivider(),
                  rowCell(listAspirationSummary.length, "${convertCommaSeparatedAmount(aspirationsSummaryTotal.wealthRequiredTodayTotal ?? "")}", width: 100, maxLine: 1, isBold: true),
                  showLineDivider(),
                  rowCell(listAspirationSummary.length, "${aspirationsSummaryTotal.volatileComponent}", width: 80, maxLine: 1, isBold: true),
                  showLineDivider(),
                  rowCell(listAspirationSummary.length, "${aspirationsSummaryTotal.targetReturn}", width: 70, maxLine: 1, isBold: true),
                  showLineDivider(),
                  rowCell(listAspirationSummary.length, "${convertCommaSeparatedAmount("${aspirationsSummaryTotal.requiredSip}")}", width: 90, maxLine: 1, isBold: true, isLastIndexRight: true),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


  Widget existingAssetWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: blue), left: BorderSide(color: blue), right: BorderSide(color: blue)),
          borderRadius: BorderRadius.circular(14)
      ),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                expandedCell(flex: 2, rowCellTitle("Investment Type", white, alignment: Alignment.centerLeft, isPadding: true, maxLine: 2)),
                showLineDivider(),
                expandedCell(flex: 1, rowCellTitle("Asset Type", white,)),
                showLineDivider(),
                expandedCell(flex: 1, rowCellTitle("Current Value", white, )),
              ],
            ),
          ),
          ListView.builder(
            itemCount: listNetWorth.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(0),
            itemBuilder: (context, index) {
              final existingNetWorthData = listNetWorth[index];
              return IntrinsicHeight(
                child: Row(
                  children: [
                    expandedCell(flex: 2, rowCell(index, existingNetWorthData.investmentType ?? "", alignment: Alignment.centerLeft, isPadding: true, maxLine: 2)),
                    showLineDivider(),
                    expandedCell(flex: 1, rowCell(index, "${existingNetWorthData.assetType}", maxLine: 2)),
                    showLineDivider(),
                    expandedCell(flex: 1, rowCell(index, "${convertCommaSeparatedAmount(existingNetWorthData.currentValue ?? "")}", maxLine: 2)),
                  ],
                ),
              );
            },
          ),
          IntrinsicHeight(
            child: Row(
              children: [
                expandedCell(flex: 2, rowCell(listNetWorth.length, "Total", alignment: Alignment.centerLeft, isPadding: true, maxLine: 2, isBold: true, isLastIndexLeft: true)),
                showLineDivider(),
                expandedCell(flex: 1, rowCell(listNetWorth.length, "", maxLine: 2, isBold: true)),
                showLineDivider(),
                expandedCell(flex: 1, rowCell(listNetWorth.length, "${convertCommaSeparatedAmount(listNetWorthTotal.currentValue ?? "")}", maxLine: 2, isBold: true, isLastIndexRight: true)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget existingLiabilitiesWidget(){
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: listLiabilities.isEmpty ? Border.all(color: blue) : Border(top: BorderSide(color: blue), left: BorderSide(color: blue), right: BorderSide(color: blue)),
          borderRadius: BorderRadius.circular(14)
      ),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                expandedCell(rowCellTitle("Liability Type", white, alignment: Alignment.centerLeft, isPadding: true)),
                showLineDivider(),
                expandedCell(rowCellTitle("Asset Type", white)),
                showLineDivider(),
                expandedCell(rowCellTitle("Current Value", white)),
              ],
            ),
          ),
          listLiabilities.isEmpty ?
          Container(
            height: 100,
            padding: const EdgeInsets.only(bottom: 10),
            child: Center(
              child: Text(
                "No Data Found",
                style: getMediumTextStyle(fontSize: 14, color: blackLight),
              ),
            ),
          ) :
          ListView.builder(
            itemCount: listLiabilities.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(0),
            itemBuilder: (context, index) {
              final existingLiabilitiesData = listLiabilities[index];
              return IntrinsicHeight(
                child: Row(
                  children: [
                    expandedCell(rowCell(index, existingLiabilitiesData.liabilityType ?? "", alignment: Alignment.centerLeft, isPadding: true, maxLine: 2)),
                    showLineDivider(),
                    expandedCell(rowCell(index, "${existingLiabilitiesData.assetType}", maxLine: 2)),
                    showLineDivider(),
                    expandedCell(rowCell(index, "${convertCommaSeparatedAmount(existingLiabilitiesData.currentValue ?? "")}", maxLine: 2)),
                  ],
                ),
              );
            },
          ),
          if(listLiabilities.isNotEmpty)
          IntrinsicHeight(
            child: Row(
              children: [
                expandedCell(rowCell(listLiabilities.length, "Total", alignment: Alignment.centerLeft, isPadding: true, maxLine: 2, isBold: true, isLastIndexLeft: true)),
                showLineDivider(),
                expandedCell(rowCell(listLiabilities.length, "", maxLine: 2, isBold: true)),
                showLineDivider(),
                expandedCell(rowCell(listLiabilities.length, "${convertCommaSeparatedAmount(summaryData.liabilitiesData?.totalLiabilities ?? "")}", maxLine: 2, isBold: true, isLastIndexRight: true)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget futureInflowWidget(){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Container(
        width: 557,
        decoration: BoxDecoration(
            border: listFutureInflow.isEmpty ? Border.all(color: blue) : Border(top: BorderSide(color: blue), left: BorderSide(color: blue), right: BorderSide(color: blue)),
            borderRadius: BorderRadius.circular(14)
        ),
        child: Column(
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  rowCellTitle("Source", white, alignment: Alignment.centerLeft, isPadding: true, width: 100),
                  showLineDivider(),
                  rowCellTitle("Duration", white, width: 80, maxLine: 2),
                  showLineDivider(),
                  rowCellTitle("Amount", white, width: 80, maxLine: 2),
                  showLineDivider(),
                  rowCellTitle("Expected Growth", white, width: 80, maxLine: 2),
                  showLineDivider(),
                  rowCellTitle("Inflation Adjusted Income", white, width: 110, maxLine: 2),
                  showLineDivider(),
                  rowCellTitle("PV of Income", white, width: 100, maxLine: 2),
                ],
              ),
            ),
            listFutureInflow.isEmpty ?
            Container(
              height: 100,
              padding: const EdgeInsets.only(bottom: 10),
              child: Center(
                child: Text(
                  "No Data Found",
                  style: getMediumTextStyle(fontSize: 14, color: blackLight),
                ),
              ),
            ) :
            ListView.builder(
              itemCount: listFutureInflow.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              itemBuilder: (context, index) {
                final futureInflowData = listFutureInflow[index];
                return IntrinsicHeight(
                  child: Row(
                    children: [
                      rowCell(index, futureInflowData.source ?? "", alignment: Alignment.centerLeft, isPadding: true, width: 100, maxLine: 2),
                      showLineDivider(),
                      rowCell(index, "${futureInflowData.startYear} - ${futureInflowData.endYear}", width: 80, maxLine: 2),
                      showLineDivider(),
                      rowCell(index, "${convertCommaSeparatedAmount(futureInflowData.amount ?? "")}", width: 80, maxLine: 2),
                      showLineDivider(),
                      rowCell(index, futureInflowData.expectedGrowth ?? "", width: 80, maxLine: 2),
                      showLineDivider(),
                      rowCell(index, "${convertCommaSeparatedAmount(futureInflowData.inflationAdjustedIncome ?? "")}", width: 110, maxLine: 2),
                      showLineDivider(),
                      rowCell(index, "${convertCommaSeparatedAmount(futureInflowData.pvOfIncome ?? "")}", width: 100, maxLine: 2),
                    ],
                  ),
                );
              },
            ),
            if(listFutureInflow.isNotEmpty)
            IntrinsicHeight(
              child: Row(
                children: [
                  rowCell(listFutureInflow.length, "Total", alignment: Alignment.centerLeft, isPadding: true, width: 100, maxLine: 2, isBold: true, isLastIndexLeft: true),
                  showLineDivider(),
                  rowCell(listFutureInflow.length, "", width: 80, maxLine: 2, isBold: true),
                  showLineDivider(),
                  rowCell(listFutureInflow.length, "${convertCommaSeparatedAmount(futureInflowTotal.amount ?? "")}", width: 80, maxLine: 2, isBold: true),
                  showLineDivider(),
                  rowCell(listFutureInflow.length, "", width: 80, maxLine: 2, isBold: true),
                  showLineDivider(),
                  rowCell(listFutureInflow.length, "${convertCommaSeparatedAmount(futureInflowTotal.inflationAdjustedIncome ?? "")}", width: 110, maxLine: 2, isBold: true),
                  showLineDivider(),
                  rowCell(listFutureInflow.length, "${convertCommaSeparatedAmount(futureInflowTotal.pvOfIncome ?? "")}", width: 100, maxLine: 2, isBold: true, isLastIndexRight: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget wrapValueItem(Color color, String title) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: color,
          ),
        ),
        const Gap(6),
        Text(
          title,
          style: getMediumTextStyle(fontSize: 12, color: black,),
        ),
      ],
    );
  }

  suggestedAssetAllocationWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: listRiskProfileAllocation.isEmpty ? Border.all(color: blue) : Border(top: BorderSide(color: blue), left: BorderSide(color: blue), right: BorderSide(color: blue)),
          borderRadius: BorderRadius.circular(14)
      ),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                expandedCell(rowCellTitle("Asset Class", white, alignment: Alignment.centerLeft, isPadding: true)),
                showLineDivider(),
                expandedCell(rowCellTitle("Allocation", white)),
                showLineDivider(),
                expandedCell(rowCellTitle("Expected Return", white)),
              ],
            ),
          ),
          listRiskProfileAllocation.isEmpty ?
          Container(
            height: 100,
            padding: const EdgeInsets.only(bottom: 10),
            child: Center(
              child: Text(
                "No Data Found",
                style: getMediumTextStyle(fontSize: 14, color: blackLight),
              ),
            ),
          ) :
          ListView.builder(
            itemCount: listRiskProfileAllocation.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(0),
            itemBuilder: (context, index) {
              final suggestedData = listRiskProfileAllocation[index];
              final isTotal = (suggestedData.assetClass ?? "") == "Total";
              final bool isLastItem = index == listRiskProfileAllocation.length - 1;
              return IntrinsicHeight(
                child: Row(
                  children: [
                    expandedCell(rowCell(index, suggestedData.assetClass ?? "", alignment: Alignment.centerLeft, isPadding: true, maxLine: 2, isBold: isTotal, isLastIndexLeft: isLastItem)),
                    showLineDivider(),
                    expandedCell(rowCell(index, "${suggestedData.allocation}", maxLine: 2, isBold: isTotal)),
                    showLineDivider(),
                    expandedCell(rowCell(index, suggestedData.expectedReturn ?? "", isBold: isTotal, isLastIndexRight: isLastItem)),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  rangeOfReturnWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: listReturnOfRisk.isEmpty ? Border.all(color: blue) : Border(top: BorderSide(color: blue), left: BorderSide(color: blue), right: BorderSide(color: blue)),
          borderRadius: BorderRadius.circular(14)
      ),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                expandedCell(flex: 2, rowCellTitle("Range of Return", white, alignment: Alignment.centerLeft, isPadding: true, maxLine: 2)),
                showLineDivider(),
                expandedCell(rowCellTitle("1 Year", white,maxLine: 2)),
                showLineDivider(),
                expandedCell(rowCellTitle("3 Years", white, maxLine: 2)),
                showLineDivider(),
                expandedCell(rowCellTitle("5 Years", white, maxLine: 2)),
              ],
            ),
          ),

          listReturnOfRisk.isEmpty ?
          Container(
            height: 100,
            padding: const EdgeInsets.only(bottom: 10),
            child: Center(
              child: Text(
                "No Data Found",
                style: getMediumTextStyle(fontSize: 14, color: blackLight),
              ),
            ),
          ) :
          ListView.builder(
            itemCount: listReturnOfRisk.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(0),
            itemBuilder: (context, index) {
              final returnOfRiskData = listReturnOfRisk[index];
              final bool isLastItem = index == listReturnOfRisk.length - 1;
              return IntrinsicHeight(
                child: Row(
                  children: [
                    expandedCell(flex: 2, rowCell(index, returnOfRiskData.rangeOfReturn ?? "", alignment: Alignment.centerLeft, isPadding: true, maxLine: 2, isLastIndexLeft: isLastItem)),
                    showLineDivider(),
                    expandedCell(rowCell(index, returnOfRiskData.oneYear ?? "", maxLine: 2)),
                    showLineDivider(),
                    expandedCell(rowCell(index, returnOfRiskData.threeYear ?? "", maxLine: 2)),
                    showLineDivider(),
                    expandedCell(rowCell(index, returnOfRiskData.fiveYear ?? "", maxLine: 2, isLastIndexRight: isLastItem)),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget ourRecommendationWidget(){
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: listOurRecommendation.isEmpty ? Border.all(color: blue) : Border(top: BorderSide(color: blue), left: BorderSide(color: blue), right: BorderSide(color: blue)),
          borderRadius: BorderRadius.circular(14)
      ),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                expandedCell(rowCellTitle("Asset Class", white, alignment: Alignment.centerLeft, isPadding: true)),
                showLineDivider(),
                expandedCell(rowCellTitle("Allocation", white, )),
                showLineDivider(),
                expandedCell(rowCellTitle("Expected Returns", white,)),
              ],
            ),
          ),

          listOurRecommendation.isEmpty ?
          Container(
            height: 100,
            padding: const EdgeInsets.only(bottom: 10),
            child: Center(
              child: Text(
                "No Data Found",
                style: getMediumTextStyle(fontSize: 14, color: blackLight),
              ),
            ),
          ) :
          ListView.builder(
            itemCount: listOurRecommendation.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(0),
            itemBuilder: (context, index) {
              final ourRecommendationData = listOurRecommendation[index];
              return IntrinsicHeight(
                child: Row(
                  children: [
                    expandedCell(rowCell(index, ourRecommendationData.assetClass ?? "", alignment: Alignment.centerLeft, isPadding: true, maxLine: 2)),
                    showLineDivider(),
                    expandedCell(rowCell(index, "${ourRecommendationData.allocationPct}%", maxLine: 2)),
                    showLineDivider(),
                    expandedCell(rowCell(index, "${ourRecommendationData.expectedReturn}%", maxLine: 2)),
                  ],
                ),
              );
            },
          ),
          IntrinsicHeight(
            child: Row(
              children: [
                expandedCell(rowCell(listOurRecommendation.length, "Total", alignment: Alignment.centerLeft, isPadding: true, maxLine: 1, isBold: true, isLastIndexLeft: true)),
                showLineDivider(),
                expandedCell(rowCell(listOurRecommendation.length, "${summaryData.recommendationTable?.summary?.totalAllocationPct ?? ""}%", maxLine: 1, isBold: true)),
                showLineDivider(),
                expandedCell(rowCell(listOurRecommendation.length, "${summaryData.recommendationTable?.summary?.overallExpectedReturn ?? ""}%", maxLine: 1, isBold: true, isLastIndexRight: true)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget balanceSheetDataWidget(){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Container(
        width: 728,
        decoration: BoxDecoration(
          border: listBalanceSheetData.isEmpty ? Border.all(color: blue) : Border(top: BorderSide(color: blue), left: BorderSide(color: blue), right: BorderSide(color: blue)),
          borderRadius: BorderRadius.circular(14)
        ),
        child: Column(
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  rowCellTitle("Year", white, alignment: Alignment.centerLeft, isPadding: true, width: 60),
                  showLineDivider(),
                  rowCellTitle("Opening Balance", white, maxLine: 2, width: 110),
                  showLineDivider(),
                  rowCellTitle("Outflow", white, maxLine: 2, width: 110),
                  showLineDivider(),
                  rowCellTitle("Fresh Inflow", white, maxLine: 2, width: 110),
                  showLineDivider(),
                  rowCellTitle("Expected Profit", white, maxLine: 2, width: 110),
                  showLineDivider(),
                  rowCellTitle("Closing Balance", white, maxLine: 2, width: 110),
                  showLineDivider(),
                  rowCellTitle("Present Value", white, maxLine: 2, width: 110),
                ],
              ),
            ),

            listBalanceSheetData.isEmpty ?
            Container(
              height: 100,
              padding: const EdgeInsets.only(bottom: 10),
              child: Center(
                child: Text(
                  "No Data Found",
                  style: getMediumTextStyle(fontSize: 14, color: blackLight),
                ),
              ),
            ) :
            ListView.builder(
              itemCount: balanceSheetCount,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              itemBuilder: (context, index) {
                final balanceData = listBalanceSheetData[index];
                final bool isLastIndex = index == balanceSheetCount - 1;
                return IntrinsicHeight(
                  child: Row(
                    children: [
                      rowCell(index, "${balanceData.year}", alignment: Alignment.centerLeft, isPadding: true, width: 60, isLastIndexLeft: isLastIndex),
                      showLineDivider(),
                      rowCell(index, convertCommaSeparatedAmount("${balanceData.openingBalance}"), maxLine: 3, width: 110),
                      showLineDivider(),
                      rowCell(index, convertCommaSeparatedAmount("${balanceData.outflow}"), maxLine: 3, width: 110),
                      showLineDivider(),
                      rowCell(index, convertCommaSeparatedAmount("${balanceData.freshInflow}"), maxLine: 3, width: 110),
                      showLineDivider(),
                      rowCell(index, convertCommaSeparatedAmount("${balanceData.expectedProfit}"), maxLine: 3, width: 110),
                      showLineDivider(),
                      rowCell(index, convertCommaSeparatedAmount("${balanceData.closingBalance}"), maxLine: 3, width: 110),
                      showLineDivider(),
                      rowCell(index, convertCommaSeparatedAmount("${balanceData.presentValue}"), maxLine: 3, width: 110, isLastIndexRight: isLastIndex),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget suggestedChangeAssetWidget(){
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: blue), left: BorderSide(color: blue), right: BorderSide(color: blue)),
          borderRadius: BorderRadius.circular(14)
      ),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                expandedCell(rowCellTitle("Asset Class", white, alignment: Alignment.centerLeft, isPadding: true, maxLine: 2)),
                showLineDivider(),
                expandedCell(rowCellTitle("Suggested Allocation", white, maxLine: 2)),
                showLineDivider(),
                expandedCell(rowCellTitle("Existing Allocation", white, maxLine: 2)),
                showLineDivider(),
                expandedCell(rowCellTitle("Variance", white, maxLine: 2)),
              ],
            ),
          ),

          listMacroAllocation.isEmpty ?
          Container(
            height: 100,
            padding: const EdgeInsets.only(bottom: 10),
            child: Center(
              child: Text(
                "No Data Found",
                style: getMediumTextStyle(fontSize: 14, color: blackLight),
              ),
            ),
          ) :
          ListView.builder(
            itemCount: listMacroAllocation.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(0),
            itemBuilder: (context, index) {
              final macroAllocationData = listMacroAllocation[index];
              final variationValue = double.tryParse("${macroAllocationData.variation}") ?? 0;
              final bool isLastIndex = index == listMacroAllocation.length - 1;
              return IntrinsicHeight(
                child: Row(
                  children: [
                    expandedCell(rowCell(index, macroAllocationData.assetClass ?? "", alignment: Alignment.centerLeft, isPadding: true, maxLine: 2, isLastIndexLeft: isLastIndex)),
                    showLineDivider(),
                    expandedCell(rowCell(index, "${macroAllocationData.recommendedAllocation}%", maxLine: 2)),
                    showLineDivider(),
                    expandedCell(rowCell(index, "${macroAllocationData.allocation ?? ""}%", maxLine: 2)),
                    showLineDivider(),
                    expandedCell(rowCell(index, "${macroAllocationData.variation ?? ""}%", titleColor: getValueColor(variationValue), maxLine: 2, isLastIndexRight: isLastIndex)),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget actionPointWidget(String title){
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 6,
            width: 6,
            margin: const EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
              color: black,
              shape: BoxShape.circle
            ),
          ),
          const Gap(8),
          Expanded(
            child: Text(
              title,
              style: getMediumTextStyle(fontSize: 12, color: blackLight),
            ),
          )
        ],
      ),
    );
  }

  openRiskProfileOptionDialog(){
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: white,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context, StateSetter setStateNew) {
            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 22),
              child: Wrap(
                children: <Widget>[
                  Column(
                    children: [
                      getBottomSheetHeaderWithoutButton2(context, "Select Risk Profile Type"),
                      ListView.builder(
                        itemCount: listRiskProfileType.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              changeRiskStatus(listRiskProfileType[index]);
                              Navigator.pop(context);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                                  child: Text(
                                    listRiskProfileType[index],
                                    style: getMediumTextStyle(fontSize: 14, color: selectedRiskProfileType == listRiskProfileType[index] ? blue : black),
                                  ),
                                ),
                                const Divider(color: graySemiDark,thickness: 0.6,height: 0.6,)
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            );
          });
        }
    );
  }

  changeRiskStatus(String riskProfile) async{
    if(isOnline)
    {
      setState(() {
        isLoading = true;
      });

      try
      {
        HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
          HttpLogger(logLevel: LogLevel.BODY),
        ]);
        final url = Uri.parse(API_URL_ANALYSIS + riskStatusChange);
        Map<String, String> jsonBody = {
          "risk_profile": riskProfile,
          'user_id': sessionManager.getUserId(),
        };

        final response = await http.post(url, body: jsonBody);
        final statusCode = response.statusCode;
        final body = response.body;
        Map<String, dynamic> user = jsonDecode(body);
        var dataResponse = CommanResponse.fromJson(user);

        if(statusCode == 200 && dataResponse.success == 1)
        {
          showToast(dataResponse.message);
          _refresh();
        }
        else
        {
          if(dataResponse.message?.isNotEmpty ?? false)
          {
            showToast(dataResponse.message);
          }
          if(mounted)
          {
            isLoading = false;
          }
        }
      }
      catch(e)
      {
        print("Failed to change risk status : $e");
        if(mounted)
        {
          setState(() {
            isLoading = false;
          });
        }
      }
    }
    else
    {
      noInterNet(context);
    }
  }

  fetchFPSummaryData() async{
    if(isOnline)
    {
      setState(() {
        isLoading = true;
      });

      try
      {

        HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
          HttpLogger(logLevel: LogLevel.BODY),
        ]);
        final url = Uri.parse(API_URL_ANALYSIS + summaryDataApi);
        Map<String, String> jsonBody = {
          'user_id': userId,
        };
        final response = await http.post(url, body: jsonBody);
        final statusCode = response.statusCode;
        final body = response.body;
        Map<String, dynamic> user = jsonDecode(body);
        var dataResponse = FpSummaryDataResponseModel.fromJson(user);

        if(statusCode == 200 && dataResponse.success == 1)
        {
          summaryData = dataResponse.summaryData ?? SummaryData();

          listBalanceSheetData = summaryData.balanceSheet ?? [];
          balanceSheetCount = listBalanceSheetData.length > 25 ? 25 : listBalanceSheetData.length;

          listMacroAllocation = summaryData.macroAllocation ?? [];
          listOurRecommendation = summaryData.recommendationTable?.components ?? [];
          listFutureInflow = summaryData.futureInflows?.futureInflowsList ?? [];
          futureInflowTotal = summaryData.futureInflows?.futureInflowsTotal ?? FutureInflowsTotal();
          listLiabilities = summaryData.liabilitiesData?.liabilitiesList ?? [];
          listAspirationSummary = summaryData.aspirationsSummary?.aspirationsSummaryList ?? [];
          aspirationsSummaryTotal = summaryData.aspirationsSummary?.aspirationsSummaryTotal ?? AspirationsSummaryTotal();
          listNetWorth = summaryData.networth?.networthList ?? [];
          listNetWorthTotal = summaryData.networth?.networthTotal ?? NetworthTotal();

          selectedRiskProfileType = summaryData.userDetails?.riskProfile ?? "";
          listRiskProfileAllocation = summaryData.riskProfileAllocation ?? [];
          listReturnOfRisk = summaryData.rangeOfReturn ?? [];

          if (listReturnOfRisk.isNotEmpty)
          {
            final allValues = listReturnOfRisk.expand((e) => [
              e.oneYearValue,
              e.threeYearValue,
              e.fiveYearValue,
            ]);

            final rawMinY = allValues.reduce((a, b) => a < b ? a : b);
            final rawMaxY = allValues.reduce((a, b) => a > b ? a : b);

            final scale = calculateChartScale2(rawMinY, rawMaxY, divisions: 6);

            minY = scale.minY;
            maxY = scale.maxY;
            interval = scale.interval;
          }

          if(summaryData.wealthMetrics != null)
          {
            //================ Current Wealth ================

            final requiredRawCurrent = double.tryParse(summaryData.wealthMetrics?.requiredAmount?.trim() ?? "0",) ?? 0;
            // final existingRawCurrent = summaryData.wealthMetrics?.existingAmount ?? 0;
            final existingRawCurrent = double.tryParse(summaryData.wealthMetrics?.existingAmount ?? "") ?? 0;
            final maxRawCurrent = [requiredRawCurrent, existingRawCurrent].reduce((a, b) => a > b ? a : b);

            amountFormatter = getFormatter(double.tryParse("$maxRawCurrent") ?? 0);

            difference = requiredRawCurrent - existingRawCurrent;
            double diffValue = difference / amountFormatter.divisor;
            currentRsValue = "${diffValue.abs().toStringAsFixed(2)} ${amountFormatter.suffix}";

            requiredWealthCurrent = requiredRawCurrent / amountFormatter.divisor;
            existingWealthCurrent = existingRawCurrent / amountFormatter.divisor;
            final maxValueCurrent = maxRawCurrent / amountFormatter.divisor;

            final scaleCurrent = calculateChartScale2(0, maxValueCurrent, divisions: 6);

            minYCurrent = scaleCurrent.minY;
            maxYCurrent = scaleCurrent.maxY;
            intervalCurrent = scaleCurrent.interval;

            //================ Future Wealth ================

            final requiredRawFuture = double.tryParse(summaryData.wealthMetrics?.requiredAmount?.trim() ?? "0",) ?? 0;
            // final totalRawFuture = summaryData.wealthMetrics?.totalAmount ?? 0;
            final totalRawFuture = double.tryParse(summaryData.wealthMetrics?.totalAmount ?? "") ?? 0;
            final maxRawFuture = [requiredRawFuture, totalRawFuture].reduce((a, b) => a > b ? a : b);

            amountFormatter = getFormatter(double.tryParse("$maxRawFuture") ?? 0);

            differenceFuture = totalRawFuture - requiredRawFuture;
            double diffValueFuture = differenceFuture / amountFormatter.divisor;
            futureRsValue = "${diffValueFuture.toStringAsFixed(2)} ${amountFormatter.suffix}";

            requiredWealthFuture = requiredRawFuture / amountFormatter.divisor;
            totalWealthFuture = totalRawFuture / amountFormatter.divisor;
            final maxValueFuture = maxRawFuture / amountFormatter.divisor;

            final scaleFuture = calculateChartScale2(0, maxValueFuture, divisions: 6);

            minYFuture = scaleFuture.minY;
            maxYFuture = scaleFuture.maxY;
            intervalFuture = scaleFuture.interval;
          }
        }
        else
        {
          showToast("${dataResponse.message}");
        }
      }
      catch(e)
      {
        print("Failed to fetch summary data : $e");
      }
      finally
      {
        setState(() {
          isLoading = false;
        });
      }
    }
    else
    {
      noInterNet(context);
    }
  }

  @override
  void castStatefulWidget() {
    widget as EStateSummaryScreen;
  }
}

extension ReturnOfRiskParsing on RangeOfReturn {
  double get oneYearValue => double.parse("${oneYear?.replaceAll('%', '')}".trim());
  double get threeYearValue => double.parse("${threeYear?.replaceAll('%', '')}".trim());
  double get fiveYearValue => double.parse("${fiveYear?.replaceAll('%', '')}".trim());
}
