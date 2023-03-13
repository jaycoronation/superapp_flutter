import 'dart:convert';
/// future_inflow : {"listmaininflow":[{"future_inflow_id":"64","user_id":"26","source":"SIP","start_year":"2023","end_year":"2025","expected_growth":"2","amount":" 1000","inflation_adjusted_income":" 3060","pv_of_income":" 2888"},{"future_inflow_id":"66","user_id":"26","source":"fixed deposit","start_year":"2025","end_year":"2030","expected_growth":"10","amount":" 5000","inflation_adjusted_income":" 46679","pv_of_income":" 35512"}],"total":{"inflation_adjusted_income":"49739.85","pv_of_income":"38400.66"}}
/// message : "Future inflow found..."
/// success : 1

FutureInflowMainListResponseModel futureInflowMainListResponseModelFromJson(String str) => FutureInflowMainListResponseModel.fromJson(json.decode(str));
String futureInflowMainListResponseModelToJson(FutureInflowMainListResponseModel data) => json.encode(data.toJson());
class FutureInflowMainListResponseModel {
  FutureInflowMainListResponseModel({
      FutureInflow? futureInflow, 
      String? message, 
      num? success,}){
    _futureInflow = futureInflow;
    _message = message;
    _success = success;
}

  FutureInflowMainListResponseModel.fromJson(dynamic json) {
    _futureInflow = json['future_inflow'] != null ? FutureInflow.fromJson(json['future_inflow']) : null;
    _message = json['message'];
    _success = json['success'];
  }
  FutureInflow? _futureInflow;
  String? _message;
  num? _success;
FutureInflowMainListResponseModel copyWith({  FutureInflow? futureInflow,
  String? message,
  num? success,
}) => FutureInflowMainListResponseModel(  futureInflow: futureInflow ?? _futureInflow,
  message: message ?? _message,
  success: success ?? _success,
);
  FutureInflow? get futureInflow => _futureInflow;
  String? get message => _message;
  num? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_futureInflow != null) {
      map['future_inflow'] = _futureInflow?.toJson();
    }
    map['message'] = _message;
    map['success'] = _success;
    return map;
  }

}

/// listmaininflow : [{"future_inflow_id":"64","user_id":"26","source":"SIP","start_year":"2023","end_year":"2025","expected_growth":"2","amount":" 1000","inflation_adjusted_income":" 3060","pv_of_income":" 2888"},{"future_inflow_id":"66","user_id":"26","source":"fixed deposit","start_year":"2025","end_year":"2030","expected_growth":"10","amount":" 5000","inflation_adjusted_income":" 46679","pv_of_income":" 35512"}]
/// total : {"inflation_adjusted_income":"49739.85","pv_of_income":"38400.66"}

FutureInflow futureInflowFromJson(String str) => FutureInflow.fromJson(json.decode(str));
String futureInflowToJson(FutureInflow data) => json.encode(data.toJson());
class FutureInflow {
  FutureInflow({
      List<ListMainInflow>? listMainInflow,
      Total? total,}){
    _listMainInflow = listMainInflow;
    _total = total;
}

  FutureInflow.fromJson(dynamic json) {
    if (json['list'] != null) {
      _listMainInflow = [];
      json['list'].forEach((v) {
        _listMainInflow?.add(ListMainInflow.fromJson(v));
      });
    }
    _total = json['total'] != null ? Total.fromJson(json['total']) : null;
  }
  List<ListMainInflow>? _listMainInflow;
  Total? _total;
FutureInflow copyWith({  List<ListMainInflow>? listMainInflow,
  Total? total,
}) => FutureInflow(  listMainInflow: listMainInflow ?? _listMainInflow,
  total: total ?? _total,
);
  List<ListMainInflow>? get listMainInflow => _listMainInflow;
  Total? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_listMainInflow != null) {
      map['list'] = _listMainInflow?.map((v) => v.toJson()).toList();
    }
    if (_total != null) {
      map['total'] = _total?.toJson();
    }
    return map;
  }

}

/// inflation_adjusted_income : "49739.85"
/// pv_of_income : "38400.66"

Total totalFromJson(String str) => Total.fromJson(json.decode(str));
String totalToJson(Total data) => json.encode(data.toJson());
class Total {
  Total({
      String? inflationAdjustedIncome, 
      String? pvOfIncome,}){
    _inflationAdjustedIncome = inflationAdjustedIncome;
    _pvOfIncome = pvOfIncome;
}

