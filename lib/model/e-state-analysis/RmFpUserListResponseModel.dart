import 'dart:convert';

RmFpUserListResponseModel rmFpUserListResponseModelFromJson(String str) => RmFpUserListResponseModel.fromJson(json.decode(str));
String rmFpUserListResponseModelToJson(RmFpUserListResponseModel data) => json.encode(data.toJson());
class RmFpUserListResponseModel {
  RmFpUserListResponseModel({
      List<RmFpAllEmployees>? allEmployees,
      List<RmFpUsers>? rmFpUsers, 
      String? allReportsCount, 
      String? reportsCount, 
      String? count, 
      num? success,}){
    _allEmployees = allEmployees;
    _rmFpUsers = rmFpUsers;
    _allReportsCount = allReportsCount;
    _reportsCount = reportsCount;
    _count = count;
    _success = success;
}

  RmFpUserListResponseModel.fromJson(dynamic json) {
    if (json['all_employees'] != null) {
      _allEmployees = [];
      json['all_employees'].forEach((v) {
        _allEmployees?.add(RmFpAllEmployees.fromJson(v));
      });
    }
    if (json['users'] != null) {
      _rmFpUsers = [];
      json['users'].forEach((v) {
        _rmFpUsers?.add(RmFpUsers.fromJson(v));
      });
    }
    _allReportsCount = json['all_reports_count'];
    _reportsCount = json['reports_count'];
    _count = json['count'];
    _success = json['success'];
  }
  List<RmFpAllEmployees>? _allEmployees;
  List<RmFpUsers>? _rmFpUsers;
  String? _allReportsCount;
  String? _reportsCount;
  String? _count;
  num? _success;
RmFpUserListResponseModel copyWith({  List<RmFpAllEmployees>? allEmployees,
  List<RmFpUsers>? rmFpUsers,
  String? allReportsCount,
  String? reportsCount,
  String? count,
  num? success,
}) => RmFpUserListResponseModel(  allEmployees: allEmployees ?? _allEmployees,
  rmFpUsers: rmFpUsers ?? _rmFpUsers,
  allReportsCount: allReportsCount ?? _allReportsCount,
  reportsCount: reportsCount ?? _reportsCount,
  count: count ?? _count,
  success: success ?? _success,
);
  List<RmFpAllEmployees>? get allEmployees => _allEmployees;
  List<RmFpUsers>? get rmFpUsers => _rmFpUsers;
  String? get allReportsCount => _allReportsCount;
  String? get reportsCount => _reportsCount;
  String? get count => _count;
  num? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_allEmployees != null) {
      map['all_employees'] = _allEmployees?.map((v) => v.toJson()).toList();
    }
    if (_rmFpUsers != null) {
      map['users'] = _rmFpUsers?.map((v) => v.toJson()).toList();
    }
    map['all_reports_count'] = _allReportsCount;
    map['reports_count'] = _reportsCount;
    map['count'] = _count;
    map['success'] = _success;
    return map;
  }

}

/// user_id : "58"
/// pending_report : 1
/// rm_first_name : ""
/// rm_last_name : ""
/// user_name : "ABHAYAGARWAL"
/// role_name : "user"
/// role_id : "3"
/// first_name : "ABHAY AGARWAL"
/// first_name_2 : ""
/// last_name : ""
/// last_name_2 : ""
/// email : "abhay.agarwal0704@gmail.com"
/// is_superapp : 0
/// password : ""
/// enable_for_auto_generation : true
/// contact_no : "9810006331"
/// contact_no_2 : ""
/// home_no_1 : ""
/// home_no_2 : ""
/// pan_no_1 : "AAAPA3446J"
/// pan_no_2 : ""
/// company_name : ""
/// company_name_2 : ""
/// address : ""
/// address_2 : ""
/// dob : ""
/// dob_2 : ""
/// bank_detail1_holder1 : ""
/// bank_detail2_holder1 : ""
/// nominee_detail_with_dob1_holder1 : ""
/// nominee_detail_with_dob2_holder1 : ""
/// bank_detail1_holder2 : ""
/// bank_detail2_holder2 : ""
/// nominee_detail_with_dob1_holder2 : ""
/// nominee_detail_with_dob2_holder2 : ""
/// is_active : "1"
/// pdf_link_for_mail : ""
/// pdf_link_for_mail_time : ""
/// is_estate_analysis_data : 0
/// is_valut_data : 0

