import 'dart:convert';
/// risk_profile : "Moderate"
/// message : ""
/// success : 1

RiskProfileSaveResponseModel riskProfileSaveResponseModelFromJson(String str) => RiskProfileSaveResponseModel.fromJson(json.decode(str));
String riskProfileSaveResponseModelToJson(RiskProfileSaveResponseModel data) => json.encode(data.toJson());
class RiskProfileSaveResponseModel {
  RiskProfileSaveResponseModel({
      String? riskProfile, 
      String? message, 
      num? success,}){
    _riskProfile = riskProfile;
    _message = message;
    _success = success;
}

  RiskProfileSaveResponseModel.fromJson(dynamic json) {
    _riskProfile = json['risk_profile'];
    _message = json['message'];
    _success = json['success'];
  }
  String? _riskProfile;
  String? _message;
  num? _success;
RiskProfileSaveResponseModel copyWith({  String? riskProfile,
  String? message,
  num? success,
}) => RiskProfileSaveResponseModel(  riskProfile: riskProfile ?? _riskProfile,
  message: message ?? _message,
  success: success ?? _success,
);
  String? get riskProfile => _riskProfile;
  String? get message => _message;
  num? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['risk_profile'] = _riskProfile;
    map['message'] = _message;
    map['success'] = _success;
    return map;
  }

}