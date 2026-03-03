import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/model/e-state-analysis/ReturnOfRiskResponseModel.dart';
import 'package:superapp_flutter/model/e-state-analysis/RiskProfileAllocationResponseModel.dart';
import 'package:superapp_flutter/utils/app_utils.dart';
import 'package:superapp_flutter/utils/base_class.dart';
import 'package:superapp_flutter/widget/loading.dart';

import '../../common_widget/chart_scale.dart';
import '../../common_widget/common_widget.dart';
import '../../constant/analysis_api_end_point.dart';
import '../../constant/colors.dart';

class EStateRiskProfileScreenNew extends StatefulWidget {
  const EStateRiskProfileScreenNew({super.key});

  @override
  BaseState<EStateRiskProfileScreenNew> createState() => _EStateRiskProfileScreenNewState();
}

class _EStateRiskProfileScreenNewState extends BaseState<EStateRiskProfileScreenNew> {

  bool isLoading = false;

  List<ReturnOfRisk> listReturnOfRisk = [];
  List<RiskProfileAllocation> listRiskProfileAllocation = [];
  final List<Color> colorMainAll = [tableLightOrange, tableLightBlue, tableLightGreen, tableLightYellow, tableLightPurple, tableLightPink];

  double maxY = 0.0;
  double minY = 0.0;
  double interval = 0.0;

  @override
  void initState() {
    fetchReturnOfRiskData();
    fetchRiskProfileAllocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        toolbarHeight: 55,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: getBackArrow(),
        ),
        title: getTitle("Find Risk Profile",),
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
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Risk Profile Calculation",
                  style: getMediumTextStyle(fontSize: 16, color: blue),
                ),
                const Gap(20),
                Text(
                  "Suggested Asset Allocation",
                  style: getSemiBoldTextStyle(fontSize: 16, color: blue),
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
                  style: getSemiBoldTextStyle(fontSize: 16, color: blue),
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
                const Gap(20),
                Card(
                  color: white,
                  margin: const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 16),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 350,
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
                                  reservedSize: 50,
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
                                    width: 18,
                                    color: tableLightOrange,
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  BarChartRodData(
                                    toY: item.threeYearValue,
                                    width: 18,
                                    color: tableLightBlue,
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  BarChartRodData(
                                    toY: item.fiveYearValue,
                                    width: 18,
                                    color: tableLightGreen,
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ],
                              );
                            }),
                          ),
                        ),
                      ),
                      const Gap(16),
                      Center(
                        child: Wrap(
                          spacing: 12,
                          runSpacing: 8,
                          alignment: WrapAlignment.center,
                          children: listReturnOfRisk.toList().asMap().entries.map((entry) {

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
                                  item.rangeOfReturn ?? "",
                                  style: getMediumTextStyle(fontSize: 12, color: black),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                      const Gap(20)
                    ],
                  ),
                ),
                const Gap(20),
              ],
            ),
          ),
        ),
      ),
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

  fetchReturnOfRiskData() async{
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

        final url = Uri.parse(API_URL_ANALYSIS + returnOfRisk);

        Map<String, String> jsonBody = {
          'user_id': sessionManager.getUserId().toString().trim(),
        };

        final response = await http.post(url, body: jsonBody);
        final statusCode = response.statusCode;
        final body = response.body;
        Map<String, dynamic> user = jsonDecode(body);
        var dataResponse = ReturnOfRiskResponseModel.fromJson(user);

        if(statusCode == 200 && dataResponse.success == 1)
        {
          listReturnOfRisk = dataResponse.returnOfRisk ?? [];

          if (listReturnOfRisk.isNotEmpty) {
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
        }
        else
        {
          listReturnOfRisk = [];
        }
        print("Display return of risk list : ${listReturnOfRisk.length}");
      }
      catch(e)
      {
        print("Failed to fetch e state risk profile : $e");
      }
      finally
      {
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

  fetchRiskProfileAllocation() async{
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

        final url = Uri.parse(API_URL_ANALYSIS + riskProfileAllocation);

        Map<String, String> jsonBody = {
          'user_id': sessionManager.getUserId().toString().trim(),
        };

        final response = await http.post(url, body: jsonBody);
        final statusCode = response.statusCode;
        final body = response.body;
        Map<String, dynamic> user = jsonDecode(body);
        var dataResponse = RiskProfileAllocationResponseModel.fromJson(user);

        if(statusCode == 200 && dataResponse.success == 1)
        {
          listRiskProfileAllocation = dataResponse.riskProfileAllocation ?? [];
        }
        else
        {
          listRiskProfileAllocation = [];
        }
        print("Display risk profile allocation list : ${listRiskProfileAllocation.length}");
      }
      catch(e)
      {
        print("Failed to fetch e state risk profile : $e");
      }
      finally
      {
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

  @override
  void castStatefulWidget() {
    widget as EStateRiskProfileScreenNew;
  }
}

extension ReturnOfRiskParsing on ReturnOfRisk {
  double get oneYearValue => double.parse("${oneYear?.replaceAll('%', '')}".trim());
  double get threeYearValue => double.parse("${threeYear?.replaceAll('%', '')}".trim());
  double get fiveYearValue => double.parse("${fiveYear?.replaceAll('%', '')}".trim());
}
