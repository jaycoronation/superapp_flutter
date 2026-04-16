import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../constant/colors.dart';
import '../utils/app_utils.dart';

Widget getBackArrow({Color colorData = black}){
  return Container(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Image.asset('assets/images/ic_back_arrow.png', width: 32, height: 32, color: colorData,),
    ),
  );
}

Widget getTitle(String title){
  return Text(
    title,
    textAlign: TextAlign.start,
    style: const TextStyle(fontSize: 18, color: blue, fontWeight: FontWeight.w600),
  );
}

TextStyle getRegularTextStyle({Color color = black, double fontSize = 14}){
  return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w400
  );
}

TextStyle getMediumTextStyle({Color color = black, double fontSize = 14}){
  return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w500
  );
}

TextStyle getSemiBoldTextStyle({Color color = black, double fontSize = 14}){
  return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w600
  );
}

TextStyle getBoldTextStyle({Color color = black, double fontSize = 14}){
  return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w700
  );
}

Widget getBottomSheetHeaderWithoutButton2(BuildContext context, String title, {Color titleColor = blue}) {
  return Container(
    margin: EdgeInsets.only(top: 4),
    width: MediaQuery.of(context).size.width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 2,
          width: 50,
          alignment: Alignment.center,
          color: graySemiDark,
          margin: const EdgeInsets.only(bottom: 4),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4, bottom: 16),
          child: Text(title, style: TextStyle(fontSize: 18, color: titleColor, fontWeight: FontWeight.w600)),
        ),
      ],
    ),
  );
}

Widget rowCell(int index, String title, {Color titleColor = blackLight, double width = 160, Alignment alignment = Alignment.center, bool isPadding = false, bool isRow = false, String rowValue = "", bool isBold = false, int maxLine = 1, double radius = 14, bool isLastIndexLeft = false, bool isLastIndexRight = false}) {
  return Container(
    width: width,
    alignment: alignment,
    padding: isPadding ? EdgeInsets.only(left: 8, right: 8,top: 8,bottom: 8) : const EdgeInsets.only(left: 4, right: 4,top: 8,bottom: 8),
    decoration: BoxDecoration(
      color: white,
      border: Border(
        bottom: BorderSide(color: blue),
      ),
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(isLastIndexLeft ? radius : 0), bottomRight: Radius.circular(isLastIndexRight ? radius : 0))
    ),
    child: isRow ?
    Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(child: Text(title, style: isBold ? getBoldTextStyle(fontSize: 12, color: titleColor) : getMediumTextStyle(fontSize: 12, color: titleColor), maxLines: 1, overflow: TextOverflow.ellipsis,)),
        const Gap(2),
        Text(rowValue, style: getRegularTextStyle(fontSize: 10, color: titleColor),)
      ],
    ) :
    Text(title, style: isBold ? getBoldTextStyle(fontSize: 12, color: titleColor) : getMediumTextStyle(fontSize: 12, color: titleColor), maxLines: maxLine, overflow: TextOverflow.ellipsis,),
  );
}

Widget rowCellLoading(int index, {double width = 160,}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      shimmerWidget(
        Container(
          width: width,
          height: 40,
          decoration: BoxDecoration(
            color: white,
          ),
        ),
      ),
      Divider(color: grayLight, height: 1,)
    ],
  );
}

Widget rowCellTitle(String title, bgColor, {Color titleColor = black, double width = 160, Alignment alignment = Alignment.center, bool isPadding = false, double radius = 14}){
  return Container(
    width: width,
    height: 40,
    alignment: alignment,
    padding: const EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 8),
    decoration: BoxDecoration(
      color: bgColor,
      border: Border(
        bottom: BorderSide(color: blue),
      ),
      borderRadius: BorderRadius.only(topLeft: Radius.circular(radius), topRight: Radius.circular(radius))
    ),
    child: Text(title, style: getSemiBoldTextStyle(fontSize: 12, color: titleColor), textAlign: TextAlign.center,),
  );
}

Widget showLineDivider(){
  return VerticalDivider(color: blue, width: 1, thickness: 1,);
}

Widget getArrowDown({double iconPadding = 18, Color iconColor = grayDark}){
  return Padding(
    padding: EdgeInsets.all(iconPadding),
    child: Icon(Icons.keyboard_arrow_down, size: 16, color: iconColor,),
  );
}

Widget getArrowClose({double iconPadding = 18, Color iconColor = grayDark}){
  return Padding(
    padding: EdgeInsets.all(iconPadding),
    child: Icon(Icons.close, size: 16, color: iconColor,),
  );
}

Widget getDisplayFilterCategory(String title, List<String> listData){
  return Container(
    alignment: Alignment.center,
    margin: const EdgeInsets.only(right: 10),
    padding: const EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
    decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(12)
    ),
    child: Row(
      children: [
        Text(
          title,
          style: getMediumTextStyle(fontSize: 12, color: listData.isNotEmpty ? blue : grayDark),
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.start,
        ),
        const Gap(8),
        Icon(Icons.keyboard_arrow_down_outlined, size: 24, color: black),
      ],
    ),
  );
}
