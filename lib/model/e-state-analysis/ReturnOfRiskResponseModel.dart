import 'dart:convert';
/// return_of_risk : [{"range_of_return":"High","one_year":"57.8%","three_year":"35.3%","five_year":"23.9%"},{"range_of_return":"Average","one_year":"12.35%","three_year":"12.35%","five_year":"12.35%"},{"range_of_return":"Low","one_year":"-33.1%","three_year":"-10.6%","five_year":"1.2%"}]
/// message : ""
/// success : 1

ReturnOfRiskResponseModel returnOfRiskResponseModelFromJson(String str) => ReturnOfRiskResponseModel.fromJson(json.decode(str));
String returnOfRiskResponseModelToJson(ReturnOfRiskResponseModel data) => json.encode(data.toJson());
class ReturnOfRiskResponseModel {
  ReturnOfRiskResponseModel({
      List<ReturnOfRisk>? returnOfRisk, 
      String? message, 
      num? success,}){
    _returnOfRisk = returnOfRisk;
    _message = message;
    _success = success;
}

  ReturnOfRiskResponseModel.fromJson(dynamic json) {
    if (json['return_of_risk'] != null) {
      _returnOfRisk = [];
      json['return_of_risk'].forEach((v) {
        _returnOfRisk?.add(ReturnOfRisk.fromJson(v));
      });
    }
    _message = json['message'];
    _success = json['success'];
  }
  List<ReturnOfRisk>? _returnOfRisk;
  String? _message;
  num? _success;
ReturnOfRiskResponseModel copyWith({  List<ReturnOfRisk>? returnOfRisk,
  String? message,
  num? success,
}) => ReturnOfRiskResponseModel(  returnOfRisk: returnOfRisk ?? _returnOfRisk,
  message: message ?? _message,
  success: success ?? _success,
);
  List<ReturnOfRisk>? get returnOfRisk => _returnOfRisk;
  String? get message => _message;
  num? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_returnOfRisk != null) {
      map['return_of_risk'] = _returnOfRisk?.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    map['success'] = _success;
    return map;
  }

}

/// range_of_return : "High"
/// one_year : "57.8%"
/// three_year : "35.3%"
/// five_year : "23.9%"

ReturnOfRisk returnOfRiskFromJson(String str) => ReturnOfRisk.fromJson(json.decode(str));
String returnOfRiskToJson(ReturnOfRisk data) => json.encode(data.toJson());
class ReturnOfRisk {
  ReturnOfRisk({
      String? rangeOfReturn, 
      String? oneYear, 
      String? threeYear, 
      String? fiveYear,}){
    _rangeOfReturn = rangeOfReturn;
    _oneYear = oneYear;
    _threeYear = threeYear;
    _fiveYear = fiveYear;
}

  ReturnOfRisk.fromJson(dynamic json) {
    _rangeOfReturn = json['range_of_return'];
    _oneYear = json['one_year'];
    _threeYear = json['three_year'];
    _fiveYear = json['five_year'];
  }
  String? _rangeOfReturn;
  String? _oneYear;
  String? _threeYear;
  String? _fiveYear;
ReturnOfRisk copyWith({  String? rangeOfReturn,
  String? oneYear,
  String? threeYear,
  String? fiveYear,
}) => ReturnOfRisk(  rangeOfReturn: rangeOfReturn ?? _rangeOfReturn,
  oneYear: oneYear ?? _oneYear,
  threeYear: threeYear ?? _threeYear,
  fiveYear: fiveYear ?? _fiveYear,
);
  String? get rangeOfReturn => _rangeOfReturn;
  String? get oneYear => _oneYear;
  String? get threeYear => _threeYear;
  String? get fiveYear => _fiveYear;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['range_of_return'] = _rangeOfReturn;
    map['one_year'] = _oneYear;
    map['three_year'] = _threeYear;
    map['five_year'] = _fiveYear;
    return map;
  }

}