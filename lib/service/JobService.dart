import 'dart:convert';

import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../constant/consolidate-portfolio/api_end_point.dart';
import '../model/consolidated-portfolio/NetworthResponse.dart';
import '../model/consolidated-portfolio/PercentageResponse.dart';
import '../model/consolidated-portfolio/SinceInceptionResponse.dart';
import '../utils/app_utils.dart';
import '../utils/session_manager_pms.dart';

class JobService {

  List<Data> listSinceInception = List<Data>.empty(growable: true);
  List<Data> listCurrentYearXIRR = List<Data>.empty(growable: true);
  List<Data> listPreviousYearXIRR = List<Data>.empty(growable: true);
  SessionManagerPMS sessionManagerPMS = SessionManagerPMS();

  void getSinceInceptionData() async {

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
          listPreviousYearXIRR = dataResponse.result!.data!;
          sessionManagerPMS.savePerviousYearList(listPreviousYearXIRR);
        }
      }
      catch (e)
      {

      }
    } else {

    }
    getNetworthData();
  }


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
    var dataResponse = NetworthResponse.fromJson(user);

    if (statusCode == 200 && dataResponse.success == 1) {
      try {
        if (dataResponse.result != null)
        {
          var resultData = dataResponse.result!;

          sessionManagerPMS.saveNetworthData(resultData);

          if (resultData.applicantDetails != null) {
            if(resultData.applicantDetails!.isNotEmpty) {
              for (int i = 0; i < resultData.applicantDetails!.length ; i++) {
                if (resultData.applicantDetails![i].applicant == "Total") {
                  var strNetWorth = checkValidString(resultData.applicantDetails![i].currentAmount.toString());
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


}