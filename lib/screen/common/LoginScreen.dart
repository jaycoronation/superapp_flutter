import 'dart:convert';

import 'package:flutter/cupertino.dart' ;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' ;
import 'package:flutter/services.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/constant/consolidate-portfolio/api_end_point.dart';
import 'package:superapp_flutter/model/PortfolioRMIDResponseModel.dart';
import 'package:superapp_flutter/widget/loading.dart';
import 'dart:typed_data';
import 'dart:convert' show utf8;
import 'package:crypto/crypto.dart' as crypto;
import 'package:encrypt/encrypt.dart' as enc;
import 'package:convert/convert.dart' as convert;

import '../../constant/api_end_point.dart';
import '../../constant/colors.dart';
import '../../model/LoginResponseModel.dart';
import '../../service/JobService.dart';
import '../../utils/AuthService.dart';
import '../../utils/app_utils.dart';
import '../../utils/base_class.dart';
import 'ForgotPasswordScreen.dart';
import 'HomePageForWeb.dart';
import 'home_page.dart';

class LoginScreenNew extends StatefulWidget {
  const LoginScreenNew({super.key});

  @override
  BaseState<LoginScreenNew> createState() => _LoginScreenNewState();
}

class _LoginScreenNewState extends BaseState<LoginScreenNew> {
  
