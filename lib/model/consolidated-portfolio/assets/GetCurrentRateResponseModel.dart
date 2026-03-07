import 'dart:convert';
/// rates : {"current_value":"1834.8","current_price":"152.9","isin_no":"BBG010SMM1M8"}
/// success : 1
/// message : ""

GetCurrentRateResponseModel getCurrentRateResponseModelFromJson(String str) => GetCurrentRateResponseModel.fromJson(json.decode(str));
String getCurrentRateResponseModelToJson(GetCurrentRateResponseModel data) => json.encode(data.toJson());
class GetCurrentRateResponseModel {
  GetCurrentRateResponseModel({
      CurrentRates? currentRates, 
      num? success, 
      String? message,}){
    _currentRates = currentRates;
    _success = success;
    _message = message;
}

  GetCurrentRateResponseModel.fromJson(dynamic json) {
    _currentRates = json['rates'] != null ? CurrentRates.fromJson(json['rates']) : null;
    _success = json['success'];
    _message = json['message'];
  }
  CurrentRates? _currentRates;
  num? _success;
  String? _message;
GetCurrentRateResponseModel copyWith({  CurrentRates? currentRates,
  num? success,
  String? message,
}) => GetCurrentRateResponseModel(  currentRates: currentRates ?? _currentRates,
  success: success ?? _success,
  message: message ?? _message,
);
  CurrentRates? get currentRates => _currentRates;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_currentRates != null) {
      map['rates'] = _currentRates?.toJson();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// current_value : "1834.8"
/// current_price : "152.9"
/// isin_no : "BBG010SMM1M8"

CurrentRates currentRatesFromJson(String str) => CurrentRates.fromJson(json.decode(str));
String currentRatesToJson(CurrentRates data) => json.encode(data.toJson());
class CurrentRates {
  CurrentRates({
      String? currentValue, 
      String? currentPrice, 
      String? isinNo,}){
    _currentValue = currentValue;
    _currentPrice = currentPrice;
    _isinNo = isinNo;
}

  CurrentRates.fromJson(dynamic json) {
    _currentValue = json['current_value']is int || json['current_value']is double ? json['current_value'].toString() : json['current_value'];
    _currentPrice = json['current_price']is int || json['current_price']is double ? json['current_price'].toString() : json['current_price'];
    _isinNo = json['isin_no'];
  }
  String? _currentValue;
  String? _currentPrice;
  String? _isinNo;
CurrentRates copyWith({  String? currentValue,
  String? currentPrice,
  String? isinNo,
}) => CurrentRates(  currentValue: currentValue ?? _currentValue,
  currentPrice: currentPrice ?? _currentPrice,
  isinNo: isinNo ?? _isinNo,
);
  String? get currentValue => _currentValue;
  String? get currentPrice => _currentPrice;
  String? get isinNo => _isinNo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_value'] = _currentValue;
    map['current_price'] = _currentPrice;
    map['isin_no'] = _isinNo;
    return map;
  }

}