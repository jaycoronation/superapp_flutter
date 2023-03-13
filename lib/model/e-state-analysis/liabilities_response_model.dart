import 'dart:convert';
/// liabilities : [{"liability_id":"1","liability":"Car Loan","asset_type":"Debt"},{"liability_id":"2","liability":"Credit Card","asset_type":"Debt"},{"liability_id":"3","liability":"Home Loan","asset_type":"Real Estate"},{"liability_id":"4","liability":"Loan money invested in Equity","asset_type":"Equity"},{"liability_id":"5","liability":"Other Loan","asset_type":"Debt"},{"liability_id":"6","liability":"Lucknow Plot Loan","asset_type":"Real Estate"},{"liability_id":"7","liability":"Insurance Premium","asset_type":"Equity"}]
/// message : ""
/// success : 1

LiabilitiesResponseModel liabilitiesResponseModelFromJson(String str) => LiabilitiesResponseModel.fromJson(json.decode(str));
String liabilitiesResponseModelToJson(LiabilitiesResponseModel data) => json.encode(data.toJson());
class LiabilitiesResponseModel {
  LiabilitiesResponseModel({
      List<Liabilities>? liabilities, 
      String? message, 
      num? success,}){
    _liabilities = liabilities;
    _message = message;
    _success = success;
}

  LiabilitiesResponseModel.fromJson(dynamic json) {
    if (json['liabilities'] != null) {
      _liabilities = [];
      json['liabilities'].forEach((v) {
        _liabilities?.add(Liabilities.fromJson(v));
      });
    }
    _message = json['message'];
    _success = json['success'];
  }
  List<Liabilities>? _liabilities;
  String? _message;
  num? _success;
LiabilitiesResponseModel copyWith({  List<Liabilities>? liabilities,
  String? message,
  num? success,
}) => LiabilitiesResponseModel(  liabilities: liabilities ?? _liabilities,
  message: message ?? _message,
  success: success ?? _success,
);
  List<Liabilities>? get liabilities => _liabilities;
  String? get message => _message;
  num? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_liabilities != null) {
      map['liabilities'] = _liabilities?.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    map['success'] = _success;
    return map;
  }

}

/// liability_id : "1"
/// liability : "Car Loan"
/// asset_type : "Debt"

Liabilities liabilitiesFromJson(String str) => Liabilities.fromJson(json.decode(str));
String liabilitiesToJson(Liabilities data) => json.encode(data.toJson());
class Liabilities {
  Liabilities({
      String? liabilityId, 
      String? liability, 
      String? assetType,}){
    _liabilityId = liabilityId;
    _liability = liability;
    _assetType = assetType;
}

  Liabilities.fromJson(dynamic json) {
    _liabilityId = json['liability_id'];
    _liability = json['liability'];
    _assetType = json['asset_type'];
  }
  String? _liabilityId;
  String? _liability;
  String? _assetType;
Liabilities copyWith({  String? liabilityId,
  String? liability,
  String? assetType,
}) => Liabilities(  liabilityId: liabilityId ?? _liabilityId,
  liability: liability ?? _liability,
  assetType: assetType ?? _assetType,
);
  String? get liabilityId => _liabilityId;
  String? get liability => _liability;
  String? get assetType => _assetType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['liability_id'] = _liabilityId;
    map['liability'] = _liability;
    map['asset_type'] = _assetType;
    return map;
  }

}