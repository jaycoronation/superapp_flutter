import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../../common_widget/common_widget.dart';
import '../../constant/api_end_point.dart';
import '../../constant/colors.dart';
import '../../constant/consolidate-portfolio/api_end_point.dart';
import '../../model/consolidated-portfolio/SuggestedActionsResponseModel.dart';
import '../../utils/app_utils.dart';
import '../../utils/base_class.dart';
import '../../widget/loading.dart';


class SuggestedActionsScreen extends StatefulWidget {
  const SuggestedActionsScreen({super.key});

  @override
  BaseState<SuggestedActionsScreen> createState() =>
      _SuggestedActionsScreenState();
}

class _SuggestedActionsScreenState extends BaseState<SuggestedActionsScreen> {

  bool _isLoading = false;
  String suggestedActionsData = "";

  @override
  void initState() {
    getSuggestedActionsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          toolbarHeight: 55,
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: getBackArrow(),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: getTitle("Suggested Actions"),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: white,
        ),
        body: _isLoading
            ? const LoadingWidget()
            : ListView(
          padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
          children: [
            HtmlWidget(
              checkValidString(suggestedActionsData).replaceAll("\r\n\r\n", "").replaceAll("\r\n\t", "").replaceAll("\r\n", ""),
              textStyle: const TextStyle(fontSize: 14,letterSpacing: 0,fontWeight: FontWeight.w400,color: black),
              enableCaching: true,
              customStylesBuilder: (element) {
                if (element.styles.contains('font-size')) {
                  return {
                    'font-size': '10px',
                    'background': "transparent"
                  };
                }
                return null;
              },
            ),
            const Gap(12),
          ],
        )
    );
  }

  @override
  void castStatefulWidget() {
    widget as SuggestedActionsScreen;
  }

  void getSuggestedActionsData() async {
    setState(() {
      _isLoading = true;
    });

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_CP + suggestedActions);

    Map<String, String> jsonBody = {
      'user_id': sessionManagerPMS.getUserId().toString().trim(),
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = SuggestedActionsResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      suggestedActionsData = dataResponse.recommendation ?? '';

      setState(() {
        _isLoading = false;
      });

    } else {
      setState(() {
        _isLoading = false;
      });


    }
  }

}