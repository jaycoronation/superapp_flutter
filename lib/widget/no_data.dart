import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../constant/colors.dart';

class MyNoDataWidget extends StatelessWidget {
  final String msg;

  const MyNoDataWidget({Key? key, required this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 100),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset('assets/images/icon.png', width: 120, height: 120),
            Visibility(
              visible: msg.isNotEmpty,
              child: const Gap(15),
            ),
            Visibility(
              visible: msg.isNotEmpty,
              child: Text(
                msg,
                style: const TextStyle(color: black, fontSize: 18, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }
}
