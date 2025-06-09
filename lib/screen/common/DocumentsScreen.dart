import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/constant/api_end_point.dart';
import 'package:superapp_flutter/widget/loading.dart';

import '../../common_widget/common_widget.dart';
import '../../constant/colors.dart';
import '../../model/GetDocumentsResponseModel.dart';
import '../../utils/app_utils.dart';
import '../../utils/base_class.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({super.key});

  @override
  BaseState<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends BaseState<DocumentsScreen> {

  bool isLoading = false;
  List<Documents> listDocument = [];

  @override
  void initState() {
    getDocuments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          toolbarHeight: 55,
          leading: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.pop(context);
            },
            child: getBackArrow(),
          ),
          automaticallyImplyLeading: false,
          title: getTitle("Documents",),
          centerTitle: true,
          elevation: 0,
          backgroundColor: white,
        ),
        body: isLoading
            ? LoadingWidget()
            : ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            primary: false,
            padding: EdgeInsets.zero,
            itemCount: listDocument.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(left: 12, right: 12),
                alignment: Alignment.center,
                width: double.infinity,
                color: white,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.only(top: 8, bottom: 8),
                      decoration: const BoxDecoration(color: semiBlue, borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Spacer(),
                              GestureDetector(
                                onTap: (){
                                  openFileFromURL(checkValidString(listDocument[index].link),context);
                                },
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: const BoxDecoration(color: grayLight, borderRadius: BorderRadius.all(Radius.circular(30))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Image.asset('assets/images/vault_ic_download.png', width: 24, height: 24, color: black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  "Document Name",
                                  style: TextStyle(color: black, fontSize: 14, fontWeight: FontWeight.w500),
                                ),
                              ),
                              const Text(
                                " : ",
                                style: TextStyle(color: black, fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left : 8.0),
                                  child: Text(
                                    checkValidString(listDocument[index].title),
                                    maxLines: 3,
                                    style: const TextStyle(color: black, fontSize: 16, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
        )
    );
  }

  getDocuments() async {
    if (isOnline) {

      setState(() {
        isLoading = true;
      });

      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);


      final url = Uri.parse(documentLists);

      Map<String, String> jsonBody = {
        // "user_id": sessionManagerPMS.getUserId(),
        "user_id": "3925",
      };

      final response = await http.post(url, body: jsonBody, headers: {
        "Authorization": authHeader,
      });

      final statusCode = response.statusCode;
      final body = response.body;
      Map<String, dynamic> data = jsonDecode(body);
      var dataResponse = GetDocumentsResponseModel.fromJson(data);


      if (statusCode == 200 && dataResponse.success == 1) {
        if (dataResponse.documents != null) {
          listDocument = dataResponse.documents ?? [];
        }
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      noInterNet(context);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void castStatefulWidget() {
    widget is DocumentsScreen;
  }

}