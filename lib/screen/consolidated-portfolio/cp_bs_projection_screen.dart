import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/model/consolidated-portfolio/BsProjectionResponseModel.dart';
import 'package:superapp_flutter/utils/app_utils.dart';
import 'package:superapp_flutter/utils/base_class.dart';
import 'package:superapp_flutter/widget/loading.dart';
import 'package:superapp_flutter/widget/no_data.dart';

import '../../common_widget/chart_scale.dart';
import '../../common_widget/common_widget.dart';
import '../../constant/colors.dart';

class CpBsProjectionScreen extends StatefulWidget {
  const CpBsProjectionScreen({super.key});

  @override
  BaseState<CpBsProjectionScreen> createState() => _CpBsProjectionScreenState();
}

class _CpBsProjectionScreenState extends BaseState<CpBsProjectionScreen> {

  bool isLoading = false;
  bool isShowFullScreenCart = false;

  List<BalanceSheetData> listBalanceSheetData = [];
  Inflows inflowsData = Inflows();
  Aspirations aspirations = Aspirations();

  double maxY = 0.0;
  double interval = 0.0;
  final double pointWidth = 120;
  double chartWidth = 0.0;

  int bottomYearInterval = 0;

  @override
  void initState() {
    fetchBsProjectionData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if(didPop)
        {
          return;
        }
        if(isShowFullScreenCart){
          SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        }
        Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: dashboardBg,
        appBar: AppBar(
          toolbarHeight: 60,
          automaticallyImplyLeading: false,
          backgroundColor: appBg,
          elevation: 0,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              if(isShowFullScreenCart){
                SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
              }
              Navigator.pop(context);
            },
            child: getBackArrow(),
          ),
          title: getTitle('BS Projection'),
        ),
        body: SafeArea(
          child: isLoading ? LoadingWidget() : listBalanceSheetData.isEmpty ? MyNoDataWidget(msg: "No Data Found") :
          isShowFullScreenCart ?
          Container(
            decoration: BoxDecoration(color: white),
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(top: 8),
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: (listBalanceSheetData.length - 1).toDouble(),
                minY: 0,
                maxY: listBalanceSheetData.isNotEmpty ? maxY : 0.0,
                gridData: FlGridData(
                  show: true,
                  horizontalInterval: listBalanceSheetData.isNotEmpty ? interval : null,
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: listBalanceSheetData.isNotEmpty ? interval : null,
                      reservedSize: 80,
                      getTitlesWidget: (value, meta) {
                        final isTopValue = value == meta.max;
                        return Padding(
                          padding: EdgeInsets.only(top: isTopValue ? 10 : 0,),
                          child: Text(
                            value.toStringAsFixed(0),
                            style: getMediumTextStyle(fontSize: 10, color: black),
                          ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: bottomYearInterval.toDouble(),
                      getTitlesWidget: (value, meta) {
                        int index = value.toInt();
                        if (index >= 0 &&
                            index < listBalanceSheetData.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              listBalanceSheetData[index].year.toString(),
                              style: const TextStyle(fontSize: 10),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  rightTitles: AxisTitles(),
                  topTitles: AxisTitles(),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    isCurved: true,
                    barWidth: 3,
                    color: tableLightBlue,
                    dotData: FlDotData(show: true),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [white, lightBlue2],
                      ),
                    ),
                    spots: listBalanceSheetData.asMap().entries.map((entry) => FlSpot(entry.key.toDouble(), double.tryParse("${entry.value.closingBalance}") ?? 0.0,),).toList(),
                  ),
                ],
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (_) => grayDark,
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((spot) {
                        final data =
                        listBalanceSheetData[spot.x.toInt()];
                        return LineTooltipItem(
                          "${data.year}\nClosing Balance: ${convertCommaSeparatedAmount("${data.closingBalance?.toStringAsFixed(0)}")}",
                          getMediumTextStyle(
                              fontSize: 12, color: white),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            ),
          ) :
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(top: 16, bottom: 16, left: 12, right: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                                  "Balance Sheet Projection:",
                                  style: getMediumTextStyle(fontSize: 14, color: blue),
                                ),
                              ),
                              const Gap(10),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  setState(() {
                                    isShowFullScreenCart = !isShowFullScreenCart;
                                  });

                                  if(isShowFullScreenCart)
                                  {
                                    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
                                  }
                                  else
                                  {
                                    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
                                  }
                                },
                                child: Icon(Icons.fullscreen, size: 24, color: blue,),
                              )
                            ],
                          ),
                          const Gap(8),
                          Divider(color: gray,),
                          const Gap(8),
                          SizedBox(
                            height: 300,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              child: SizedBox(
                                width: chartWidth < MediaQuery.of(context).size.width ? MediaQuery.of(context).size.width : chartWidth,
                                child: LineChart(
                                  LineChartData(
                                    minX: 0,
                                    maxX: (listBalanceSheetData.length - 1).toDouble(),
                                    minY: 0,
                                    maxY: listBalanceSheetData.isNotEmpty ? maxY : 0.0,
                                    gridData: FlGridData(
                                      show: true,
                                      horizontalInterval: listBalanceSheetData.isNotEmpty ? interval : null,
                                    ),
                                    titlesData: FlTitlesData(
                                      leftTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          interval: listBalanceSheetData.isNotEmpty ? interval : null,
                                          reservedSize: 80,
                                          getTitlesWidget: (value, meta) {
                                            final isTopValue = value == meta.max;
                                            return Padding(
                                              padding: EdgeInsets.only(top: isTopValue ? 10 : 0,),
                                              child: Text(
                                                value.toStringAsFixed(0),
                                                style: getMediumTextStyle(fontSize: 10, color: black),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          interval: 1,
                                          getTitlesWidget: (value, meta) {
                                            int index = value.toInt();
                                            if (index >= 0 &&
                                                index < listBalanceSheetData.length) {
                                              return Padding(
                                                padding: const EdgeInsets.only(top: 8),
                                                child: Text(
                                                  listBalanceSheetData[index].year.toString(),
                                                  style: const TextStyle(fontSize: 10),
                                                ),
                                              );
                                            }
                                            return const SizedBox.shrink();
                                          },
                                        ),
                                      ),

                                      rightTitles: AxisTitles(),
                                      topTitles: AxisTitles(),
                                    ),

                                    borderData: FlBorderData(show: false),

                                    lineBarsData: [
                                      LineChartBarData(
                                        isCurved: true,
                                        barWidth: 3,
                                        color: tableLightBlue,
                                        dotData: FlDotData(show: true),
                                        belowBarData: BarAreaData(
                                          show: true,
                                          gradient: LinearGradient(
                                            colors: [white, lightBlue2],
                                          ),
                                        ),
                                        spots: listBalanceSheetData
                                            .asMap()
                                            .entries
                                            .map(
                                              (entry) => FlSpot(
                                            entry.key.toDouble(),
                                            double.tryParse(
                                                "${entry.value.closingBalance}") ??
                                                0.0,
                                          ),
                                        )
                                            .toList(),
                                      ),
                                    ],

                                    lineTouchData: LineTouchData(
                                      touchTooltipData: LineTouchTooltipData(
                                        getTooltipColor: (_) => grayDark,
                                        getTooltipItems: (touchedSpots) {
                                          return touchedSpots.map((spot) {
                                            final data =
                                            listBalanceSheetData[spot.x.toInt()];
                                            return LineTooltipItem(
                                              "${data.year}\nClosing Balance: ${convertCommaSeparatedAmount("${data.closingBalance?.toStringAsFixed(0)}")}",
                                              getMediumTextStyle(
                                                  fontSize: 12, color: white),
                                            );
                                          }).toList();
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
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
                          "Balance Sheet Projection:",
                          style: getMediumTextStyle(fontSize: 14, color: blue),
                        ),
                        const Gap(8),
                        Divider(color: gray,),
                        const Gap(8),
                        Visibility(
                            visible: (listBalanceSheetData.isNotEmpty),
                            child: balanceSheetDataWidget()
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
                        const Gap(12),
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

  String formatIndianAmount(double value) {
    final format = NumberFormat("#,##,##,###", "en_IN");
    return format.format(value);
  }

  Widget balanceSheetDataWidget(){
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

  fetchBsProjectionData() async{
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

        // final url = Uri.parse(API_URL_CP + bsProjection);
        final url = Uri.parse("https://portfolio.alphacapital.in/api/services/balance_sheet_projection");
        Map<String, String> jsonBody = {
          'user_id': sessionManagerPMS.getUserId().trim(),
        };

        final response = await http.post(url, body: jsonBody);
        final statusCode = response.statusCode;
        final body = response.body;
        Map<String, dynamic> user = jsonDecode(body);
        var dataResponse = BsProjectionResponseModel.fromJson(user);

        if(statusCode == 200)
        {
          if(dataResponse.balanceSheetData?.isNotEmpty ?? false)
          {
            listBalanceSheetData = dataResponse.balanceSheetData ?? [];
            chartWidth  = listBalanceSheetData.length * pointWidth;

            final double rawMaxY = listBalanceSheetData.isNotEmpty ? listBalanceSheetData
                .map((e) => double.tryParse("${e.openingBalance}") ?? 0)
                .reduce((a, b) => (a) > (b) ? a : b)
                .toDouble()
                : 0;
            final scale = calculateChartScale(rawMaxY, divisions: 7);
            maxY = scale.maxY;
            interval = scale.interval;

            bottomYearInterval = calculateYearInterval(listBalanceSheetData);
          }
          else
          {
            listBalanceSheetData = [];
          }

          if(dataResponse.inflows != null)
          {
            inflowsData = dataResponse.inflows ?? Inflows();
          }

          if(dataResponse.aspirations != null)
          {
            aspirations = dataResponse.aspirations ?? Aspirations();
          }

          setState(() {});
        }
        else
        {
          listBalanceSheetData = [];
        }

      }
      catch(e)
      {
        print("Failed to fetch cp projection data : $e");
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
    widget as CpBsProjectionScreen;
  }

}
