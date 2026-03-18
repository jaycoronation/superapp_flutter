import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/model/CommanResponse.dart';
import 'package:superapp_flutter/model/e-state-analysis/ReturnOfRiskResponseModel.dart';
import 'package:superapp_flutter/model/e-state-analysis/RiskProfileAllocationResponseModel.dart';
import 'package:superapp_flutter/utils/app_utils.dart';
import 'package:superapp_flutter/utils/base_class.dart';
import 'package:superapp_flutter/widget/loading.dart';

import '../../common_widget/chart_scale.dart';
import '../../common_widget/common_widget.dart';
import '../../constant/analysis_api_end_point.dart';
import '../../constant/colors.dart';
import '../../model/e-state-analysis/UserProfileResponseModel.dart';
import 'e_state_risk_profile_page.dart';

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
  List<String> listRiskProfileType = ["Conservative", "Moderately Conservative", "Moderate", "Moderately Aggressive", "Aggressive", "Highly Aggressive"];

  String selectedRiskProfileType = "";

  double maxY = 0.0;
  double minY = 0.0;
  double interval = 0.0;

  @override
  void initState() {
    fetchUserProfile();

    // fetchReturnOfRiskData();
    // fetchRiskProfileAllocation();
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
            padding: const EdgeInsets.only(top: 16, bottom: 16, left: 10, right: 10),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Your risk Profile is : ",
                            style: getMediumTextStyle(fontSize: 14, color: black),
                            textAlign: TextAlign.start,
                          ),
                          const Gap(4),
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
                    ),
                    const Gap(10),
                    Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          startActivity(context, EStateRiskProfilePage());
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Don't know your risk profile ?",
                              style: getMediumTextStyle(fontSize: 14, color: black),
                              textAlign: TextAlign.end,
                            ),
                            const Gap(4),
                            Text(
                              "find here",
                              style: getMediumTextStyle(fontSize: 14, color: blue),
                              textAlign: TextAlign.end,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const Gap(16),
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
                        "Risk Profile Calculation",
                        style: getMediumTextStyle(fontSize: 16, color: blue),
                      ),
                      const Gap(10),
                      Divider(color: gray, thickness: 1,),
                      const Gap(10),
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
                      const Gap(16),
                      Center(
                        child: Text(
                          "*Expected profit growth may or may not happen in future",
                          style: getMediumTextStyle(fontSize: 12, color: black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Gap(20)
                    ],
                  ),
                )
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
      fetchUserProfile();
    }
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
                              // setState(() {
                              //   selectedRiskProfileType = listRiskProfileType[index];
                              // });
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

  fetchUserProfile() async{
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

        final url = Uri.parse(API_URL_ANALYSIS + userProfile);

        Map<String, String> jsonBody = {
          'user_id': sessionManager.getUserId().toString().trim(),
        };

        final response = await http.post(url, body: jsonBody);
        final statusCode = response.statusCode;
        final body = response.body;
        Map<String, dynamic> user = jsonDecode(body);
        var dataResponse = UserProfileResponseModel.fromJson(user);

        if(statusCode == 200 && dataResponse.success == 1)
        {
          if(dataResponse.profile != null)
          {
           selectedRiskProfileType = dataResponse.profile?.riskProfile ?? "";
          }
          fetchReturnOfRiskData();
          fetchRiskProfileAllocation();
        }

      }
      catch(e)
      {
        print("Failed to fetch user detail : $e");
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

