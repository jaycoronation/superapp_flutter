import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/model/e-state-analysis/RmFpUserListResponseModel.dart';
import 'package:superapp_flutter/utils/app_utils.dart';
import 'package:superapp_flutter/utils/base_class.dart';

import '../../common_widget/common_widget.dart';
import '../../constant/analysis_api_end_point.dart';
import '../../constant/colors.dart';
import '../../model/CommanResponse.dart';
import '../../model/e-state-analysis/RMFpUserLeadResponseModel.dart';

class RmFpAddLeadScreen extends StatefulWidget {
  final UserLeadData getSet;
  final bool isFromEdit;
  final RmFpAllEmployees rmDetail;
  const RmFpAddLeadScreen(this.getSet, this.isFromEdit, this.rmDetail, {super.key});

  @override
  BaseState<RmFpAddLeadScreen> createState() => _RmFpAddLeadScreenState();
}

class _RmFpAddLeadScreenState extends BaseState<RmFpAddLeadScreen> {

  bool isLoading = false;
  bool isFromEdit = false;

  UserLeadData getSet = UserLeadData();
  RmFpAllEmployees rmDetail = RmFpAllEmployees();

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController spouseNameController = TextEditingController();
  TextEditingController spouseAgeController = TextEditingController();

  List<ChildModel> listChildData = [ChildModel()];

  @override
  void initState() {
    isFromEdit = (widget as RmFpAddLeadScreen).isFromEdit;
    getSet = (widget as RmFpAddLeadScreen).getSet;
    rmDetail = (widget as RmFpAddLeadScreen).rmDetail;
    if(isFromEdit)
    {
      setData();
    }
    super.initState();
  }

