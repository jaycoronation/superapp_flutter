import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../utils/app_utils.dart';
/// charity_related_obligations : [{"charity_related_obligation_id":"9","user_id":"164","holder_id":"97","holder_name":"","organization":"Test Organisation","nature_of_obligation":"test obligation","instructions":"test instructions","contact":"Ravi Patel","phone":"8469940500","address":"506 coronation...","holder":"A","timestamp":"1679051709"}]
/// success : 1
/// message : "Obligations found."

CharityRelatedResponse charityRelatedResponseFromJson(String str) => CharityRelatedResponse.fromJson(json.decode(str));
String charityRelatedResponseToJson(CharityRelatedResponse data) => json.encode(data.toJson());
class CharityRelatedResponse {
  CharityRelatedResponse({
      List<CharityRelatedObligations>? charityRelatedObligations, 
      num? success, 
      String? message,}){
    _charityRelatedObligations = charityRelatedObligations;
    _success = success;
    _message = message;
}

  CharityRelatedResponse.fromJson(dynamic json) {
    if (json['charity_related_obligations'] != null) {
      _charityRelatedObligations = [];
      json['charity_related_obligations'].forEach((v) {
        _charityRelatedObligations?.add(CharityRelatedObligations.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
  }
  List<CharityRelatedObligations>? _charityRelatedObligations;
  num? _success;
  String? _message;
CharityRelatedResponse copyWith({  List<CharityRelatedObligations>? charityRelatedObligations,
  num? success,
  String? message,
}) => CharityRelatedResponse(  charityRelatedObligations: charityRelatedObligations ?? _charityRelatedObligations,
  success: success ?? _success,
  message: message ?? _message,
);
  List<CharityRelatedObligations>? get charityRelatedObligations => _charityRelatedObligations;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_charityRelatedObligations != null) {
      map['charity_related_obligations'] = _charityRelatedObligations?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// charity_related_obligation_id : "9"
/// user_id : "164"
/// holder_id : "97"
/// holder_name : ""
/// organization : "Test Organisation"
/// nature_of_obligation : "test obligation"
/// instructions : "test instructions"
/// contact : "Ravi Patel"
/// phone : "8469940500"
/// address : "506 coronation..."
/// holder : "A"
/// timestamp : "1679051709"

CharityRelatedObligations charityRelatedObligationsFromJson(String str) => CharityRelatedObligations.fromJson(json.decode(str));
String charityRelatedObligationsToJson(CharityRelatedObligations data) => json.encode(data.toJson());
class CharityRelatedObligations {
  CharityRelatedObligations({
      String? charityRelatedObligationId, 
      String? userId, 
      String? holderId, 
      String? holderName, 
      String? organization, 
      String? natureOfObligation, 
      String? instructions, 
      String? contact, 
      String? phone, 
      String? address, 
      String? holder, 
      String? timestamp,}){
    _charityRelatedObligationId = charityRelatedObligationId;
    _userId = userId;
    _holderId = holderId;
    _holderName = holderName;
    _organization = organization;
    _natureOfObligation = natureOfObligation;
    _instructions = instructions;
    _contact = contact;
    _phone = phone;
    _address = address;
    _holder = holder;
    _timestamp = timestamp;
}

  CharityRelatedObligations.fromJson(dynamic json) {
    _charityRelatedObligationId = json['charity_related_obligation_id'];
    _userId = json['user_id'];
    _holderId = json['holder_id'];
    _holderName = json['holder_name'];
    _organization = json['organization'];
    _natureOfObligation = json['nature_of_obligation'];
    _instructions = json['instructions'];
    _contact = json['contact'];
    _phone = json['phone'];
    _address = json['address'];
    _holder = json['holder'];
    _timestamp = json['timestamp'];
  }
  String? _charityRelatedObligationId;
  String? _userId;
  String? _holderId;
  String? _holderName;
  String? _organization;
  String? _natureOfObligation;
  String? _instructions;
  String? _contact;
  String? _phone;
  String? _address;
  String? _holder;
  String? _timestamp;
CharityRelatedObligations copyWith({  String? charityRelatedObligationId,
  String? userId,
  String? holderId,
  String? holderName,
  String? organization,
  String? natureOfObligation,
  String? instructions,
  String? contact,
  String? phone,
  String? address,
  String? holder,
  String? timestamp,
}) => CharityRelatedObligations(  charityRelatedObligationId: charityRelatedObligationId ?? _charityRelatedObligationId,
  userId: userId ?? _userId,
  holderId: holderId ?? _holderId,
  holderName: holderName ?? _holderName,
  organization: organization ?? _organization,
  natureOfObligation: natureOfObligation ?? _natureOfObligation,
  instructions: instructions ?? _instructions,
  contact: contact ?? _contact,
  phone: phone ?? _phone,
  address: address ?? _address,
  holder: holder ?? _holder,
  timestamp: timestamp ?? _timestamp,
);
  String? get charityRelatedObligationId => _charityRelatedObligationId;
  String? get userId => _userId;
  String? get holderId => _holderId;
  String? get holderName => _holderName;
  String? get organization => _organization;
  String? get natureOfObligation => _natureOfObligation;
  String? get instructions => _instructions;
  String? get contact => _contact;
  String? get phone => _phone;
  String? get address => _address;
  String? get holder => _holder;
  String? get timestamp => _timestamp;

  TextEditingController organizationController = TextEditingController();
  TextEditingController natureOfObligationController = TextEditingController();
  TextEditingController instructionsController = TextEditingController();
  TextEditingController contactPersonController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  set setOrganization(String value)
  {
    _organization = value;
  }

  set setNatureOfObligation(String value)
  {
    _natureOfObligation = value;
  }

  set setInstructions(String value)
  {
    _instructions = value;
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['holder'] = checkValidString(_holder);
    map['organization'] = checkValidString(_organization);
    map['nature_of_obligation'] = checkValidString(_natureOfObligation);
    map['instructions'] = checkValidString(_instructions);
    map['contact'] = checkValidString(_contact);
    map['address'] = checkValidString(_address);
    map['phone'] = checkValidString(_phone);
    if(checkValidString(_charityRelatedObligationId).toString().isNotEmpty)
    {
      map['charity_related_obligation_id'] = checkValidString(_charityRelatedObligationId);
    }
    return map;
  }

}