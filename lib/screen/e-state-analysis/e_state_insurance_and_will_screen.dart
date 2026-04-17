import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/model/CommanResponse.dart';
import 'package:superapp_flutter/utils/app_utils.dart';
import 'package:superapp_flutter/utils/base_class.dart';

import '../../common_widget/common_widget.dart';
import '../../constant/analysis_api_end_point.dart';
import '../../constant/colors.dart';
import '../../model/e-state-analysis/InsuranceAndWillResponseModel.dart';

class EStateInsuranceAndWillScreen extends StatefulWidget {
  const EStateInsuranceAndWillScreen({super.key});

  @override
  BaseState<EStateInsuranceAndWillScreen> createState() => _EStateInsuranceAndWillScreenState();
}

class _EStateInsuranceAndWillScreenState extends BaseState<EStateInsuranceAndWillScreen> {

  bool isLoading = false;

  TextEditingController lifeInsuredController = TextEditingController();
  TextEditingController medicalInsuredController = TextEditingController();

  int hasWill = 0;

  InsuranceAndWillData insuranceAndWillData = InsuranceAndWillData();

  @override
  void initState() {
    fetchInsuranceData();
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
        title: getTitle("Insurance & Will Details",),
        centerTitle: true,
        elevation: 0,
        backgroundColor: white,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Life Insurance Sum Insured",
                style: getMediumTextStyle(fontSize: 12, color: blackLight),
              ),
              const Gap(10),
              TextField(
                cursorColor: black,
                controller: lifeInsuredController,
                style: getMediumTextStyle(fontSize: 14, color: black),
                decoration: InputDecoration(
                  hintText: "Enter Amount"
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              Visibility(
                visible: (insuranceAndWillData.lifeInsuranceSumInsured?.isNotEmpty ?? false),
                child: Container(
                  margin: const EdgeInsets.only(top: 4),
                  child: Text(
                    "${convertCommaSeparatedAmountWithoutSymbol(insuranceAndWillData.lifeInsuranceSumInsured ?? "")}",
                    style: getMediumTextStyle(fontSize: 14, color: black),
                  ),
                ),
              ),
              const Gap(20),
              Text(
                "Medical Insurance Covered Amount",
                style: getMediumTextStyle(fontSize: 12, color: blackLight),
              ),
              const Gap(10),
              TextField(
                cursorColor: black,
                controller: medicalInsuredController,
                style: getMediumTextStyle(fontSize: 14, color: black),
                decoration: InputDecoration(
                    hintText: "Enter Amount"
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              Visibility(
                visible: (insuranceAndWillData.medicalInsuranceCoveredAmount?.isNotEmpty ?? false),
                child: Container(
                  margin: const EdgeInsets.only(top: 4),
                  child: Text(
                    "${convertCommaSeparatedAmountWithoutSymbol(insuranceAndWillData.medicalInsuranceCoveredAmount ?? "")}",
                    style: getMediumTextStyle(fontSize: 14, color: black),
                  ),
                ),
              ),
              const Gap(20),
              Text(
                "Do you have a Will? *",
                style: getMediumTextStyle(fontSize: 12, color: blackLight),
              ),
              const Gap(10),
              Row(
                children: [
                  GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        setState(() {
                          hasWill = 1;
                        });
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            hasWill == 1 ? "assets/images/ic_radio_selected.png" : "assets/images/ic_radio_unselected.png",
                            height: 20,
                            width: 20,
                            color: blue,
                          ),
                          const Gap(10),
                          Text("Yes", style: getMediumTextStyle(fontSize: 14, color: black),),
                        ],
                      )
                  ),
                  const Gap(20),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      setState(() {
                        hasWill = 0;
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          hasWill == 0 ?  "assets/images/ic_radio_selected.png" : "assets/images/ic_radio_unselected.png",
                          height: 20,
                          width: 20,
                          color: blue,
                        ),
                        const Gap(10),
                        Text("No", style: getMediumTextStyle(fontSize: 14, color: black),),
                      ],
                    )
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 30, bottom: 10),
                width: MediaQuery.of(context).size.width,
                child: getCommonButton(
                  "Save",
                  isLoading,
                  () {
                    if(isOnline)
                    {
                      saveInsuranceAndWill();
                    }
                    else
                    {
                      noInterNet(context);
                    }
                  },

                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  saveInsuranceAndWill() async{
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

        final url = Uri.parse(API_URL_ANALYSIS + saveInsuranceAndWillUrl);

        Map<String, String> jsonBody = {
          "user_id": sessionManager.getUserId(),
          "id": insuranceAndWillData.id ?? "",
          "life_insurance_sum_insured": lifeInsuredController.text,
          "medical_insurance_covered_amount": medicalInsuredController.text,
          "has_will": "$hasWill"
        };

        final response = await http.post(url, body: jsonBody);
        final statusCode = response.statusCode;
        final body = response.body;
        Map<String, dynamic> user = jsonDecode(body);
        var dataResponse = CommanResponse.fromJson(user);

        if(statusCode == 200 && dataResponse.success == 1)
        {
          showToast(dataResponse.message);
          fetchInsuranceData();
        }
        else
        {
          showToast(dataResponse.message);
        }
      }
      catch(e)
      {
        print("Failed to fetch insurance data : $e");
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

  fetchInsuranceData() async{
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

        final url = Uri.parse(API_URL_ANALYSIS + insuranceAndWillUrl);

        Map<String, String> jsonBody = {
          "user_id": sessionManager.getUserId(),
        };

        final response = await http.post(url, body: jsonBody);
        final statusCode = response.statusCode;
        final body = response.body;
        Map<String, dynamic> user = jsonDecode(body);
        var dataResponse = InsuranceAndWillResponseModel.fromJson(user);

        if(statusCode == 200 && dataResponse.success == 1)
        {
          insuranceAndWillData = dataResponse.insuranceAndWillData ?? InsuranceAndWillData();
          lifeInsuredController.text = insuranceAndWillData.lifeInsuranceSumInsured ?? "";
          medicalInsuredController.text = insuranceAndWillData.medicalInsuranceCoveredAmount ?? "";
          hasWill = int.tryParse("${insuranceAndWillData.hasWill}") ?? 0;
          setState(() {});
        }

      }
      catch(e)
      {
        print("Failed to fetch insurance data : $e");
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
    widget as EStateInsuranceAndWillScreen;
  }

}
