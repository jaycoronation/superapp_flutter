import 'dart:convert';
/// success : 1
/// rm_details : {"first_name":"Mukesh","last_name":"Jindal","contact_no":"9891857434","email":"mukesh@alphacapital.in"}
/// supervisor_details : {"name":"Mukesh Jindal","contact":"9891857434","email":"mukesh@alphacapital.in"}
/// message : "Rm details found"

ContactRmDetailResponseModel contactRmDetailResponseModelFromJson(String str) => ContactRmDetailResponseModel.fromJson(json.decode(str));
String contactRmDetailResponseModelToJson(ContactRmDetailResponseModel data) => json.encode(data.toJson());
class ContactRmDetailResponseModel {
  ContactRmDetailResponseModel({
      num? success, 
      RmDetails? rmDetails, 
      SupervisorDetails? supervisorDetails, 
      String? message,}){
    _success = success;
    _rmDetails = rmDetails;
    _supervisorDetails = supervisorDetails;
    _message = message;
}

  ContactRmDetailResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    if (json['rm_details'] is Map<String, dynamic>)
    {
      _rmDetails = RmDetails.fromJson(json['rm_details']);
    }
    else
    {
      _rmDetails = null;
    }
    if (json['supervisor_details'] is Map<String, dynamic>)
    {
      _supervisorDetails = SupervisorDetails.fromJson(json['supervisor_details']);
    }
    else
    {
      _supervisorDetails = null;
    }
    // _rmDetails = json['rm_details'] != null ? RmDetails.fromJson(json['rm_details']) : null;
    // _supervisorDetails = json['supervisor_details'] != null ? SupervisorDetails.fromJson(json['supervisor_details']) : null;
    _message = json['message'];
  }
  num? _success;
  RmDetails? _rmDetails;
  SupervisorDetails? _supervisorDetails;
  String? _message;
ContactRmDetailResponseModel copyWith({  num? success,
  RmDetails? rmDetails,
  SupervisorDetails? supervisorDetails,
  String? message,
}) => ContactRmDetailResponseModel(  success: success ?? _success,
  rmDetails: rmDetails ?? _rmDetails,
  supervisorDetails: supervisorDetails ?? _supervisorDetails,
  message: message ?? _message,
);
  num? get success => _success;
  RmDetails? get rmDetails => _rmDetails;
  SupervisorDetails? get supervisorDetails => _supervisorDetails;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_rmDetails != null) {
      map['rm_details'] = _rmDetails?.toJson();
    }
    if (_supervisorDetails != null) {
      map['supervisor_details'] = _supervisorDetails?.toJson();
    }
    map['message'] = _message;
    return map;
  }

}

/// name : "Mukesh Jindal"
/// contact : "9891857434"
/// email : "mukesh@alphacapital.in"

SupervisorDetails supervisorDetailsFromJson(String str) => SupervisorDetails.fromJson(json.decode(str));
String supervisorDetailsToJson(SupervisorDetails data) => json.encode(data.toJson());
class SupervisorDetails {
  SupervisorDetails({
      String? name, 
      String? contact, 
      String? email,}){
    _name = name;
    _contact = contact;
    _email = email;
}

  SupervisorDetails.fromJson(dynamic json) {
    _name = json['name'];
    _contact = json['contact'];
    _email = json['email'];
  }
  String? _name;
  String? _contact;
  String? _email;
SupervisorDetails copyWith({  String? name,
  String? contact,
  String? email,
}) => SupervisorDetails(  name: name ?? _name,
  contact: contact ?? _contact,
  email: email ?? _email,
);
  String? get name => _name;
  String? get contact => _contact;
  String? get email => _email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['contact'] = _contact;
    map['email'] = _email;
    return map;
  }

}

/// first_name : "Mukesh"
/// last_name : "Jindal"
/// contact_no : "9891857434"
/// email : "mukesh@alphacapital.in"

RmDetails rmDetailsFromJson(String str) => RmDetails.fromJson(json.decode(str));
String rmDetailsToJson(RmDetails data) => json.encode(data.toJson());
class RmDetails {
  RmDetails({
      String? firstName, 
      String? lastName, 
      String? contactNo, 
      String? email,}){
    _firstName = firstName;
    _lastName = lastName;
    _contactNo = contactNo;
    _email = email;
}

  RmDetails.fromJson(dynamic json) {
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _contactNo = json['contact_no'];
    _email = json['email'];
  }
  String? _firstName;
  String? _lastName;
  String? _contactNo;
  String? _email;
RmDetails copyWith({  String? firstName,
  String? lastName,
  String? contactNo,
  String? email,
}) => RmDetails(  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  contactNo: contactNo ?? _contactNo,
  email: email ?? _email,
);
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get contactNo => _contactNo;
  String? get email => _email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['contact_no'] = _contactNo;
    map['email'] = _email;
    return map;
  }

}