import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../utils/app_utils.dart';
/// employment_related_details : [{"employment_related_id":"22","user_id":"164","holder_id":"97","type_nature_amount":"3000","company":"Coronation","contact":"Ravi Patel","address":"506 coronation","holder":"A","holder_name":"","phone":"8469940500","nominee_name":"Maharshi Saparia","timestamp":"1678950502"}]
/// success : 1
/// message : "Employment related details found."

EmploymentRelatedResponse employmentRelatedResponseFromJson(String str) => EmploymentRelatedResponse.fromJson(json.decode(str));
String employmentRelatedResponseToJson(EmploymentRelatedResponse data) => json.encode(data.toJson());
class EmploymentRelatedResponse {
  EmploymentRelatedResponse({
      List<EmploymentRelatedDetails>? employmentRelatedDetails, 
      num? success, 
      String? message,}){
    _employmentRelatedDetails = employmentRelatedDetails;
    _success = success;
    _message = message;
}

  EmploymentRelatedResponse.fromJson(dynamic json) {
    if (json['employment_related_details'] != null) {
      _employmentRelatedDetails = [];
      json['employment_related_details'].forEach((v) {
        _employmentRelatedDetails?.add(EmploymentRelatedDetails.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
  }
  List<EmploymentRelatedDetails>? _employmentRelatedDetails;
  num? _success;
  String? _message;
EmploymentRelatedResponse copyWith({  List<EmploymentRelatedDetails>? employmentRelatedDetails,
  num? success,
  String? message,
}) => EmploymentRelatedResponse(  employmentRelatedDetails: employmentRelatedDetails ?? _employmentRelatedDetails,
  success: success ?? _success,
  message: message ?? _message,
);
  List<EmploymentRelatedDetails>? get employmentRelatedDetails => _employmentRelatedDetails;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_employmentRelatedDetails != null) {
      map['employment_related_details'] = _employmentRelatedDetails?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// employment_related_id : "22"
/// user_id : "164"
/// holder_id : "97"
/// type_nature_amount : "3000"
/// company : "Coronation"
/// contact : "Ravi Patel"
/// address : "506 coronation"
/// holder : "A"
/// holder_name : ""
/// phone : "8469940500"
/// nominee_name : "Maharshi Saparia"
/// timestamp : "1678950502"

EmploymentRelatedDetails employmentRelatedDetailsFromJson(String str) => EmploymentRelatedDetails.fromJson(json.decode(str));
String employmentRelatedDetailsToJson(EmploymentRelatedDetails data) => json.encode(data.toJson());
class EmploymentRelatedDetails {
  EmploymentRelatedDetails({
      String? employmentRelatedId, 
      String? userId, 
      String? holderId, 
      String? typeNatureAmount, 
      String? company, 
      String? contact, 
      String? address, 
      String? holder, 
      String? holderName, 
      String? phone, 
      String? nomineeName, 
      String? timestamp,}){
    _employmentRelatedId = employmentRelatedId;
    _userId = userId;
    _holderId = holderId;
    _typeNatureAmount = typeNatureAmount;
    _company = company;
    _contact = contact;
    _address = address;
    _holder = holder;
    _holderName = holderName;
    _phone = phone;
    _nomineeName = nomineeName;
    _timestamp = timestamp;
}

  EmploymentRelatedDetails.fromJson(dynamic json) {
    _employmentRelatedId = json['employment_related_id'];
    _userId = json['user_id'];
    _holderId = json['holder_id'];
    _typeNatureAmount = json['type_nature_amount'];
    _company = json['company'];
    _contact = json['contact'];
    _address = json['address'];
    _holder = json['holder'];
    _holderName = json['holder_name'];
    _phone = json['phone'];
    _nomineeName = json['nominee_name'];
    _timestamp = json['timestamp'];
  }
  String? _employmentRelatedId;
  String? _userId;
  String? _holderId;
  String? _typeNatureAmount;
  String? _company;
  String? _contact;
  String? _address;
  String? _holder;
  String? _holderName;
  String? _phone;
  String? _nomineeName;
  String? _timestamp;
EmploymentRelatedDetails copyWith({  String? employmentRelatedId,
  String? userId,
  String? holderId,
  String? typeNatureAmount,
  String? company,
  String? contact,
  String? address,
  String? holder,
  String? holderName,
  String? phone,
  String? nomineeName,
  String? timestamp,
}) => EmploymentRelatedDetails(  employmentRelatedId: employmentRelatedId ?? _employmentRelatedId,
  userId: userId ?? _userId,
  holderId: holderId ?? _holderId,
  typeNatureAmount: typeNatureAmount ?? _typeNatureAmount,
  company: company ?? _company,
  contact: contact ?? _contact,
  address: address ?? _address,
  holder: holder ?? _holder,
  holderName: holderName ?? _holderName,
  phone: phone ?? _phone,
  nomineeName: nomineeName ?? _nomineeName,
  timestamp: timestamp ?? _timestamp,
);
  String? get employmentRelatedId => _employmentRelatedId;
  String? get userId => _userId;
  String? get holderId => _holderId;
  String? get typeNatureAmount => _typeNatureAmount;
  String? get company => _company;
  String? get contact => _contact;
  String? get address => _address;
  String? get holder => _holder;
  String? get holderName => _holderName;
  String? get phone => _phone;
  String? get nomineeName => _nomineeName;
  String? get timestamp => _timestamp;

  TextEditingController typeNameAmountController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController contactPersonController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nomineeNameController = TextEditingController();

  set setTypeNameAmount(String value)
  {
    _typeNatureAmount = value;
  }

  set setCompany(String value)
  {
    _company = value;
  }

  set setContactPerson(String value)
  {
    _contact = value;
  }

  set setAddress(String value)
  {
    _address = value;
  }

  set setPhone(String value)
  {
    _phone = value;
  }

  set setNomineeName(String value)
  {
    _nomineeName = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['holder'] = checkValidString(_holder);
    map['type_nature_amount'] = checkValidString(typeNatureAmount);
    map['company'] = checkValidString(company);
    map['contact'] = checkValidString(contact);
    map['address'] = checkValidString(address);
    map['phone'] = checkValidString(phone);
    map['nominee_name'] = checkValidString(nomineeName);
    if(checkValidString(_employmentRelatedId).toString().isNotEmpty)
    {
      map['employment_related_id'] = checkValidString(_employmentRelatedId);
    }

    return map;
  }

}