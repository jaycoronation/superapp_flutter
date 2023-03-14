import 'dart:convert';
/// existing_liabilities : [{"existing_liability_id":"15","user_id":"26","liability_type":"Home Loan","asset_type":"Real Estate","current_value":" 2000000","timestamp":"1677021210"},{"existing_liability_id":"","user_id":"","liability_type":"Total","asset_type":"","current_value":" 2000000","timestamp":""}]
/// total_count : "1"
/// success : 1
/// message : "Liability found."

ExistingLiabilitiesResponseModel existingLiabilitiesResponseModelFromJson(String str) => ExistingLiabilitiesResponseModel.fromJson(json.decode(str));
String existingLiabilitiesResponseModelToJson(ExistingLiabilitiesResponseModel data) => json.encode(data.toJson());
class ExistingLiabilitiesResponseModel {
  ExistingLiabilitiesResponseModel({
      List<ExistingLiabilities>? existingLiabilities, 
      // String? totalCount,
      num? success, 
      String? message,}){
    _existingLiabilities = existingLiabilities;
    // _totalCount = totalCount;
    _success = success;
    _message = message;
}

  ExistingLiabilitiesResponseModel.fromJson(dynamic json) {
    if (json['existing_liabilities'] != null) {
      _existingLiabilities = [];
      json['existing_liabilities'].forEach((v) {
        _existingLiabilities?.add(ExistingLiabilities.fromJson(v));
      });
    }
    // _totalCount = json['total_count'];
    _success = json['success'];
    _message = json['message'];
  }
  List<ExistingLiabilities>? _existingLiabilities;
  // String? _totalCount;
  num? _success;
  String? _message;
ExistingLiabilitiesResponseModel copyWith({  List<ExistingLiabilities>? existingLiabilities,
  // String? totalCount,
  num? success,
  String? message,
}) => ExistingLiabilitiesResponseModel(  existingLiabilities: existingLiabilities ?? _existingLiabilities,
  // totalCount: totalCount ?? _totalCount,
  success: success ?? _success,
  message: message ?? _message,
);
  List<ExistingLiabilities>? get existingLiabilities => _existingLiabilities;
  // String? get totalCount => _totalCount;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_existingLiabilities != null) {
      map['existing_liabilities'] = _existingLiabilities?.map((v) => v.toJson()).toList();
    }
    // map['total_count'] = _totalCount;
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// existing_liability_id : "15"
/// user_id : "26"
/// liability_type : "Home Loan"
/// asset_type : "Real Estate"
/// current_value : " 2000000"
/// timestamp : "1677021210"

ExistingLiabilities existingLiabilitiesFromJson(String str) => ExistingLiabilities.fromJson(json.decode(str));
String existingLiabilitiesToJson(ExistingLiabilities data) => json.encode(data.toJson());
class ExistingLiabilities {
  ExistingLiabilities({
      String? existingLiabilityId, 
      String? userId, 
      String? liabilityType, 
      String? assetType, 
      String? currentValue, 
      String? timestamp,}){
    _existingLiabilityId = existingLiabilityId;
    _userId = userId;
    _liabilityType = liabilityType;
    _assetType = assetType;
    _currentValue = currentValue;
    _timestamp = timestamp;
}

  ExistingLiabilities.fromJson(dynamic json) {
    _existingLiabilityId = json['existing_liability_id'];
    _userId = json['user_id'];
    _liabilityType = json['liability_type'];
    _assetType = json['asset_type'];
    _currentValue = json['current_value'];
    _timestamp = json['timestamp'];
  }
  String? _existingLiabilityId;
  String? _userId;
  String? _liabilityType;
  String? _assetType;
  String? _currentValue;
  String? _timestamp;
ExistingLiabilities copyWith({  String? existingLiabilityId,
  String? userId,
  String? liabilityType,
  String? assetType,
  String? currentValue,
  String? timestamp,
}) => ExistingLiabilities(  existingLiabilityId: existingLiabilityId ?? _existingLiabilityId,
  userId: userId ?? _userId,
  liabilityType: liabilityType ?? _liabilityType,
  assetType: assetType ?? _assetType,
  currentValue: currentValue ?? _currentValue,
  timestamp: timestamp ?? _timestamp,
);
  String? get existingLiabilityId => _existingLiabilityId;
  String? get userId => _userId;
  String? get liabilityType => _liabilityType;
  String? get assetType => _assetType;
  String? get currentValue => _currentValue;
  String? get timestamp => _timestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['existing_liability_id'] = _existingLiabilityId;
    map['user_id'] = _userId;
    map['liability_type'] = _liabilityType;
    map['asset_type'] = _assetType;
    map['current_value'] = _currentValue;
    map['timestamp'] = _timestamp;
    return map;
  }

}