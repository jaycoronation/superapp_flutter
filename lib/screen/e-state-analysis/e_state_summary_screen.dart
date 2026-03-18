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
import '../../model/e-state-analysis/FPSummaryDataResponseModel.dart';
import '../../model/e-state-analysis/aspiration_response_model.dart';
import '../../model/e-state-analysis/existing_assets_response_model.dart';
import '../../widget/loading.dart';
import 'e_state_add_existing_assets_page.dart';
import 'e_state_add_future_expense_page.dart';

class EStateSummaryScreen extends StatefulWidget {
  const EStateSummaryScreen({super.key});

  @override
  BaseState<EStateSummaryScreen> createState() => _EStateSummaryScreenState();
}

class _EStateSummaryScreenState extends BaseState<EStateSummaryScreen> {

  bool isLoading = false;

 SummaryData summaryData = SummaryData();
 List<RiskProfileAllocation> listRiskProfileAllocation = [];
 List<RangeOfReturn> listReturnOfRisk = [];
 final List<Color> colorMainAll = [tableLightOrange, tableLightBlue, tableLightGreen, tableLightYellow, tableLightPurple, tableLightPink];
 List<String> listRiskProfileType = ["Conservative", "Moderately Conservative", "Moderate", "Moderately Aggressive", "Aggressive", "Highly Aggressive"];

  String selectedRiskProfileType = "";

  double maxY = 0.0;
  double minY = 0.0;
  double interval = 0.0;

  double maxYCurrent = 0.0;
  double minYCurrent = 0.0;
  double intervalCurrent = 0.0;
  String currentRsValue = "";
  Color currentColor = green;

  double maxYFuture = 0.0;
  double minYFuture = 0.0;
  double intervalFuture = 0.0;
  String futureRsValue = "";
  Color futureColor = green;

  ChartAmountFormatter formatter = ChartAmountFormatter(1, "");
  ChartAmountFormatter formatterFuture = ChartAmountFormatter(1, "");

  double requiredWealthCurrent = 0;
  double existingWealthCurrent = 0;

  double requiredWealthFuture = 0;
  double totalWealthFuture = 0;