RmFpUsers rmFpUsersFromJson(String str) => RmFpUsers.fromJson(json.decode(str));
String rmFpUsersToJson(RmFpUsers data) => json.encode(data.toJson());
class RmFpUsers {
  RmFpUsers({
      String? userId, 
      num? pendingReport, 
      String? rmFirstName, 
      String? rmLastName, 
      String? userName, 
      String? roleName, 
      String? roleId, 
      String? firstName, 
      String? firstName2, 
      String? lastName, 
      String? lastName2, 
      String? email, 
      num? isSuperapp, 
      String? password, 
      bool? enableForAutoGeneration, 
      String? contactNo, 
      String? contactNo2, 
      String? homeNo1, 
      String? homeNo2, 
      String? panNo1, 
      String? panNo2, 
      String? companyName, 
      String? companyName2, 
      String? address, 
      String? address2, 
      String? dob, 
      String? dob2, 
      String? bankDetail1Holder1, 
      String? bankDetail2Holder1, 
      String? nomineeDetailWithDob1Holder1, 
      String? nomineeDetailWithDob2Holder1, 
      String? bankDetail1Holder2, 
      String? bankDetail2Holder2, 
      String? nomineeDetailWithDob1Holder2, 
      String? nomineeDetailWithDob2Holder2, 
      String? isActive, 
      String? pdfLinkForMail, 
      String? pdfLinkForMailTime, 
      num? isEstateAnalysisData, 
      num? isValutData,}){
    _userId = userId;
    _pendingReport = pendingReport;
    _rmFirstName = rmFirstName;
    _rmLastName = rmLastName;
    _userName = userName;
    _roleName = roleName;
    _roleId = roleId;
    _firstName = firstName;
    _firstName2 = firstName2;
    _lastName = lastName;
    _lastName2 = lastName2;
    _email = email;
    _isSuperapp = isSuperapp;
    _password = password;
    _enableForAutoGeneration = enableForAutoGeneration;
    _contactNo = contactNo;
    _contactNo2 = contactNo2;
    _homeNo1 = homeNo1;
    _homeNo2 = homeNo2;
    _panNo1 = panNo1;
    _panNo2 = panNo2;
    _companyName = companyName;
    _companyName2 = companyName2;
    _address = address;
    _address2 = address2;
    _dob = dob;
    _dob2 = dob2;
    _bankDetail1Holder1 = bankDetail1Holder1;
    _bankDetail2Holder1 = bankDetail2Holder1;
    _nomineeDetailWithDob1Holder1 = nomineeDetailWithDob1Holder1;
    _nomineeDetailWithDob2Holder1 = nomineeDetailWithDob2Holder1;
    _bankDetail1Holder2 = bankDetail1Holder2;
    _bankDetail2Holder2 = bankDetail2Holder2;
    _nomineeDetailWithDob1Holder2 = nomineeDetailWithDob1Holder2;
    _nomineeDetailWithDob2Holder2 = nomineeDetailWithDob2Holder2;
    _isActive = isActive;
    _pdfLinkForMail = pdfLinkForMail;
    _pdfLinkForMailTime = pdfLinkForMailTime;
    _isEstateAnalysisData = isEstateAnalysisData;
    _isValutData = isValutData;
}

