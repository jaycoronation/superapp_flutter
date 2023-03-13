import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import '../../../constant/colors.dart';
import '../../../utils/base_class.dart';
import '../../constant/e-state-valut/api_end_point.dart';
import '../../model/e-state-vault/ConstitutionValuesResponse.dart';
import '../../utils/app_utils.dart';
import '../../utils/my_toolbar.dart';
import '../../widget/loading.dart';

class ConstitutionValuesPage extends StatefulWidget {
  const ConstitutionValuesPage({Key? key}) : super(key: key);

  @override
  _ConstitutionValuesPageState createState() => _ConstitutionValuesPageState();
}

class _ConstitutionValuesPageState extends BaseState<ConstitutionValuesPage> {
  bool _isLoading = false;
  List<Data> listData = List<Data>.empty(growable: true);
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (isOnline) {
      _getApiData();
    } else {
      noInterNet(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: appBg,
      appBar : AppBar(
        toolbarHeight: 55,
        automaticallyImplyLeading: false,
        title: const MyToolBar(pageName : "Constitution And Values"),
        centerTitle: false,
        elevation: 0,
        backgroundColor: appBg,
      ),
      body: SafeArea(
        top: false,
        child: _isLoading
            ? const LoadingWidget()
            : Column(
                children: [
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Container(
                            child: _itemList(),
                          )))
                ],
              ),
      ),
    );
  }

  ListView _itemList() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        primary: false,
        padding: EdgeInsets.zero,
        itemCount: listData.length,
        itemBuilder: (ctx, index) => (GestureDetector(
            onTap: () async {
              setState(() {
              });
            },
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              color: white,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(top: 8, bottom: 8),
                    decoration: const BoxDecoration(color: semiBlue,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          checkValidString(listData[index].notes),
                          style: const TextStyle(color: black, fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        const Spacer(),
                        Image.asset(headerPosition == index ? 'assets/images/ic_arrow_double_down.png' : 'assets/images/ic_arrow_double_right.png',
                            width: 24, height: 24, color: headerPosition == index ? white : blue),
                      ],
                    ),
                  ),
                  Visibility(
                      visible: headerPosition == index,
                      child: Container(
                        margin: const EdgeInsets.only(top: 6, bottom: 6),
                        child: _menuList(menuList[index].menuItems),
                      ))
                ],
              ),
            ))));
  }


  _getApiData() async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_VAULT + constitutionValues);
    Map<String, String> jsonBody = {'user_id': sessionManagerVault.getUserId().trim()};

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = ConstitutionValuesResponse.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      try {
        if (dataResponse.data != null) {
          listData = dataResponse.data!;
        }
      } catch (e) {
        print(e);
      }
    } else {
      showSnackBar(dataResponse.message, context);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void castStatefulWidget() {
    widget is ConstitutionValuesPage;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
