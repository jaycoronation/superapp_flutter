import 'dart:convert';
/// members : [{"user_id":"500","pan_no":"ADQPJ6338P","applicant_name":"MUKESH JINDAL","contact_no":"9891857434"},{"user_id":"500","pan_no":"AIGPA9618Q","applicant_name":"ABHA AGARWAL","contact_no":"9891857434"}]
/// last_consent : {"date":"13-12-2025 01:56 PM","consentId":"5f48d893-d24e-434d-9931-95f9c86cffc5"}
/// success : 1
/// message : ""

FamilyMembersResponseModel familyMembersResponseModelFromJson(String str) => FamilyMembersResponseModel.fromJson(json.decode(str));
String familyMembersResponseModelToJson(FamilyMembersResponseModel data) => json.encode(data.toJson());
class FamilyMembersResponseModel {
  FamilyMembersResponseModel({
      List<Members>? members, 
      LastConsent? lastConsent, 
      num? success, 
      String? message,}){
    _members = members;
    _lastConsent = lastConsent;
    _success = success;
    _message = message;
}

  FamilyMembersResponseModel.fromJson(dynamic json) {
    if (json['members'] != null) {
      _members = [];
      json['members'].forEach((v) {
        _members?.add(Members.fromJson(v));
      });
    }
    _lastConsent = json['last_consent'] != null ? LastConsent.fromJson(json['last_consent']) : null;
    _success = json['success'];
    _message = json['message'];
  }
  List<Members>? _members;
  LastConsent? _lastConsent;
  num? _success;
  String? _message;
FamilyMembersResponseModel copyWith({  List<Members>? members,
  LastConsent? lastConsent,
  num? success,
  String? message,
}) => FamilyMembersResponseModel(  members: members ?? _members,
  lastConsent: lastConsent ?? _lastConsent,
  success: success ?? _success,
  message: message ?? _message,
);
  List<Members>? get members => _members;
  LastConsent? get lastConsent => _lastConsent;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_members != null) {
      map['members'] = _members?.map((v) => v.toJson()).toList();
    }
    if (_lastConsent != null) {
      map['last_consent'] = _lastConsent?.toJson();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// date : "13-12-2025 01:56 PM"
/// consentId : "5f48d893-d24e-434d-9931-95f9c86cffc5"

LastConsent lastConsentFromJson(String str) => LastConsent.fromJson(json.decode(str));
String lastConsentToJson(LastConsent data) => json.encode(data.toJson());
class LastConsent {
  LastConsent({
      String? date, 
      String? consentId,}){
    _date = date;
    _consentId = consentId;
}

  LastConsent.fromJson(dynamic json) {
    _date = json['date'];
    _consentId = json['consentId'];
  }
  String? _date;
  String? _consentId;
LastConsent copyWith({  String? date,
  String? consentId,
}) => LastConsent(  date: date ?? _date,
  consentId: consentId ?? _consentId,
);
  String? get date => _date;
  String? get consentId => _consentId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = _date;
    map['consentId'] = _consentId;
    return map;
  }

}

/// user_id : "500"
/// pan_no : "ADQPJ6338P"
/// applicant_name : "MUKESH JINDAL"
/// contact_no : "9891857434"

Members membersFromJson(String str) => Members.fromJson(json.decode(str));
String membersToJson(Members data) => json.encode(data.toJson());
class Members {
  Members({
      String? userId, 
      String? panNo, 
      String? applicantName, 
      String? contactNo,}){
    _userId = userId;
    _panNo = panNo;
    _applicantName = applicantName;
    _contactNo = contactNo;
}

  Members.fromJson(dynamic json) {
    _userId = json['user_id'];
    _panNo = json['pan_no'];
    _applicantName = json['applicant_name'];
    _contactNo = json['contact_no'];
  }
  String? _userId;
  String? _panNo;
  String? _applicantName;
  String? _contactNo;
Members copyWith({  String? userId,
  String? panNo,
  String? applicantName,
  String? contactNo,
}) => Members(  userId: userId ?? _userId,
  panNo: panNo ?? _panNo,
  applicantName: applicantName ?? _applicantName,
  contactNo: contactNo ?? _contactNo,
);
  String? get userId => _userId;
  String? get panNo => _panNo;
  String? get applicantName => _applicantName;
  String? get contactNo => _contactNo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['pan_no'] = _panNo;
    map['applicant_name'] = _applicantName;
    map['contact_no'] = _contactNo;
    return map;
  }

}