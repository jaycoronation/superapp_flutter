import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/model/links_response_model.dart';
import '../../constant/api_end_point.dart';
import '../../constant/colors.dart';
import '../../utils/app_utils.dart';
import '../../utils/base_class.dart';

class WebviewPage extends StatefulWidget {
  final String url; 
  const WebviewPage(this.url,{Key? key}) : super(key: key);

  @override
  _WebviewPageState createState() => _WebviewPageState();
}

class _WebviewPageState extends BaseState<WebviewPage> {
  bool _isLoading = false;

  var _url;
  late final InAppWebViewController webViewController;
  List<Links> listData = List<Links>.empty();

  @override
  void initState() {
    super.initState();

    _url = (widget as WebviewPage).url;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          toolbarHeight: 55,
          automaticallyImplyLeading: false,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 8),
                child: Image.asset('assets/images/fin_plan_ic_back_arrow.png',height: 30, width: 30, color: black,),
              )
          ),
          centerTitle: false,
          elevation: 0,
          backgroundColor: white,
        ),
        body: Stack(
          children: [
            Visibility(visible:_isLoading, child: const CircularProgressIndicator()),
            InAppWebView(
              initialUrlRequest: URLRequest(url: Uri.parse(_url)),
              initialUserScripts: UnmodifiableListView<UserScript>([]),
              onWebViewCreated: (controller) async {
                webViewController = controller;
              },
              onLoadStart: (controller, url) async {
                print(url);
                setState(() {
                  _isLoading = true;
                });
              },
              onUpdateVisitedHistory: (controller, url, androidIsReload) {
                print("onUpdateVisitedHistory Current URL = $url");
                setState(() {
                  _isLoading = false;
                });

              },
              onLoadStop: (controller, url) async {
                print("onLoadStop Current URL = $url");
              },
              onProgressChanged: (controller, progress) {
                print("onProgressChanged $progress");
                if(progress == 100) {
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
              onConsoleMessage: (controller, consoleMessage) {
                print(consoleMessage);
              },
            ),
          ],
        )
    );
  }

  @override
  void castStatefulWidget() {
    widget is WebviewPage;
  }

  //API call func..

}
