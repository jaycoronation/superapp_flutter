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
  bool isExpandedBalanceSheet =  false;

  List<BalanceSheetData> listBalanceSheetData = [];
  Inflows inflowsData = Inflows();
  Aspirations aspirations = Aspirations();

  double maxY = 0.0;
  double interval = 0.0;
  final double pointWidth = 120;
  double chartWidth = 0.0;

  int bottomYearInterval = 0;

  int balanceSheetCount = 0;

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
          actions: [
            Visibility(
              visible: isShowFullScreenCart == true,
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                child: GestureDetector(
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
                  child: Icon(Icons.fullscreen_exit, size: 24, color: blue,),
                ),
              ),
            )
          ],
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
                clipData: FlClipData.all(),
                rangeAnnotations: RangeAnnotations(),
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
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 3, // smaller dots = no overflow feel
                          color: tableLightBlue,
                          strokeWidth: 0,
                        );
                      },
                    ),
                   // dotData: FlDotData(show: true),
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
                  handleBuiltInTouches: true,
                  touchTooltipData: LineTouchTooltipData(
                    fitInsideHorizontally: true,
                    fitInsideVertically: true,
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
                          SizedBox(
                            child: SizedBox(
                              height: 300,
                              width: MediaQuery.of(context).size.width,
                              child: LineChart(
                                LineChartData(
                                  clipData: FlClipData.all(),
                                  rangeAnnotations: RangeAnnotations(),
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
                                        interval: getDynamicInterval(),
                                        getTitlesWidget: (value, meta) {
                                          int index = value.toInt();

                                          if (index >= 0 && index < listBalanceSheetData.length) {
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
                                    // bottomTitles: AxisTitles(
                                    //   sideTitles: SideTitles(
                                    //     showTitles: true,
                                    //     interval: 1,
                                    //     getTitlesWidget: (value, meta) {
                                    //       int index = value.toInt();
                                    //       if (index >= 0 &&
                                    //           index < listBalanceSheetData.length) {
                                    //         return Padding(
                                    //           padding: const EdgeInsets.only(top: 8),
                                    //           child: Text(
                                    //             listBalanceSheetData[index].year.toString(),
                                    //             style: const TextStyle(fontSize: 10),
                                    //           ),
                                    //         );
                                    //       }
                                    //       return const SizedBox.shrink();
                                    //     },
                                    //   ),
                                    // ),

                                    rightTitles: AxisTitles(),
                                    topTitles: AxisTitles(),
                                  ),

                                  borderData: FlBorderData(show: false),

                                  lineBarsData: [
                                    LineChartBarData(
                                      isCurved: true,
                                      barWidth: 3,
                                      color: tableLightBlue,
                                      dotData: FlDotData(
                                        show: true,
                                        getDotPainter: (spot, percent, barData, index) {
                                          return FlDotCirclePainter(
                                            radius: 2, // smaller dots = no overflow feel
                                            color: tableLightBlue,
                                            strokeWidth: 0,
                                          );
                                        },
                                      ),
                                      //dotData: FlDotData(show: true),
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
                                    handleBuiltInTouches: true,
                                    touchTooltipData: LineTouchTooltipData(
                                      fitInsideHorizontally: true,
                                      fitInsideVertically: true,
                                      getTooltipColor: (_) => grayDark,
                                      getTooltipItems: (touchedSpots) {
                                        return touchedSpots.map((spot) {
                                          final data = listBalanceSheetData[spot.x.toInt()];
                                          return LineTooltipItem(
                                            "${data.year}\nClosing Balance: ${convertCommaSeparatedAmount("${data.closingBalance?.toStringAsFixed(0)}")}",
                                            getMediumTextStyle(fontSize: 12, color: white),
                                          );
                                        }).toList();
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Gap(8),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              balanceSheetDataWidget(),
                              GestureDetector(
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
                              )
                            ],
                          )
                        ),
                        const Gap(10),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              belowTableTitle("*Inflation is assumed at 6%"),
                              const Gap(2),
                              belowTableTitle("**Expected profit growth is 12%"),
                              const Gap(2),
                              belowTableTitle("***Expected growth in fresh inflow is 10%"),
                              const Gap(2),
                              belowTableTitle("**Expected profit growth may or may not happen in future due to market risk."),
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

  double getDynamicInterval() {
    int length = listBalanceSheetData.length;

    if (length <= 6) return 1;
    if (length <= 12) return 2;
    if (length <= 20) return 3;
    return (length / 6).ceilToDouble(); // approx 5-6 labels
  }

  String formatIndianAmount(double value) {
    final format = NumberFormat("#,##,##,###", "en_IN");
    return format.format(value);
  }

  Widget balanceSheetDataWidget() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        decoration: BoxDecoration(
          // border: Border.all(color: blue),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
              decoration: const BoxDecoration(
                color: semiBlue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Row(
                children: [
                  tableHeader("Year", width: 80, align: TextAlign.left),
                  tableHeader("Opening Balance", width: 140),
                  tableHeader("Outflow", width: 120),
                  tableHeader("Fresh Inflow", width: 140),
                  tableHeader("Expected Profit", width: 140),
                  tableHeader("Closing Balance", width: 140),
                  tableHeader("Present Value", width: 140),
                ],
              ),
            ),

            Column(
              children: List.generate(balanceSheetCount, (index) {
                final data = listBalanceSheetData[index];
                final isLast = index == balanceSheetCount - 1;

                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                  decoration: BoxDecoration(
                    color: index % 2 == 0 ? white : semiBlue,
                    borderRadius: isLast
                        ? const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    )
                        : BorderRadius.zero,
                  ),
                  child: Row(
                    children: [
                      tableCell("${data.year}", isAmount: false, width: 80, align: TextAlign.left, isBold: true),
                      tableCell("${data.openingBalance}", width: 140),
                      tableCell("${data.outflow}", width: 120),
                      tableCell("${data.freshInflow}", width: 140),
                      tableCell("${data.expectedProfit}", width: 140),
                      tableCell("${data.closingBalance}", width: 140),
                      tableCell("${data.presentValue}", width: 140),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget tableHeader(String text, {double width = 120, TextAlign align = TextAlign.center}) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        textAlign: align,
        style: const TextStyle(
          color: blue,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget tableCell(String value, {double width = 120, TextAlign align = TextAlign.center, bool isBold = false, bool isAmount = true}) {
    return SizedBox(
      width: width,
      child: Text(
        isAmount ? convertCommaSeparatedAmount(value) : value,
        textAlign: align,
        style: TextStyle(
          color: black,
          fontSize: 14,
          fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
        ),
      ),
    );
  }

/*  Widget balanceSheetDataWidget(){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Container(
        width: 758,
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: blue), left: BorderSide(color: blue), right: BorderSide(color: blue)),
            borderRadius: BorderRadius.circular(14)
        ),
        child: Column(
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  rowCellTitle("Year", white, alignment: Alignment.centerLeft, isPadding: true, width: 60),
                  showLineDivider(),
                  rowCellTitle("Opening Balance", white, width: 120),
                  showLineDivider(),
                  rowCellTitle("Outflow", white, width: 100),
                  showLineDivider(),
                  rowCellTitle("Fresh Inflow", white, width: 110),
                  showLineDivider(),
                  rowCellTitle("Expected Profit", white, width: 120),
                  showLineDivider(),
                  rowCellTitle("Closing Balance", white, width: 120),
                  showLineDivider(),
                  rowCellTitle("Present Value", white, width: 120),
                ],
              ),
            ),
            ListView.builder(
              itemCount: balanceSheetCount,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              itemBuilder: (context, index) {
                final balanceData = listBalanceSheetData[index];
                final bool isLastItem = index == balanceSheetCount - 1;
                return IntrinsicHeight(
                  child: Row(
                    children: [
                      rowCell(index, "${balanceData.year}", alignment: Alignment.centerLeft, isPadding: true, width: 60, isLastIndexLeft: isLastItem),
                      showLineDivider(),
                      rowCell(index, convertCommaSeparatedAmount("${balanceData.openingBalance}") , width: 120),
                      showLineDivider(),
                      rowCell(index, convertCommaSeparatedAmount("${balanceData.outflow}") , width: 100),
                      showLineDivider(),
                      rowCell(index, convertCommaSeparatedAmount("${balanceData.freshInflow}") , width: 110),
                      showLineDivider(),
                      rowCell(index, convertCommaSeparatedAmount("${balanceData.expectedProfit}") , width: 120),
                      showLineDivider(),
                      rowCell(index, convertCommaSeparatedAmount("${balanceData.closingBalance}") , width: 120),
                      showLineDivider(),
                      rowCell(index, convertCommaSeparatedAmount("${balanceData.presentValue}") , width: 120, isLastIndexRight: isLastItem),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }*/

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
          "view_more": "1"
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
            balanceSheetCount = listBalanceSheetData.length > 25 ? 25 : listBalanceSheetData.length;

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
