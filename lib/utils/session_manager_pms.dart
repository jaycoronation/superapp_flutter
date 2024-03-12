import 'dart:convert';

import 'package:superapp_flutter/model/consolidated-portfolio/XIRRCommonResponseModel.dart';

import '../model/consolidated-portfolio/NetworthResponseModel.dart';
import '../model/consolidated-portfolio/PercentageResponse.dart';
import '../model/consolidated-portfolio/SinceInceptionResponse.dart';
import 'session_manager_methods.dart';

class SessionManagerPMS {
  final String isLoggedIn = "isLoggedInPMS";
  final String userId = "userIdPMS";
  final String firstName = "firstNamePMS";
  final String lastName = "lastNamePMS";
  final String email = "emailPMS";
  final String pan = "panPMS";
  final String KEY_PERFORMANCE = "KEY_PERFORMANCE";
  final String KEY_NEXTYEAR = "KEY_NEXTYEAR";
  final String KEY_PERVIOUSYEAR = "KEY_PERVIOUSYEAR";
  final String KEY_NETWORTH = "KEY_NETWORTH";
  final String KEY_PERCENTAGE = "KEY_PERCENTAGE";
  final String TOTAL_NETWORTH = "TOTAL_NETWORTH";

  //set data into shared preferences...
  Future createLoginSession(String userIdApi,String firstNameApi,String lastNameApi ,String emailApi,String panApi) async {

    await SessionManagerMethods.setBool(isLoggedIn, true);
    await SessionManagerMethods.setString(userId,userIdApi);
    await SessionManagerMethods.setString(firstName,firstNameApi);
    await SessionManagerMethods.setString(lastName, lastNameApi);
    await SessionManagerMethods.setString(email,emailApi);
    await SessionManagerMethods.setString(pan,panApi);
  }

  bool? checkIsLoggedIn() {
    return SessionManagerMethods.getBool(isLoggedIn);
  }

  Future<void> setIsLoggedIn(bool isLogin)
  async {
    await SessionManagerMethods.setBool(isLoggedIn, isLogin);
  }

  String getPanCard() {
    return checkValidString(SessionManagerMethods.getString(pan));
  }

  Future<void> setPanCard(String data)
  async {
    await SessionManagerMethods.setString(pan, data);
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

  Future<void> savePerformanceList(List<Xirr> listItems) async {
    var json = jsonEncode(listItems);
    await SessionManagerMethods.setString(KEY_PERFORMANCE, json);
  }

  List<Xirr> getPerformanceList() {
    List<Xirr> listJsonData = [];
    String jsonString = checkValidString(SessionManagerMethods.getString(KEY_PERFORMANCE));
    if (jsonString.isNotEmpty)
      {
        List<dynamic> jsonDataList = jsonDecode(jsonString);
        listJsonData = jsonDataList.map((jsonData) => Xirr.fromJson(jsonData)).toList();
      }
    return listJsonData;
  }

  Future<void> savePerviousYearList(List<Xirr> listItems) async {
    var json = jsonEncode(listItems);
    await SessionManagerMethods.setString(KEY_PERVIOUSYEAR, json);
  }

  List<Xirr> getPerviousYearList() {
    List<Xirr> listJsonData = [];
    String jsonString = checkValidString(SessionManagerMethods.getString(KEY_PERVIOUSYEAR));
    if (jsonString.isNotEmpty)
      {
        List<dynamic> jsonDataList = jsonDecode(jsonString);
        listJsonData = jsonDataList.map((jsonData) => Xirr.fromJson(jsonData)).toList();
      }
    return listJsonData;
  }

  Future<void> saveNextYearList(List<Xirr> listItems) async {
    var json = jsonEncode(listItems);
    await SessionManagerMethods.setString(KEY_NEXTYEAR, json);
  }

  List<Xirr> getNextYearList() {
    List<Xirr> listJsonData = [];
    String jsonString = checkValidString(SessionManagerMethods.getString(KEY_NEXTYEAR));
    if (jsonString.isNotEmpty)
      {
        List<dynamic> jsonDataList = jsonDecode(jsonString);
        listJsonData = jsonDataList.map((jsonData) => Xirr.fromJson(jsonData)).toList();
      }
    return listJsonData;
  }

  Future<void> saveNetworthData(Result getSet) async {
    var json = resultToJson(getSet);
    print("json [== $json");
    await SessionManagerMethods.setString(KEY_NETWORTH, json);
  }

  Result getNetworthData() {
    Result dataGetSet = Result();
    String jsonString = checkValidString(SessionManagerMethods.getString(KEY_NETWORTH));
    print("json [== $jsonString");
    if (jsonString.isNotEmpty)
      {
        dataGetSet = resultFromJson(jsonString);
      }
    return dataGetSet;
  }

  Future<void> savePercentageData(PercentageResponse getSet) async {
    var json = jsonEncode(getSet);
    await SessionManagerMethods.setString(KEY_PERCENTAGE, json);
  }

  PercentageResponse getPercentageData() {
    PercentageResponse dataGetSet = PercentageResponse();
    String jsonString = checkValidString(SessionManagerMethods.getString(KEY_PERCENTAGE));
    if (jsonString.isNotEmpty)
      {
        dataGetSet = percentageFromJson(jsonString);
      }
    return dataGetSet;
  }

  Future<void> setTotalNetworth(String data)
  async {
    await SessionManagerMethods.setString(TOTAL_NETWORTH, data);
  }

  String getTotalNetworth() {
    return checkValidString(SessionManagerMethods.getString(TOTAL_NETWORTH));
  }

  checkValidString (String? value) {
    if (value == null || value == "null" || value == "<null>")
    {
      value = "";
    }
    return value.trim();
  }
}