/// result : {"scheme_allocation":[{"scheme_name":"Aditya Birla SL Corporate Bond Fund (G)","current_value":4746255,"category":"Debt: Corporate Bond","allocation":14},{"scheme_name":"Axis Banking & PSU Debt (G)","current_value":3641890,"category":"Debt: Banking and PSU","allocation":11},{"scheme_name":"Bandhan Banking & PSU Debt Fund Reg (G)","current_value":2349387,"category":"Debt: Banking and PSU","allocation":7},{"scheme_name":"Bandhan Corporate Bond Fund Reg (G)","current_value":2464235,"category":"Debt: Corporate Bond","allocation":7},{"scheme_name":"ICICI Pru Balanced Advantage Fund Reg (G)","current_value":2490335,"category":"Hybrid: Balanced Advantage","allocation":7},{"scheme_name":"HDFC Balanced Advantage Fund (G)","current_value":2312981,"category":"Hybrid: Balanced Advantage","allocation":7},{"scheme_name":"SBI Equity Hybrid Fund Reg (G)","current_value":2048319,"category":"Hybrid: Aggressive","allocation":6},{"scheme_name":"ICICI Pru Savings Fund (G)","current_value":2202311,"category":"Debt: Low Duration","allocation":6},{"scheme_name":"DSP Mid cap Fund Reg (G)","current_value":1615481,"category":"Equity: Mid Cap","allocation":5},{"scheme_name":"Kotak Equity Opportunities Fund (G)","current_value":1418110,"category":"Equity: Large & Mid Cap","allocation":4},{"scheme_name":"UTI Nifty 50 Index Fund (G)","current_value":1457097,"category":"Equity: Index","allocation":4},{"scheme_name":"Franklin India Feeder Franklin US Opp (G)","current_value":996258,"category":"Equity: Global","allocation":3},{"scheme_name":"Aditya Birla SL Flexi Cap Fund Reg (G)","current_value":1068708,"category":"Equity: Flexi Cap","allocation":3},{"scheme_name":"Mirae Asset Focused Fund Reg (G)","current_value":1129121,"category":"Equity: Focused","allocation":3},{"scheme_name":"Kotak Smallcap Fund (G)","current_value":1115498,"category":"Equity: Small Cap","allocation":3},{"scheme_name":"Axis Midcap Fund (G)","current_value":690334,"category":"Equity: Mid Cap","allocation":2},{"scheme_name":"SBI Small Cap Fund Reg (G)","current_value":634189,"category":"Equity: Small Cap","allocation":2},{"scheme_name":"Motilal Oswal S&P 500 Index Fund Reg (G)","current_value":541223,"category":"Equity: Index","allocation":2},{"scheme_name":"Invesco India Contra Fund (G)","current_value":692589,"category":"Equity: Contra","allocation":2},{"scheme_name":"UTI Flexi Cap Fund Reg (G)","current_value":431925,"category":"Equity: Flexi Cap","allocation":1},{"scheme_name":"Total","current_value":34046246,"category":"","allocation":100}]}
/// success : 1
/// message : ""

class SchemeAllocationResponse {
  SchemeAllocationResponse({
      Result? result, 
      num? success, 
      String? message,}){
    _result = result;
    _success = success;
    _message = message;
}

