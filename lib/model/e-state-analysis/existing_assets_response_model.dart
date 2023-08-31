import 'dart:convert';
/// existing_assets : [{"existing_assets_id":"90","user_id":"26","investment_type":"Real Estate","asset_type":"Resal Estate","current_value":" 500000","timestamp":"1674792451","can_delete":0},{"existing_assets_id":"86","user_id":"26","investment_type":"Bank Fixed Deposit","asset_type":"Debt","current_value":" 5000","timestamp":"1667236727","can_delete":0}]
/// total_count : "2"
/// success : 1
/// message : "Assets found."

ExistingAssetsResponseModel existingAssetsResponseModelFromJson(String str) => ExistingAssetsResponseModel.fromJson(json.decode(str));
String existingAssetsResponseModelToJson(ExistingAssetsResponseModel data) => json.encode(data.toJson());
class ExistingAssetsResponseModel {
  ExistingAssetsResponseModel({
      List<ExistingAssets>? existingAssets, 
      // String? totalCount,
      num? success, 
      String? message,}){
    _existingAssets = existingAssets;
    // _totalCount = totalCount;
    _success = success;
    _message = message;
}

  ExistingAssetsResponseModel.fromJson(dynamic json) {
    if (json['existing_assets'] != null) {
      _existingAssets = [];
      json['existing_assets'].forEach((v) {
        _existingAssets?.add(ExistingAssets.fromJson(v));
      });
    }
    // _totalCount = json['total_count'];
    _success = json['success'];
    _message = json['message'];
  }
  List<ExistingAssets>? _existingAssets;
  // String? _totalCount;
  num? _success;
  String? _message;
ExistingAssetsResponseModel copyWith({  List<ExistingAssets>? existingAssets,
  // String? totalCount,
  num? success,
  String? message,
}) => ExistingAssetsResponseModel(  existingAssets: existingAssets ?? _existingAssets,
  // totalCount: totalCount ?? _totalCount,
  success: success ?? _success,
  message: message ?? _message,
);
  List<ExistingAssets>? get existingAssets => _existingAssets;
  // String? get totalCount => _totalCount;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_existingAssets != null) {
      map['existing_assets'] = _existingAssets?.map((v) => v.toJson()).toList();
    }
    // map['total_count'] = _totalCount;
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// existing_assets_id : "90"
/// user_id : "26"
/// investment_type : "Real Estate"
/// asset_type : "Resal Estate"
/// current_value : " 500000"
/// timestamp : "1674792451"
/// can_delete : 0

ExistingAssets existingAssetsFromJson(String str) => ExistingAssets.fromJson(json.decode(str));
String existingAssetsToJson(ExistingAssets data) => json.encode(data.toJson());
class ExistingAssets {
  ExistingAssets({
      String? existingAssetsId, 
      String? userId, 
      String? investmentType, 
      String? assetType, 
      String? currentValue, 
      String? timestamp,
    String? canDelete,}){
    _existingAssetsId = existingAssetsId;
    _userId = userId;
    _investmentType = investmentType;
    _assetType = assetType;
    _currentValue = currentValue;
    _timestamp = timestamp;
    _canDelete = canDelete;
}

  ExistingAssets.fromJson(dynamic json) {
    _existingAssetsId = json['existing_assets_id'];
    _userId = json['user_id'];
    _investmentType = json['investment_type'];
    _assetType = json['asset_type'];
    _currentValue = json['current_value'];
    _timestamp = json['timestamp'];
    _canDelete = json['restrict_delete'];
  }
  String? _existingAssetsId;
  String? _userId;
  String? _investmentType;
  String? _assetType;
  String? _currentValue;
  String? _timestamp;
  String? _canDelete;
ExistingAssets copyWith({  String? existingAssetsId,
  String? userId,
  String? investmentType,
  String? assetType,
  String? currentValue,
  String? timestamp,
  String? canDelete,
}) => ExistingAssets(  existingAssetsId: existingAssetsId ?? _existingAssetsId,
  userId: userId ?? _userId,
  investmentType: investmentType ?? _investmentType,
  assetType: assetType ?? _assetType,
  currentValue: currentValue ?? _currentValue,
  timestamp: timestamp ?? _timestamp,
  canDelete: canDelete ?? _canDelete,
);
  String? get existingAssetsId => _existingAssetsId;
  String? get userId => _userId;
  String? get investmentType => _investmentType;
  String? get assetType => _assetType;
  String? get currentValue => _currentValue;
  String? get timestamp => _timestamp;
  String? get canDelete => _canDelete;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['existing_assets_id'] = _existingAssetsId;
    map['user_id'] = _userId;
    map['investment_type'] = _investmentType;
    map['asset_type'] = _assetType;
    map['current_value'] = _currentValue;
    map['timestamp'] = _timestamp;
    map['can_delete'] = _canDelete;
    return map;
  }

}