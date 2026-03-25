import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/utils/base_class.dart';

import '../../common_widget/common_widget.dart';
import '../../constant/colors.dart';
import '../../constant/consolidate-portfolio/api_end_point.dart';
import '../../model/consolidated-portfolio/XIRRCommonResponseModel.dart';
import '../../utils/app_utils.dart';
import '../../widget/loading.dart';

class CpPerformanceScreen extends StatefulWidget {
  const CpPerformanceScreen({super.key});

  @override
  BaseState<CpPerformanceScreen> createState() => _CpPerformanceScreenState();
}

class _CpPerformanceScreenState extends BaseState<CpPerformanceScreen> {

  bool isLoading = false;

  List<Xirr> listSinceInceptionNew = [];
  List<Xirr> listCurrentYearXIRRNew = [];
  List<Xirr> listPreviousYearXIRRNew = [];

  String asPerDate = "";

  @override
  void initState() {
    fetchPerformanceData();
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
        title: getTitle("Performance",),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Performance - Since Inception:",
                        style: getSemiBoldTextStyle(fontSize: 14, color: blue),
                      ),
                      const Gap(16),
                      performanceWidget(1),
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
                        "Performance ${getCurrentFinancialYear()}:",
                        style: getSemiBoldTextStyle(fontSize: 14, color: blue),
                      ),
                      const Gap(16),
                      performanceWidget(2),
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
                        "Performance ${getPreviousFinancialYear()}:",
                        style: getSemiBoldTextStyle(fontSize: 14, color: blue),
                      ),
                      const Gap(16),
                      performanceWidget(3),
                      const Gap(10),
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

  Widget performanceWidget(int isFor){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Container(
        width: 676,
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: blue), left: BorderSide(color: blue), right: BorderSide(color: blue)),
            borderRadius: BorderRadius.circular(14)
        ),
        child: Column(
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  rowCellTitle("Assets", white, alignment: Alignment.centerLeft, isPadding: true, width: 130),
                  showLineDivider(),
                  rowCellTitle("Invested Amount", white, width: 140),
                  showLineDivider(),
                  rowCellTitle("Current Value", white, width: 140),
                  showLineDivider(),
                  rowCellTitle("Gain", white, width: 140),
                  showLineDivider(),
                  rowCellTitle("XIRR", white, width: 120),
                ],
              ),
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
                final bool isLastItem = index == listSinceInceptionNew.length - 1;
                return IntrinsicHeight(
                  child: Row(
                    children: [
                      rowCell(index, "${performanceData.asset}", width: 130, isBold: isTotal, isLastIndexLeft: isLastItem),
                      showLineDivider(),
                      rowCell(index, convertCommaSeparatedAmount("${performanceData.investedAmount}"), width: 140, isBold: isTotal,),
                      showLineDivider(),
                      rowCell(index, convertCommaSeparatedAmount("${performanceData.currentValue}"), width: 140, isBold: isTotal,),
                      showLineDivider(),
                      rowCell(index, convertCommaSeparatedAmount("${performanceData.gain}"), width: 140, isBold: isTotal),
                      showLineDivider(),
                      rowCell(index, "${performanceData.xirr}%", titleColor: getValueColor(gainValue), width: 120, isBold: isTotal, isLastIndexRight: isLastItem),
                    ],
                  ),
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
                final bool isLastItem = index == listCurrentYearXIRRNew.length - 1;
                return IntrinsicHeight(
                  child: Row(
                    children: [
                      rowCell(index, "${performanceData.asset}", alignment: Alignment.centerLeft, isPadding: true, width: 130, isBold: isTotal, isLastIndexLeft: isLastItem),
                      showLineDivider(),
                      rowCell(index, convertCommaSeparatedAmount("${performanceData.investedAmount}") , width: 140, isBold: isTotal),
                      showLineDivider(),
                      rowCell(index, convertCommaSeparatedAmount("${performanceData.currentValue}") , width: 140, isBold: isTotal),
                      showLineDivider(),
                      rowCell(index, convertCommaSeparatedAmount("${performanceData.gain}") , width: 140, isBold: isTotal),
                      showLineDivider(),
                      rowCell(index, "${performanceData.xirr}%", titleColor: getValueColor(gainValue), width: 120, isBold: isTotal, isLastIndexRight: isLastItem),
                    ],
                  ),
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
                final bool isLastItem = index == listPreviousYearXIRRNew.length - 1;
                return IntrinsicHeight(
                  child: Row(
                    children: [
                      rowCell(index, "${performanceData.asset}", alignment: Alignment.centerLeft, isPadding: true, width: 130, isBold: isTotal, isLastIndexLeft: isLastItem),
                      showLineDivider(),
                      rowCell(index, convertCommaSeparatedAmount("${performanceData.investedAmount}") , width: 140, isBold: isTotal),
                      showLineDivider(),
                      rowCell(index, convertCommaSeparatedAmount("${performanceData.currentValue}") , width: 140, isBold: isTotal),
                      showLineDivider(),
                      rowCell(index, convertCommaSeparatedAmount("${performanceData.gain}") , width: 140, isBold: isTotal),
                      showLineDivider(),
                      rowCell(index, "${performanceData.xirr}%", titleColor: getValueColor(gainValue), width: 120, isBold: isTotal, isLastIndexRight: isLastItem),
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

  void fetchPerformanceData() async {
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
          listCurrentYearXIRRNew = dataResponse.xirr ?? [];
          listPreviousYearXIRRNew = dataResponse.xirrPrevious ?? [];
          asPerDate = universalDateConverter("dd-MM-yyyy", 'dd MMM,yyyy', dataResponse.reportDate ?? '');
        }
        else
        {
          listSinceInceptionNew = [];
          listCurrentYearXIRRNew = [];
          listPreviousYearXIRRNew = [];
        }
      }
      catch(e)
      {
        print("Failed to fetch performance data :$e");
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
    widget as CpPerformanceScreen;
  }

}
