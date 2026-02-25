import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../common_widget/common_widget.dart';
import '../constant/colors.dart';
import '../model/TaskListResponseModel.dart';
import 'package:shimmer/shimmer.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

setTaskName(TaskList allTaskList) {
  String taskFullText = "";
  String taskMsg = checkValidString(allTaskList.taskMessage);
  String clientName = "";
  String dueDate = "";

  if(allTaskList.lstclient != null)
  {
    if (allTaskList.lstclient!.isNotEmpty)
    {
      for (int i = 0; i < allTaskList.lstclient!.length; i++) {
        if (clientName.isEmpty)
        {
          clientName = checkValidString(allTaskList.lstclient![i].clientName);
        }
        else
        {
          clientName ="$clientName," + checkValidString(allTaskList.lstclient![i].clientName);
        }
      }
    }
  }

  if(allTaskList.dueDate != null)
  {
    if (checkValidString(allTaskList.dueDate).isNotEmpty)
    {
      dueDate = universalDateConverter("MM/dd/yyyy HH:mm:ss a", "dd MMM,yyyy", checkValidString(allTaskList.dueDate));

      DateTime today = DateTime.now();

      DateTime givenDate = DateFormat("dd MMM,yyyy").parse(dueDate);

      int differenceInDays = givenDate.difference(today).inDays;

      if (differenceInDays > 7)
      {
        dueDate = "is due on ${universalDateConverter("MM/dd/yyyy HH:mm:ss a", "dd MMM,yyyy", checkValidString(allTaskList.dueDate))}";
      }
      else
      {
        dueDate = "is due in $differenceInDays day(s)";
      }


    }
  }

  if (clientName.isNotEmpty)
  {
    if (dueDate.isNotEmpty)
    {
      taskFullText = "$taskMsg for $clientName $dueDate";
    }
    else
    {
      taskFullText = "$taskMsg for $clientName";
    }
  }
  else
  {
    if (dueDate.isNotEmpty)
    {
      taskFullText = "$taskMsg $dueDate";
    }
    else
    {
      taskFullText = taskMsg;
    }
  }

  return taskFullText;
}

startActivity(BuildContext context,Widget screen){
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}

String getSortName(String text)
{
  String sortname = "";

  if(checkValidString(text).toString().isNotEmpty)
  {
    var splited = text.split(" ");
    if (splited.isNotEmpty)
    {
      if (splited.length == 1)
      {
        var temp = splited[0].toString();
        sortname = temp[0];
      }
      else
      {
        var temp1 = splited[0].toString();
        var temp2 = splited[1].toString();
        sortname = temp1[0] + temp2[0];
      }
    }
  }
  return sortname.toUpperCase();
}

String getFirstName(String text)
{
  String sortname = "";

  if(checkValidString(text).toString().isNotEmpty)
  {
    var splited = text.split(" ");
    if (splited.isNotEmpty)
    {
      sortname = splited[0];
    }
  }

  return sortname;
}

String getExtension(String fileName)
{
  String ext = "";
  ext = fileName.substring(fileName.lastIndexOf(".") + 1, fileName.toString().length);
  return ext;
}

String convertToAgo(String dateTime) {
  DateTime input =
  DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').parse(dateTime, false);
  Duration diff = DateTime.now().difference(input);

  if (diff.inDays >= 1) {
    return universalDateConverter("yyyy-MM-ddTHH:mm:ss.SSS", "dd MMM yyyy", dateTime);
  } else if (diff.inHours >= 1) {
    return '${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago';
  } else if (diff.inMinutes >= 1) {
    return '${diff.inMinutes} minute${diff.inMinutes == 1 ? '' : 's'} ago';
  } else if (diff.inSeconds >= 1) {
    return '${diff.inSeconds} second${diff.inSeconds == 1 ? '' : 's'} ago';
  } else {
    return 'just now';
  }
}

String getFinancialYear() {
  DateTime now = DateTime.now();
  int currentYear = now.year;
  int currentMonth = now.month;
  int financialYearStartMonth = 4; // Assuming the financial year starts in April (4th month)

  int financialYear;
  if (currentMonth >= financialYearStartMonth) {
    financialYear = currentYear;
  } else {
    financialYear = currentYear - 1;
  }

  int nextYear = financialYear + 1;
  return '$financialYear-$nextYear';
}

String getCurrentFinancialYear() {
  // Get the current date
  DateTime now = DateTime.now();

  // If the current month is before April, we consider the previous financial year
  if (now.month < 4) {
    return "${now.year - 1}-${universalDateConverter("yyyy", 'yy', (now.year).toString())}";
  } else {
    return "${now.year}-${universalDateConverter("yyyy", 'yy', (now.year + 1).toString())}";
  }
}

String getPreviousFinancialYear() {
  // Get the current date
  DateTime now = DateTime.now();

  // If the current month is before April, the previous financial year is the previous year
  if (now.month < 4) {
    return "${now.year - 2}-${universalDateConverter("yyyy", 'yy', (now.year - 1).toString())}";
  } else {
    return "${now.year - 1}-${universalDateConverter("yyyy", 'yy', (now.year).toString())}";
  }
}

String getFinancialYearFormated() {
  DateTime now = DateTime.now();
  int currentYear = now.year;
  int currentMonth = now.month;
  int financialYearStartMonth = 3; // Assuming the financial year starts in April (4th month)

  int financialYear;
  if (currentMonth >= financialYearStartMonth) {
    financialYear = currentYear - 1;
  } else {
    financialYear = currentYear;

  }

  int nextYearTemp = financialYear + 1;

  String nextYear = universalDateConverter("yyyy", "yy", nextYearTemp.toString());
  print(' Current FinancialYear ===== $financialYear-$nextYear');
  return '$financialYear-$nextYear';
}

