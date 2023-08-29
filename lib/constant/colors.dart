import 'dart:ui';
import 'package:flutter/material.dart';

var bottomWidgetKey = GlobalKey<State<BottomNavigationBar>>();

var keyHome = GlobalKey<ScaffoldState>();
double kEditTextCornerRadius = 15.0;
double kBorderRadius = 6.0;
double kButtonCornerRadius = 8.0;
double kButtonHeight = 42;
double kDropDownHeight = 32;
bool isHomeReload = false;
bool isGalleryReload = false;
bool isVideoReload = false;
bool isBlogReload = false;
bool isNewsReload = false;

const Color appBg= Color(0xffffffff);
const Color black= Color(0xff000000);
const Color white= Color(0xffffffff);
const Color gray = Color(0xffD3DADC);
const Color grayLight= Color(0xffe0e0e0);
const Color graySemiDark= Color(0xff9F9F9F);
const Color grayDark= Color(0xff72716d);
const Color blue= Color(0xff2042FE);
const Color divider_color = Color(0xffbec7ff);
const Color lightBlue= Color(0xffedf1fb);
const Color semiBlue= Color(0xffE8EFFC);


const Color purple= Color(0xffB255E1);
const Color dashboardBg = Color(0xfff3f6fd);

const Color chart_color1= Color(0xff74ABE2);
const Color chart_color2= Color(0xffEF8D5D);
const Color chart_color3= Color(0xff3FB68E);
const Color chart_color4= Color(0xffF06A93);
const Color chart_color5= Color(0xffA97DD8);
const Color chart_color6= Color(0xffBF399E);
const Color chart_color7= Color(0xff6973F6);
const Color chart_color8= Color(0xff3AB5C2);
const Color chart_color9= Color(0xff6C8893);
const Color chart_color10= Color(0xffF38787);
const Color chart_color11= Color(0xfff1f3f4);
const Color chart_color12= Color(0xfff1f3f4);
const Color listActionColor = Color(0xff3366ff);
const Color lightGrey = Color(0xffacbecc);

const LinearGradient loginBgGradient = LinearGradient(
    begin: FractionalOffset.bottomCenter,
    end: FractionalOffset.topCenter,
    colors: [Color(0xffB255E1), Color(0xff8C8BDE),Color(0xff7BB5DF)]);




