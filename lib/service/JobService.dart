import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:superapp_flutter/model/SyncMintResponse.dart';
import 'package:superapp_flutter/model/consolidated-portfolio/XIRRCommonResponseModel.dart';

import '../constant/consolidate-portfolio/api_end_point.dart';
import '../model/consolidated-portfolio/NetworthResponseModel.dart';
import '../model/consolidated-portfolio/PercentageResponse.dart';
import '../model/consolidated-portfolio/SinceInceptionResponse.dart';
import '../model/consolidated-portfolio/ApplicantResponseModel.dart' as applicants;
import '../utils/app_utils.dart';
import '../utils/session_manager_pms.dart';

class JobService {

  List<Data> listSinceInception = List<Data>.empty(growable: true);
  List<Data> listCurrentYearXIRR = List<Data>.empty(growable: true);
  List<Data> listPreviousYearXIRR = List<Data>.empty(growable: true);

  List<applicants.ApplicantsOnly> listApplicants = List<applicants.ApplicantsOnly>.empty(growable: true);

  List<Xirr> listSinceInceptionNew = [];
  List<Xirr> listCurrentYearXIRRNew = [];
  List<Xirr> listPreviousYearXIRRNew = [];

  SessionManagerPMS sessionManagerPMS = SessionManagerPMS();

  void getLatestDataFromMint() async {

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_CP + updateLatestData);

    Map<String, String> jsonBody = {
      'user_id': sessionManagerPMS.getUserId().trim(),
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = SyncMintResponse.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1)
    {
      DateTime dateTime = DateTime.now();
      String formattedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);

      sessionManagerPMS.setLastSyncDate(formattedDateTime);
      getCommonXirr();
    }
  }

  void getCommonXirr() async {

    String dateTimeString = sessionManagerPMS.getLastSyncDate();
    DateTime parsedDateTime = dateTimeString.isNotEmpty ? DateTime.parse(dateTimeString) : DateTime.now().subtract(Duration(hours: 3));

    print("dateTimeString ==== $dateTimeString");
    print("isTwoHoursPassed ==== ${isTwoHoursPassed(parsedDateTime)}");
    if (isTwoHoursPassed(parsedDateTime))
      {
        getLatestDataFromMint();
      }

    getListApplicants();

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_CP + xirrCommon);
    Map<String, String> jsonBody = {
      'user_id': sessionManagerPMS.getUserId().trim(),
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = XirrCommonResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1)
      {
        listSinceInceptionNew = dataResponse.performance ?? [];

        sessionManagerPMS.savePerformanceList(listSinceInceptionNew);

        listCurrentYearXIRRNew = dataResponse.xirr ?? [];

        sessionManagerPMS.saveNextYearList(listCurrentYearXIRRNew);

        listPreviousYearXIRRNew = dataResponse.xirrPrevious ?? [];

        sessionManagerPMS.savePerviousYearList(listPreviousYearXIRRNew);

        String asPerDate = universalDateConverter("dd-MM-yyyy", 'dd MMM,yyyy', dataResponse.reportDate ?? '');
        sessionManagerPMS.setReportDate(asPerDate);

      }
    getNetworthData();
  }

  void getListApplicants() async {

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_CP + applicantsList);

    Map<String, String> jsonBody = {
      'user_id': sessionManagerPMS.getUserId().trim(),
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = applicants.ApplicantResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      if (dataResponse.applicantDetails != null) {
        listApplicants = dataResponse.applicantDetails ?? [];
        sessionManagerPMS.saveApplicantsList(listApplicants);
      }
    } else {

    }
  }

  /*void getSinceInceptionData() async {

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_CP + performance);
    Map<String, String> jsonBody = {
      'user_id': sessionManagerPMS.getUserId().trim(),
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = SinceInceptionResponse.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      if (dataResponse.result != null) {
        listSinceInception = dataResponse.result!.data!;
        sessionManagerPMS.savePerformanceList(listSinceInception);
      }
    } else {

    }
    getCurrentYearXIRR();
  }

  void getCurrentYearXIRR() async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_CP + xirr);
    Map<String, String> jsonBody = {
      'user_id': sessionManagerPMS.getUserId().trim(),
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = SinceInceptionResponse.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      try {

        if (dataResponse.result != null) {
          listCurrentYearXIRR = dataResponse.result!.data!;
          sessionManagerPMS.saveNextYearList(listCurrentYearXIRR);
        }
      } catch (e)
      {
      }
    } else {

    }
    getPreviousYearXIRR();
  }

  void getPreviousYearXIRR() async {

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_CP + xirrPrevious);
    Map<String, String> jsonBody = {
      'user_id': sessionManagerPMS.getUserId().trim(),
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = SinceInceptionResponse.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      try {
        if (dataResponse.result != null)
        {
          listPreviousYearXIRRNew = dataResponse.result!.data!;
          sessionManagerPMS.savePerviousYearList(listPreviousYearXIRRNew);
        }
      }
      catch (e)
      {

      }
    } else {

    }
    getNetworthData();
  }*/

  getNetworthData() async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_CP + networth);
    Map<String, String> jsonBody = {
      'user_id': sessionManagerPMS.getUserId().trim(),
    };

    final response = await http.post(url, body: jsonBody);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = NetworthResponseModel.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      try {
        if (dataResponse.result != null)
        {
          var resultData = dataResponse.result ?? Result();

          print("Data === ");
          print(jsonEncode(resultData.macroAssetStratagic?[0]));

          sessionManagerPMS.saveNetworthData(resultData);

          if (resultData.applicantDetails != null) {
            if(resultData.applicantDetails!.isNotEmpty) {
              for (int i = 0; i < resultData.applicantDetails!.length ; i++) {
                if (resultData.applicantDetails![i].applicant == "Amount Total") {
                  var strNetWorth = checkValidString(resultData.applicantDetails![i].amount.toString());
                  sessionManagerPMS.setTotalNetworth(strNetWorth);
                }
              }
            }
          }

          print(jsonEncode(sessionManagerPMS.getNetworthData()));
          print(sessionManagerPMS.getTotalNetworth());

        }
      } catch (e) {
      }
    } else {

    }
    _getPercentageData();
  }

  _getPercentageData() async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL_CP + percentage);

    final response = await http.get(url);
    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var dataResponse = PercentageResponse.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      try {
        var percentageResponse = dataResponse;
        sessionManagerPMS.savePercentageData(percentageResponse);
      } catch (e) {

      }
    } else {

    }

  }

  bool isTwoHoursPassed(DateTime timestamp) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(timestamp);
    return difference.inHours >= 2;
  }

}