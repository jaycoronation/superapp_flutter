import 'dart:convert';
/// future_inflows : [{"future_inflow_id":"66","user_id":"26","source":"fixed deposit","start_year":"2025","end_year":"2030","expected_growth":"10","amount":" 5000","timestamp":"1678345723"},{"future_inflow_id":"64","user_id":"26","source":"SIP","start_year":"2023","end_year":"2025","expected_growth":"2","amount":" 1000","timestamp":"1668509774"}]
/// total_count : "2"
/// success : 1
/// message : "Future Inflow detail found."

FutureInflowListReponseModel futureInflowListReponseModelFromJson(String str) => FutureInflowListReponseModel.fromJson(json.decode(str));
String futureInflowListReponseModelToJson(FutureInflowListReponseModel data) => json.encode(data.toJson());
class FutureInflowListReponseModel {
  FutureInflowListReponseModel({
      List<FutureInflows>? futureInflows, 
      // String? totalCount,
      num? success, 
      String? message,}){
    _futureInflows = futureInflows;
    // _totalCount = totalCount;
    _success = success;
    _message = message;
}

  FutureInflowListReponseModel.fromJson(dynamic json) {
    if (json['future_inflows'] != null) {
      _futureInflows = [];
      json['future_inflows'].forEach((v) {
        _futureInflows?.add(FutureInflows.fromJson(v));
      });
    }
    // _totalCount = json['total_count'];
    _success = json['success'];
    _message = json['message'];
  }
  List<FutureInflows>? _futureInflows;
  String? _totalCount;
  num? _success;
  String? _message;
FutureInflowListReponseModel copyWith({  List<FutureInflows>? futureInflows,
  String? totalCount,
  num? success,
  String? message,
}) => FutureInflowListReponseModel(  futureInflows: futureInflows ?? _futureInflows,
  // totalCount: totalCount ?? _totalCount,
  success: success ?? _success,
  message: message ?? _message,
);
  List<FutureInflows>? get futureInflows => _futureInflows;
  // String? get totalCount => _totalCount;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_futureInflows != null) {
      map['future_inflows'] = _futureInflows?.map((v) => v.toJson()).toList();
    }
    // map['total_count'] = _totalCount;
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// future_inflow_id : "66"
/// user_id : "26"
/// source : "fixed deposit"
/// start_year : "2025"
/// end_year : "2030"
/// expected_growth : "10"
/// amount : " 5000"
/// timestamp : "1678345723"

FutureInflows futureInflowsFromJson(String str) => FutureInflows.fromJson(json.decode(str));
String futureInflowsToJson(FutureInflows data) => json.encode(data.toJson());
class FutureInflows {
  FutureInflows({
      String? futureInflowId, 
      String? userId, 
      String? source, 
      String? startYear, 
      String? endYear, 
      String? expectedGrowth, 
      String? amount, 
      String? timestamp,}){
    _futureInflowId = futureInflowId;
    _userId = userId;
    _source = source;
    _startYear = startYear;
    _endYear = endYear;
    _expectedGrowth = expectedGrowth;
    _amount = amount;
    _timestamp = timestamp;
}

  FutureInflows.fromJson(dynamic json) {
    _futureInflowId = json['future_inflow_id'];
    _userId = json['user_id'];
    _source = json['source'];
    _startYear = json['start_year'];
    _endYear = json['end_year'];
    _expectedGrowth = json['expected_growth'];
    _amount = json['amount'];
    _timestamp = json['timestamp'];
  }
  String? _futureInflowId;
  String? _userId;
  String? _source;
  String? _startYear;
  String? _endYear;
  String? _expectedGrowth;
  String? _amount;
  String? _timestamp;
FutureInflows copyWith({  String? futureInflowId,
  String? userId,
  String? source,
  String? startYear,
  String? endYear,
  String? expectedGrowth,
  String? amount,
  String? timestamp,
}) => FutureInflows(  futureInflowId: futureInflowId ?? _futureInflowId,
  userId: userId ?? _userId,
  source: source ?? _source,
  startYear: startYear ?? _startYear,
  endYear: endYear ?? _endYear,
  expectedGrowth: expectedGrowth ?? _expectedGrowth,
  amount: amount ?? _amount,
  timestamp: timestamp ?? _timestamp,
);
  String? get futureInflowId => _futureInflowId;
  String? get userId => _userId;
  String? get source => _source;
  String? get startYear => _startYear;
  String? get endYear => _endYear;
  String? get expectedGrowth => _expectedGrowth;
  String? get amount => _amount;
  String? get timestamp => _timestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['future_inflow_id'] = _futureInflowId;
    map['user_id'] = _userId;
    map['source'] = _source;
    map['start_year'] = _startYear;
    map['end_year'] = _endYear;
    map['expected_growth'] = _expectedGrowth;
    map['amount'] = _amount;
    map['timestamp'] = _timestamp;
    return map;
  }

}