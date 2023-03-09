import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import '../../../constant/colors.dart';
import '../../../utils/base_class.dart';
import '../../model/e-state-vault/header_model.dart';
import '../../model/e-state-vault/menu_model.dart';
import '../../widget/loading.dart';

class EStateVaultHomePage extends StatefulWidget {
  const EStateVaultHomePage({Key? key}) : super(key: key);

  @override
  _EStateVaultHomePageState createState() => _EStateVaultHomePageState();
}

class _EStateVaultHomePageState extends BaseState<EStateVaultHomePage> {
  final bool _isLoading = false;
  List<HeaderGetSet> menuList = List<HeaderGetSet>.empty(growable: true);
  List<MenuGetSet> directions = List<MenuGetSet>.empty(growable: true);
  List<MenuGetSet> assets = List<MenuGetSet>.empty(growable: true);
  List<MenuGetSet> debt = List<MenuGetSet>.empty(growable: true);

  @override
  void initState() {
    super.initState();
    HeaderGetSet headerGetSet = HeaderGetSet();
    headerGetSet.setName = "General Information";
    List<MenuGetSet> temp1 = List<MenuGetSet>.empty(growable: true);
    temp1 = [
      MenuGetSet(
          idStatic : 1,
          nameStatic: "Constitution And Values",
          itemIconStatic: "assets/images/vault_ic_account_holder.png"),
      MenuGetSet(
          idStatic : 2,
          nameStatic: "Death Notifications",
          itemIconStatic: "assets/images/vault_ic_death_notification.png"),
      MenuGetSet(
          idStatic : 3,
          nameStatic: "Advisors",
          itemIconStatic: "assets/images/vault_ic_advisor.png"),
      MenuGetSet(
          idStatic : 4,
          nameStatic: "Keys to Residence",
          itemIconStatic: "assets/images/vault_ic_key_to_residences.png"),
      MenuGetSet(
          idStatic : 5,
          nameStatic: "Safe Deposit Boxes",
          itemIconStatic: "assets/images/vault_ic_safe_deposit_box.png"),
      MenuGetSet(
          idStatic : 6,
          nameStatic: "Important Documents",
          itemIconStatic: "assets/images/vault_ic_important_documents.png")
    ];
    headerGetSet.setList = temp1;
    menuList.add(headerGetSet);

    HeaderGetSet headerGetSet1 = HeaderGetSet();
    headerGetSet1.setName = "Directions and Instructions";
    List<MenuGetSet> temp2 = List<MenuGetSet>.empty(growable: true);
    temp2 = [
      MenuGetSet(
          idStatic : 7,
          nameStatic: "Medical & Funeral",
          itemIconStatic: "assets/images/vault_ic_generally.png"),
      MenuGetSet(
          idStatic : 8,
          nameStatic: "Dependent Children",
          itemIconStatic: "assets/images/vault_ic_dependant.png"),
      MenuGetSet(
          idStatic : 9,
          nameStatic: "Will",
          itemIconStatic: "assets/images/vault_ic_will.png"),
      MenuGetSet(
          idStatic : 10,
          nameStatic: "Business(es)",
          itemIconStatic: "assets/images/vault_ic_business.png"),
      MenuGetSet(
          idStatic : 11,
          nameStatic: "Domestic Employees",
          itemIconStatic: "assets/images/vault_ic_domestic_employee.png")
    ];
    headerGetSet1.setList = temp1;
    menuList.add(headerGetSet1);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
        return Future.value(true);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: appBg,
        appBar: AppBar(
            toolbarHeight: 60,
            automaticallyImplyLeading: false,
            backgroundColor: appBg,
            elevation: 0,
            centerTitle: false,
            title: Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(right: 8),
                    child: Image.asset('assets/images/ic_profile.png', width: 40, height: 40),
                  ),
                ),
                Expanded(
                    child: Text(
                  "Hi,${sessionManagerPMS.getFristName()} ${sessionManagerPMS.getLastName()}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18, color: blue, fontWeight: FontWeight.w600),
                )),
              ],
            )),
        body: SafeArea(
          top: false,
          child: _isLoading
              ? LoadingWidget()
              : Column(
                  children: [
                    Expanded(
                        child: Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: dashboardBg, borderRadius: BorderRadius.only(topLeft: Radius.circular(22), topRight: Radius.circular(22))),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            EStateVaultHomePageBlocks(),
                            Container(
                              alignment: Alignment.center,
                              child: Image.asset('assets/images/ic_login_logo.png', width: 200, height: 80, color: blue),
                            ),
                          ],
                        ),
                      ),
                    ))
                  ],
                ),
        ),
      ),
    );
  }

  Expanded EStateVaultHomePageBlocks() {
    return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Gap(10),
            Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: const BoxDecoration(color: white, borderRadius: BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/ic_portfolio.png', width: 40, height: 40),
                              const Spacer(),
                              const Text(
                                "Alpha Portfolio",
                                maxLines: 2,
                                style: TextStyle(color: black, fontSize: 18, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        )),
                    const Gap(15),
                    Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(left: 15, bottom: 15, top: 15, right: 2),
                          decoration: const BoxDecoration(color: white, borderRadius: BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/ic_consolidated.png', width: 40, height: 40),
                              const Spacer(),
                              const Text(
                                "Consolidated Portfolio",
                                maxLines: 2,
                                style: TextStyle(color: black, fontSize: 18, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ))
                  ],
                )),
            const Gap(15),
            Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: const BoxDecoration(color: white, borderRadius: BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/ic_estate_a.png', width: 40, height: 40),
                              const Spacer(),
                              const Text(
                                "Estate Analysis",
                                maxLines: 2,
                                style: TextStyle(color: black, fontSize: 18, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        )),
                    const Gap(15),
                    Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: const BoxDecoration(color: white, borderRadius: BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/ic_vault.png', width: 40, height: 40),
                              const Spacer(),
                              const Text(
                                "Estate Vault",
                                maxLines: 2,
                                style: TextStyle(color: black, fontSize: 18, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ))
                  ],
                )),
            const Gap(15),
            Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: const BoxDecoration(color: white, borderRadius: BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/ic_meeting.png', width: 40, height: 40),
                              const Spacer(),
                              const Text(
                                "Fix Meeting",
                                maxLines: 2,
                                style: TextStyle(color: black, fontSize: 18, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        )),
                    const Gap(15),
                    Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: const BoxDecoration(color: white, borderRadius: BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/ic_contact.png', width: 40, height: 40),
                              const Spacer(),
                              const Text(
                                "Contact",
                                maxLines: 2,
                                style: TextStyle(color: black, fontSize: 18, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ))
                  ],
                )),
            const Gap(15),
            Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: const BoxDecoration(color: white, borderRadius: BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/ic_blog.png', width: 40, height: 40),
                              const Spacer(),
                              const Text(
                                "Blogs",
                                maxLines: 2,
                                style: TextStyle(color: black, fontSize: 18, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        )),
                    const Gap(15),
                    Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: const BoxDecoration(color: white, borderRadius: BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/ic_videos.png', width: 40, height: 40),
                              const Spacer(),
                              const Text(
                                "Videos",
                                maxLines: 2,
                                style: TextStyle(color: black, fontSize: 18, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ))
                  ],
                )),
            const Gap(15),
          ],
        ));
  }





  /*updateDeviceTokenData() async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL + updateDeviceToken);

    var deviceType = "";
    if (Platform.isIOS) {
      deviceType = "IOS";
    } else {
      deviceType = "Android";
    }

    Map<String, String> jsonBody = {
      'logged_in_master_user_id': sessionManager.getMasterUserId().toString(),
      'device_type': deviceType,
      'token_id': sessionManager.getDeviceToken().toString().trim()
    };

    final response = await http.post(url, body: jsonBody, headers: {
      "Authorization": sessionManager.getAuthToken().toString().trim(),
    });

    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> apiResponse = jsonDecode(body);
    var dataResponse = CommanResponse.fromJson(apiResponse);
    if (statusCode == 200 && dataResponse.success == 1) {
    } else {}
  }*/

  @override
  void castStatefulWidget() {
    widget is EStateVaultHomePage;
  }


}
