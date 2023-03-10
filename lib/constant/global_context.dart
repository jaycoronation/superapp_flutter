import 'package:flutter/material.dart';

import '../model/e-state-vault/AccountHolderListResponse.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> navigatorKeyHome = GlobalKey<NavigatorState>();
  static String notif_type = "";
  static List<String> holderList = List<String>.empty(growable: true);
  static  List<Holders> accountHolder = List<Holders>.empty(growable: true);
}