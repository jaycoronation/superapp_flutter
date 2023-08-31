import 'dart:convert';

/// result : {"data":[{"Asset":"Debt","InvestedAmount":5962513,"CurrentValue":7713183,"Gain":1750670,"XIRR":6.2500762939453}]}
/// success : 1

class SinceInceptionResponse {
  SinceInceptionResponse({
      ResultData? result, 
      num? success,}){
    _result = result;
    _success = success;
}

  SinceInceptionResponse.fromJson(dynamic json) {
    _result = json['result'] != null ? ResultData.fromJson(json['result']) : null;
    _success = json['success'];
  }
  ResultData? _result;
  num? _success;
SinceInceptionResponse copyWith({  ResultData? result,
  num? success,
}) => SinceInceptionResponse(  result: result ?? _result,
  success: success ?? _success,
);
  ResultData? get result => _result;
  num? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_result != null) {
      map['result'] = _result?.toJson();
    }
    map['success'] = _success;
    return map;
  }

}

/// data : [{"Asset":"Debt","InvestedAmount":5962513,"CurrentValue":7713183,"Gain":1750670,"XIRR":6.2500762939453}]

class ResultData {
  ResultData({
      List<Data>? data,}){
    _data = data;
}

  ResultData.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  List<Data>? _data;
ResultData copyWith({  List<Data>? data,
}) => ResultData(  data: data ?? _data,
);
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// Asset : "Debt"
/// InvestedAmount : 5962513
/// CurrentValue : 7713183
/// Gain : 1750670
/// XIRR : 6.2500762939453

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? asset, 
      num? investedAmount, 
      num? currentValue, 
      num? gain, 
      num? xirr,}){
    _asset = asset;
    _investedAmount = investedAmount;
    _currentValue = currentValue;
    _gain = gain;
    _xirr = xirr;
}

  Data.fromJson(dynamic json) {
    _asset = json['Asset'];
    _investedAmount = json['InvestedAmount'];
    _currentValue = json['CurrentValue'];
    _gain = json['Gain'];
    _xirr = json['XIRR'];
  }
  String? _asset;
  num? _investedAmount;
  num? _currentValue;
  num? _gain;
  num? _xirr;
Data copyWith({  String? asset,
  num? investedAmount,
  num? currentValue,
  num? gain,
  num? xirr,
}) => Data(  asset: asset ?? _asset,
  investedAmount: investedAmount ?? _investedAmount,
  currentValue: currentValue ?? _currentValue,
  gain: gain ?? _gain,
  xirr: xirr ?? _xirr,
);
  String? get asset => _asset;
  num? get investedAmount => _investedAmount;
  num? get currentValue => _currentValue;
  num? get gain => _gain;
  num? get xirr => _xirr;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Asset'] = _asset;
    map['InvestedAmount'] = _investedAmount;
    map['CurrentValue'] = _currentValue;
    map['Gain'] = _gain;
    map['XIRR'] = _xirr;
    return map;
  }

  @override
  String toString() {
    return 'Data{_asset: $_asset, _investedAmount: $_investedAmount, _currentValue: $_currentValue, _gain: $_gain, _xirr: $_xirr}';
  }
}