  setData(){
    nameController.text = getSet.name ?? "";
    ageController.text = getSet.age ?? "";
    cityController.text = getSet.city ?? "";
    spouseNameController.text = getSet.spouseName ?? "";
    spouseAgeController.text = getSet.spouseAge ?? "";

    if(getSet.childDetails != "")
    {
      List<dynamic> decodedList = jsonDecode(getSet.childDetails ?? "");
      listChildData.clear();
      for (var item in decodedList) {
        listChildData.add(
          ChildModel(
            childName: item["name"] ?? "",
            childAge: item["age"] ?? "",
          ),
        );
      }
    }
    setState(() {});
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
          child:  getBackArrow(),
        ),
        title: getTitle("Add Financial Lead",),
        centerTitle: true,
        elevation: 2,
        backgroundColor: white,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      cursorColor: black,
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      style: getMediumTextStyle(fontSize: 14, color: black),
                      decoration: const InputDecoration(
                        labelText: 'Name*',
                      ),
                    ),
                    const Gap(20),
                    TextField(
                      cursorColor: black,
                      controller: ageController,
                      keyboardType: TextInputType.number,
                      style: getMediumTextStyle(fontSize: 14, color: black),
                      inputFormatters: [ FilteringTextInputFormatter.digitsOnly ],
                      decoration: const InputDecoration(
                        labelText: 'Age',
                      ),
                    ),
                    const Gap(20),
                    TextField(
                      cursorColor: black,
                      controller: cityController,
                      keyboardType: TextInputType.text,
                      style: getMediumTextStyle(fontSize: 14, color: black),
                      decoration: const InputDecoration(
                        labelText: 'City',
                      ),
                    ),
                    const Gap(20),
                    TextField(
                      cursorColor: black,
                      controller: spouseNameController,
                      keyboardType: TextInputType.text,
                      style: getMediumTextStyle(fontSize: 14, color: black),
                      decoration: const InputDecoration(
                        labelText: 'Spouse Name',
                      ),
                    ),
                    const Gap(20),
                    TextField(
                      cursorColor: black,
                      controller: spouseAgeController,
                      keyboardType: TextInputType.number,
                      style: getMediumTextStyle(fontSize: 14, color: black),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        labelText: 'Spouse Age',
                      ),
                    ),
                    const Gap(20),

                    ListView.builder(
                      itemCount: listChildData.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(0),
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: bgFpLead,
                            border: Border.all(color: gray),
                            borderRadius: BorderRadius.circular(8)
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Child ${index+1} Details",
                                      style: getMediumTextStyle(fontSize: 14, color: black),
                                    ),
                                  ),
                                  const Gap(2),
                                  Visibility(
                                    visible: listChildData.length > 1,
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        setState(() {
                                          listChildData[index].dispose();
                                          listChildData.removeAt(index);
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.only(left: 14, right: 14, top: 8, bottom: 8),
                                        decoration: BoxDecoration(
                                          color: redLight,
                                          borderRadius: BorderRadius.circular(6)
                                        ),
                                        child: Text("Remove", style: getMediumTextStyle(fontSize: 12, color: white),),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const Gap(10),
                              TextField(
                                cursorColor: black,
                                controller: listChildData[index].childNameController,
                                keyboardType: TextInputType.text,
                                style: getMediumTextStyle(fontSize: 14, color: black),
                                decoration: const InputDecoration(
                                  labelText: 'Enter name',
                                ),
                              ),
                              const Gap(20),
                              TextField(
                                cursorColor: black,
                                controller: listChildData[index].childAgeController,
                                keyboardType: TextInputType.number,
                                style: getMediumTextStyle(fontSize: 14, color: black),
                                inputFormatters: [ FilteringTextInputFormatter.digitsOnly ],
                                decoration: const InputDecoration(
                                  labelText: 'Enter age',
                                ),
                              ),
                            ],
                          )
                        );
                      },
                    ),

                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        setState(() {
                          listChildData.add(ChildModel());
                        });
                      },
                      child: Container(
                       margin: const EdgeInsets.only(top: 10),
                       decoration: BoxDecoration(
                         color: bgFpLead,
                         border: Border.all(color: blue),
                         borderRadius: BorderRadius.circular(8)
                       ),
                       padding: const EdgeInsets.all(10),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Icon(Icons.add, size: 20, color: blue,),
                           const Gap(6),
                           Text(
                             "Add Another Child",
                             style: getMediumTextStyle(fontSize: 14, color: blue),
                           )
                         ],
                       ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Gap(10),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: getCommonButton(
                "Submit",
                isLoading,
                () {
                  if(nameController.text.isEmpty)
                  {
                    showToast("Please enter name");
                  }
                  else
                  {
                    addFpLead();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  String getChildJson() {
    List<Map<String, dynamic>> data = listChildData.map((child) {
      return {
        "name": child.childNameController.text,
        "age": child.childAgeController.text,
      };
    }).toList();

    return jsonEncode(data);
  }

  addFpLead() async{
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

        final url = Uri.parse(API_URL_ANALYSIS + addFPUserLead);
        Map<String, String> jsonBody = {
          "first_name": nameController.text,
          "age": ageController.text,
          "city": cityController.text,
          "spouse_name": spouseNameController.text,
          "spouse_age": spouseAgeController.text,
          "child_details": getChildJson(),
          "portfolio_rm_id": rmDetail.id ?? "",
          "portfolio_rm_name": rmDetail.name ?? "",
          "user_id": isFromEdit ? (getSet.userId ?? ""): "",
        };
        final response = await http.post(url, body: jsonBody);
        final statusCode = response.statusCode;
        final body = response.body;
        Map<String, dynamic> user = jsonDecode(body);
        var dataResponse = CommanResponse.fromJson(user);

        if(statusCode == 200 && dataResponse.success == 1)
        {
          showToast(dataResponse.message);
          Navigator.pop(context, "success");
        }
        else
        {
          showToast(dataResponse.message);
        }
      }
      catch(e)
      {
        print("Failed to add lead : $e");
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
    widget as RmFpAddLeadScreen;
  }
}

class ChildModel{
  TextEditingController childNameController = TextEditingController();
  TextEditingController childAgeController = TextEditingController();

  ChildModel({String childName = "", String childAge = ""}){
    childNameController.text = childName;
    childAgeController.text = childAge;
  }

  void dispose() {
    childNameController.dispose();
    childAgeController.dispose();
  }
}
