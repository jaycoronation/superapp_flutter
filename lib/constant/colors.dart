import 'dart:ui';
import 'package:flutter/material.dart';

var bottomWidgetKey = GlobalKey<State<BottomNavigationBar>>();

var keyHome = GlobalKey<ScaffoldState>();
double kEditTextCornerRadius = 10.0;
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
const Color lightBlue= Color(0xffedf1fb);
const Color semiBlue= Color(0xffE8EFFC);


const Color purple= Color(0xffB255E1);
const Color dashboardBg = Color(0xfff3f6fd);

const LinearGradient loginBgGradient = LinearGradient(
    begin: FractionalOffset.bottomCenter,
    end: FractionalOffset.topCenter,
    colors: [Color(0xffB255E1), Color(0xff8C8BDE),Color(0xff7BB5DF)]);




