import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../constant/api_end_point.dart';
import '../../../constant/colors.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/base_class.dart';
import '../../../widget/loading.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import '../../model/InvestWellResponse.dart';
import '../../model/LoginResponseModel.dart';
import 'home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen> {
  bool _isLoading = false;
  bool _passwordVisible = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: appBg,
      statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      statusBarBrightness: Brightness.dark,
    ));
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: WillPopScope(
        child: Scaffold(
            backgroundColor: appBg,
            resizeToAvoidBottomInset: true,
            body: _isLoading
                ? const LoadingWidget()
                : Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 30, left: 15, right: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: Image.asset('assets/images/ic_login_logo.png', width: 200, height: 150, color: blue),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 15, right: 15),
                              child: const Text("Welcome!", style: TextStyle(fontWeight: FontWeight.w800, color: black, fontSize: 30)),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 8, bottom: 30, left: 15, right: 15),
                              child: const Text("Please sign in with your registered email/username",
                                  style: TextStyle(fontWeight: FontWeight.w500, color: black, fontSize: 18)),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 8, right: 8),
                              child: TextField(
                                cursorColor: black,
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
                                decoration: const InputDecoration(
                                  hintText: 'Email/Username',
                                  filled: true,
                                  fillColor: lightBlue,
                                  contentPadding: EdgeInsets.only(left: 12, right: 12, top: 22, bottom: 22),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: lightBlue),
                                    borderRadius: BorderRadius.all(Radius.zero),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: lightBlue),
                                    borderRadius: BorderRadius.all(Radius.zero),
                                  ),
                                  labelStyle: TextStyle(
                                    color: graySemiDark,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  hintStyle: TextStyle(
                                    color: graySemiDark,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20, left: 8, right: 8),
                              child: TextField(
                                cursorColor: black,
                                controller: _pwController,
                                obscureText: _passwordVisible,
                                keyboardType: TextInputType.visiblePassword,
                                style: const TextStyle(fontWeight: FontWeight.w600, color: black, fontSize: 16),
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  filled: true,
                                  fillColor: lightBlue,
                                  contentPadding: const EdgeInsets.only(left: 12, right: 12, top: 22, bottom: 22),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: lightBlue),
                                    borderRadius: BorderRadius.all(Radius.zero),
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: lightBlue),
                                    borderRadius: BorderRadius.all(Radius.zero),
                                  ),
                                  labelStyle: const TextStyle(
                                    color: graySemiDark,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  hintStyle: const TextStyle(
                                    color: graySemiDark,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                    child: Icon(
                                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
                                      color: grayDark,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 35),
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: blue,
                                    backgroundColor: blue,
                                    //specify the color of the button's text and icons as well as the overlay colors used to indicate the hover, focus, and pressed states
                                    elevation: 0.0,
                                    //buttons Material shadow
                                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                                    //specify the button's Padding
                                    side: const BorderSide(color: blue, width: 1.0, style: BorderStyle.solid),
                                    //set border for the button
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                                    // set the buttons shape. Make its birders rounded etc
                                    tapTargetSize: MaterialTapTargetSize.padded,
                                    // set the MaterialTapTarget size. can set to: values, padded and shrinkWrap properties
                                    animationDuration: const Duration(milliseconds: 100),
                                    //the buttons animations duration
                                    enableFeedback: true,
                                    //to set the feedback to true or false
                                    alignment: Alignment.center, //set the button's child Alignment
                                  ),
                                  onPressed: () async {
                                    FocusScope.of(context).requestFocus(FocusNode());
                                    String email = _emailController.text.toString().trim();
                                    String password = _pwController.text.toString().trim();
                                    if (email.isEmpty) {
                                      showSnackBar("Please enter a email/username", context);
                                    }else if (password.isEmpty) {
                                      showSnackBar("Please enter password", context);
                                    } else {
                                      if (isInternetConnected) {
                                        _makeSignInRequest();
                                      } else {
                                        noInterNet(context);
                                      }
                                    }
                                  }, //set both onPressed and onLongPressed to null to see the disabled properties
                                  onLongPress: () => {}, //set both onPressed and onLongPressed to null to see the disabled properties
                                  child: const Text(
                                    "SIGN IN",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 16, color: white, fontWeight: FontWeight.w600),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
        onWillPop: () {
          SystemNavigator.pop();
          return Future.value(true);
        },
      ),
    );
  }

  @override
  void castStatefulWidget() {
    widget is LoginScreen;
  }

  //API call function...
  _makeSignInRequest() async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    String userParam = _emailController.value.text.trim();
    String passwordParam = _pwController.value.text.trim();

    final url = Uri.parse("http://m.investwell.in/hc/logincheck.jsp?user=$userParam&password=$passwordParam&bid=10250");

    final response = await http.get(url);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = InvestWellResponse.fromJson(user);

    try {
      if (statusCode == 200) {
            try {
              if (dataResponse.flag == "Y")
              {
                _makeLoginInRequest(checkValidString(dataResponse.uid.toString()));
              }
              else
              {
                 showSnackBar("Invalid Username or Password.", context);
                 setState(() {
                   _isLoading = false;
                 });
              }
            } catch (e) {
              print(e);
              setState(() {
                _isLoading = false;
              });
            }

          } else {
            setState(() {
              _isLoading = false;
            });
            showSnackBar("Failed to login.", context);
          }
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
      showSnackBar("Failed to login.", context);
    }
  }

  _makeLoginInRequest(String uId) async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL+login);
    Map<String, String> jsonBody = {
      'username': uId.trim(),
      'email': _emailController.value.text.trim(),
      'password': _pwController.value.text.trim(),
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = LoginResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      try {
        sessionManager.setIsLoggedIn(true);
        await sessionManager.createLoginSession(
            checkValidString(dataResponse.profile!.userId.toString()),
            checkValidString(dataResponse.profile!.username.toString()),
            checkValidString(dataResponse.profile!.email.toString()),
            checkValidString(dataResponse.profile!.phone.toString()),
            checkValidString(dataResponse.profile!.image.toString()),
            false);

        sessionManagerPMS.setIsLoggedIn(true);
        await sessionManagerPMS.createLoginSession(
            checkValidString(dataResponse.portfolio!.userId.toString()),
            checkValidString(dataResponse.portfolio!.firstName.toString()),
            checkValidString(dataResponse.portfolio!.lastName.toString()),
            checkValidString(dataResponse.portfolio!.email.toString()));

        sessionManagerVault.setIsLoggedIn(true);
        await sessionManagerVault.createLoginSession(
            checkValidString(dataResponse.vault!.userId.toString()),
            checkValidString(dataResponse.vault!.username.toString()),
            checkValidString(dataResponse.vault!.email.toString()),
            checkValidString(dataResponse.vault!.phone.toString()),
            checkValidString(dataResponse.vault!.image.toString()),
            checkValidString(dataResponse.vault!.countryName.toString()),
            checkValidString(dataResponse.vault!.countryId.toString()),
            checkValidString(dataResponse.vault!.stateName.toString()),
            checkValidString(dataResponse.vault!.stateId.toString()),
            checkValidString(dataResponse.vault!.cityName.toString()),
            checkValidString(dataResponse.vault!.cityId.toString()),
            );
        openHomePage();
      } catch (e) {
        print(e);
      }

      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(dataResponse.message, context);
    }
  }

  void openHomePage() {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomePage()), (Route<dynamic> route) => false);
  }
}
