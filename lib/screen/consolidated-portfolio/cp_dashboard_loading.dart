import 'package:flutter/material.dart';

import '../../constant/colors.dart';

class CPDashboardLoadingWidget extends StatelessWidget {
  const CPDashboardLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top:12,bottom: 12),
      color: appBg,
      child: const Center(
          child: Padding(
            padding: EdgeInsets.all(18.0),
            child: CircularProgressIndicator(color: blue, strokeWidth: 1.5),
          )
      ),
    );
  }
}