  RmFpUsers.fromJson(dynamic json) {
    _userId = json['user_id'];
    _pendingReport = json['pending_report'];
    _rmFirstName = json['rm_first_name'];
    _rmLastName = json['rm_last_name'];
    _userName = json['user_name'];
    _roleName = json['role_name'];
    _roleId = json['role_id'];
    _firstName = json['first_name'];
    _firstName2 = json['first_name_2'];
    _lastName = json['last_name'];
    _lastName2 = json['last_name_2'];
    _email = json['email'];
    _isSuperapp = json['is_superapp'];
    _password = json['password'];
    _enableForAutoGeneration = json['enable_for_auto_generation'];
    _contactNo = json['contact_no'];
    _contactNo2 = json['contact_no_2'];
    _homeNo1 = json['home_no_1'];
    _homeNo2 = json['home_no_2'];
    _panNo1 = json['pan_no_1'];
    _panNo2 = json['pan_no_2'];
    _companyName = json['company_name'];
    _companyName2 = json['company_name_2'];
    _address = json['address'];
    _address2 = json['address_2'];
    _dob = json['dob'];
    _dob2 = json['dob_2'];
    _bankDetail1Holder1 = json['bank_detail1_holder1'];
    _bankDetail2Holder1 = json['bank_detail2_holder1'];
    _nomineeDetailWithDob1Holder1 = json['nominee_detail_with_dob1_holder1'];
    _nomineeDetailWithDob2Holder1 = json['nominee_detail_with_dob2_holder1'];
    _bankDetail1Holder2 = json['bank_detail1_holder2'];
    _bankDetail2Holder2 = json['bank_detail2_holder2'];
    _nomineeDetailWithDob1Holder2 = json['nominee_detail_with_dob1_holder2'];
    _nomineeDetailWithDob2Holder2 = json['nominee_detail_with_dob2_holder2'];
    _isActive = json['is_active'];
    _pdfLinkForMail = json['pdf_link_for_mail'];
    _pdfLinkForMailTime = json['pdf_link_for_mail_time'];
    _isEstateAnalysisData = json['is_estate_analysis_data'];
    _isValutData = json['is_valut_data'];
  }
  String? _userId;
  num? _pendingReport;
  String? _rmFirstName;
  String? _rmLastName;
  String? _userName;
  String? _roleName;
  String? _roleId;
  String? _firstName;
  String? _firstName2;
  String? _lastName;
  String? _lastName2;
  String? _email;
  num? _isSuperapp;
  String? _password;
  bool? _enableForAutoGeneration;
  String? _contactNo;
  String? _contactNo2;
  String? _homeNo1;
  String? _homeNo2;
  String? _panNo1;
  String? _panNo2;
  String? _companyName;
  String? _companyName2;
  String? _address;
  String? _address2;
  String? _dob;
  String? _dob2;
  String? _bankDetail1Holder1;
  String? _bankDetail2Holder1;
  String? _nomineeDetailWithDob1Holder1;
  String? _nomineeDetailWithDob2Holder1;
  String? _bankDetail1Holder2;
  String? _bankDetail2Holder2;
  String? _nomineeDetailWithDob1Holder2;
  String? _nomineeDetailWithDob2Holder2;
  String? _isActive;
  String? _pdfLinkForMail;
  String? _pdfLinkForMailTime;
  num? _isEstateAnalysisData;
  num? _isValutData;
RmFpUsers copyWith({  String? userId,
  num? pendingReport,
  String? rmFirstName,
  String? rmLastName,
  String? userName,
  String? roleName,
  String? roleId,
  String? firstName,
  String? firstName2,
  String? lastName,
  String? lastName2,
  String? email,
  num? isSuperapp,
  String? password,
  bool? enableForAutoGeneration,
  String? contactNo,
  String? contactNo2,
  String? homeNo1,
  String? homeNo2,
  String? panNo1,
  String? panNo2,
  String? companyName,
  String? companyName2,
  String? address,
  String? address2,
  String? dob,
  String? dob2,
  String? bankDetail1Holder1,
  String? bankDetail2Holder1,
  String? nomineeDetailWithDob1Holder1,
  String? nomineeDetailWithDob2Holder1,
  String? bankDetail1Holder2,
  String? bankDetail2Holder2,
  String? nomineeDetailWithDob1Holder2,
  String? nomineeDetailWithDob2Holder2,
  String? isActive,
  String? pdfLinkForMail,
  String? pdfLinkForMailTime,
  num? isEstateAnalysisData,
  num? isValutData,
}) => RmFpUsers(  userId: userId ?? _userId,
  pendingReport: pendingReport ?? _pendingReport,
  rmFirstName: rmFirstName ?? _rmFirstName,
  rmLastName: rmLastName ?? _rmLastName,
  userName: userName ?? _userName,
  roleName: roleName ?? _roleName,
  roleId: roleId ?? _roleId,
  firstName: firstName ?? _firstName,
  firstName2: firstName2 ?? _firstName2,
  lastName: lastName ?? _lastName,
  lastName2: lastName2 ?? _lastName2,
  email: email ?? _email,
  isSuperapp: isSuperapp ?? _isSuperapp,
  password: password ?? _password,
  enableForAutoGeneration: enableForAutoGeneration ?? _enableForAutoGeneration,
  contactNo: contactNo ?? _contactNo,
  contactNo2: contactNo2 ?? _contactNo2,
  homeNo1: homeNo1 ?? _homeNo1,
  homeNo2: homeNo2 ?? _homeNo2,
  panNo1: panNo1 ?? _panNo1,
  panNo2: panNo2 ?? _panNo2,
  companyName: companyName ?? _companyName,
  companyName2: companyName2 ?? _companyName2,
  address: address ?? _address,
  address2: address2 ?? _address2,
  dob: dob ?? _dob,
  dob2: dob2 ?? _dob2,
  bankDetail1Holder1: bankDetail1Holder1 ?? _bankDetail1Holder1,
  bankDetail2Holder1: bankDetail2Holder1 ?? _bankDetail2Holder1,
  nomineeDetailWithDob1Holder1: nomineeDetailWithDob1Holder1 ?? _nomineeDetailWithDob1Holder1,
  nomineeDetailWithDob2Holder1: nomineeDetailWithDob2Holder1 ?? _nomineeDetailWithDob2Holder1,
  bankDetail1Holder2: bankDetail1Holder2 ?? _bankDetail1Holder2,
  bankDetail2Holder2: bankDetail2Holder2 ?? _bankDetail2Holder2,
  nomineeDetailWithDob1Holder2: nomineeDetailWithDob1Holder2 ?? _nomineeDetailWithDob1Holder2,
  nomineeDetailWithDob2Holder2: nomineeDetailWithDob2Holder2 ?? _nomineeDetailWithDob2Holder2,
  isActive: isActive ?? _isActive,
  pdfLinkForMail: pdfLinkForMail ?? _pdfLinkForMail,
  pdfLinkForMailTime: pdfLinkForMailTime ?? _pdfLinkForMailTime,
  isEstateAnalysisData: isEstateAnalysisData ?? _isEstateAnalysisData,
  isValutData: isValutData ?? _isValutData,
);
  String? get userId => _userId;
  num? get pendingReport => _pendingReport;
  String? get rmFirstName => _rmFirstName;
  String? get rmLastName => _rmLastName;
  String? get userName => _userName;
  String? get roleName => _roleName;
  String? get roleId => _roleId;
  String? get firstName => _firstName;
  String? get firstName2 => _firstName2;
  String? get lastName => _lastName;
  String? get lastName2 => _lastName2;
  String? get email => _email;
  num? get isSuperapp => _isSuperapp;
  String? get password => _password;
  bool? get enableForAutoGeneration => _enableForAutoGeneration;
  String? get contactNo => _contactNo;
  String? get contactNo2 => _contactNo2;
  String? get homeNo1 => _homeNo1;
  String? get homeNo2 => _homeNo2;
  String? get panNo1 => _panNo1;
  String? get panNo2 => _panNo2;
  String? get companyName => _companyName;
  String? get companyName2 => _companyName2;
  String? get address => _address;
  String? get address2 => _address2;
  String? get dob => _dob;
  String? get dob2 => _dob2;
  String? get bankDetail1Holder1 => _bankDetail1Holder1;
  String? get bankDetail2Holder1 => _bankDetail2Holder1;
  String? get nomineeDetailWithDob1Holder1 => _nomineeDetailWithDob1Holder1;
  String? get nomineeDetailWithDob2Holder1 => _nomineeDetailWithDob2Holder1;
  String? get bankDetail1Holder2 => _bankDetail1Holder2;
  String? get bankDetail2Holder2 => _bankDetail2Holder2;
  String? get nomineeDetailWithDob1Holder2 => _nomineeDetailWithDob1Holder2;
  String? get nomineeDetailWithDob2Holder2 => _nomineeDetailWithDob2Holder2;
  String? get isActive => _isActive;
  String? get pdfLinkForMail => _pdfLinkForMail;
  String? get pdfLinkForMailTime => _pdfLinkForMailTime;
  num? get isEstateAnalysisData => _isEstateAnalysisData;
  num? get isValutData => _isValutData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['pending_report'] = _pendingReport;
    map['rm_first_name'] = _rmFirstName;
    map['rm_last_name'] = _rmLastName;
    map['user_name'] = _userName;
    map['role_name'] = _roleName;
    map['role_id'] = _roleId;
    map['first_name'] = _firstName;
    map['first_name_2'] = _firstName2;
    map['last_name'] = _lastName;
    map['last_name_2'] = _lastName2;
    map['email'] = _email;
    map['is_superapp'] = _isSuperapp;
    map['password'] = _password;
    map['enable_for_auto_generation'] = _enableForAutoGeneration;
    map['contact_no'] = _contactNo;
    map['contact_no_2'] = _contactNo2;
    map['home_no_1'] = _homeNo1;
    map['home_no_2'] = _homeNo2;
    map['pan_no_1'] = _panNo1;
    map['pan_no_2'] = _panNo2;
    map['company_name'] = _companyName;
    map['company_name_2'] = _companyName2;
    map['address'] = _address;
    map['address_2'] = _address2;
    map['dob'] = _dob;
    map['dob_2'] = _dob2;
    map['bank_detail1_holder1'] = _bankDetail1Holder1;
    map['bank_detail2_holder1'] = _bankDetail2Holder1;
    map['nominee_detail_with_dob1_holder1'] = _nomineeDetailWithDob1Holder1;
    map['nominee_detail_with_dob2_holder1'] = _nomineeDetailWithDob2Holder1;
    map['bank_detail1_holder2'] = _bankDetail1Holder2;
    map['bank_detail2_holder2'] = _bankDetail2Holder2;
    map['nominee_detail_with_dob1_holder2'] = _nomineeDetailWithDob1Holder2;
    map['nominee_detail_with_dob2_holder2'] = _nomineeDetailWithDob2Holder2;
    map['is_active'] = _isActive;
    map['pdf_link_for_mail'] = _pdfLinkForMail;
    map['pdf_link_for_mail_time'] = _pdfLinkForMailTime;
    map['is_estate_analysis_data'] = _isEstateAnalysisData;
    map['is_valut_data'] = _isValutData;
    return map;
  }

}