  SchemeAllocationResponse.fromJson(dynamic json) {
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
    _success = json['success'];
    _message = json['message'];
  }
  Result? _result;
  num? _success;
  String? _message;
SchemeAllocationResponse copyWith({  Result? result,
  num? success,
  String? message,
}) => SchemeAllocationResponse(  result: result ?? _result,
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

/// scheme_allocation : [{"scheme_name":"Aditya Birla SL Corporate Bond Fund (G)","current_value":4746255,"category":"Debt: Corporate Bond","allocation":14},{"scheme_name":"Axis Banking & PSU Debt (G)","current_value":3641890,"category":"Debt: Banking and PSU","allocation":11},{"scheme_name":"Bandhan Banking & PSU Debt Fund Reg (G)","current_value":2349387,"category":"Debt: Banking and PSU","allocation":7},{"scheme_name":"Bandhan Corporate Bond Fund Reg (G)","current_value":2464235,"category":"Debt: Corporate Bond","allocation":7},{"scheme_name":"ICICI Pru Balanced Advantage Fund Reg (G)","current_value":2490335,"category":"Hybrid: Balanced Advantage","allocation":7},{"scheme_name":"HDFC Balanced Advantage Fund (G)","current_value":2312981,"category":"Hybrid: Balanced Advantage","allocation":7},{"scheme_name":"SBI Equity Hybrid Fund Reg (G)","current_value":2048319,"category":"Hybrid: Aggressive","allocation":6},{"scheme_name":"ICICI Pru Savings Fund (G)","current_value":2202311,"category":"Debt: Low Duration","allocation":6},{"scheme_name":"DSP Mid cap Fund Reg (G)","current_value":1615481,"category":"Equity: Mid Cap","allocation":5},{"scheme_name":"Kotak Equity Opportunities Fund (G)","current_value":1418110,"category":"Equity: Large & Mid Cap","allocation":4},{"scheme_name":"UTI Nifty 50 Index Fund (G)","current_value":1457097,"category":"Equity: Index","allocation":4},{"scheme_name":"Franklin India Feeder Franklin US Opp (G)","current_value":996258,"category":"Equity: Global","allocation":3},{"scheme_name":"Aditya Birla SL Flexi Cap Fund Reg (G)","current_value":1068708,"category":"Equity: Flexi Cap","allocation":3},{"scheme_name":"Mirae Asset Focused Fund Reg (G)","current_value":1129121,"category":"Equity: Focused","allocation":3},{"scheme_name":"Kotak Smallcap Fund (G)","current_value":1115498,"category":"Equity: Small Cap","allocation":3},{"scheme_name":"Axis Midcap Fund (G)","current_value":690334,"category":"Equity: Mid Cap","allocation":2},{"scheme_name":"SBI Small Cap Fund Reg (G)","current_value":634189,"category":"Equity: Small Cap","allocation":2},{"scheme_name":"Motilal Oswal S&P 500 Index Fund Reg (G)","current_value":541223,"category":"Equity: Index","allocation":2},{"scheme_name":"Invesco India Contra Fund (G)","current_value":692589,"category":"Equity: Contra","allocation":2},{"scheme_name":"UTI Flexi Cap Fund Reg (G)","current_value":431925,"category":"Equity: Flexi Cap","allocation":1},{"scheme_name":"Total","current_value":34046246,"category":"","allocation":100}]

class Result {
  Result({
      List<SchemeAllocation>? schemeAllocation,}){
    _schemeAllocation = schemeAllocation;
}

  Result.fromJson(dynamic json) {
    if (json['scheme_allocation'] != null) {
      _schemeAllocation = [];
      json['scheme_allocation'].forEach((v) {
        _schemeAllocation?.add(SchemeAllocation.fromJson(v));
      });
    }
  }
  List<SchemeAllocation>? _schemeAllocation;
Result copyWith({  List<SchemeAllocation>? schemeAllocation,
}) => Result(  schemeAllocation: schemeAllocation ?? _schemeAllocation,
);
  List<SchemeAllocation>? get schemeAllocation => _schemeAllocation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_schemeAllocation != null) {
      map['scheme_allocation'] = _schemeAllocation?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// scheme_name : "Aditya Birla SL Corporate Bond Fund (G)"
/// current_value : 4746255
/// category : "Debt: Corporate Bond"
/// allocation : 14

class SchemeAllocation {
  SchemeAllocation({
      String? schemeName, 
      num? currentValue, 
      String? category, 
      num? allocation,}){
    _schemeName = schemeName;
    _currentValue = currentValue;
    _category = category;
    _allocation = allocation;
}

  SchemeAllocation.fromJson(dynamic json) {
    _schemeName = json['scheme_name'];
    _currentValue = json['current_value'];
    _category = json['category'];
    _allocation = json['allocation'];
  }
  String? _schemeName;
  num? _currentValue;
  String? _category;
  num? _allocation;
SchemeAllocation copyWith({  String? schemeName,
  num? currentValue,
  String? category,
  num? allocation,
}) => SchemeAllocation(  schemeName: schemeName ?? _schemeName,
  currentValue: currentValue ?? _currentValue,
  category: category ?? _category,
  allocation: allocation ?? _allocation,
);
  String? get schemeName => _schemeName;
  num? get currentValue => _currentValue;
  String? get category => _category;
  num? get allocation => _allocation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['scheme_name'] = _schemeName;
    map['current_value'] = _currentValue;
    map['category'] = _category;
    map['allocation'] = _allocation;
    return map;
  }

}