  Total.fromJson(dynamic json) {
    _inflationAdjustedIncome = json['inflation_adjusted_income'];
    _pvOfIncome = json['pv_of_income'];
  }
  String? _inflationAdjustedIncome;
  String? _pvOfIncome;
Total copyWith({  String? inflationAdjustedIncome,
  String? pvOfIncome,
}) => Total(  inflationAdjustedIncome: inflationAdjustedIncome ?? _inflationAdjustedIncome,
  pvOfIncome: pvOfIncome ?? _pvOfIncome,
);
  String? get inflationAdjustedIncome => _inflationAdjustedIncome;
  String? get pvOfIncome => _pvOfIncome;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['inflation_adjusted_income'] = _inflationAdjustedIncome;
    map['pv_of_income'] = _pvOfIncome;
    return map;
  }

}

/// future_inflow_id : "64"
/// user_id : "26"
/// source : "SIP"
/// start_year : "2023"
/// end_year : "2025"
/// expected_growth : "2"
/// amount : " 1000"
/// inflation_adjusted_income : " 3060"
/// pv_of_income : " 2888"

ListMainInflow listmaininflowFromJson(String str) => ListMainInflow.fromJson(json.decode(str));
String listmaininflowToJson(ListMainInflow data) => json.encode(data.toJson());
class ListMainInflow {
  ListMainInflow({
      String? futureInflowId, 
      String? userId, 
      String? source, 
      String? startYear, 
      String? endYear, 
      String? expectedGrowth, 
      String? amount, 
      String? inflationAdjustedIncome, 
      String? pvOfIncome,}){
    _futureInflowId = futureInflowId;
    _userId = userId;
    _source = source;
    _startYear = startYear;
    _endYear = endYear;
    _expectedGrowth = expectedGrowth;
    _amount = amount;
    _inflationAdjustedIncome = inflationAdjustedIncome;
    _pvOfIncome = pvOfIncome;
}

  ListMainInflow.fromJson(dynamic json) {
    _futureInflowId = json['future_inflow_id'];
    _userId = json['user_id'];
    _source = json['source'];
    _startYear = json['start_year'];
    _endYear = json['end_year'];
    _expectedGrowth = json['expected_growth'];
    _amount = json['amount'];
    _inflationAdjustedIncome = json['inflation_adjusted_income'];
    _pvOfIncome = json['pv_of_income'];
  }
  String? _futureInflowId;
  String? _userId;
  String? _source;
  String? _startYear;
  String? _endYear;
  String? _expectedGrowth;
  String? _amount;
  String? _inflationAdjustedIncome;
  String? _pvOfIncome;
ListMainInflow copyWith({  String? futureInflowId,
  String? userId,
  String? source,
  String? startYear,
  String? endYear,
  String? expectedGrowth,
  String? amount,
  String? inflationAdjustedIncome,
  String? pvOfIncome,
}) => ListMainInflow(  futureInflowId: futureInflowId ?? _futureInflowId,
  userId: userId ?? _userId,
  source: source ?? _source,
  startYear: startYear ?? _startYear,
  endYear: endYear ?? _endYear,
  expectedGrowth: expectedGrowth ?? _expectedGrowth,
  amount: amount ?? _amount,
  inflationAdjustedIncome: inflationAdjustedIncome ?? _inflationAdjustedIncome,
  pvOfIncome: pvOfIncome ?? _pvOfIncome,
);
  String? get futureInflowId => _futureInflowId;
  String? get userId => _userId;
  String? get source => _source;
  String? get startYear => _startYear;
  String? get endYear => _endYear;
  String? get expectedGrowth => _expectedGrowth;
  String? get amount => _amount;
  String? get inflationAdjustedIncome => _inflationAdjustedIncome;
  String? get pvOfIncome => _pvOfIncome;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['future_inflow_id'] = _futureInflowId;
    map['user_id'] = _userId;
    map['source'] = _source;
    map['start_year'] = _startYear;
    map['end_year'] = _endYear;
    map['expected_growth'] = _expectedGrowth;
    map['amount'] = _amount;
    map['inflation_adjusted_income'] = _inflationAdjustedIncome;
    map['pv_of_income'] = _pvOfIncome;
    return map;
  }

}