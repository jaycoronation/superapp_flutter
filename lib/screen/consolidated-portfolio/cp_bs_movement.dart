import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/common_widget/common_widget.dart';
import 'package:superapp_flutter/utils/app_utils.dart';
import '../../constant/colors.dart';
import '../../constant/consolidate-portfolio/api_end_point.dart';
import '../../model/consolidated-portfolio/BSMovementResponse.dart';
import '../../utils/base_class.dart';
import '../../widget/loading.dart';
import '../../widget/no_data.dart';

class CPBsMovementPage extends StatefulWidget {
  const CPBsMovementPage({Key? key}) : super(key: key);

  @override
  BaseState<CPBsMovementPage> createState() =>
      CPBsMovementPageState();
}

class CPBsMovementPageState extends BaseState<CPBsMovementPage> {
  bool _isLoading = false;
  bool _isShowChart = false;
  List<SheetData> listSheetData =
      List<SheetData>.empty(growable: true);
  List<GraphData> listGraphData =
  List<GraphData>.empty(growable: true);

  List<FlSpot> spotsData = List<FlSpot>.empty(growable: true);
  List<Color> gradientColors = [
    blue,
    divider_color,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 60,
          automaticallyImplyLeading: false,
          backgroundColor: appBg,
          elevation: 0,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              if(_isShowChart){
                SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
              }
              Navigator.pop(context);
            },
            child: getBackArrow(),
          ),

          title: getTitle('BS Movement'),
        actions: [
          InkWell(
            onTap: (){
              setState(() {
                _isShowChart = !_isShowChart;
              });

              if(_isShowChart){
                print("IS IN IF");
                SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
              }
              else{
                SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
              }
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _isShowChart ? "Table" : "Graph",
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontSize: 18, color: blue, fontWeight: FontWeight.w600),
              ),
            ),
          )
        ],
      ),
      backgroundColor: white,
      body: _isLoading
          ? const LoadingWidget()
          : Container(
              margin: const EdgeInsets.only(top: 8,bottom: 50),
            child: _isShowChart
                ? Container( margin: const EdgeInsets.only(top: 32, right: 38),height: kIsWeb ? 800 : 300 , child: LineChart(generatedLineChart()))
                : Column(
                children: [
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(left: 6, right: 6),
                          child: Stack(
                            children: [
                              listSheetData.isNotEmpty
                                  ? Column(children: [
                                      Container(
                                        padding: const EdgeInsets.only(left: 8,right: 8,top: 14,bottom: 14),
                                        decoration: const BoxDecoration(
                                            color:semiBlue,
                                            borderRadius: BorderRadius.only(topLeft:Radius.circular(8),topRight: Radius.circular(8))),
                                        child: const Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: Text('Month/Date',
                                                    style: TextStyle(
                                                        color: blue,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600))),
                                            Expanded(
                                                flex: 1,
                                                child: Text('Total Amount',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: blue,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600))),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: _itemList(),
                                      ),
                                    ])
                                  : const MyNoDataWidget(msg: "No data found."),
                            ],
                          )))
                ],
              ),
          ),
    );
  }

  @override
  final List<DeviceOrientation> supportedOrientations = [
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
    // Add other supported orientations if needed
  ];

  ListView _itemList() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        primary: false,
        padding: EdgeInsets.zero,
        itemCount: listSheetData.length,
        itemBuilder: (ctx, index) => (Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 8,right: 8,top: 14,bottom: 14),
                    decoration: BoxDecoration(
                        color: index % 2 == 0 ? white : semiBlue,
                        borderRadius: index == listSheetData.length - 1 ? const BorderRadius.only(bottomLeft:Radius.circular(8),bottomRight: Radius.circular(8)) : const BorderRadius.all(Radius.circular(0))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          toDisplayCase(listSheetData[index]
                                              .timestamp
                                              .toString()),
                                          style: const TextStyle(
                                              color: black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700))),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                          convertCommaSeparatedAmount(listSheetData[index].total.toString()),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w200))),
                                ],
                              ),
                      ],
                    ),
                  )
                ],
              ),
            )));
  }

  LineChartData generatedLineChart() {
    final lineBarsData = [
      LineChartBarData(
        spots: spotsData,
        isCurved: true,
        barWidth: 4,
        shadow: const Shadow(
          blurRadius: 8,
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors: [
              blue.withOpacity(0.4),
              divider_color.withOpacity(0.4),
            ],
          ),
        ),
        dotData: FlDotData(show: false),
        gradient: const LinearGradient(
          colors: [
            blue,
            divider_color,
          ],
        ),
      ),
    ];

    return LineChartData(
      backgroundColor: white,
      lineBarsData: lineBarsData,
      lineTouchData: LineTouchData(
        enabled: true,
        getTouchedSpotIndicator:
            (LineChartBarData barData, List<int> spotIndexes) {
          return spotIndexes.map((index) {
            return TouchedSpotIndicatorData(
              FlLine(
                color: blue,
              ),
              FlDotData(
                show: true,
              ),
            );
          }).toList();
        },
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: blue,
          tooltipRoundedRadius: 8,
          getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
            return lineBarsSpot.map((lineBarSpot) {
              return LineTooltipItem(
                convertCommaSeparatedAmount(lineBarSpot.y.toString()),
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            }).toList();
          },
        ),
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: (double value, TitleMeta meta) {
              return SideTitleWidget(
                axisSide: meta.axisSide,
                child: Text(listGraphData[value.toInt()].timestamp.toString()),
              );
            },
            interval: 2,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(
          color: blue,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getSchemeAllocationData();
  }

  _getSchemeAllocationData() async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_CP + bsMovement);
    Map<String, String> jsonBody = {
      'user_id': sessionManagerPMS.getUserId().trim(),
      'range_time': "monthly"
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = BsMovementResponse.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      try {
        if (dataResponse.sheetData != null) {
          listSheetData = dataResponse.sheetData!.reversed.toList();
        }

        if(dataResponse.graphData != null){
          listGraphData = dataResponse.graphData!.reversed.toList();

          for(int i = 0;i<listGraphData.length;i++){
            spotsData.add(FlSpot(i.toDouble(), double.parse(listGraphData[i].total!.toString())));
          }
        }

        setState(() {
          _isLoading = false;
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

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void castStatefulWidget() {
    widget is CPBsMovementPage;
  }
}
