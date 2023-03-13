import 'dart:convert';
/// aspiration_types : [{"aspiration_type_id":"1","aspiration_type":"Vatika India Next"},{"aspiration_type_id":"2","aspiration_type":"Bank Balance"},{"aspiration_type_id":"3","aspiration_type":"Union bank Balance"},{"aspiration_type_id":"4","aspiration_type":"Aspiration Type"},{"aspiration_type_id":"5","aspiration_type":"Retirement"},{"aspiration_type_id":"6","aspiration_type":"Contingency"},{"aspiration_type_id":"7","aspiration_type":"Medical Contingency/ emergency"},{"aspiration_type_id":"8","aspiration_type":"Automobile"},{"aspiration_type_id":"9","aspiration_type":"Child Education - Schooling"},{"aspiration_type_id":"10","aspiration_type":"Child Education - Undergraduation"},{"aspiration_type_id":"11","aspiration_type":"Child Education - Post Graduation"},{"aspiration_type_id":"12","aspiration_type":"Vacation With Family"},{"aspiration_type_id":"13","aspiration_type":"Vacation With Wife"},{"aspiration_type_id":"14","aspiration_type":"Rent"},{"aspiration_type_id":"15","aspiration_type":"Interior & Furnishing"},{"aspiration_type_id":"16","aspiration_type":"Holidays"},{"aspiration_type_id":"17","aspiration_type":"Philanthropy"},{"aspiration_type_id":"18","aspiration_type":"Mrs. Seth college expense"},{"aspiration_type_id":"19","aspiration_type":"Parents Good care"},{"aspiration_type_id":"20","aspiration_type":"Business requirement"},{"aspiration_type_id":"21","aspiration_type":"Real Estate"},{"aspiration_type_id":"22","aspiration_type":"Farm House"},{"aspiration_type_id":"23","aspiration_type":"Lifestyle Villa"},{"aspiration_type_id":"24","aspiration_type":"Electronic Gadgets"},{"aspiration_type_id":"25","aspiration_type":"Other miscelaneous aspiration"},{"aspiration_type_id":"26","aspiration_type":"US Expense "},{"aspiration_type_id":"27","aspiration_type":"Pre Retirement Expense"},{"aspiration_type_id":"28","aspiration_type":"Gifts"}]
/// message : ""
/// success : 1

AspirationTypesResponseModel aspirationTypesResponseModelFromJson(String str) => AspirationTypesResponseModel.fromJson(json.decode(str));
String aspirationTypesResponseModelToJson(AspirationTypesResponseModel data) => json.encode(data.toJson());
class AspirationTypesResponseModel {
  AspirationTypesResponseModel({
      List<AspirationTypes>? aspirationTypes, 
      String? message, 
      num? success,}){
    _aspirationTypes = aspirationTypes;
    _message = message;
    _success = success;
}

  AspirationTypesResponseModel.fromJson(dynamic json) {
    if (json['aspiration_types'] != null) {
      _aspirationTypes = [];
      json['aspiration_types'].forEach((v) {
        _aspirationTypes?.add(AspirationTypes.fromJson(v));
      });
    }
    _message = json['message'];
    _success = json['success'];
  }
  List<AspirationTypes>? _aspirationTypes;
  String? _message;
  num? _success;
AspirationTypesResponseModel copyWith({  List<AspirationTypes>? aspirationTypes,
  String? message,
  num? success,
}) => AspirationTypesResponseModel(  aspirationTypes: aspirationTypes ?? _aspirationTypes,
  message: message ?? _message,
  success: success ?? _success,
);
  List<AspirationTypes>? get aspirationTypes => _aspirationTypes;
  String? get message => _message;
  num? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_aspirationTypes != null) {
      map['aspiration_types'] = _aspirationTypes?.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    map['success'] = _success;
    return map;
  }

}

/// aspiration_type_id : "1"
/// aspiration_type : "Vatika India Next"

AspirationTypes aspirationTypesFromJson(String str) => AspirationTypes.fromJson(json.decode(str));
String aspirationTypesToJson(AspirationTypes data) => json.encode(data.toJson());
class AspirationTypes {
  AspirationTypes({
      String? aspirationTypeId, 
      String? aspirationType,}){
    _aspirationTypeId = aspirationTypeId;
    _aspirationType = aspirationType;
}

  AspirationTypes.fromJson(dynamic json) {
    _aspirationTypeId = json['aspiration_type_id'];
    _aspirationType = json['aspiration_type'];
  }
  String? _aspirationTypeId;
  String? _aspirationType;
AspirationTypes copyWith({  String? aspirationTypeId,
  String? aspirationType,
}) => AspirationTypes(  aspirationTypeId: aspirationTypeId ?? _aspirationTypeId,
  aspirationType: aspirationType ?? _aspirationType,
);
  String? get aspirationTypeId => _aspirationTypeId;
  String? get aspirationType => _aspirationType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['aspiration_type_id'] = _aspirationTypeId;
    map['aspiration_type'] = _aspirationType;
    return map;
  }

}