  bool _isLoading = false;
  bool _passwordVisible = true;
  TextEditingController userNameController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 30,
            backgroundColor: white,
            elevation: 0,
          ),
          body: _isLoading 
              ? const LoadingWidget()
              : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(height: 62,),
                      Image.asset('assets/images/ic_login_logo.png', width: 180, height: 70,color: blue,fit: BoxFit.contain,),
                      Container(height: 22,),
                      const Text("Login to View Your Portfolio", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500, color: graySemiDark),),
                      Container(height: 28,),
                      TextField(
                        keyboardType: TextInputType.text,
                        cursorColor: black,
                        controller:userNameController,
                        decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            filled: true,
                          prefixIcon: const Icon(Icons.account_circle_outlined,size: 22,color: black),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                          counterText: "",
                          hintText: 'User Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(kBorderRadius),
                              borderSide:  const BorderSide(width: 1, style: BorderStyle.solid, color: blue)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(kBorderRadius),
                              borderSide: const BorderSide(width: 1, style: BorderStyle.solid, color: blue)
                          ),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(kBorderRadius),
                              borderSide: const BorderSide(width: 1, color: blue)
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(kBorderRadius),
                              borderSide: const BorderSide(width:1, color: blue)
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(kBorderRadius),
                              borderSide: const BorderSide(width:1, style: BorderStyle.solid, color: blue)
                          ),

                        ),
                      ),
                      Container(height: 18,),
                      TextField(
                        cursorColor: black,
                        controller: _pwController,
                        obscureText: _passwordVisible,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          fillColor: Colors.transparent,
                          filled: true,
                          prefixIcon: const Icon(Icons.lock_outline,size: 22,color: black),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                          counterText: "",
                          hintText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(kBorderRadius),
                              borderSide:  const BorderSide(width: 1, style: BorderStyle.solid, color: blue)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(kBorderRadius),
                              borderSide: const BorderSide(width: 1, style: BorderStyle.solid, color: blue)
                          ),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(kBorderRadius),
                              borderSide: const BorderSide(width: 1, color: blue)
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(kBorderRadius),
                              borderSide: const BorderSide(width:1, color: blue)
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(kBorderRadius),
                              borderSide: const BorderSide(width:1, style: BorderStyle.solid, color: blue)
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                            child: Icon(
                              _passwordVisible ? Icons.visibility : Icons.visibility_off,
                              color: black,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      Container(height: 22,),
                       Align(
                        alignment: Alignment.centerRight,
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen(),));
                            },
                            child: const Text("Forgot Password?", style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: graySemiDark),)
                          )
                      ),
                      Container(height: 22,),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          String email = userNameController.text.toString().trim();
                          String password = _pwController.text.toString().trim();
                          if (email.isEmpty) {
                            showSnackBar("Please enter a email/username", context);
                          }else if (password.isEmpty) {
                            showSnackBar("Please enter password", context);
                          } else {
                            if (isOnline)
                            {
                              print("IS IN");
                              const authName = 'alphacapitalapi';
                              const password = 'Mukesh@2025';

                              final c = encryptPasswordForAggregator(secretKey: authName, password: password);
                              final p = decryptPasswordForAggregator(secretKey: authName, hexCiphertext: c);

                              assert(p == password);
                              print('OK: $c');
                              print('p: $p');
                              // _makeLoginRequestRMID("manjeet@alphacapital.in");
                              _mintLogin();
                              // _makeLoginInRequest("OM1143","OM PRAKASH DHINGRA","nishchay64@gmail.com","9210574409");
                              // _makeLoginInRequest("gauravgarg0209@gmail.com","GAURAV GARG","gauravgarg0209@gmail.com","9911280201");
                            } else {
                              noInterNet(context);
                            }
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 220,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: gray
                          ),
                            child: const Text("Sign In", style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: white),),
                        ),
                      )
                    ],
                  ),
                ),
              ),
        ),
        onWillPop: (){
          Navigator.pop(context,true);
          return Future.value(true);
        }
    );
  }

  @override
  void castStatefulWidget() {
    widget is LoginScreenNew;
  }



  /// Encrypt a plaintext password using:
  /// - AES-256-CBC
  /// - key = SHA-256(secretKey)
  /// - iv  = MD5(secretKey)
  /// Returns lowercase hex string of ciphertext.
  String encryptPasswordForAggregator({
    required String secretKey, // must be the user's authName
    required String password,
  }) {
    // Derive key (32 bytes) via SHA-256(secretKey)
    final keyBytes = crypto.sha256.convert(utf8.encode(secretKey)).bytes;
    // Derive IV (16 bytes) via MD5(secretKey)
    final ivBytes = crypto.md5.convert(utf8.encode(secretKey)).bytes;

    final key = enc.Key(Uint8List.fromList(keyBytes)); // 32 bytes
    final iv  = enc.IV(Uint8List.fromList(ivBytes));   // 16 bytes

    final encrypter = enc.Encrypter(
      enc.AES(key, mode: enc.AESMode.cbc, padding: 'PKCS7'),
    );

    final encrypted = encrypter.encrypt(password, iv: iv);

    // Hex-encode ciphertext (lowercase)
    return convert.hex.encode(encrypted.bytes);
  }

  String decryptPasswordForAggregator({
    required String secretKey,
    required String hexCiphertext,
  }) {
    final keyBytes = crypto.sha256.convert(utf8.encode(secretKey)).bytes;
    final ivBytes  = crypto.md5.convert(utf8.encode(secretKey)).bytes;

    final key = enc.Key(Uint8List.fromList(keyBytes));
    final iv  = enc.IV(Uint8List.fromList(ivBytes));

    final encrypter = enc.Encrypter(
      enc.AES(key, mode: enc.AESMode.cbc, padding: 'PKCS7'),
    );

    final cipherBytes = Uint8List.fromList(convert.hex.decode(hexCiphertext));
    final encrypted = enc.Encrypted(cipherBytes);
    return encrypter.decrypt(encrypted, iv: iv);
  }




   _mintLogin() async{
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var mInputEmail = userNameController.value.text.toString();
    var mInputPassword = _pwController.value.text.toString();

    var headers = {
      "User-Agent": "MintApp",
      'Content-Type': 'application/json',
    };
    var body = json.encode({
      "email":mInputEmail,
      "password":mInputPassword,
      "brokerDomain": "alphacapital",
    });
    final url = Uri.parse(MINT_URL + mintLogin);
    final response = await http.post(url,body: body,headers: headers);
    final statusCode = response.statusCode;
    final mbody = response.body;
    Map res = jsonDecode(mbody);
    if(statusCode == 200 && res['status'] ==0){
      setState(() {
        _isLoading = false;
      });
      // sessionManager.setMintUser(mInputEmail);
      // sessionManager.setmintPass(mInputPassword);
      var mintResponse = mbody;
      // startMintSession(mbody);
      // startMintFirstHeaders(allHeaders);

      sessionManager.setUserType(res['result']['userType']);
      print("Display user type : ${sessionManager.getUserType()}");

      if(sessionManager.getUserType() == "client")
      {
        _makeLoginInRequest(res['result']['username'],res['result']['name'],res['result']['email'],mintResponse);
      }
      else
      {
        sessionManager.setRMIUserName(res['result']['username']);
        sessionManager.setRMIDName(res['result']['name']);

        print("Display user name : ${sessionManager.getRMIUserName()}");
        print("Display name : ${sessionManager.getRMIDName()}");

        _makeLoginRequestRMID(res['result']['email']);
      }

    }else{
      showSnackBar("${res['message']}", context);
      setState(() {
        _isLoading = false;
      });
    }
  }

  _makeLoginRequestRMID(String email) async
  {
    setState(() {
      if(!_isLoading){
        _isLoading = true;
      }else{
        _isLoading = true;
      }
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_CP+getPortfolioRMID);

    Map<String, String> jsonBody = {
      'email': email
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = PortfolioRMIDResponseModel.fromJson(user);

    if(statusCode == 200 && dataResponse.success == 1)
    {
      try
      {
        sessionManager.setIsLoggedIn(true);
        sessionManager.setRMIDAdminId(dataResponse.adminId ?? "");
        getAuthCheck();
      }
      catch(error)
      {
        print("login error : $error");
      }
      setState(() {
        if(_isLoading)
        {
          _isLoading = false;
        }
      });
    }
    else
    {
      setState(() {
        if(_isLoading){
          _isLoading = false;
        }else{
          _isLoading = false;
        }
      });
      showSnackBar(dataResponse.message, context);
    }

  }

  _makeLoginInRequest(String? userName,String? name,String? email, String? mintResponse) async {
    setState(() {
      if(!_isLoading){
        _isLoading = true;
      }else{
        _isLoading = true;
      }
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL+login);

    print("mintResponse === $mintResponse");

    // var mintDecoded = jsonDecode(mintResponse ?? '{}');

    // Map<String, String> jsonBody = {
    //   'first_name': mintDecoded['result']['name'] ?? '',
    //   'email': mintDecoded['result']['email'] ?? '',
    //   'username': mintDecoded['result']['username'] ?? '',
    //   'phone_number': mintDecoded['result']['phone'] ?? '',
    //   'pan_no': '',
    // };

    Map<String, String> jsonBody = {
      'first_name': name ?? '',
      'email': email ?? '',
      'username': userName ?? '',
      'phone_number': mintResponse ?? '',
      'pan_no': '',
    };

    /* Map<String, String> jsonBody = {
      'username': uId.trim(),
      'email': 'mukesh58',
      'password': 'Mykel@3421',
    };*/

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = LoginResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      try {
        // startMintSession(mintResponse);

        sessionManager.setUserType('client');

        sessionManager.setIsLoggedIn(true);
        await sessionManager.createLoginSession(
            dataResponse.profile?.userId ?? '',
            userName ?? '',
            dataResponse.profile?.email ?? '',
            dataResponse.profile?.phone ?? '',
            dataResponse.profile?.image ?? '',
            false);

        sessionManagerPMS.setIsLoggedIn(true);

        print("JSON MODEL === ${jsonEncode(dataResponse.portfolio)}");

        await sessionManagerPMS.createLoginSession(
            dataResponse.portfolio?.userId ?? '',
            dataResponse.portfolio?.firstName ?? '',
            dataResponse.portfolio?.lastName ?? '',
            dataResponse.portfolio?.email ?? '',
            dataResponse.portfolio?.panNo ?? ''
        );

        print("Session === ${sessionManagerPMS.getFirstName()}");
        print("Session === ${sessionManagerPMS.getLastName()}");
        print("Session === ${sessionManagerPMS.getUserId()}");

        sessionManagerVault.setIsLoggedIn(true);
        await sessionManagerVault.createLoginSession(
          dataResponse.vault?.userId ?? '',
          userName ?? '',
          dataResponse.vault?.email ?? '',
          dataResponse.vault?.phone ?? '',
          dataResponse.vault?.image ?? '',
          dataResponse.vault?.countryName ?? '',
          dataResponse.vault?.countryId ?? '',
          dataResponse.vault?.stateName ?? '',
          dataResponse.vault?.stateId ?? '',
          dataResponse.vault?.cityName ?? '',
          dataResponse.vault?.cityId ?? '',
        );

        JobService().getCommonXirr();
        JobService().getNetworthData();

        getAuthCheck();

      } catch (e) {
        print(e);
      }

      setState(() {
        if(_isLoading){
          _isLoading = false;
        }
      });
    } else {
      setState(() {
        if(_isLoading){
          _isLoading = false;
        }else{
          _isLoading = false;
        }
      });
      showSnackBar(dataResponse.message, context);
    }
  }

  Future<void> getAuthCheck() async {
    bool isAuthenticated = await AuthService.authenticateUser();
    print("Display is authenticated : $isAuthenticated");
    if (isAuthenticated)
    {
      openHomePage();
    }
    else
    {
      showSnackBar('Authentication failed.', context);
    }

  }

  void openHomePage() {
    if(kIsWeb)
    {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomePageForWeb()), (Route<dynamic> route) => false);
    }
    else
    {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomePage()), (Route<dynamic> route) => false);
    }
  }

}