/// name : "Manjeet Singh"
/// id : "15"
/// admin_id : "15"
/// first_name : "Manjeet"
/// last_name : "Singh"

RmFpAllEmployees allEmployeesFromJson(String str) => RmFpAllEmployees.fromJson(json.decode(str));
String allEmployeesToJson(RmFpAllEmployees data) => json.encode(data.toJson());
class RmFpAllEmployees {
  RmFpAllEmployees({
      String? name, 
      String? id, 
      String? adminId, 
      String? firstName, 
      String? lastName,}){
    _name = name;
    _id = id;
    _adminId = adminId;
    _firstName = firstName;
    _lastName = lastName;
}

  RmFpAllEmployees.fromJson(dynamic json) {
    _name = json['name'];
    _id = json['id'];
    _adminId = json['admin_id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
  }
  String? _name;
  String? _id;
  String? _adminId;
  String? _firstName;
  String? _lastName;
RmFpAllEmployees copyWith({  String? name,
  String? id,
  String? adminId,
  String? firstName,
  String? lastName,
}) => RmFpAllEmployees(  name: name ?? _name,
  id: id ?? _id,
  adminId: adminId ?? _adminId,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
);
  String? get name => _name;
  String? get id => _id;
  String? get adminId => _adminId;
  String? get firstName => _firstName;
  String? get lastName => _lastName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['id'] = _id;
    map['admin_id'] = _adminId;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    return map;
  }

}