String getPerviousFinancialYearFormated() {
  DateTime now = DateTime.now();
  int currentYear = now.year;
  int currentMonth = now.month;
  int financialYearStartMonth = 3; // Assuming the financial year starts in April (4th month)

  int financialYear;
  if (currentMonth >= financialYearStartMonth) {

    financialYear = currentYear - 2;
  } else {
    financialYear = currentYear - 1;
  }

  int nextYearTemp = financialYear + 1;

  String nextYear = universalDateConverter("yyyy", "yy", nextYearTemp.toString());
  print('PerviousFinancialYear ===== $financialYear-$nextYear');
  return '$financialYear-$nextYear';
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
      return str;
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
    var formatter = NumberFormat('#,##,###');
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

bool isTwoHoursPassed(DateTime timestamp) {
  DateTime now = DateTime.now();
  Duration difference = now.difference(timestamp);
  return difference.inHours >= 2;
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
    Share.shareXFiles([XFile(filePath)], text: text);
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

String getDateFromTimeStampNew(int timeStamp){
  var dt = DateTime.fromMillisecondsSinceEpoch((timeStamp * 1000).toInt());
  var formatedDate = DateFormat('dd MMM yyyy').format(dt);
  return formatedDate;
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

openFileFromURL(String url,BuildContext? context) async {
    try {
      if(checkValidString(url).toString().isNotEmpty)
          {
            if (await canLaunchUrl(Uri.parse(url)))
              {
                launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication);
              }
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

Widget getCommonButton(String title, bool isLoading, void Function() onPressed, [Color textColor = white,FontWeight weight = FontWeight.w600]){
  return TextButton(
    // onPressed: isLoading ? null : onPressed,
    onPressed: onPressed,
    style: ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: const BorderSide(color: white,width: 0.6)
        ),
      ),
      backgroundColor: MaterialStateProperty.all<Color>(blue),
    ),
    child: isLoading
        ? const Padding(
      padding: EdgeInsets.only(top: 11,bottom: 11),
      child: SizedBox(width: 16,height: 16,child: CircularProgressIndicator(color: white,strokeWidth: 2)),
    )
        : Padding(
      padding: const EdgeInsets.only(top: 11,bottom: 11,),
      child: Text(title.toUpperCase(),
        style: TextStyle(fontSize: 14, fontWeight: weight, color: textColor,),
      ),
    ),
  );
}

Widget getCommonButtonBorder(String title, bool isLoading, void Function() onPressed, {bool isLoadingBtnLight = false, Color bgColor = white, Color borderColor = blue, Color fontColor = blue, bool isSmallFont = false, EdgeInsets? padding, bool isSemiBold = false}){
  return TextButton(
    onPressed: onPressed,
    style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            side: BorderSide(width: 1, color: borderColor),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        backgroundColor: WidgetStateProperty.all<Color>(isLoadingBtnLight && isLoading ? bgColor.withValues(alpha: 0.6) : bgColor)
    ),
    child: isLoading
        ? Padding(
      padding: padding ?? const EdgeInsets.only(top: 10,bottom: 10),
      child: SizedBox(width: 16,height: 16,child: CircularProgressIndicator(color: fontColor,strokeWidth: 2)),
    )
        : Padding(
      padding: padding ?? const EdgeInsets.only(top: 8,bottom: 8),
      child: Text(
        title,
        style: isSemiBold ?
        getSemiBoldTextStyle(
            fontSize: isSmallFont ? 12 : 14,
            color: fontColor
        ) :
        TextStyle(fontSize: isSmallFont ? 12 : 14, fontWeight: FontWeight.w500, color: fontColor,),
      ),
    ),
  );
}

Widget shimmerWidget(Widget child){
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    enabled: true,
    child: child,
  );
}

Color getValueColor(double value) {
  if (value < 0) return redLight;
  if (value > 0) return green;
  return black;
}

Color getValueColorFundHouse(double value) {
  if (value == 0 || value == 1) {
    return redLight;
  }
  return black;
}

showToast(String? message) {
  try {
    return
      Fluttertoast.showToast(
          msg: message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 15
      );

  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}

Future<String> convertImageToBase64(String imagePath) async {
  File imageFile = File(imagePath);

  List<int> imageBytes = await imageFile.readAsBytes();

  String base64Image = base64Encode(imageBytes);

  return base64Image;
}

Widget getBottomSheetHeaderWithoutButton(BuildContext context,String title){
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 2,
          width: 50,
          alignment: Alignment.center,
          color: textFieldBorder,
          margin: const EdgeInsets.only(top: 10, bottom: 8),
        ),
        Container(
          margin: const EdgeInsets.only(top: 12,bottom: 20),
          child: Text(title, style: const TextStyle(fontSize: 20, color: black, fontWeight: FontWeight.w600)),
        ),
      ],
    ),
  );
}

Column getBottomSheetItemWithoutSelection(String title,bool isSelected,bool isDividerVisible) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.only(left: 22, right: 22, top: 12, bottom: 12),
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            color: black,
            fontSize: 16,
          ),
        ),
      ),
      Container(
        height: 1,
        color: isDividerVisible ? Colors.transparent : borderGray,
      ),
    ],
  );
}