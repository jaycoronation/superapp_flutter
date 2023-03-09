import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:superapp/push_notification/PushNotificationService.dart';
import 'package:superapp/screen/common/home_page.dart';
import 'package:superapp/screen/common/login_screen.dart';
import 'package:superapp/utils/app_utils.dart';
import 'package:superapp/utils/session_manager.dart';
import 'package:superapp/utils/session_manager_methods.dart';
import 'constant/colors.dart';
import 'constant/global_context.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  //print("Handling a background message: ${message.data.toString()}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SessionManagerMethods.init();
  PaintingBinding.instance.imageCache.maximumSizeBytes = 1000 << 40; // for increase the cache memory
  await PushNotificationService().setupInteractedMessage();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null)
  {
    print("@@@@@@@@ Main Dart @@@@@@@@ ${initialMessage.data}");
    NavigationService.notif_type = initialMessage.data['content_type'];
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'AlphaCapital Super App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: createMaterialColor(white),
            platform: TargetPlatform.iOS,
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: white,
              contentPadding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kEditTextCornerRadius),
                  borderSide:  const BorderSide(width: 0.5, style: BorderStyle.solid, color: grayDark)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kEditTextCornerRadius),
                  borderSide: const BorderSide(width: 0.5, style: BorderStyle.solid, color: grayDark)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kEditTextCornerRadius),
                  borderSide: const BorderSide(width: 0.8, color: Colors.red)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kEditTextCornerRadius),
                  borderSide: const BorderSide(width:0.8, color: Colors.red)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kEditTextCornerRadius),
                  borderSide: const BorderSide(width:0.5, style: BorderStyle.solid, color: grayDark)),
              labelStyle: const TextStyle(
                color: grayDark,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              hintStyle: const TextStyle(  color: grayDark,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
            textTheme: GoogleFonts.sourceSansProTextTheme(Theme.of(context).textTheme)
        ),
        home: const MyHomePage(),
        navigatorKey: NavigationService.navigatorKey
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoggedIn = false ;
  SessionManager sessionManager = SessionManager();

  @override
  void initState() {
    super.initState();
    doSomeAsyncStuff();
  }

  Future<void> doSomeAsyncStuff() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      SessionManager sessionManager = SessionManager();
      isLoggedIn = sessionManager.checkIsLoggedIn() ?? false;
      if(isLoggedIn)
      {
        Timer(const Duration(seconds:1),
                () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
             const HomePage()), (Route<dynamic> route) => false));
      }
      else
      {
        Timer(
            const Duration(seconds:1),
                () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            const LoginScreen()), (Route<dynamic> route) => false));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: appBg,
      statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      statusBarBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: appBg,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Colors.transparent,
          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.light,
          // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            color: blue),
        child: const Center(
        ),
      ),
    );
  }
}
