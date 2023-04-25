import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../constant/colors.dart';

class MyToolBar extends StatelessWidget {
  final String pageName;

  const MyToolBar({Key? key, required this.pageName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            width: 40,
            height: 40,
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(right: 8),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Image.asset('assets/images/ic_back_arrow.png', width: 32, height: 32),
            ),
          ),
        ),
        Expanded(
            child: Text(
              pageName,
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 18, color: blue, fontWeight: FontWeight.w600),
            )),
      ],
    );
  }
}
