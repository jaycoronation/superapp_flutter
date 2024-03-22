import 'dart:convert';
/// applicant_details : [{"applicant":"MUKESH JINDAL"},{"applicant":"ABHA AGARWAL"},{"applicant":"ALL"}]
/// success : 1

ApplicantResponseModel applicantResponseModelFromJson(String str) => ApplicantResponseModel.fromJson(json.decode(str));
String applicantResponseModelToJson(ApplicantResponseModel data) => json.encode(data.toJson());
class ApplicantResponseModel {
  ApplicantResponseModel({
      List<ApplicantsOnly>? applicantDetails,
      num? success,}){
    _applicantDetails = applicantDetails;
    _success = success;
}

  ApplicantResponseModel.fromJson(dynamic json) {
    if (json['applicant_details'] != null) {
      _applicantDetails = [];
      json['applicant_details'].forEach((v) {
        _applicantDetails?.add(ApplicantsOnly.fromJson(v));
      });
    }
    _success = json['success'];
  }
  List<ApplicantsOnly>? _applicantDetails;
  num? _success;
ApplicantResponseModel copyWith({  List<ApplicantsOnly>? applicantDetails,
  num? success,
}) => ApplicantResponseModel(  applicantDetails: applicantDetails ?? _applicantDetails,
  success: success ?? _success,
);
  List<ApplicantsOnly>? get applicantDetails => _applicantDetails;
  num? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_applicantDetails != null) {
      map['applicant_details'] = _applicantDetails?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    return map;
  }

}

/// applicant : "MUKESH JINDAL"

ApplicantsOnly applicantDetailsFromJson(String str) => ApplicantsOnly.fromJson(json.decode(str));
String applicantDetailsToJson(ApplicantsOnly data) => json.encode(data.toJson());
class ApplicantsOnly {
  ApplicantsOnly({
      String? applicant,}){
    _applicant = applicant;
}

  ApplicantsOnly.fromJson(dynamic json) {
    _applicant = json['applicant'];
  }
  String? _applicant;
ApplicantsOnly copyWith({  String? applicant,
}) => ApplicantsOnly(  applicant: applicant ?? _applicant,
);
  String? get applicant => _applicant;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['applicant'] = _applicant;
    return map;
  }

}