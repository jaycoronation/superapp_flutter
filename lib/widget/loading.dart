import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../constant/colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appBg,
      child: Center(
          child: Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(color: blue, borderRadius: BorderRadius.all(Radius.circular(10))),
            child:  const Padding(
              padding: EdgeInsets.all(18.0),
              child: CircularProgressIndicator(color: white, strokeWidth: 1.5),
            ),
          )
      ),
    );
  }
}
