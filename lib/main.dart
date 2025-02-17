import 'dart:async';
import 'package:cron/cron.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:superapp_flutter/screen/common/HomePageForWeb.dart';
import 'package:superapp_flutter/screen/common/LoginScreen.dart';
import 'package:superapp_flutter/screen/common/home_page.dart';
import 'package:superapp_flutter/screen/common/login_screen.dart';
import 'package:superapp_flutter/service/JobService.dart';
import 'package:superapp_flutter/service/UpdateData.dart';
import 'package:superapp_flutter/utils/app_utils.dart';
import 'package:superapp_flutter/utils/session_manager.dart';
import 'package:superapp_flutter/utils/session_manager_methods.dart';
import 'package:superapp_flutter/utils/session_manager_pms.dart';
import 'constant/colors.dart';
import 'constant/global_context.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCIO9zXDh3SQSbD7sZ-4vyd9dUZmnk2Zac",
      appId: "1:204998889984:android:31c7b55cb70ea81d0d7ee5",
      messagingSenderId: "204998889984",
      projectId: "alpha-capital-super-app", ),
  );
  //print("Handling a background message: ${message.data.toString()}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb)
  {

  }
  else
  {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  await SessionManagerMethods.init();
  PaintingBinding.instance.imageCache.maximumSizeBytes = 1000 << 40; // for increase the cache memory

  const fatalError = true;
  // Non-async exceptions
 /* FlutterError.onError = (errorDetails) {
    if (fatalError) {
      // If you want to record a "fatal" exception
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      // ignore: dead_code
    } else {
      // If you want to record a "non-fatal" exception
      FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    }
  };*/
  // Async exceptions
  PlatformDispatcher.instance.onError = (error, stack) {
    if (fatalError) {
      // If you want to record a "fatal" exception
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      // ignore: dead_code
    } else {
      // If you want to record a "non-fatal" exception
      FirebaseCrashlytics.instance.recordError(error, stack);
    }
    return true;
  };
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((value) => runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => UpdateData()),
          ],
          child: const MyApp(),
        )
    )
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FlutterWebFrame(
      backgroundColor: chart_color11,
      builder: (context) {
        return MaterialApp(
            title: 'AlphaCapital Super App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: false,
                primarySwatch: createMaterialColor(white),
                platform: TargetPlatform.iOS,
                inputDecorationTheme: InputDecorationTheme(
                  filled: true,
                  fillColor: lightBlue,
                  contentPadding: const EdgeInsets.only(left: 12, right: 12, top: 18, bottom: 18),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kEditTextCornerRadius),
                      borderSide:  const BorderSide(width: 0, style: BorderStyle.solid, color: lightBlue)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kEditTextCornerRadius),
                      borderSide: const BorderSide(width: 0, style: BorderStyle.solid, color: lightBlue)
                  ),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kEditTextCornerRadius),
                      borderSide: const BorderSide(width: 0, color: Colors.red)
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kEditTextCornerRadius),
                      borderSide: const BorderSide(width:0, color: Colors.red)
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kEditTextCornerRadius),
                      borderSide: const BorderSide(width:0, style: BorderStyle.solid, color: lightBlue)
                  ),
                  labelStyle: const TextStyle(
                    color: black, fontSize: 15, fontWeight: FontWeight.w500,
                  ),
                  hintStyle: const TextStyle(
                      color: grayDark, fontSize: 15, fontWeight: FontWeight.w500
                  ),
                ),
              // textTheme: GoogleFonts.sourceSansProTextTheme(Theme.of(context).textTheme)
              fontFamily: 'Switzer',
            ),
            home: const MyHomePage(),
          );
      },
      maximumSize: const Size(1160.0, 812.0),
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
  SessionManagerPMS sessionManagerPMS = SessionManagerPMS();
  
  final cron = Cron();

  @override
  void initState() {
    super.initState();
    doSomeAsyncStuff();
  }

  Future<void> doSomeAsyncStuff() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      isLoggedIn = sessionManager.checkIsLoggedIn() ?? false;
      if(isLoggedIn)
      {
        JobService().getCommonXirr();

        String dateTimeString = sessionManagerPMS.getLastSyncDate();
        DateTime parsedDateTime = dateTimeString.isNotEmpty ? DateTime.parse(dateTimeString) : DateTime.now().subtract(Duration(hours: 3));

        print("dateTimeString ==== $dateTimeString");
        print("isTwoHoursPassed ==== ${isTwoHoursPassed(parsedDateTime)}");
        if (isTwoHoursPassed(parsedDateTime))
        {
          JobService().getLatestDataFromMint();
        }

        Timer(const Duration(seconds:1),
                () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
             kIsWeb ? const HomePage() : const HomePage()), (Route<dynamic> route) => false));
      }
      else
      {
        Timer(
            const Duration(seconds:1),
                () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            const LoginScreenNew()), (Route<dynamic> route) => false));
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
