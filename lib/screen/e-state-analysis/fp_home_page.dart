import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/screen/e-state-analysis/e_state_insurance_and_will_screen.dart';
import 'package:superapp_flutter/screen/e-state-analysis/rm_fp_add_lead_screen.dart';
import 'package:superapp_flutter/utils/base_class.dart';

import '../../common_widget/common_widget.dart';
import '../../constant/analysis_api_end_point.dart';
import '../../constant/colors.dart';
import '../../model/e-state-analysis/RMFpUserLeadResponseModel.dart';
import '../../model/e-state-analysis/RmFpUserListResponseModel.dart';
import '../../utils/app_utils.dart';
import 'e_state_aspiration_page.dart';
import 'e_state_existing_assets_page.dart';
import 'e_state_existing_liabilities_page.dart';
import 'e_state_future_inflow_page.dart';
import 'e_state_risk_profile_screen_new.dart';
import 'e_state_summary_screen.dart';

class FpHomePage extends StatefulWidget {
  const FpHomePage({super.key});

  @override
  BaseState<FpHomePage> createState() => _FpHomePageState();
}

class _FpHomePageState extends BaseState<FpHomePage> {

  bool isLoading = false;
  bool isLoadingReport = false;

  List<Widget> _pages = [];
  final List<BottomNavigationBarItem> itemsList = [];
  late int _currentIndex = 0;
  late TabController tabController;

  UserLeadData directUserInfo = UserLeadData();
  List<ChildModel> listChildData = [];

