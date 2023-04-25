import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constant/colors.dart';

/*show message to user*/
showSnackBar(String? message,BuildContext? context) {
  try {
    return ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          backgroundColor: black,
          content: Text(message!,style: const TextStyle(color: white,fontSize: 16,fontWeight: FontWeight.w600)),
          duration: const Duration(seconds: 1),
        ),
      );
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}

hideKeyboard(BuildContext context){
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

showSnackBarLong(String? message,BuildContext? context) {
  try {
    return ScaffoldMessenger.of(context!).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 3),
      ),
    );
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}

String getPrice(String text) {
    if(text.isNotEmpty)
    {
      try {
        var formatter = NumberFormat('#,##,###');
        return "₹ ${formatter.format(double.parse(text))}";
      } catch (e) {
        return "₹ $text";
      }
    }
    else
    {
      return "₹ $text";
    }
}

noInterNet(BuildContext? context) {
  try {
    return ScaffoldMessenger.of(context!).showSnackBar(
      const SnackBar(
        content: Text("Please check your internet connection!"),
        duration: Duration(seconds: 1),
      ),
    );
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}

/*check email validation*/
bool isValidEmail(String ? input) {
  try {
    return RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(input!);
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    return false;
  }
}

tabNavigationReload() {
  try {
    isHomeReload = true;
    isGalleryReload = true;
    isVideoReload = true;
    isBlogReload = true;
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}

/*convert string to CamelCase*/
toDisplayCase (String str) {
  try {
    return str.toLowerCase().split(' ').map((word) {
        String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
        return word[0].toUpperCase() + leftText;
      }).join(' ');
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}

getRandomCartSession () {
  try {
    var r = Random();
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(8, (index) => _chars[r.nextInt(_chars.length)]).join();
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}

doubleUpto2Digit (double value) {
  try {
    return double.parse(value.toStringAsFixed(2));
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}

convertCommaSeparatedAmount (String value) {
  try {
    var formatter = NumberFormat('#,##,000');
    return checkValidString(value).toString().isNotEmpty ? "₹ ${formatter.format(double.parse(value))}" : "₹ 0";
  } catch (e) {
    return value;
  }
}

final numberFormatter = NumberFormat(
  "##,##,###",
  "en_US",     // local US
);

extension RupeesFormatter on num {
  String inRupeesFormat() {
    return numberFormatter.format(this);
  }
}

/*generate hex color into material color*/
MaterialColor createMaterialColor(Color color) {
  try {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
        strengths.add(0.1 * i);
      }
    for (var strength in strengths) {
        final double ds = 0.5 - strength;
        swatch[(strength * 1000).round()] = Color.fromRGBO(
          r + ((ds < 0 ? r : (255 - r)) * ds).round(),
          g + ((ds < 0 ? g : (255 - g)) * ds).round(),
          b + ((ds < 0 ? b : (255 - b)) * ds).round(),
          1,
        );
      }
    return MaterialColor(color.value, swatch);
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    return const MaterialColor(0xFFFFFFFF, <int, Color>{});
  }
}

Future<void> shareFileWithText(String text,String filePath) async {
  try {
    Share.shareFiles([filePath], text: text);
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}

Future<void> setOrientation(List<DeviceOrientation> orientations) async {
  SystemChrome.setPreferredOrientations(orientations);
}

checkValidString (String? value) {
  if (value == null || value == "null" || value == "<null>")
  {
    value = "";
  }
  return value.trim();
}

checkValidStringWithToDisplayCase (String? value) {
  if (value == null || value == "null" || value == "<null>")
  {
    value = "";
  }
  return value.isNotEmpty ? toDisplayCase(value.trim()) : value.trim();
}

getTimeStampDate (String value,String dateFormat) {
    int timestamp = 0;
    if(value.isNotEmpty)
    {
      DateTime datetime = DateFormat(dateFormat).parse(value);
      timestamp = datetime.millisecondsSinceEpoch ~/ 1000;
    }

  return timestamp;
}

String universalDateConverter(String inputDateFormat,String outputDateFormat, String date) {
  var inputFormat = DateFormat(inputDateFormat);
  var inputDate = inputFormat.parse(date); // <-- dd/MM 24H format
  var outputFormat = DateFormat(outputDateFormat);
  var outputDate = outputFormat.format(inputDate);
  print(outputDate); // 12/31/2000 11:59 PM <-- MM/dd 12H format
  return outputDate;
}

List<String> getYear(int currentYear) {
  List<String> listData = [];

  int lastYear = currentYear+100;

  for (int i = currentYear; i <= lastYear; i++) {
    listData.add("$i");
  }
  return listData;
}


List<String> getPeriodicity() {
  List<String> listData = [];

  for (int i = 1; i <= 20; i++) {
    listData.add("$i");
  }
  return listData;
}

openFileFromURL(String url,BuildContext? context)
{
    try {
      if(checkValidString(url).toString().isNotEmpty)
          {
            launch(url);
          }
          else
            {
              showSnackBar("File URL not found.", context);
            }
    } catch (e) {
      print(e);
      showSnackBar("File URL not found.", context);
    }
}