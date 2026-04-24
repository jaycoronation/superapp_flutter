import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../constant/analysis_api_end_point.dart';

class ReportDownload{
  static Future<void> startDownload(BuildContext context, String userId, Function(bool) setLoading) async {
    // 1. Base64 Encoding
    final bytes = utf8.encode(userId.trim());
    final base64Str = base64.encode(bytes);

    //set url
    String url = API_URL_ANALYSIS + generateFinalReport +  base64Str;

    setLoading(true);

    try {
      // 2. Permission Handling
      bool hasPermission = await _requestPermissions(context);
      if (!hasPermission) {
        _showSnackBar(context, "Storage permission denied!");
        setLoading(false);
        return;
      }

      // 3. Get Safe Directory
      // iOS aur Android 13+
      Directory? directory;
      if (Platform.isIOS)
      {
        directory = await getApplicationDocumentsDirectory();
      }
      else
      {
        // for Android downloads folder
        directory = await getExternalStorageDirectory();
      }

      final fileName = "Report_${DateTime.now().millisecondsSinceEpoch}.pdf";
      final filePath = "${directory!.path}/$fileName";

      // 4. Download File
      final request = await HttpClient().getUrl(Uri.parse(url));
      final response = await request.close();

      if (response.statusCode == 200) {
        final file = File(filePath);
        await response.pipe(file.openWrite());

        print("File saved at: $filePath");

        // 5. Open File
        final result = await OpenFile.open(filePath);
        if (result.type != ResultType.done) {
          _showSnackBar(context, "Could not open file: ${result.message}");
        }
      } else {
        _showSnackBar(context, "Server Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Download Error: $e");
      _showSnackBar(context, "Download failed: $e");
    } finally {
      setLoading(false);
    }
  }

  static Future<bool> _requestPermissions(BuildContext context) async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;

      if (androidInfo.version.sdkInt >= 33)
      {
        return true;
      }

      var status = await Permission.storage.status;

      if (status.isGranted) {
        return true;
      } else if (status.isPermanentlyDenied) {
        await _showPermissionDialog(context);
        return false;
      } else {
        // Naya request bhejein
        var result = await Permission.storage.request();
        if (result.isGranted) {
          return true;
        } else {
          return false;
        }
      }
    }

    return true;
  }


  static Future<void> _showPermissionDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Storage Permission Required"),
        content: Text("App ko file save karne ke liye storage permission chahiye. Please settings mein jaakar ise allow karein."),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: Text("Open Settings"),
            onPressed: () {
              openAppSettings();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  // static Future<bool> _requestPermissions() async {
  //   if (Platform.isAndroid) {
  //     final androidInfo = await DeviceInfoPlugin().androidInfo;
  //     // Android 13 (API 33) ya usse upar storage permission ki zarurat nahi hoti simple download ke liye
  //     if (androidInfo.version.sdkInt <= 32) {
  //       var status = await Permission.storage.request();
  //       return status.isGranted;
  //     }
  //     return true; // Android 13+ ke liye true
  //   }
  //   return true; // iOS handles it via sandbox
  // }

  static void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}