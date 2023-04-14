/// result : {"fund_house_allocation":[{"fund_house":"Aditya Birla Sun Life Mutual Fund","current_value":5814963,"allocation":17},{"fund_house":"Bandhan Mutual Fund","current_value":4813622,"allocation":14},{"fund_house":"ICICI Prudential Mutual Fund","current_value":4692646,"allocation":14},{"fund_house":"Axis Mutual Fund","current_value":4332224,"allocation":13},{"fund_house":"SBI Mutual Fund","current_value":2682508,"allocation":8},{"fund_house":"Kotak Mahindra Mutual Fund","current_value":2533608,"allocation":7},{"fund_house":"HDFC Mutual Fund","current_value":2312981,"allocation":7},{"fund_house":"UTI Mutual Fund","current_value":1889022,"allocation":6},{"fund_house":"DSP Mutual Fund","current_value":1615481,"allocation":5},{"fund_house":"Franklin Templeton Mutual Fund","current_value":996258,"allocation":3},{"fund_house":"Mirae Asset Mutual Fund","current_value":1129121,"allocation":3},{"fund_house":"Invesco Mutual Fund","current_value":692589,"allocation":2},{"fund_house":"Motilal Oswal Mutual Fund","current_value":541223,"allocation":2},{"fund_house":"Total","current_value":34046246,"allocation":100}]}
/// success : 1
/// message : ""

class FundHouseAllocationResponse {
  FundHouseAllocationResponse({
      Result? result, 
      num? success, 
      String? message,}){
    _result = result;
    _success = success;
    _message = message;
}

  FundHouseAllocationResponse.fromJson(dynamic json) {
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
    _success = json['success'];
    _message = json['message'];
  }
  Result? _result;
  num? _success;
  String? _message;
FundHouseAllocationResponse copyWith({  Result? result,
  num? success,
  String? message,
}) => FundHouseAllocationResponse(  result: result ?? _result,
  success: success ?? _success,
  message: message ?? _message,
);
  Result? get result => _result;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_result != null) {
      map['result'] = _result?.toJson();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// fund_house_allocation : [{"fund_house":"Aditya Birla Sun Life Mutual Fund","current_value":5814963,"allocation":17},{"fund_house":"Bandhan Mutual Fund","current_value":4813622,"allocation":14},{"fund_house":"ICICI Prudential Mutual Fund","current_value":4692646,"allocation":14},{"fund_house":"Axis Mutual Fund","current_value":4332224,"allocation":13},{"fund_house":"SBI Mutual Fund","current_value":2682508,"allocation":8},{"fund_house":"Kotak Mahindra Mutual Fund","current_value":2533608,"allocation":7},{"fund_house":"HDFC Mutual Fund","current_value":2312981,"allocation":7},{"fund_house":"UTI Mutual Fund","current_value":1889022,"allocation":6},{"fund_house":"DSP Mutual Fund","current_value":1615481,"allocation":5},{"fund_house":"Franklin Templeton Mutual Fund","current_value":996258,"allocation":3},{"fund_house":"Mirae Asset Mutual Fund","current_value":1129121,"allocation":3},{"fund_house":"Invesco Mutual Fund","current_value":692589,"allocation":2},{"fund_house":"Motilal Oswal Mutual Fund","current_value":541223,"allocation":2},{"fund_house":"Total","current_value":34046246,"allocation":100}]

class Result {
  Result({
      List<FundHouseAllocation>? fundHouseAllocation,}){
    _fundHouseAllocation = fundHouseAllocation;
}

  Result.fromJson(dynamic json) {
    if (json['fund_house_allocation'] != null) {
      _fundHouseAllocation = [];
      json['fund_house_allocation'].forEach((v) {
        _fundHouseAllocation?.add(FundHouseAllocation.fromJson(v));
      });
    }
  }
  List<FundHouseAllocation>? _fundHouseAllocation;
Result copyWith({  List<FundHouseAllocation>? fundHouseAllocation,
}) => Result(  fundHouseAllocation: fundHouseAllocation ?? _fundHouseAllocation,
);
  List<FundHouseAllocation>? get fundHouseAllocation => _fundHouseAllocation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_fundHouseAllocation != null) {
      map['fund_house_allocation'] = _fundHouseAllocation?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// fund_house : "Aditya Birla Sun Life Mutual Fund"
/// current_value : 5814963
/// allocation : 17

class FundHouseAllocation {
  FundHouseAllocation({
      String? fundHouse, 
      num? currentValue, 
      num? allocation,}){
    _fundHouse = fundHouse;
    _currentValue = currentValue;
    _allocation = allocation;
}

  FundHouseAllocation.fromJson(dynamic json) {
    _fundHouse = json['fund_house'];
    _currentValue = json['current_value'];
    _allocation = json['allocation'];
  }
  String? _fundHouse;
  num? _currentValue;
  num? _allocation;
FundHouseAllocation copyWith({  String? fundHouse,
  num? currentValue,
  num? allocation,
}) => FundHouseAllocation(  fundHouse: fundHouse ?? _fundHouse,
  currentValue: currentValue ?? _currentValue,
  allocation: allocation ?? _allocation,
);
  String? get fundHouse => _fundHouse;
  num? get currentValue => _currentValue;
  num? get allocation => _allocation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fund_house'] = _fundHouse;
    map['current_value'] = _currentValue;
    map['allocation'] = _allocation;
    return map;
  }

}