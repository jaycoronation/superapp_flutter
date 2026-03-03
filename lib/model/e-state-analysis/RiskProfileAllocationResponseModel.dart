import 'dart:convert';
/// equity_allocation : 75
/// risk_profile_allocation : [{"asset_class":"Volatile","allocation":"75%","expected_return":"14%"},{"asset_class":"Fixed Income","allocation":"25%","expected_return":"7%"},{"asset_class":"Total","allocation":"100%","expected_return":"12%"}]
/// message : ""
/// success : 1

RiskProfileAllocationResponseModel riskProfileAllocationResponseModelFromJson(String str) => RiskProfileAllocationResponseModel.fromJson(json.decode(str));
String riskProfileAllocationResponseModelToJson(RiskProfileAllocationResponseModel data) => json.encode(data.toJson());
class RiskProfileAllocationResponseModel {
  RiskProfileAllocationResponseModel({
      num? equityAllocation, 
      List<RiskProfileAllocation>? riskProfileAllocation, 
      String? message, 
      num? success,}){
    _equityAllocation = equityAllocation;
    _riskProfileAllocation = riskProfileAllocation;
    _message = message;
    _success = success;
}

  RiskProfileAllocationResponseModel.fromJson(dynamic json) {
    _equityAllocation = json['equity_allocation'];
    if (json['risk_profile_allocation'] != null) {
      _riskProfileAllocation = [];
      json['risk_profile_allocation'].forEach((v) {
        _riskProfileAllocation?.add(RiskProfileAllocation.fromJson(v));
      });
    }
    _message = json['message'];
    _success = json['success'];
  }
  num? _equityAllocation;
  List<RiskProfileAllocation>? _riskProfileAllocation;
  String? _message;
  num? _success;
RiskProfileAllocationResponseModel copyWith({  num? equityAllocation,
  List<RiskProfileAllocation>? riskProfileAllocation,
  String? message,
  num? success,
}) => RiskProfileAllocationResponseModel(  equityAllocation: equityAllocation ?? _equityAllocation,
  riskProfileAllocation: riskProfileAllocation ?? _riskProfileAllocation,
  message: message ?? _message,
  success: success ?? _success,
);
  num? get equityAllocation => _equityAllocation;
  List<RiskProfileAllocation>? get riskProfileAllocation => _riskProfileAllocation;
  String? get message => _message;
  num? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['equity_allocation'] = _equityAllocation;
    if (_riskProfileAllocation != null) {
      map['risk_profile_allocation'] = _riskProfileAllocation?.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    map['success'] = _success;
    return map;
  }

}

/// asset_class : "Volatile"
/// allocation : "75%"
/// expected_return : "14%"

RiskProfileAllocation riskProfileAllocationFromJson(String str) => RiskProfileAllocation.fromJson(json.decode(str));
String riskProfileAllocationToJson(RiskProfileAllocation data) => json.encode(data.toJson());
class RiskProfileAllocation {
  RiskProfileAllocation({
      String? assetClass, 
      String? allocation, 
      String? expectedReturn,}){
    _assetClass = assetClass;
    _allocation = allocation;
    _expectedReturn = expectedReturn;
}

  RiskProfileAllocation.fromJson(dynamic json) {
    _assetClass = json['asset_class'];
    _allocation = json['allocation'];
    _expectedReturn = json['expected_return'];
  }
  String? _assetClass;
  String? _allocation;
  String? _expectedReturn;
RiskProfileAllocation copyWith({  String? assetClass,
  String? allocation,
  String? expectedReturn,
}) => RiskProfileAllocation(  assetClass: assetClass ?? _assetClass,
  allocation: allocation ?? _allocation,
  expectedReturn: expectedReturn ?? _expectedReturn,
);
  String? get assetClass => _assetClass;
  String? get allocation => _allocation;
  String? get expectedReturn => _expectedReturn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['asset_class'] = _assetClass;
    map['allocation'] = _allocation;
    map['expected_return'] = _expectedReturn;
    return map;
  }

}