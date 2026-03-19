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
        child: RefreshIndicator(
          onRefresh: _refresh,
          color: blue,
          child: isLoading ?
          Center(
            child: LoadingWidget(),
          ):
          listInsurance.isEmpty ?
          Center(
            child: MyNoDataWidget(msg: "No Data Found"),
          ) :
          SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      itemCount: listInsurance.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {

                        final listData = listInsurance[index];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      listData.insuranceCompany ?? "",
                                      style: getSemiBoldTextStyle(fontSize: 14, color: blue),
                                    ),
                                  ),
                                  const Gap(10),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () {
                                          _redirectToAddUpdate(listData, true);
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
                                          openDialogDelete(listData, index);
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
                                ],
                              ),
                              const Gap(6),
                              Divider(color: gray,),
                              const Gap(6),
                              titleAndValueWidget("Type", listData.type == "1" ? "Life Term Insurance" : "Medical Insurance"),
                              const Gap(8),
                              Row(
                                children: [
                                  Expanded(
                                    child: titleAndValueWidget("Policy Number", listData.policyNumber ?? ""),
                                  ),
                                  const Gap(8),
                                  Expanded(
                                    child:  titleAndValueWidget("Sum Assured", convertCommaSeparatedAmount(listData.sumAssured ?? "")),
                                  ),
                                ],
                              ),
                              const Gap(8),
                              titleAndValueWidget("Person Covered", listData.personCovered ?? ""),
                              const Gap(8),
                              Row(
                                children: [
                                  Expanded(
                                    child: titleAndValueWidget("Start Date", (listData.startDate != null && listData.startDate != "") ? universalDateConverter("dd-MM-yyyy", "dd MMM, yyyy", listData.startDate ?? "") : "-"),
                                  ),
                                  const Gap(8),
                                  Expanded(
                                    child: titleAndValueWidget("End Date", (listData.endDate != null && listData.endDate != "") ? universalDateConverter("dd-MM-yyyy", "dd MMM, yyyy", listData.endDate ?? "") : "-"),
                                  ),
                                ],
                              ),
                              const Gap(8),
                              Row(
                                children: [
                                  Expanded(
                                    child: titleAndValueWidget("Last Payment Date", (listData.lastPaymentDate != null && listData.lastPaymentDate != "") ? universalDateConverter("dd MMM yyyy", "dd MMM, yyyy", getDateFromTimeStampNew(int.tryParse("${listData.lastPaymentDate}") ?? 0)) : "-"),
                                  ),
                                  const Gap(8),
                                  Expanded(
                                    child: titleAndValueWidget("Next Payment Date", (listData.nextDueDate != null && listData.nextDueDate != "") ? universalDateConverter("dd MMM yyyy", "dd MMM, yyyy", getDateFromTimeStampNew(int.tryParse("${listData.nextDueDate}") ?? 0)) : "-"),
                                  ),
                                ],
                              ),
                              const Gap(8),
                              Row(
                                children: [
                                  Expanded(
                                    child: titleAndValueWidget("Maturity Date", (listData.maturityDate != null && listData.maturityDate != "") ? universalDateConverter("dd MMM yyyy", "dd MMM, yyyy", getDateFromTimeStampNew(int.tryParse("${listData.maturityDate}") ?? 0)) : "-"),
                                  ),
                                  const Gap(8),
                                  Expanded(
                                    child: titleAndValueWidget("Premium Amount", convertCommaSeparatedAmount(listData.premiumAmount ?? "")),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const Gap(10),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total",
                            style: getSemiBoldTextStyle(fontSize: 14, color: blue),
                          ),
                          const Gap(6),
                          Divider(color: gray,),
                          const Gap(6),
                          Row(
                            children: [
                              Expanded(
                                child: titleAndValueWidget("Sum Assured", convertCommaSeparatedAmount("$totalSumAssured")),
                              ),
                              const Gap(8),
                              Expanded(
                                child: titleAndValueWidget("Premium Amount", convertCommaSeparatedAmount("$totalPremiumAmount")),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )
              //child: insuranceListWidget()
            ),
          ),
        )
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

  Future<void> _refresh() async{
    if(isOnline)
    {
      fetchInsuranceList();
    }
  }

  Widget titleAndValueWidget(String title, String value){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: getMediumTextStyle(fontSize: 12, color: graySemiDark),
        ),
        const Gap(4),
        Text(
          value,
          style: getMediumTextStyle(fontSize: 12, color: black),
        )
      ],
    );
  }

  _redirectToAddUpdate(Insurances getSet, bool isEdit) async{
    var value = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddInsuranceScreen(getSet, isEdit)));
    if (value == "success")
    {
      fetchInsuranceList();
    }
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
