import 'dart:convert';
/// Debt : 1193270
/// Equity : 129534056
/// Gold : 69758
/// Hybrid : 942584
/// assets_total : 131739668
/// success : 1
/// message : "MF Transaction inserted successfully."

SyncMintResponse syncMintResponseFromJson(String str) => SyncMintResponse.fromJson(json.decode(str));
String syncMintResponseToJson(SyncMintResponse data) => json.encode(data.toJson());
class SyncMintResponse {
  SyncMintResponse({
      num? debt, 
      num? equity, 
      num? gold, 
      num? hybrid, 
      num? assetsTotal, 
      num? success, 
      String? message,}){
    _debt = debt;
    _equity = equity;
    _gold = gold;
    _hybrid = hybrid;
    _assetsTotal = assetsTotal;
    _success = success;
    _message = message;
}

  SyncMintResponse.fromJson(dynamic json) {
    _debt = json['Debt'];
    _equity = json['Equity'];
    _gold = json['Gold'];
    _hybrid = json['Hybrid'];
    _assetsTotal = json['assets_total'];
    _success = json['success'];
    _message = json['message'];
  }
  num? _debt;
  num? _equity;
  num? _gold;
  num? _hybrid;
  num? _assetsTotal;
  num? _success;
  String? _message;
SyncMintResponse copyWith({  num? debt,
  num? equity,
  num? gold,
  num? hybrid,
  num? assetsTotal,
  num? success,
  String? message,
}) => SyncMintResponse(  debt: debt ?? _debt,
  equity: equity ?? _equity,
  gold: gold ?? _gold,
  hybrid: hybrid ?? _hybrid,
  assetsTotal: assetsTotal ?? _assetsTotal,
  success: success ?? _success,
  message: message ?? _message,
);
  num? get debt => _debt;
  num? get equity => _equity;
  num? get gold => _gold;
  num? get hybrid => _hybrid;
  num? get assetsTotal => _assetsTotal;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Debt'] = _debt;
    map['Equity'] = _equity;
    map['Gold'] = _gold;
    map['Hybrid'] = _hybrid;
    map['assets_total'] = _assetsTotal;
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}