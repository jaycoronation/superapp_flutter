import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cron/cron.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:provider/provider.dart';
import 'package:superapp_flutter/constant/consolidate-portfolio/api_end_point.dart';
import 'package:superapp_flutter/screen/common/LoginScreen.dart';
import 'package:superapp_flutter/screen/common/home_page.dart';
import 'package:superapp_flutter/service/JobService.dart';
import 'package:superapp_flutter/service/UpdateData.dart';
import 'package:superapp_flutter/utils/app_utils.dart';
import 'package:superapp_flutter/utils/base_class.dart';
import 'package:superapp_flutter/utils/session_manager.dart';
import 'package:superapp_flutter/utils/session_manager_methods.dart';
import 'package:superapp_flutter/utils/session_manager_pms.dart';
import 'package:superapp_flutter/widget/no_internet.dart';
import 'package:url_launcher/url_launcher.dart';
import 'constant/colors.dart';
import 'firebase_options.dart';
import 'model/GetAppVersionRepsponseModel.dart';
import 'utils/AuthService.dart';

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
  String isForceUpdate = '0';
  final cron = Cron();

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    getVersionFromLocal();
    initConnectivity();
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) async {
      await _updateConnectionStatus().then((bool isConnected) => setState(() {
        isOnline = isConnected;
        if (isOnline)
          {
            getAppVersion();
          }
      }));
    });
  }


  Future<void> getVersionFromLocal() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }

  getAppVersion() async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_CP + appVersionUrl);


    final response = await http.get(url);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> apiResponse = jsonDecode(body);
    var dataResponse = GetAppVersionRepsponseModel.fromJson(apiResponse);
    if (statusCode == 200 && dataResponse.success == 1) {
      var verApp = int.parse(_packageInfo.version.toString().replaceAll(".", ''));
      if (Platform.isAndroid)
        {
          var verLive = int.parse(dataResponse.android?.version.toString().replaceAll(".", '') ?? '0');
          print(verLive);
          print("APP verApp == $verApp");
          print("APP verLive == $verLive");
          print(verApp < verLive);
          isForceUpdate = dataResponse.android?.forceUpdate ?? '';
          if (verLive > verApp) {
            showVersionMismatchDialog(dataResponse.android?.version ?? '', _packageInfo.version ?? '');
          } else {
            doSomeAsyncStuff();
          }
        }
      else
        {
          var verLive = int.parse(dataResponse.ios?.version.toString().replaceAll(".", '') ?? '0');
          print(verLive);
          print("APP verApp == $verApp");
          print("APP verLive == $verLive");
          print(verApp < verLive);
          isForceUpdate = dataResponse.ios?.forceUpdate ?? '';
          if (verLive > verApp) {
            showVersionMismatchDialog(dataResponse.ios?.version ?? '', _packageInfo.version ?? '');
          } else {
            doSomeAsyncStuff();
          }
        }

    } else {
      doSomeAsyncStuff();
    }
  }

  void showVersionMismatchDialog(String verLive, String verApp) {
    var titleText = "Upgrade";
    var messageText = "A new version of Alpha Capital is ready for installation. Please upgrade from $verApp to $verLive to continue.";
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Text(titleText, style: const TextStyle(color: black, fontWeight: FontWeight.w500, fontSize: 16)),
        content: Text(messageText, style: const TextStyle(color: black, fontWeight: FontWeight.w400, fontSize: 14)),
        actions: <Widget>[
          Visibility(
            visible: isForceUpdate != 1,
            child: TextButton(
                onPressed: () {
                  doSomeAsyncStuff();
                  Navigator.pop(context);
                },
                child: const Text(
                  "Skip",
                  style: TextStyle(color: black, fontSize: 16, fontWeight: FontWeight.w600),
                )),
          ),
          TextButton(
              onPressed: () async {
                String appPackageName = _packageInfo.packageName; // getPackageName() from Context or Activity object
                try {
                  if (Platform.isIOS) {
                    if (await canLaunchUrl(Uri.parse("https://apps.apple.com/us/app/alpha-capital/id1075956827"))) {
                      launchUrl(Uri.parse("https://apps.apple.com/us/app/alpha-capital/id1075956827"), mode: LaunchMode.externalApplication);
                    }
                  } else {
                    if (await canLaunchUrl(Uri.parse("https://play.google.com/store/apps/details?id=$appPackageName"))) {
                      launchUrl(Uri.parse("https://play.google.com/store/apps/details?id=$appPackageName"), mode: LaunchMode.externalApplication);
                    }
                  }
                } catch (anfe) {
                  if (await canLaunchUrl(Uri.parse("https://play.google.com/store/apps/details?id=$appPackageName"))) {
                    launchUrl(Uri.parse("https://play.google.com/store/apps/details?id=$appPackageName"));
                  }
                }
              },
              child: const Text(
                "Upgrade",
                style: TextStyle(color: black, fontSize: 16, fontWeight: FontWeight.w600),
              ))
        ],
      ),
    );
  }

  Future<void> doSomeAsyncStuff() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      isLoggedIn = sessionManager.checkIsLoggedIn() ?? false;
      if(isLoggedIn)
      {
        getAuthCheck();
      }
      else
      {
        Timer(
            const Duration(milliseconds:1),
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
    return Scaffold(
      backgroundColor: isOnline ? blue : Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
        elevation: 0,

      ),
      body: isOnline
          ? Container(
            decoration: const BoxDecoration(color: blue),
            child: const Center(),
          )
          : NoInternetWidget(() {
            if (isOnline) {
              getAppVersion();
            }else {
              noInterNet(context);
            }
          },),
    );
  }

  @override
  void castStatefulWidget() {
    widget is MyHomePage;
  }

  bool isOnline = true;
  /// initialize connectivity checking
  /// Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return;
    }

    await _updateConnectionStatus().then((bool isConnected) => setState(() {
      isOnline = isConnected;
    }));
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  Future<bool> _updateConnectionStatus() async {
    bool isConnected = false;
    try {
      final List<InternetAddress> result =
      await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      }
    } on SocketException catch (_) {
      isConnected = false;
      return false;
    }
    return isConnected;
  }

  Future<void> getAuthCheck() async {
    bool isAuthenticated = await AuthService.authenticateUser();
    print("Display is authenticated : $isAuthenticated");
    if (isAuthenticated)
    {
      if (sessionManager.getUserType() == "client")
      {
        JobService().getCommonXirr();
      }

      String dateTimeString = sessionManagerPMS.getLastSyncDate();
      DateTime parsedDateTime = dateTimeString.isNotEmpty ? DateTime.parse(dateTimeString) : DateTime.now().subtract(Duration(hours: 3));

      print("dateTimeString ==== $dateTimeString");
      print("isTwoHoursPassed ==== ${isTwoHoursPassed(parsedDateTime)}");
      if (isTwoHoursPassed(parsedDateTime) && sessionManager.getUserType() == "client")
      {
        JobService().getLatestDataFromMint();
      }

      Timer(const Duration(milliseconds:1),
              () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const HomePage()), (Route<dynamic> route) => false));
    }
    else
    {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Authentication failed.'),
        ),
      );
    }

  }
}
