import 'package:flutter/material.dart';
import '../constant/colors.dart';

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

