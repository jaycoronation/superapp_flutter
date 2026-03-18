import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/model/CommanResponse.dart';
import 'package:superapp_flutter/model/insurance/InsuranceListResponseModel.dart';
import 'package:superapp_flutter/screen/insurance_data/add_insurance_screen.dart';
import 'package:superapp_flutter/utils/base_class.dart';
import 'package:superapp_flutter/widget/no_data.dart';

import '../../common_widget/common_widget.dart';
import '../../constant/colors.dart';
import '../../constant/consolidate-portfolio/api_end_point.dart';
import '../../utils/app_utils.dart';
import '../../widget/loading.dart';

class InsuranceListScreen extends StatefulWidget {
  const InsuranceListScreen({super.key});

  @override
  BaseState<InsuranceListScreen> createState() => _InsuranceListScreenState();
}

class _InsuranceListScreenState extends BaseState<InsuranceListScreen> {

  bool isLoading = false;

  double totalSumAssured = 0;
  double totalPremiumAmount = 0;

  List<Insurances> listInsurance = [];

  @override
  void initState() {
    fetchInsuranceList();
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
        title: getTitle("My Insurances"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: white,
      ),
      body: SafeArea(
        child: isLoading ?
        Center(
          child: LoadingWidget(),
        ):
        listInsurance.isEmpty ? 
            Center(
              child: MyNoDataWidget(msg: "No Data Found"),
            ) :
        SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: insuranceListWidget()
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _redirectToAddUpdate(Insurances(), false);
        },
        backgroundColor: blue,
        child: const Icon(Icons.add, color: white,),
      ),
    );
  }

  _redirectToAddUpdate(Insurances getSet, bool isEdit) async{
    var value = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddInsuranceScreen(getSet, isEdit)));
    if (value == "success")
    {
      fetchInsuranceList();
    }
  }

  insuranceListWidget(){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Container(
        width: 1582,
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: gray), left: BorderSide(color: gray), right: BorderSide(color: gray)),
            borderRadius: BorderRadius.circular(4)
        ),
        child: Column(
          children: [
            Row(
              children: [
                rowCellTitle("SR.", white, alignment: Alignment.centerLeft, isPadding: true, width: 80),
                rowCellTitle("Company Name", white, alignment: Alignment.centerLeft, isPadding: true, width: 150),
                rowCellTitle("Type", white, width: 150),
                rowCellTitle("Policy Number", white, width: 120),
                rowCellTitle("Sum Assured", white, width: 120),
                rowCellTitle("Person Covered", white, width: 120),
                rowCellTitle("Start Date", white, width: 120),
                rowCellTitle("End Date", white, width: 120),
                rowCellTitle("Maturity Date", white, width: 120),
                rowCellTitle("Last Payment \nDate", white, width: 120,),
                rowCellTitle("Next Payment \nDate", white, width: 120),
                rowCellTitle("Premium Amount", white, width: 120),
                rowCellTitle("Action", white, width: 120),
              ],
            ),
            ListView.builder(
              itemCount: listInsurance.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              itemBuilder: (context, index) {
                final insuranceData = listInsurance[index];
                return Row(
                  children: [
                    rowCell(index, "${index+1}", alignment: Alignment.centerLeft, isPadding: true, width: 80),
                    rowCell(index, insuranceData.insuranceCompany ?? "", alignment: Alignment.centerLeft, isPadding: true, width: 150),
                    rowCell(index, insuranceData.type == "1" ? "Life Term Insurance" : "Medical Insurance", width: 150),
                    rowCell(index, insuranceData.policyNumber ?? "", width: 120),
                    rowCell(index, convertCommaSeparatedAmount(insuranceData.sumAssured ?? ""), width: 120),
                    rowCell(index, insuranceData.personCovered ?? "", width: 120),
                    rowCell(index, (insuranceData.startDate != null && insuranceData.startDate != "") ? universalDateConverter("dd-MM-yyyy", "dd MMM, yyyy", insuranceData.startDate ?? "") : "-", width: 120),
                    rowCell(index, (insuranceData.endDate != null && insuranceData.endDate != "") ? universalDateConverter("dd-MM-yyyy", "dd MMM, yyyy", insuranceData.endDate ?? "") : "-", width: 120),
                    rowCell(index, (insuranceData.maturityDate != null && insuranceData.maturityDate != "") ? universalDateConverter("dd MMM yyyy", "dd MMM, yyyy", getDateFromTimeStampNew(int.tryParse("${insuranceData.maturityDate}") ?? 0)) : "-", width: 120),
                    rowCell(index, (insuranceData.lastPaymentDate != null && insuranceData.lastPaymentDate != "") ?universalDateConverter("dd MMM yyyy", "dd MMM, yyyy", getDateFromTimeStampNew(int.tryParse("${insuranceData.lastPaymentDate}") ?? 0)) : "-", width: 120),
                    rowCell(index, (insuranceData.nextDueDate != null && insuranceData.nextDueDate != "") ?universalDateConverter("dd MMM yyyy", "dd MMM, yyyy", getDateFromTimeStampNew(int.tryParse("${insuranceData.nextDueDate}") ?? 0)) : "-", width: 120),
                    rowCell(index, convertCommaSeparatedAmount(insuranceData.premiumAmount ?? ""), width: 120),
                    Container(
                      width: 120,
                      height: 40 ,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: index % 2 == 0 ? listBg : white,
                        border: Border(
                          bottom: BorderSide(color: grayLight),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              _redirectToAddUpdate(insuranceData, true);
                            },
                            child: Image.asset(
                              "assets/images/fin_plan_ic_edit_gray.png",
                              height: 20,
                              width: 20,
                              color: green,
                            ),
                          ),
                          const Gap(10),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              openDialogDelete(insuranceData, index);
                            },
                            child: Image.asset(
                              "assets/images/fin_plan_ic_delete_black.png",
                              height: 24,
                              width: 24,
                              color: redLight,
                            ),
                          ),
                        ],
                      )
                    )
                  ],
                );
              },
            ),
            Row(
              children: [
                rowCell(listInsurance.length, "Total", alignment: Alignment.centerLeft, isPadding: true, width: 80, isBold: true),
                rowCell(listInsurance.length, "", width: 150),
                rowCell(listInsurance.length, "", width: 150),
                rowCell(listInsurance.length, "", width: 120),
                rowCell(listInsurance.length, convertCommaSeparatedAmount("$totalSumAssured"), width: 120, isBold: true),
                rowCell(listInsurance.length, "", width: 120),
                rowCell(listInsurance.length, "", width: 120),
                rowCell(listInsurance.length, "", width: 120),
                rowCell(listInsurance.length, "", width: 120),
                rowCell(listInsurance.length, "", width: 120),
                rowCell(listInsurance.length, "", width: 120),
                rowCell(listInsurance.length, convertCommaSeparatedAmount("$totalPremiumAmount"), width: 120, isBold: true),
                rowCell(listInsurance.length, "", width: 120),
              ],
            )
          ],
        ),
      ),
    );
  }

  openDialogDelete(Insurances getSet, int index){
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      builder: (BuildContext context) {
        bool isDeleteLoading = false;

        return SafeArea(
          child: StatefulBuilder(
            builder: (context, setStateSheet) {
              return Wrap(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)), color: white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        getBottomSheetHeaderWithoutButton(context, "Delete?"),
                        Text(
                          "Are you sure want to delete?",
                          style: getMediumTextStyle(fontSize: 16),
                        ),
                        const Gap(20),
                        Row(
                          children: [
                            Expanded(
                              child: getCommonButton(
                                "Cancel",
                                false,
                                () {
                                  Navigator.pop(context);
                                }
                              ),
                            ),
                            const Gap(20),
                            Expanded(
                              child: getCommonButton(
                                  "Yes",
                                  isDeleteLoading,
                                  () async{
                                    setStateSheet(() {
                                      isDeleteLoading = true;
                                    });
                                    await deleteInsurance("${getSet.insuranceId}", index);
                                    Navigator.pop(context);
                                  },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  deleteInsurance(String insuranceId, int index) async{
    if(isOnline)
    {
      try
      {
        HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
          HttpLogger(logLevel: LogLevel.BODY),
        ]);
        final url = Uri.parse(API_URL_CP + deleteInsuranceApi);
        Map<String, String> jsonBody = {
          "insurance_id" : insuranceId,
        };
        final response = await http.post(url, body: jsonBody);
        final statusCode = response.statusCode;
        final body = response.body;
        Map<String, dynamic> user = jsonDecode(body);
        var dataResponse = CommanResponse.fromJson(user);

        if(statusCode == 200 && dataResponse.success == 1)
        {
          showToast("${dataResponse.message}");
          setState(() {
            listInsurance.removeAt(index);
          });
          for (var item in (listInsurance))
          {
            totalSumAssured += parseAmount(item.sumAssured);
            totalPremiumAmount += parseAmount(item.premiumAmount);
          }
        }
        else
        {
          showToast("${dataResponse.message}");
        }
      }
      catch(e)
      {
        print("Failed to delete insurance : $e");
      }
    }
    else
    {
      noInterNet(context);
    }
  }

  fetchInsuranceList() async{
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
        final url = Uri.parse(API_URL_CP + insuranceListApi);
        Map<String, String> jsonBody = {
          "user_id" : sessionManagerPMS.getUserId(),
        };
        final response = await http.post(url, body: jsonBody);
        final statusCode = response.statusCode;
        final body = response.body;
        Map<String, dynamic> user = jsonDecode(body);
        var dataResponse = InsuranceListResponseModel.fromJson(user);

        if(statusCode == 200 && dataResponse.success == 1)
        {
          listInsurance = dataResponse.insurances ?? [];

          for (var item in (listInsurance))
          {
            totalSumAssured += parseAmount(item.sumAssured);
            totalPremiumAmount += parseAmount(item.premiumAmount);
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
    widget as InsuranceListScreen;
  }
}
