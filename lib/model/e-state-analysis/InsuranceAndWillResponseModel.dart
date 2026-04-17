import 'dart:convert';
/// success : 1
/// message : "Data retrieved"
/// data : {"id":"50","user_id":"1218","life_insurance_sum_insured":"10000","medical_insurance_covered_amount":"20000","has_will":"0"}

InsuranceAndWillResponseModel insuranceAndWillResponseModelFromJson(String str) => InsuranceAndWillResponseModel.fromJson(json.decode(str));
String insuranceAndWillResponseModelToJson(InsuranceAndWillResponseModel data) => json.encode(data.toJson());
class InsuranceAndWillResponseModel {
  InsuranceAndWillResponseModel({
      num? success, 
      String? message, 
      InsuranceAndWillData? insuranceAndWillData,}){
    _success = success;
    _message = message;
    _insuranceAndWillData = insuranceAndWillData;
}

  InsuranceAndWillResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _insuranceAndWillData = json['data'] != null ? InsuranceAndWillData.fromJson(json['data']) : null;
  }
  num? _success;
  String? _message;
  InsuranceAndWillData? _insuranceAndWillData;
InsuranceAndWillResponseModel copyWith({  num? success,
  String? message,
  InsuranceAndWillData? insuranceAndWillData,
}) => InsuranceAndWillResponseModel(  success: success ?? _success,
  message: message ?? _message,
  insuranceAndWillData: insuranceAndWillData ?? _insuranceAndWillData,
);
  num? get success => _success;
  String? get message => _message;
  InsuranceAndWillData? get insuranceAndWillData => _insuranceAndWillData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_insuranceAndWillData != null) {
      map['data'] = _insuranceAndWillData?.toJson();
    }
    return map;
  }

}

/// id : "50"
/// user_id : "1218"
/// life_insurance_sum_insured : "10000"
/// medical_insurance_covered_amount : "20000"
/// has_will : "0"

InsuranceAndWillData insuranceAndWillDataFromJson(String str) => InsuranceAndWillData.fromJson(json.decode(str));
String insuranceAndWillDataToJson(InsuranceAndWillData data) => json.encode(data.toJson());
class InsuranceAndWillData {
  InsuranceAndWillData({
      String? id, 
      String? userId, 
      String? lifeInsuranceSumInsured, 
      String? medicalInsuranceCoveredAmount, 
      String? hasWill,}){
    _id = id;
    _userId = userId;
    _lifeInsuranceSumInsured = lifeInsuranceSumInsured;
    _medicalInsuranceCoveredAmount = medicalInsuranceCoveredAmount;
    _hasWill = hasWill;
}

  InsuranceAndWillData.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _lifeInsuranceSumInsured = json['life_insurance_sum_insured'];
    _medicalInsuranceCoveredAmount = json['medical_insurance_covered_amount'];
    _hasWill = json['has_will'];
  }
  String? _id;
  String? _userId;
  String? _lifeInsuranceSumInsured;
  String? _medicalInsuranceCoveredAmount;
  String? _hasWill;
InsuranceAndWillData copyWith({  String? id,
  String? userId,
  String? lifeInsuranceSumInsured,
  String? medicalInsuranceCoveredAmount,
  String? hasWill,
}) => InsuranceAndWillData(  id: id ?? _id,
  userId: userId ?? _userId,
  lifeInsuranceSumInsured: lifeInsuranceSumInsured ?? _lifeInsuranceSumInsured,
  medicalInsuranceCoveredAmount: medicalInsuranceCoveredAmount ?? _medicalInsuranceCoveredAmount,
  hasWill: hasWill ?? _hasWill,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get lifeInsuranceSumInsured => _lifeInsuranceSumInsured;
  String? get medicalInsuranceCoveredAmount => _medicalInsuranceCoveredAmount;
  String? get hasWill => _hasWill;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['life_insurance_sum_insured'] = _lifeInsuranceSumInsured;
    map['medical_insurance_covered_amount'] = _medicalInsuranceCoveredAmount;
    map['has_will'] = _hasWill;
    return map;
  }

}