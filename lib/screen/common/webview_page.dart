import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:superapp_flutter/common_widget/common_widget.dart';
import 'package:superapp_flutter/model/links_response_model.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../constant/colors.dart';
import '../../utils/base_class.dart';

class WebViewPage extends StatefulWidget {
  final String url; 
  const WebViewPage(this.url,{super.key});

  @override
  BaseState<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends BaseState<WebViewPage> {
  bool _isLoading = false;

  var _url;
  // late final InAppWebViewController webViewController;
  List<Links> listData = List<Links>.empty();

  late WebViewController controller;

  @override
  void initState() {
    super.initState();

    _url = (widget as WebViewPage).url;
    setState(() {
      _isLoading = true;
    });
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            if (progress == 100)
              {
                setState(() {
                  _isLoading = false;
                });
              }
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(_url));
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
              child: getBackArrow(),
          ),
          centerTitle: false,
          elevation: 0,
          backgroundColor: white,
        ),
        body: Stack(
          children: [
            Visibility(visible:_isLoading, child: const CircularProgressIndicator()),
            WebViewWidget(controller: controller),
          ],
        )
    );
  }

  @override
  void castStatefulWidget() {
    widget is WebViewPage;
  }

  //API call func..

}
