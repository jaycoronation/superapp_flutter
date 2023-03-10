

import 'package:superapp/utils/session_manager_methods.dart';

class SessionManager {
  final String isLoggedIn = "isLoggedIn";
  final String deviceToken = "deviceToken";
  final String userId = "userId";
  final String fullName = "fullName";
  final String email = "email";
  final String phone = "phone";
  final String image = "image";
  final String isSocial = "isSocial";

  //set data into shared preferences...
  Future createLoginSession(String userIdApi,String fullNameApi ,String emailApi,
      String phoneApi,String imageApi,bool isSocialApi) async {

    await SessionManagerMethods.setBool(isLoggedIn, true);
    await SessionManagerMethods.setString(userId,userIdApi);
    await SessionManagerMethods.setString(fullName,fullNameApi);
    await SessionManagerMethods.setString(email,emailApi);
    await SessionManagerMethods.setString(phone, phoneApi);
    await SessionManagerMethods.setString(image, imageApi);
    await SessionManagerMethods.setBool(isSocial, isSocialApi);
  }

  bool? checkIsLoggedIn() {
    return SessionManagerMethods.getBool(isLoggedIn);
  }

  Future<void> setIsLoggedIn(bool isLogin)
  async {
    await SessionManagerMethods.setBool(isLoggedIn, isLogin);
  }


  String getUserId() {
    return checkValidString(SessionManagerMethods.getString(userId));
  }

  Future<void> setUserId(String data)
  async {
    await SessionManagerMethods.setString(userId, data);
  }

  String getFullName() {
    return checkValidString(SessionManagerMethods.getString(fullName));
  }

  Future<void> setFullName(String data)
  async {
    await SessionManagerMethods.setString(fullName, data);
  }
  

  String getEmail() {
    return checkValidString(SessionManagerMethods.getString(email));
  }

  Future<void> setEmail(String data)
  async {
    await SessionManagerMethods.setString(email, data);
  }

  String getPhoneNo() {
    return checkValidString(SessionManagerMethods.getString(phone));
  }

  Future<void> setPhoneNo(String data)
  async {
    await SessionManagerMethods.setString(phone, data);
  }

  String getImage() {
    return checkValidString(SessionManagerMethods.getString(image));
  }

  Future<void> setImage(String data)
  async {
    await SessionManagerMethods.setString(image, data);
  }

  bool? checkIsSocial() {
    return SessionManagerMethods.getBool(isSocial);
  }

  Future<void> setIsSocial(bool data)
  async {
    await SessionManagerMethods.setBool(isSocial, data);
  }

  String getDeviceToken() {
    return  checkValidString(SessionManagerMethods.getString(deviceToken));
  }

  Future<void> setDeviceToken(String apiDeviceToken)
  async {
    await SessionManagerMethods.setString(deviceToken, apiDeviceToken);
  }

  checkValidString (String? value) {
    if (value == null || value == "null" || value == "<null>")
    {
      value = "";
    }
    return value.trim();
  }
}