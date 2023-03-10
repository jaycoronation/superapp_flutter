import 'package:superapp/utils/session_manager_methods_vault.dart';


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

    await SessionManagerMethodsVault.setBool(isLoggedIn, true);
    await SessionManagerMethodsVault.setString(userId,userIdApi);
    await SessionManagerMethodsVault.setString(username,usernameApi);
    await SessionManagerMethodsVault.setString(email,emailApi);
    await SessionManagerMethodsVault.setString(phone, phoneApi);
    await SessionManagerMethodsVault.setString(image, imageApi);
    await SessionManagerMethodsVault.setString(country_name, countrynameApi);
    await SessionManagerMethodsVault.setString(countryId, countryIdApi);
    await SessionManagerMethodsVault.setString(state_name, statenameApi);
    await SessionManagerMethodsVault.setString(stateId, stateIdApi);
    await SessionManagerMethodsVault.setString(city_name, citynameApi);
    await SessionManagerMethodsVault.setString(cityId, cityIdApi);
  }

  bool? checkIsLoggedIn() {
    return SessionManagerMethodsVault.getBool(isLoggedIn);
  }

  Future<void> setIsLoggedIn(bool isLogin)
  async {
    await SessionManagerMethodsVault.setBool(isLoggedIn, isLogin);
  }

  String getUserId() {
    return checkValidString(SessionManagerMethodsVault.getString(userId));
  }

  Future<void> setUserId(String data)
  async {
    await SessionManagerMethodsVault.setString(userId, data);
  }

  String getEmail() {
    return checkValidString(SessionManagerMethodsVault.getString(email));
  }

  Future<void> setEmail(String data)
  async {
    await SessionManagerMethodsVault.setString(email, data);
  }

  String getPhoneNo() {
    return checkValidString(SessionManagerMethodsVault.getString(phone));
  }

  Future<void> setPhoneNo(String data)
  async {
    await SessionManagerMethodsVault.setString(phone, data);
  }

  String getImage() {
    return checkValidString(SessionManagerMethodsVault.getString(image));
  }

  Future<void> setImage(String data)
  async {
    await SessionManagerMethodsVault.setString(image, data);
  }


  String getCountryName() {
    return checkValidString(SessionManagerMethodsVault.getString(country_name));
  }

  Future<void> setCountryName(String data)
  async {
    await SessionManagerMethodsVault.setString(country_name, data);
  }

  String getCountryId() {
    return checkValidString(SessionManagerMethodsVault.getString(countryId));
  }

  Future<void> setCountryId(String data)
  async {
    await SessionManagerMethodsVault.setString(countryId, data);
  }

  String getStateName() {
    return checkValidString(SessionManagerMethodsVault.getString(state_name));
  }

  Future<void> setStateName(String data)
  async {
    await SessionManagerMethodsVault.setString(state_name, data);
  }

  String getStateId() {
    return checkValidString(SessionManagerMethodsVault.getString(stateId));
  }

  Future<void> setStateId(String data)
  async {
    await SessionManagerMethodsVault.setString(stateId, data);
  }

  String getCityName() {
    return checkValidString(SessionManagerMethodsVault.getString(city_name));
  }

  Future<void> setCityName(String data)
  async {
    await SessionManagerMethodsVault.setString(city_name, data);
  }

  String getCityId() {
    return checkValidString(SessionManagerMethodsVault.getString(cityId));
  }

  Future<void> setCityId(String data)
  async {
    await SessionManagerMethodsVault.setString(cityId, data);
  }

  checkValidString (String? value) {
    if (value == null || value == "null" || value == "<null>")
    {
      value = "";
    }
    return value.trim();
  }
}