  @override
  void initState() {
    fetchFPSummaryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dashboardBg,
      appBar: AppBar(
        toolbarHeight: 55,
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
        SingleChildScrollView(
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
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Aspiration Calculations :",
                              style: getSemiBoldTextStyle(fontSize: 14, color: blue),
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
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Existing Assets :",
                              style: getSemiBoldTextStyle(fontSize: 14, color: blue),
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
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Existing Liabilities :",
                              style: getSemiBoldTextStyle(fontSize: 14, color: blue),
                            ),
                          ),
                          const Gap(8),
                          Container(
                            decoration: BoxDecoration(
                                color: blue,
                                borderRadius: BorderRadius.circular(8)
                            ),
                            padding: const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
                            child: Text("+ Add Liabilities", style: getMediumTextStyle(fontSize: 12, color: white),),
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
                              style: getSemiBoldTextStyle(fontSize: 14, color: blue),
                            ),
                          ),
                          const Gap(8),
                          Container(
                            decoration: BoxDecoration(
                                color: blue,
                                borderRadius: BorderRadius.circular(8)
                            ),
                            padding: const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
                            child: Text("+ Add Future Inflow", style: getMediumTextStyle(fontSize: 12, color: white),),
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
                            style: getSemiBoldTextStyle(fontSize: 14, color: blue),
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
                        style: getSemiBoldTextStyle(fontSize: 14, color: blue),
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
                                        "${value.toStringAsFixed(0)} ${formatter.suffix}",
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
                              "There will be a deficit of",
                              style: getSemiBoldTextStyle(fontSize: 14, color: blue),
                              textAlign: TextAlign.center,
                            ),
                            const Gap(8),
                            Text(
                              currentRsValue,
                              style: getSemiBoldTextStyle(fontSize: 14, color: currentColor),
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
                                        "${value.toStringAsFixed(0)} ${formatterFuture.suffix}",
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
                              "There will be a surplus of",
                              style: getSemiBoldTextStyle(fontSize: 14, color: blue),
                              textAlign: TextAlign.center,
                            ),
                            const Gap(8),
                            Text(
                              futureRsValue,
                              style: getSemiBoldTextStyle(fontSize: 14, color: futureColor),
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
                        style: getSemiBoldTextStyle(fontSize: 14, color: blue),
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
                        style: getSemiBoldTextStyle(fontSize: 14, color: blue),
                      ),
                      const Gap(16),
                      balanceSheetDataWidget(),
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
    );
  }

  Future<void> _refresh() async{
    if(isOnline)
    {
      fetchFPSummaryData();
    }
  }

  Widget aspirationCalculationWidget(){
    final List<AspirationsSummaryList> listAspirationSummary = summaryData.aspirationsSummary?.aspirationsSummaryList ?? [];
    final AspirationsSummaryTotal aspirationsSummaryTotal = summaryData.aspirationsSummary?.aspirationsSummaryTotal ?? AspirationsSummaryTotal();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Container(
        width: 1122,
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: gray), left: BorderSide(color: gray), right: BorderSide(color: gray)),
            borderRadius: BorderRadius.circular(4)
        ),
        child: Column(
          children: [
            Row(
              children: [
                rowCellTitle("Aspiration Type", white, alignment: Alignment.centerLeft, isPadding: true, width: 160),
                rowCellTitle("Start-End Year", white, width: 150),
                rowCellTitle("Total Outflow", white, width: 150),
                rowCellTitle("Inflation adjusted outflow", white, width: 150),
                rowCellTitle("Wealth required today", white, width: 150),
                rowCellTitle("Volatile Component", white, width: 120),
                rowCellTitle("Target Return", white, width: 120),
                rowCellTitle("Monthly SIP", white, width: 120),
              ],
            ),
            ListView.builder(
              itemCount: listAspirationSummary.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              itemBuilder: (context, index) {
                final aspirationData = listAspirationSummary[index];
                return Row(
                  children: [
                    rowCell(index, aspirationData.aspirationType ?? "", alignment: Alignment.centerLeft, isPadding: true, width: 160, maxLine: 2),
                    rowCell(index, "${aspirationData.startYear} - ${aspirationData.endYear}", width: 150, maxLine: 2),
                    rowCell(index, "${convertCommaSeparatedAmount(aspirationData.totalOutflow ?? "")}", width: 150, maxLine: 2),
                    rowCell(index, "${convertCommaSeparatedAmount(aspirationData.totalInflationAdjustedExpense ?? "")}", width: 150, maxLine: 2),
                    rowCell(index, "${convertCommaSeparatedAmount(aspirationData.wealthRequiredTodayTotal ?? "")}", width: 150, maxLine: 2),
                    rowCell(index, aspirationData.volatileComponent ?? "", width: 120, maxLine: 2),
                    rowCell(index, aspirationData.targetReturn ?? "", width: 120, maxLine: 2),
                    rowCell(index, "${convertCommaSeparatedAmount("${aspirationData.requiredSip}")}", width: 120, maxLine: 2),
                  ],
                );
              },
            ),
            Row(
              children: [
                rowCell(listAspirationSummary.length, "Total", alignment: Alignment.centerLeft, isPadding: true, width: 160, maxLine: 1, isBold: true),
                rowCell(listAspirationSummary.length, "", width: 150, maxLine: 1, isBold: true),
                rowCell(listAspirationSummary.length, "${convertCommaSeparatedAmount(aspirationsSummaryTotal.totalOutflow ?? "")}", width: 150, maxLine: 1, isBold: true),
                rowCell(listAspirationSummary.length, "${convertCommaSeparatedAmount(aspirationsSummaryTotal.totalInflationAdjustedExpense ?? "")}", width: 150, maxLine: 1, isBold: true),
                rowCell(listAspirationSummary.length, "${convertCommaSeparatedAmount(aspirationsSummaryTotal.wealthRequiredTodayTotal ?? "")}", width: 150, maxLine: 1, isBold: true),
                rowCell(listAspirationSummary.length, "${aspirationsSummaryTotal.volatileComponent}", width: 120, maxLine: 1, isBold: true),
                rowCell(listAspirationSummary.length, "${aspirationsSummaryTotal.targetReturn}", width: 120, maxLine: 1, isBold: true),
                rowCell(listAspirationSummary.length, "${convertCommaSeparatedAmount("${aspirationsSummaryTotal.requiredSip}")}", width: 120, maxLine: 1, isBold: true),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget existingAssetWidget() {
    final List<NetworthList> listNetWorth = summaryData.networth?.networthList ?? [];
    final NetworthTotal listNetWorthTotal = summaryData.networth?.networthTotal ?? NetworthTotal();

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
                rowCellTitle("Investment Type", white, alignment: Alignment.centerLeft, isPadding: true, width: 180),
                rowCellTitle("Asset Type", white, width: 120),
                rowCellTitle("Current Value", white, width: 150),
              ],
            ),
            ListView.builder(
              itemCount: listNetWorth.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              itemBuilder: (context, index) {
                final existingNetWorthData = listNetWorth[index];
                return Row(
                  children: [
                    rowCell(index, existingNetWorthData.investmentType ?? "", alignment: Alignment.centerLeft, isPadding: true, width: 180, maxLine: 1),
                    rowCell(index, "${existingNetWorthData.assetType}", width: 120, maxLine: 1),
                    rowCell(index, "${convertCommaSeparatedAmount(existingNetWorthData.currentValue ?? "")}", width: 150, maxLine: 1),
                  ],
                );
              },
            ),
            Row(
              children: [
                rowCell(listNetWorth.length, "Total", alignment: Alignment.centerLeft, isPadding: true, width: 180, maxLine: 1, isBold: true),
                rowCell(listNetWorth.length, "", width: 120, maxLine: 1, isBold: true),
                rowCell(listNetWorth.length, "${convertCommaSeparatedAmount(listNetWorthTotal.currentValue ?? "")}", width: 150, maxLine: 1, isBold: true),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget existingLiabilitiesWidget(){
    final List<LiabilitiesList> listLiabilities = summaryData.liabilitiesData?.liabilitiesList ?? [];

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
                rowCellTitle("Liability Type", white, alignment: Alignment.centerLeft, isPadding: true, width: 180),
                rowCellTitle("Asset Type", white, width: 120),
                rowCellTitle("Current Value", white, width: 150),
              ],
            ),
            ListView.builder(
              itemCount: listLiabilities.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              itemBuilder: (context, index) {
                final existingLiabilitiesData = listLiabilities[index];
                return Row(
                  children: [
                    rowCell(index, existingLiabilitiesData.liabilityType ?? "", alignment: Alignment.centerLeft, isPadding: true, width: 180, maxLine: 1),
                    rowCell(index, "${existingLiabilitiesData.assetType}", width: 120, maxLine: 1),
                    rowCell(index, "${convertCommaSeparatedAmount(existingLiabilitiesData.currentValue ?? "")}", width: 150, maxLine: 1),
                  ],
                );
              },
            ),
            Row(
              children: [
                rowCell(listLiabilities.length, "Total", alignment: Alignment.centerLeft, isPadding: true, width: 180, maxLine: 1, isBold: true),
                rowCell(listLiabilities.length, "", width: 120, maxLine: 1, isBold: true),
                rowCell(listLiabilities.length, "${convertCommaSeparatedAmount(summaryData.liabilitiesData?.totalLiabilities ?? "")}", width: 150, maxLine: 1, isBold: true),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget futureInflowWidget(){
    final List<FutureInflowsList> listFutureInflow = summaryData.futureInflows?.futureInflowsList ?? [];
    final FutureInflowsTotal futureInflowTotal = summaryData.futureInflows?.futureInflowsTotal ?? FutureInflowsTotal();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Container(
        width: 902,
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: gray), left: BorderSide(color: gray), right: BorderSide(color: gray)),
            borderRadius: BorderRadius.circular(4)
        ),
        child: Column(
          children: [
            Row(
              children: [
                rowCellTitle("Source", white, alignment: Alignment.centerLeft, isPadding: true, width: 180),
                rowCellTitle("Duration", white, width: 120),
                rowCellTitle("Amount", white, width: 150),
                rowCellTitle("Expected Growth", white, width: 150),
                rowCellTitle("Inflation Adjusted Income", white, width: 150),
                rowCellTitle("PV of Income", white, width: 150),
              ],
            ),
            ListView.builder(
              itemCount: listFutureInflow.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              itemBuilder: (context, index) {
                final futureInflowData = listFutureInflow[index];
                return Row(
                  children: [
                    rowCell(index, futureInflowData.source ?? "", alignment: Alignment.centerLeft, isPadding: true, width: 180, maxLine: 1),
                    rowCell(index, "${futureInflowData.startYear} - ${futureInflowData.endYear}", width: 120, maxLine: 1),
                    rowCell(index, "${convertCommaSeparatedAmount(futureInflowData.amount ?? "")}", width: 150, maxLine: 1),
                    rowCell(index, futureInflowData.expectedGrowth ?? "", width: 150, maxLine: 1),
                    rowCell(index, "${convertCommaSeparatedAmount(futureInflowData.inflationAdjustedIncome ?? "")}", width: 150, maxLine: 1),
                    rowCell(index, "${convertCommaSeparatedAmount(futureInflowData.pvOfIncome ?? "")}", width: 150, maxLine: 1),
                  ],
                );
              },
            ),
            Row(
              children: [
                rowCell(listFutureInflow.length, "Total", alignment: Alignment.centerLeft, isPadding: true, width: 180, maxLine: 1, isBold: true),
                rowCell(listFutureInflow.length, "", width: 120, maxLine: 1, isBold: true),
                rowCell(listFutureInflow.length, "${convertCommaSeparatedAmount(futureInflowTotal.amount ?? "")}", width: 150, maxLine: 1, isBold: true),
                rowCell(listFutureInflow.length, "", width: 150, maxLine: 1, isBold: true),
                rowCell(listFutureInflow.length, "${convertCommaSeparatedAmount(futureInflowTotal.inflationAdjustedIncome ?? "")}", width: 150, maxLine: 1, isBold: true),
                rowCell(listFutureInflow.length, "${convertCommaSeparatedAmount(futureInflowTotal.pvOfIncome ?? "")}", width: 150, maxLine: 1, isBold: true),
              ],
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Container(
        width: 352,
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: gray), left: BorderSide(color: gray), right: BorderSide(color: gray)),
            borderRadius: BorderRadius.circular(4)
        ),
        child: Column(
          children: [
            Row(
              children: [
                rowCellTitle("Asset Class", white, alignment: Alignment.centerLeft, isPadding: true, width: 120),
                rowCellTitle("Allocation", white, width: 110),
                rowCellTitle("Expected Return", white, width: 120),
              ],
            ),
            ListView.builder(
              itemCount: listRiskProfileAllocation.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              itemBuilder: (context, index) {
                final suggestedData = listRiskProfileAllocation[index];
                final isTotal = (suggestedData.assetClass ?? "") == "Total";
                return Row(
                  children: [
                    rowCell(index, suggestedData.assetClass ?? "", alignment: Alignment.centerLeft, isPadding: true, width: 120, isBold: isTotal),
                    rowCell(index, "${suggestedData.allocation}", width: 110, isBold: isTotal),
                    rowCell(index, suggestedData.expectedReturn ?? "", width: 120, isBold: isTotal),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  rangeOfReturnWidget() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Container(
        width: 502,
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: gray), left: BorderSide(color: gray), right: BorderSide(color: gray)),
            borderRadius: BorderRadius.circular(4)
        ),
        child: Column(
          children: [
            Row(
              children: [
                rowCellTitle("Range of Return", white, alignment: Alignment.centerLeft, isPadding: true, width: 140),
                rowCellTitle("1 Year", white, width: 120),
                rowCellTitle("3 Years", white, width: 120),
                rowCellTitle("5 Years", white, width: 120),
              ],
            ),
            ListView.builder(
              itemCount: listReturnOfRisk.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              itemBuilder: (context, index) {
                final returnOfRiskData = listReturnOfRisk[index];
                return Row(
                  children: [
                    rowCell(index, returnOfRiskData.rangeOfReturn ?? "", alignment: Alignment.centerLeft, isPadding: true, width: 140),
                    rowCell(index, returnOfRiskData.oneYear ?? "", width: 120),
                    rowCell(index, returnOfRiskData.threeYear ?? "", width: 120),
                    rowCell(index, returnOfRiskData.fiveYear ?? "", width: 120),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget ourRecommendationWidget(){

    final List<Components> listOurRecommendation = summaryData.recommendationTable?.components ?? [];

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
                rowCellTitle("Asset Class", white, alignment: Alignment.centerLeft, isPadding: true, width: 180),
                rowCellTitle("Allocation", white, width: 120),
                rowCellTitle("Expected Returns", white, width: 150),
              ],
            ),
            ListView.builder(
              itemCount: listOurRecommendation.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              itemBuilder: (context, index) {
                final ourRecommendationData = listOurRecommendation[index];
                return Row(
                  children: [
                    rowCell(index, ourRecommendationData.assetClass ?? "", alignment: Alignment.centerLeft, isPadding: true, width: 180, maxLine: 1),
                    rowCell(index, "${ourRecommendationData.allocationPct}%", width: 120, maxLine: 1),
                    rowCell(index, "${ourRecommendationData.expectedReturn}%", width: 150, maxLine: 1),
                  ],
                );
              },
            ),
            Row(
              children: [
                rowCell(listOurRecommendation.length, "Total", alignment: Alignment.centerLeft, isPadding: true, width: 180, maxLine: 1, isBold: true),
                rowCell(listOurRecommendation.length, "${summaryData.recommendationTable?.summary?.totalAllocationPct ?? ""}%", width: 120, maxLine: 1, isBold: true),
                rowCell(listOurRecommendation.length, "${summaryData.recommendationTable?.summary?.overallExpectedReturn ?? ""}%", width: 150, maxLine: 1, isBold: true),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget balanceSheetDataWidget(){

    final List<BalanceSheet> listBalanceSheetData = summaryData.balanceSheet ?? [];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Container(
        width: 1002,
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: gray), left: BorderSide(color: gray), right: BorderSide(color: gray)),
            borderRadius: BorderRadius.circular(4)
        ),
        child: Column(
          children: [
            Row(
              children: [
                rowCellTitle("Year", white, alignment: Alignment.centerLeft, isPadding: true, width: 100),
                rowCellTitle("Opening Balance", white, width: 150),
                rowCellTitle("Outflow", white, width: 150),
                rowCellTitle("Fresh Inflow", white, width: 150),
                rowCellTitle("Expected Profit", white, width: 150),
                rowCellTitle("Closing Balance", white, width: 150),
                rowCellTitle("Present Value", white, width: 150),
              ],
            ),
            ListView.builder(
              itemCount: listBalanceSheetData.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              itemBuilder: (context, index) {
                final balanceData = listBalanceSheetData[index];
                return Row(
                  children: [
                    rowCell(index, "${balanceData.year}", alignment: Alignment.centerLeft, isPadding: true, width: 100),
                    rowCell(index, convertCommaSeparatedAmount("${balanceData.openingBalance}") , width: 150),
                    rowCell(index, convertCommaSeparatedAmount("${balanceData.outflow}") , width: 150),
                    rowCell(index, convertCommaSeparatedAmount("${balanceData.freshInflow}") , width: 150),
                    rowCell(index, convertCommaSeparatedAmount("${balanceData.expectedProfit}") , width: 150),
                    rowCell(index, convertCommaSeparatedAmount("${balanceData.closingBalance}") , width: 150),
                    rowCell(index, convertCommaSeparatedAmount("${balanceData.presentValue}") , width: 150),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget suggestedChangeAssetWidget(){
    final List<MacroAllocation> listMacroAllocation = summaryData.macroAllocation ?? [];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Container(
        width: 602,
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: gray), left: BorderSide(color: gray), right: BorderSide(color: gray)),
            borderRadius: BorderRadius.circular(4)
        ),
        child: Column(
          children: [
            Row(
              children: [
                rowCellTitle("Asset Class", white, alignment: Alignment.centerLeft, isPadding: true, width: 180),
                rowCellTitle("Suggested Allocation", white, width: 120),
                rowCellTitle("Existing Allocation", white, width: 150),
                rowCellTitle("Variance", white, width: 150),
              ],
            ),
            ListView.builder(
              itemCount: listMacroAllocation.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              itemBuilder: (context, index) {
                final macroAllocationData = listMacroAllocation[index];
                final variationValue = double.tryParse("${macroAllocationData.variation}") ?? 0;
                return Row(
                  children: [
                    rowCell(index, macroAllocationData.assetClass ?? "", alignment: Alignment.centerLeft, isPadding: true, width: 180, maxLine: 1),
                    rowCell(index, "${macroAllocationData.recommendedAllocation}%", width: 120, maxLine: 1),
                    rowCell(index, "${macroAllocationData.allocation ?? ""}%", width: 150, maxLine: 1),
                    rowCell(index, "${macroAllocationData.variation ?? ""}%", titleColor: getValueColor(variationValue), width: 150, maxLine: 1),
                  ],
                );
              },
            ),
          ],
        ),
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
          'user_id': sessionManager.getUserId().toString().trim(),
        };
        final response = await http.post(url, body: jsonBody);
        final statusCode = response.statusCode;
        final body = response.body;
        Map<String, dynamic> user = jsonDecode(body);
        var dataResponse = FpSummaryDataResponseModel.fromJson(user);

        if(statusCode == 200 && dataResponse.success == 1)
        {
          summaryData = dataResponse.summaryData ?? SummaryData();

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
            final existingRawCurrent = summaryData.wealthMetrics?.existingAmount ?? 0;
            final maxRawCurrent = [requiredRawCurrent, existingRawCurrent].reduce((a, b) => a > b ? a : b);

            formatter = getFormatter(double.tryParse("$maxRawCurrent") ?? 0);

            double difference = requiredRawCurrent - existingRawCurrent;
            double diffValue = difference / formatter.divisor;
            currentRsValue = "${diffValue.abs().toStringAsFixed(2)} ${formatter.suffix}";
            currentColor = difference > 0 ? red : green;

            requiredWealthCurrent = requiredRawCurrent / formatter.divisor;
            existingWealthCurrent = existingRawCurrent / formatter.divisor;
            final maxValueCurrent = maxRawCurrent / formatter.divisor;

            final scaleCurrent = calculateChartScale2(0, maxValueCurrent, divisions: 6);

            minYCurrent = scaleCurrent.minY;
            maxYCurrent = scaleCurrent.maxY;
            intervalCurrent = scaleCurrent.interval;

            //================ Future Wealth ================

            final requiredRawFuture = double.tryParse(summaryData.wealthMetrics?.requiredAmount?.trim() ?? "0",) ?? 0;
            final totalRawFuture = summaryData.wealthMetrics?.totalAmount ?? 0;
            final maxRawFuture = [requiredRawFuture, totalRawFuture].reduce((a, b) => a > b ? a : b);

            formatterFuture = getFormatter(double.tryParse("$maxRawFuture") ?? 0);

            double differenceFuture = totalRawFuture - requiredRawFuture;
            double diffValueFuture = differenceFuture / formatterFuture.divisor;
            futureRsValue = "${diffValueFuture.toStringAsFixed(2)} ${formatterFuture.suffix}";
            futureColor = differenceFuture > 0 ? green : red;

            requiredWealthFuture = requiredRawFuture / formatterFuture.divisor;
            totalWealthFuture = totalRawFuture / formatterFuture.divisor;
            final maxValueFuture = maxRawFuture / formatterFuture.divisor;

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
