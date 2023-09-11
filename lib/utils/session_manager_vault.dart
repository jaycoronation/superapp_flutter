import 'package:superapp_flutter/utils/session_manager_methods.dart';

class SessionManagerVault {
  final String isLoggedIn = "isLoggedInVault";
  final String userId = "userIdVault";
  final String username = "usernameVault";
  final String email = "emailVault";
  final String phone = "phoneVault";
  final String image = "imageVault";
  final String country_name = "country_nameVault";
  final String countryId = "countryIdVault";
  final String state_name = "state_nameVault";
  final String stateId = "stateIdVault";
  final String city_name = "city_nameVault";
  final String cityId = "cityIdVault";

  //set data into shared preferences...
  Future createLoginSession(String userIdApi,String usernameApi ,String emailApi,
      String phoneApi,String imageApi,String countrynameApi,
      String countryIdApi,
      String statenameApi,
      String stateIdApi,
      String citynameApi,
      String cityIdApi) async {

    await SessionManagerMethods.setBool(isLoggedIn, true);
    await SessionManagerMethods.setString(userId,userIdApi);
    await SessionManagerMethods.setString(username,usernameApi);
    await SessionManagerMethods.setString(email,emailApi);
    await SessionManagerMethods.setString(phone, phoneApi);
    await SessionManagerMethods.setString(image, imageApi);
    await SessionManagerMethods.setString(country_name, countrynameApi);
    await SessionManagerMethods.setString(countryId, countryIdApi);
    await SessionManagerMethods.setString(state_name, statenameApi);
    await SessionManagerMethods.setString(stateId, stateIdApi);
    await SessionManagerMethods.setString(city_name, citynameApi);
    await SessionManagerMethods.setString(cityId, cityIdApi);
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


  String getCountryName() {
    return checkValidString(SessionManagerMethods.getString(country_name));
  }

  Future<void> setCountryName(String data)
  async {
    await SessionManagerMethods.setString(country_name, data);
  }

  String getCountryId() {
    return checkValidString(SessionManagerMethods.getString(countryId));
  }

  Future<void> setCountryId(String data)
  async {
    await SessionManagerMethods.setString(countryId, data);
  }

  String getStateName() {
    return checkValidString(SessionManagerMethods.getString(state_name));
  }

  Future<void> setStateName(String data)
  async {
    await SessionManagerMethods.setString(state_name, data);
  }

  String getStateId() {
    return checkValidString(SessionManagerMethods.getString(stateId));
  }

  Future<void> setStateId(String data)
  async {
    await SessionManagerMethods.setString(stateId, data);
  }

  String getCityName() {
    return checkValidString(SessionManagerMethods.getString(city_name));
  }

  Future<void> setCityName(String data)
  async {
    await SessionManagerMethods.setString(city_name, data);
  }

  String getCityId() {
    return checkValidString(SessionManagerMethods.getString(cityId));
  }

  Future<void> setCityId(String data)
  async {
    await SessionManagerMethods.setString(cityId, data);
  }

  checkValidString (String? value) {
    if (value == null || value == "null" || value == "<null>")
    {
      value = "";
    }
    return value.trim();
  }
}