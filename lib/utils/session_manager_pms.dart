import 'package:superapp/utils/session_manager_methods_pms.dart';

class SessionManagerPMS {
  final String isLoggedIn = "isLoggedInPMS";
  final String userId = "userIdPMS";
  final String firstName = "firstNamePMS";
  final String lastName = "lastNamePMS";
  final String email = "emailPMS";

  //set data into shared preferences...
  Future createLoginSession(String userIdApi,String firstNameApi,String lastNameApi ,String emailApi) async {

    await SessionManagerMethodsPMS.setBool(isLoggedIn, true);
    await SessionManagerMethodsPMS.setString(userId,userIdApi);
    await SessionManagerMethodsPMS.setString(firstName,firstNameApi);
    await SessionManagerMethodsPMS.setString(lastName, lastNameApi);
    await SessionManagerMethodsPMS.setString(email,emailApi);
  }

  bool? checkIsLoggedIn() {
    return SessionManagerMethodsPMS.getBool(isLoggedIn);
  }

  Future<void> setIsLoggedIn(bool isLogin)
  async {
    await SessionManagerMethodsPMS.setBool(isLoggedIn, isLogin);
  }

  String getUserId() {
    return checkValidString(SessionManagerMethodsPMS.getString(userId));
  }

  Future<void> setUserId(String data)
  async {
    await SessionManagerMethodsPMS.setString(userId, data);
  }

  String getFristName() {
    return checkValidString(SessionManagerMethodsPMS.getString(firstName));
  }

  Future<void> setFristName(String data)
  async {
    await SessionManagerMethodsPMS.setString(firstName, data);
  }

  String getLastName() {
    return checkValidString(SessionManagerMethodsPMS.getString(lastName));
  }

  Future<void> setLastName(String data)
  async {
    await SessionManagerMethodsPMS.setString(lastName, data);
  }

  String getEmail() {
    return checkValidString(SessionManagerMethodsPMS.getString(email));
  }

  Future<void> setEmail(String data)
  async {
    await SessionManagerMethodsPMS.setString(email, data);
  }


  checkValidString (String? value) {
    if (value == null || value == "null" || value == "<null>")
    {
      value = "";
    }
    return value.trim();
  }
}