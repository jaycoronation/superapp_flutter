import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/utils/base_class.dart';

import '../../common_widget/common_widget.dart';
import '../../constant/colors.dart';
import '../../constant/consolidate-portfolio/api_end_point.dart';
import '../../model/CommonModel.dart';
import '../../model/consolidated-portfolio/SipAndStpTransactionDataResponseModel.dart';
import '../../utils/app_utils.dart';
import '../../widget/loading.dart';

class CpSipAndStpScreen extends StatefulWidget {
  const CpSipAndStpScreen({super.key});

  @override
  BaseState<CpSipAndStpScreen> createState() => _CpSipAndStpScreenState();
}

class _CpSipAndStpScreenState extends BaseState<CpSipAndStpScreen> {

  bool isLoading = false;

  List<MonthlyTransaction> sipProcessed = [];
  List<MonthlyTransaction> stpProcessed = [];
  List<MonthlyTransaction> swpProcessed = [];

  List<String> lastFourMonths = [];

  @override
  void initState() {
    generateDynamicHeaders();
    fetchLast30DaysTransaction();
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
        title: getTitle("SIP & STP",),
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
                        Text(
                          "SIP :",
                          style: getSemiBoldTextStyle(fontSize: 14, color: blue),
                        ),
                        const Gap(16),
                        transactionTable(sipProcessed)
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
                          "STP :",
                          style: getSemiBoldTextStyle(fontSize: 14, color: blue),
                        ),
                        const Gap(16),
                        transactionTable(stpProcessed)
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
                          "SWP :",
                          style: getSemiBoldTextStyle(fontSize: 14, color: blue),
                        ),
                        const Gap(16),
                        transactionTable(swpProcessed)
                      ],
                    ),
                  ),
                  const Gap(20),
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
      fetchLast30DaysTransaction();
    }
  }

  Widget transactionTable(List<MonthlyTransaction> listData){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Container(
        width: 992,
        decoration: BoxDecoration(
            border:  listData.isEmpty ?
            Border.all(color: gray) :
            Border(top: BorderSide(color: gray), left: BorderSide(color: gray), right: BorderSide(color: gray)),
            borderRadius: BorderRadius.circular(4)
        ),
        child: Column(
          children: [
            Row(
              children: [
                rowCellTitle("Fund Name", white, alignment: Alignment.centerLeft, isPadding: true, width: 240),
                rowCellTitle("Folio No", white, width: 150),
                ...lastFourMonths.map((m) => rowCellTitle(m, white, width: 150)),
              ],
            ),
            listData.isEmpty ?
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
              itemCount: listData.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              itemBuilder: (context, index) {
                final transactionData = listData[index];

                if (transactionData.isHeader) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(8),
                    color: tableLightBlue,
                    child: Text(
                      transactionData.applicant,
                      style: getBoldTextStyle(fontSize: 14, color: black),
                    ),
                  );
                }

                return Row(
                  children: [
                    rowCell(index, transactionData.schemeName, alignment: Alignment.centerLeft, isPadding: true, width: 240,  maxLine: 2, isBold: transactionData.isTotal == true),
                    rowCell(index, transactionData.folioNo, width: 150, maxLine: 2, isBold: transactionData.isTotal == true),
                    ...lastFourMonths.map((m) {
                      final value = transactionData.monthlyAmounts[m] ?? 0.0;
                      return rowCell(index, convertCommaSeparatedAmount(value.toString()), width: 150, maxLine: 2, isBold: transactionData.isTotal == true);
                    }),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void fetchLast30DaysTransaction() async{
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

        final url = Uri.parse(API_URL_CP + latestTransaction);
        Map<String, String> jsonBody = {
          "type": "last_four_month",
          "user_id": sessionManagerPMS.getUserId().trim(),
        };

        final response = await http.post(url, body: jsonBody);
        final statusCode = response.statusCode;
        final body = response.body;
        Map<String, dynamic> user = jsonDecode(body);
        var dataResponse = SipAndStpTransactionDataResponseModel.fromJson(user);

        if(statusCode == 200 && dataResponse.success == 1)
        {
          generateDynamicHeaders();
          final sipRaw = filterByType(dataResponse.sipStpDetails ?? [], "SIP");
          final stpRaw = filterByType(dataResponse.stpDetails ?? [], "STP");
          final swpRaw = filterByType(dataResponse.swpDetails ?? [], "SWP");

          sipProcessed = processData(sipRaw);
          stpProcessed = processData(stpRaw);
          swpProcessed = processData(swpRaw);

          // sipProcessed = processData(dataResponse.sipStpDetails ?? []);
          // stpProcessed = processData(dataResponse.stpDetails ?? []);
          // swpProcessed = processData(dataResponse.swpDetails ?? []);
        }
        else
        {
          sipProcessed = [];
          stpProcessed = [];
          swpProcessed = [];
          print("Success 0 for last 30 days transaction");
        }
      }
      catch(e)
      {
        print("Failed to fetch last 30 days transaction : $e");
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

  List<TransactionDetails> filterByType(List<TransactionDetails> data, String type) {
    return data.where((item) {
      return (item.type ?? "").toUpperCase() == type;
    }).toList();
  }

  void generateDynamicHeaders() {
    final now = DateTime.now();
    final List<String> result = [];

    for (int i = 0; i < 4; i++) {
      final d = DateTime(now.year, now.month - i, 1);

      final monthName = _getMonthShort(d.month);
      final yearShort = d.year.toString().substring(2);

      result.add('$monthName $yearShort');
    }

    lastFourMonths = result.reversed.toList();
  }

  String _getMonthShort(int month) {
    const months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return months[month - 1];
  }

  List<MonthlyTransaction> processData(List<TransactionDetails> data) {
    final Map<String, Map<String, MonthlyTransaction>> grouped = {};

    for (var item in data) {
      DateTime? date;
      try
      {
        date = DateFormat("dd MMM yyyy").parse(item.tranDate ?? "");
      }
      catch (e)
      {
        continue;
      }

      final applicant = (item.applicant ?? "").trim();
      final key = '${item.schemeName}-${item.folioNo}';

      final month = _getMonthShort(date.month);
      final year = date.year.toString().substring(2);
      final monthKey = '$month $year';

      grouped.putIfAbsent(applicant, () => {});

      if (!grouped[applicant]!.containsKey(key))
      {
        grouped[applicant]![key] = MonthlyTransaction(
          schemeName: item.schemeName ?? '',
          folioNo: item.folioNo ?? '',
          applicant: applicant,
          monthlyAmounts: {
            for (var m in lastFourMonths) m: 0.0
          },
        );
      }

      final model = grouped[applicant]![key]!;

      if (model.monthlyAmounts.containsKey(monthKey))
      {
        final amount = (item.amount ?? 0).toDouble();
        model.monthlyAmounts[monthKey] = (model.monthlyAmounts[monthKey] ?? 0) + amount;
      }
    }

    /// 🔥 FINAL LIST WITH HEADER + TOTAL
    final List<MonthlyTransaction> finalList = [];

    for (var applicant in grouped.keys)
    {
      /// HEADER ROW
      finalList.add(MonthlyTransaction(
        schemeName: applicant,
        folioNo: "",
        applicant: applicant,
        monthlyAmounts: {},
        isHeader: true,
      ));

      final rows = grouped[applicant]!.values.toList();
      finalList.addAll(rows);

      /// CALCULATE TOTAL
      final total = {
        for (var m in lastFourMonths) m: 0.0
      };

      for (var row in rows) {
        for (var m in lastFourMonths) {
          total[m] = total[m]! + (row.monthlyAmounts[m] ?? 0);
        }
      }

      /// TOTAL ROW
      finalList.add(MonthlyTransaction(
        schemeName: "Total for $applicant",
        folioNo: "",
        applicant: applicant,
        monthlyAmounts: total,
        isTotal: true,
      ));
    }
    return finalList;
  }

  @override
  void castStatefulWidget() {
    widget as CpSipAndStpScreen;
  }
}
