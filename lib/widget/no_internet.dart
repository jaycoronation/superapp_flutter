import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../constant/colors.dart';

class NoInternetWidget extends StatelessWidget {

  const NoInternetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(60.0))),
                      elevation: 0,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 22.0, bottom: 22, left: 40, right: 40),
                        child: Image.asset("assets/images/ic-no-network-connection.png", width: 60,height: 60, color: black,),
                      )
                  ),
                  const Gap(6),
                  const Text("Oops!", style: TextStyle(color: black, fontSize: 20, fontWeight: FontWeight.bold,),),
                  const Gap(6),
                  const Text("No internet connection found,\nCheck your connection.",
                    style: TextStyle(color: black, fontSize: 18, fontWeight: FontWeight.w500,),
                    textAlign: TextAlign.center,),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20, left: 50, right: 50),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: blue,
                  onPrimary: blue,
                  elevation: 0.0,
                  padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                  side: const BorderSide(color: blue, width: 0.5, style: BorderStyle.solid),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kButtonCornerRadius)),
                  tapTargetSize: MaterialTapTargetSize.padded,
                  animationDuration: const Duration(milliseconds: 100),
                  enableFeedback: true,
                  alignment: Alignment.center,
                ),
                onPressed: () {
                  // tabNavigationReload();
                },
                child: const Text("Try Again", textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: white, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ));
  }
}
