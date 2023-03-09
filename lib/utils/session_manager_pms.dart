
import 'session_manager_methods.dart';

class SessionManagerPMS {
  final String isLoggedIn = "isLoggedIn";
  final String userId = "userId";
  final String firstName = "firstName";
  final String lastName = "lastName";
  final String email = "email";

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


  checkValidString (String? value) {
    if (value == null || value == "null" || value == "<null>")
    {
      value = "";
    }
    return value.trim();
  }
}