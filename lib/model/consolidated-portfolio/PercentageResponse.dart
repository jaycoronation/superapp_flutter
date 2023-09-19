import 'dart:convert';

/// master_market_percentage : "5"
/// success : 1

PercentageResponse percentageFromJson(String str) => PercentageResponse.fromJson(json.decode(str));
String percentageToJson(PercentageResponse data) => json.encode(data.toJson());
class PercentageResponse {
  PercentageResponse({
      String? masterMarketPercentage, 
      num? success,}){
    _masterMarketPercentage = masterMarketPercentage;
    _success = success;
}

  PercentageResponse.fromJson(dynamic json) {
    _masterMarketPercentage = json['master_market_percentage'];
    _success = json['success'];
  }
  String? _masterMarketPercentage;
  num? _success;
PercentageResponse copyWith({  String? masterMarketPercentage,
  num? success,
}) => PercentageResponse(  masterMarketPercentage: masterMarketPercentage ?? _masterMarketPercentage,
  success: success ?? _success,
);
  String? get masterMarketPercentage => _masterMarketPercentage;
  num? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['master_market_percentage'] = _masterMarketPercentage;
    map['success'] = _success;
    return map;
  }

}