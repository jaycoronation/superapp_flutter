import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../constant/colors.dart';
import '../../utils/base_class.dart';

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({super.key});

  @override
  BaseState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends BaseState<ForgotPasswordScreen> {
  TextEditingController userNameController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: white,
            elevation: 0,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: blue,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.light,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(height: 62,),
                  Image.asset('assets/images/ic_login_logo.png', width: 150, height: 52,color: blue,fit: BoxFit.contain,),
                  Container(height: 22,),
                  const Text("Please Enter Your Login ID", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500, color: graySemiDark),),
                  Container(height: 28,),
                  TextField(
                    readOnly: false,
                    keyboardType: TextInputType.phone,
                    cursorColor: black,
                    controller:userNameController,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      color: black,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                      counterText: "",
                      fillColor: Colors.transparent,
                      hintText: 'Enter Login Id',
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

                  Container(height: 30,),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: blue
                    ),
                    child: const Text("Submit", style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: white),),
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
    // TODO: implement castStatefulWidget
  }

}