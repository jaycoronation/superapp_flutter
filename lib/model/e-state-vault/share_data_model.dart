import 'package:flutter/cupertino.dart';

class ShareDataGetSet {
  String email = "";
  TextEditingController emailController = TextEditingController();
  set setEmail(String data)
  {
    email = data;
  }
}