  @override
  void initState() {
    super.initState();
    fetchDirectUserDetail();
    _currentIndex = 0;

    _pages = [
      const EStateSummaryScreen(),
      const EStateAspirationPage(),
      const EStateExistingAssetsPage()
    ];

    itemsList.add(
        BottomNavigationBarItem(
          icon: Image.asset("assets/images/ic_summary.png", width: 24, height: 24, color: divider_color, fit: BoxFit.fill,),
          activeIcon: Image.asset("assets/images/ic_summary.png", width: 24, height: 24, color: blue, fit: BoxFit.fill,),
          label: 'Summary',
        )
    );

    itemsList.add(BottomNavigationBarItem(
      icon: Image.asset("assets/images/ic_aspiration.png", width: 24, height: 24, color: divider_color, fit: BoxFit.fill,),
      activeIcon: Image.asset("assets/images/ic_aspiration.png", width: 24, height: 24, color: blue, fit: BoxFit.fill,),
      label: 'Aspirations',
    ));

    itemsList.add(BottomNavigationBarItem(
      icon: Image.asset("assets/images/ic_existing_asset.png", width: 24, height: 24, color: divider_color,),
      activeIcon: Image.asset("assets/images/ic_existing_asset.png", width: 24, height: 24, color: blue,),
      label: 'Existing Assets',
    ));

    itemsList.add(BottomNavigationBarItem(
      icon: Image.asset("assets/images/ic_more_unselected.png", width: 24, height: 24),
      activeIcon: Image.asset("assets/images/ic_more_selected.png", width: 24, height: 24),
      label: 'More',
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBg,
      appBar: AppBar(
          toolbarHeight: _currentIndex == 2 ? 60 : 60,
          automaticallyImplyLeading: false,
          backgroundColor: appBg,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              if (_currentIndex == 0)
              {

                if(sessionManager.getUserType() == "client")
                {
                  Navigator.pop(context);
                }
                else
                {
                  sessionManagerPMS.createLoginSession('', '', '', '', '');
                  Navigator.pop(context);
                }
              }
              else
              {
                final BottomNavigationBar bar = bottomWidgetKey.currentWidget as BottomNavigationBar;
                bar.onTap!(0);
              }
            },
            child: getBackArrow(),
          ),
          centerTitle: true,
          titleSpacing: 0,
          title: getTitle(
            _currentIndex == 0
                ? "Summary"
                : _currentIndex == 1
                ? "Aspirations"
                : "Existing Assets",
          ),
          actions: [
            GestureDetector(
              onTap: () {
                final bytes = utf8.encode(sessionManager.getUserId().toString().trim());
                final base64Str = base64.encode(bytes);
                print("Display base 64 :$base64Str");

                var _url = API_URL_ANALYSIS + generateFinalReport + base64Str;
                handleDownload(context, _url);
                //_getDownloadDirectory(context,_url);
              },
              child: Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(right: 5),
                padding: const EdgeInsets.all(3),
                width: 32,
                height:  32,
                child: Image.asset('assets/images/vault_ic_share_pdf.png', width: 32, height: 32, color: blue),
              ),
            ),
          ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(directUserInfo.userId == "" ? 0 : 40),
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: white,
                                  border: Border.all(color: borderGray)
                              ),
                              child: Text(
                                "${sessionManager.getUserType() == "client" ? "Name" : "Client"}: ${directUserInfo.firstName ?? "-"}",
                                style: getMediumTextStyle(fontSize: 12, color: blackLight),
                              ),
                            ),
                            Visibility(
                              visible: directUserInfo.spouseName?.isNotEmpty ?? false,
                              child: Container(
                                margin: const EdgeInsets.only(left: 4),
                                padding: const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: white,
                                    border: Border.all(color: borderGray)
                                ),
                                child: Text(
                                  "Spouse: ${directUserInfo.spouseName ?? "-"} (${directUserInfo.spouseAge ?? "0"})",
                                  style: getMediumTextStyle(fontSize: 12, color: blackLight),
                                ),
                              ),
                            ),

                            if (listChildData.isNotEmpty)
                              ...listChildData.asMap().entries.map((entry) {
                                int index = entry.key;
                                ChildModel child = entry.value;

                                return Container(
                                  margin: const EdgeInsets.only(left: 4),
                                  padding: const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: white,
                                      border: Border.all(color: borderGray)
                                  ),
                                  child: Text(
                                    "Child ${index + 1}: ${child.childNameController.text} (${child.childAgeController.text})",
                                    style: getMediumTextStyle(fontSize: 12, color: blackLight),
                                  ),
                                );
                              }),
                          ],
                        ),
                      ),
                    ),
                    const Gap(10),
                    Visibility(
                      visible: sessionManager.getUserType() == "client",
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () async{
                          final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => RmFpAddLeadScreen(directUserInfo, true, RmFpAllEmployees())),);
                          print("result ===== $result");
                          if (result == "success")
                          {
                            setState(() {
                              fetchDirectUserDetail();
                            });
                          }
                        },
                        child: Text(
                          "Update Family Info",
                          style: getMediumTextStyle(fontSize: 12, color: graySemiDark),
                        ),
                      ),
                    )
                  ],
                ),
                const Gap(10),
              ],
            ),
          )
        ),
      ),
      body: Column(
        children: [
          Visibility(visible: isLoadingReport, child: LinearProgressIndicator(color: blue,backgroundColor: blue.withOpacity(0.3),)),
          Expanded(
            child: IndexedStack(
              index: _currentIndex,
              alignment: Alignment.center,
              sizing: StackFit.expand,
              children: _pages,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 15,
        key: bottomWidgetKey,
        items: itemsList,
        backgroundColor: white,
        selectedItemColor: black,
        selectedLabelStyle: const TextStyle(color: black, fontSize: 13, height: 1.5, fontWeight: FontWeight.w400),
        unselectedLabelStyle: const TextStyle(color: black, fontSize: 13, height: 1.5, fontWeight: FontWeight.w400),
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (value) {
          _onItemTapped(context, value);
        },
      ),
    );
  }

  void _onItemTapped(BuildContext context, int value) {
    if (value == 3)
    {
      openDocumentShareSheet(context);
    }
    else
    {
      setState(() {
        _currentIndex = value;
      });
    }
  }

  void openDocumentShareSheet(BuildContext context,) {
    showModalBottomSheet(
        constraints: const BoxConstraints(maxWidth: 600,),
        isScrollControlled: true,
        backgroundColor: white,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        context: context,
        builder: (ctx) {
          return StatefulBuilder(builder: (BuildContext ctx, StateSetter setStateNew) {
            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 25),
              child: Wrap(
                children: <Widget>[
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const EStateExistingLiabilitiesPage()),);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Image.asset('assets/images/ic_existing_libaliti.png', width: 24, height: 24,color: blue),
                                Container(width: 12),
                                const Text(
                                  "Existing Liabilities",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(fontSize: 18, color: blue, fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                        const Gap(12),
                        const Divider(
                          height: 0.5,
                          thickness: 0.5,
                          color: divider_color,
                        ),
                        const Gap(12),
                        InkWell(
                          onTap: (){
                            Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const EStateFutureInflowPage(true)));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Image.asset('assets/images/portfolio_ic_bs_movement.png', width: 24, height: 24,color: blue),
                                Container(width: 12),
                                const Text(
                                  "Future Inflow",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(fontSize: 18, color: blue, fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                        const Gap(12),
                        const Divider(
                          height: 0.5,
                          thickness: 0.5,
                          color: divider_color,
                        ),
                        const Gap(12),
                        InkWell(
                          onTap: (){
                            Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const EStateRiskProfileScreenNew()));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Image.asset('assets/images/portfolio_ic_transaction.png', width: 24, height: 24,color: blue),
                                Container(width: 12),
                                const Text(
                                  "Risk Profile",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(fontSize: 18, color: blue, fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                        const Gap(12),
                        const Divider(
                          height: 0.5,
                          thickness: 0.5,
                          color: divider_color,
                        ),
                        const Gap(12),
                        InkWell(
                          onTap: (){
                            Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const EStateInsuranceAndWillScreen()));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Image.asset('assets/images/vault_ic_instruction.png', width: 24, height: 24,color: blue),
                                Container(width: 12),
                                const Text(
                                  "Insurance & Will",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(fontSize: 18, color: blue, fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                        const Gap(12),
                        const Divider(
                          height: 0.5,
                          thickness: 0.5,
                          color: divider_color,
                        ),
                        Image.asset('assets/images/portfolio_icon_logo_header_blue.png',fit: BoxFit.contain,color: blue, width: 250,height: 100,),
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
        }
    );
  }

  Future<void> handleDownload(BuildContext context, String url) async {
    int version = await getAndroidVersion();

    print("Android Version: $version");

    if (version <= 32)
    {
      // Android 12 and below
      await downloadAndOpenFile(context, url);
    }
    else
    {
      // Android 13+
      await _getDownloadDirectory(context, url);
    }
  }

  Future<int> getAndroidVersion() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      return androidInfo.version.sdkInt;
    }
    return 0;
  }

    Future<void> downloadAndOpenFile(BuildContext context, String fileUrl) async {
      print("Display url :$fileUrl");
      setState(() {
        isLoadingReport = true;
      });

      try {
        // Get safe directory (works on ALL Android versions)
        final directory = await getExternalStorageDirectory();
        final fileName = "${sessionManagerPMS.getFirstName()}_${sessionManagerPMS.getLastName()}_${DateTime.now().millisecondsSinceEpoch}.pdf";
        final filePath = "${directory!.path}/$fileName";
        final file = File(filePath);

        // Request permission (for Android < 13 mostly)
        if (Platform.isAndroid)
        {
          var status = await Permission.storage.request();
          if (!status.isGranted)
          {
            print("Permission denied");
            return;
          }
        }

        // Download file
        final request = await HttpClient().getUrl(Uri.parse(fileUrl));
        final response = await request.close();
        await response.pipe(file.openWrite());
        print("File saved at: $filePath");

        // Open file
        final result = await OpenFile.open(filePath);

        print("Open result: ${result.message}");

      }
      catch (e)
      {
        print("Download error: $e");
      }

      setState(() {
        isLoadingReport = false;
      });
    }

  Future<String> _getDownloadDirectory(BuildContext context, String fileUrlServer) async {
    String? directory;
    try {

      if (Platform.isIOS)
      {
        var pathMain = await getApplicationDocumentsDirectory();
        directory = pathMain.path;
      }
      else
      {
        directory = await FilePicker.platform.getDirectoryPath();
      }

      _downloadFile(directory ?? '',fileUrlServer);
    } catch (e) {
      print("Error while picking directory: $e");
    }

    if (directory == null)
    {
      showSnackBar("No directory selected!", context);
      return "";
    }
    return directory;
  }

  Future<void> _downloadFile(String downloadPath, String fileUrlServer) async {

    setState(() {
      isLoadingReport = true;
    });

    // Example using `http` package
    String fileUrl = fileUrlServer;
    String fileName = '${sessionManagerPMS.getFirstName()}_${sessionManagerPMS.getLastName()}_${DateTime.now().millisecondsSinceEpoch / 1000}.pdf';

    if (Platform.isIOS)
    {
      var permissionStatus = await Permission.storage.status;
      if (permissionStatus.isDenied)
      {
        await Permission.storage.request();
      }
    }

    HttpClient().getUrl(Uri.parse(fileUrl)).then((HttpClientRequest request) {
      return request.close(); // Return the result of request.close()
    })
      .catchError((error, stackTrace) {
      print("error === ${error}");
      print("stackTrace === ${stackTrace}");
      return error;
    },)
        .then((HttpClientResponse response) async {
      File file = File('$downloadPath/$fileName');

      await response.pipe(file.openWrite(mode: FileMode.write))
          .catchError((error, stackTrace) {
        print("error === ${error}");
        print("stackTrace === ${stackTrace}");
      },);

      print('File Path ==== ${file.path}');

      if (Platform.isAndroid)
      {
        final result = await OpenFile.open(file.path);
        setState(() {
          var openResult = "type=${result.type}  message=${result.message}";
          print("openResult === $openResult");
        });
        //Navigator.pop(context);
      }
      else
      {
        final result = await OpenFile.open(file.path);
        var openResult = "type=${result.type}  message=${result.message}";
        print("openResult === $openResult");
      }

      setState(() {
        isLoadingReport = false;
      });


    });
  }

  fetchDirectUserDetail() async {
    if(isOnline)
    {
      setState(() {
        isLoading = true;
      });

      try
      {
        HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
          HttpLogger(logLevel: LogLevel.BODY),
        ]);

        final url = Uri.parse(API_URL_ANALYSIS + fPUserLeadAPI);
        Map<String, String> jsonBody = {
          "user_id": sessionManager.getUserId(),
          "is_from_superapp": "1",
        };
        final response = await http.post(url, body: jsonBody);
        final statusCode = response.statusCode;
        final body = response.body;
        Map<String, dynamic> user = jsonDecode(body);
        var dataResponse = RmFpUserLeadResponseModel.fromJson(user);

        if(statusCode == 200 && dataResponse.success == 1)
        {
          if(dataResponse.userLeadData?.isNotEmpty ?? false)
          {
            directUserInfo = dataResponse.userLeadData?[0] ?? UserLeadData();
            if ((directUserInfo.childDetails ?? "").isNotEmpty) {
              List<dynamic> decodedList = jsonDecode(directUserInfo.childDetails!);
              listChildData.clear();
              for (var item in decodedList) {
                String name = (item["name"] ?? "").toString().trim();
                String age = (item["age"] ?? "").toString().trim();

                if (name.isNotEmpty)
                {
                  listChildData.add(
                    ChildModel(
                      childName: name,
                      childAge: age,
                    ),
                  );
                }
              }
            }
          }
        }

      }
      catch(e)
      {
        print("Failed to fetch user lead list : $e");
      }
      finally
      {
        setState(() {
          isLoading = false;
        });
      }
    }
    else
    {
      noInterNet(context);
    }
  }

  @override
  void castStatefulWidget() {
    widget as FpHomePage;
  }
}
