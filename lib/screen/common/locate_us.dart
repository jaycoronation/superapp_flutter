import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/common_widget/common_widget.dart';
import 'package:superapp_flutter/constant/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constant/consolidate-portfolio/api_end_point.dart';
import '../../model/OfficeResponseModel.dart';
import '../../utils/base_class.dart';

class LocateUsPage extends StatefulWidget {
  const LocateUsPage({Key? key}) : super(key: key);

  @override
  BaseState<LocateUsPage> createState() => _LocateUsPageState();
}

class _LocateUsPageState extends BaseState<LocateUsPage> {

  bool isLoading = false;
  List<Address> listAddress = [];

  @override
  void initState(){
    super.initState();
    getOfficesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBg,
      appBar: AppBar(
        toolbarHeight: 55,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.pop(context);
            },
            child: getBackArrow()
        ),
        title: getTitle("Locate Us"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: white,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: listAddress.length,
            itemBuilder: (context, index) {
              var getSet = listAddress[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: grayLight,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(getSet.city ?? '',style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: black),),
                    const Gap(12),
                    Text(getSet.address ?? '',style: const TextStyle(fontSize:14,fontWeight: FontWeight.w500,color: black),),
                    Visibility(
                      visible: getSet.phone?.isNotEmpty ?? false,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {

                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 6),
                          child: Text('Ph: ${getSet.phone}',style: const TextStyle(fontSize:14,fontWeight: FontWeight.w500,color: black),)
                        ),
                      ),
                    ),
                    Visibility(
                      visible: getSet.fax?.isNotEmpty ?? false,
                      child: Container(
                        margin: const EdgeInsets.only(top: 6),
                        child: Text('Fax: ${getSet.fax}',style: const TextStyle(fontSize:14,fontWeight: FontWeight.w500,color: black),)
                      ),
                    ),
                    const Gap(12),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        Uri url = Uri.parse(getSet.mapLink ?? '');

                        if (await canLaunchUrl(url))
                          {
                            launchUrl(url,mode: LaunchMode.externalNonBrowserApplication);
                          }

                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('assets/images/ic_location.png',width: 22,height: 22,),
                          const Gap(8),
                          const Text("View on Map",style: TextStyle(color: black,fontWeight: FontWeight.w500,fontSize: 14),)
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
        ),
      )
    );
  }

  @override
  void castStatefulWidget() {
    widget is LocateUsPage;
  }

  getOfficesList() async {
    setState(() {
      isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse('https://alphacapital.in/about_offices.json');
    Map<String, String> jsonBody = {
      'user_id': sessionManagerPMS.getUserId().trim(),
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = OfficeResponseModel.fromJson(user);

    if (statusCode == 200)
    {
      setState(() {
        listAddress = dataResponse.address ?? [];
        isLoading = false;
      });
    }
  }

}