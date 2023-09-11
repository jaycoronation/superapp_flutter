import 'dart:convert';

import 'package:superapp_flutter/utils/session_manager_methods.dart';

import '../model/consolidated-portfolio/SinceInceptionResponse.dart';

class SessionManagerPMS {
  final String isLoggedIn = "isLoggedInPMS";
  final String userId = "userIdPMS";
  final String firstName = "firstNamePMS";
  final String lastName = "lastNamePMS";
  final String email = "emailPMS";
  final String KEY_PERFORMANCE = "KEY_PERFORMANCE";
  final String KEY_NEXTYEAR = "KEY_NEXTYEAR";
  final String KEY_PERVIOUSYEAR = "KEY_PERVIOUSYEAR";

  //set data into shared preferences...
  Future createLoginSession(String userIdApi,String firstNameApi,String lastNameApi ,String emailApi) async {

    await SessionManagerMethods.setBool(isLoggedIn, true);
    await SessionManagerMethods.setString(userId,userIdApi);
    await SessionManagerMethods.setString(firstName,firstNameApi);
    await SessionManagerMethods.setString(lastName, lastNameApi);
    await SessionManagerMethods.setString(email,emailApi);
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

  String getFristName() {
    return checkValidString(SessionManagerMethods.getString(firstName));
  }

  Future<void> setFristName(String data)
  async {
    await SessionManagerMethods.setString(firstName, data);
  }

  String getLastName() {
    return checkValidString(SessionManagerMethods.getString(lastName));
  }

  Future<void> setLastName(String data)
  async {
    await SessionManagerMethods.setString(lastName, data);
  }

  String getEmail() {
    return checkValidString(SessionManagerMethods.getString(email));
  }

  Future<void> setEmail(String data)
  async {
    await SessionManagerMethods.setString(email, data);
  }

  Future<void> savePerformanceList(List<Data> listItems) async {
    var json = jsonEncode(listItems);
    await SessionManagerMethods.setString(KEY_PERFORMANCE, json);
  }

  List<Data> getPerformanceList() {
    List<Data> listJsonData = [];
    String jsonString = checkValidString(SessionManagerMethods.getString(KEY_PERFORMANCE));
    if (jsonString.isNotEmpty)
      {
        List<dynamic> jsonDataList = jsonDecode(jsonString);
        listJsonData = jsonDataList.map((jsonData) => Data.fromJson(jsonData)).toList();
      }
    return listJsonData;
  }

  Future<void> savePerviousYearList(List<Data> listItems) async {
    var json = jsonEncode(listItems);
    await SessionManagerMethods.setString(KEY_PERVIOUSYEAR, json);
  }

  List<Data> getPerviousYearList() {
    List<Data> listJsonData = [];
    String jsonString = checkValidString(SessionManagerMethods.getString(KEY_PERVIOUSYEAR));
    if (jsonString.isNotEmpty)
      {
        List<dynamic> jsonDataList = jsonDecode(jsonString);
        listJsonData = jsonDataList.map((jsonData) => Data.fromJson(jsonData)).toList();
      }
    return listJsonData;
  }

  Future<void> saveNextYearList(List<Data> listItems) async {
    var json = jsonEncode(listItems);
    await SessionManagerMethods.setString(KEY_NEXTYEAR, json);
  }

  List<Data> getNextYearList() {
    List<Data> listJsonData = [];
    String jsonString = checkValidString(SessionManagerMethods.getString(KEY_NEXTYEAR));
    if (jsonString.isNotEmpty)
      {
        List<dynamic> jsonDataList = jsonDecode(jsonString);
        listJsonData = jsonDataList.map((jsonData) => Data.fromJson(jsonData)).toList();
      }
    return listJsonData;
  }

  checkValidString (String? value) {
    if (value == null || value == "null" || value == "<null>")
    {
      value = "";
    }
    return value.trim();
  }
}