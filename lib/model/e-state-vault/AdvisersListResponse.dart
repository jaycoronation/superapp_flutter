import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../utils/app_utils.dart';
/// advisers : [{"adviser_id":"13","user_id":"164","holder_id":"97","name":"Ravi Patel","phone":"8469940500","address":"506 Coronation","relationship":"Self","holder":"A","holder_name":"","company":"Coronation","timestamp":"1678774391"}]
/// total_count : "1"
/// success : 1
/// message : "Advisers found."

AdvisersListResponse advisersListResponseFromJson(String str) => AdvisersListResponse.fromJson(json.decode(str));
String advisersListResponseToJson(AdvisersListResponse data) => json.encode(data.toJson());
class AdvisersListResponse {
  AdvisersListResponse({
      List<Advisers>? advisers, 
      num? success,
      String? message,}){
    _advisers = advisers;
    _success = success;
    _message = message;
}

  AdvisersListResponse.fromJson(dynamic json) {
    if (json['advisers'] != null) {
      _advisers = [];
      json['advisers'].forEach((v) {
        _advisers?.add(Advisers.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
  }
  List<Advisers>? _advisers;
  num? _success;
  String? _message;
AdvisersListResponse copyWith({  List<Advisers>? advisers,
  num? success,
  String? message,
}) => AdvisersListResponse(  advisers: advisers ?? _advisers,
  success: success ?? _success,
  message: message ?? _message,
);
  List<Advisers>? get advisers => _advisers;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_advisers != null) {
      map['advisers'] = _advisers?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// adviser_id : "13"
/// user_id : "164"
/// holder_id : "97"
/// name : "Ravi Patel"
/// phone : "8469940500"
/// address : "506 Coronation"
/// relationship : "Self"
/// holder : "A"
/// holder_name : ""
/// company : "Coronation"
/// timestamp : "1678774391"

Advisers advisersFromJson(String str) => Advisers.fromJson(json.decode(str));
String advisersToJson(Advisers data) => json.encode(data.toJson());
class Advisers {
  Advisers({
      String? adviserId, 
      String? userId, 
      String? holderId, 
      String? name, 
      String? phone, 
      String? address, 
      String? relationship, 
      String? holder, 
      String? holderName, 
      String? company, 
      String? timestamp,}){
    _adviserId = adviserId;
    _userId = userId;
    _holderId = holderId;
    _name = name;
    _phone = phone;
    _address = address;
    _relationship = relationship;
    _holder = holder;
    _holderName = holderName;
    _company = company;
    _timestamp = timestamp;
}

  Advisers.fromJson(dynamic json) {
    _adviserId = json['adviser_id'];
    _userId = json['user_id'];
    _holderId = json['holder_id'];
    _name = json['name'];
    _phone = json['phone'];
    _address = json['address'];
    _relationship = json['relationship'];
    _holder = json['holder'];
    _holderName = json['holder_name'];
    _company = json['company'];
    _timestamp = json['timestamp'];
  }
  String? _adviserId;
  String? _userId;
  String? _holderId;
  String? _name;
  String? _phone;
  String? _address;
  String? _relationship;
  String? _holder;
  String? _holderName;
  String? _company;
  String? _timestamp;
Advisers copyWith({  String? adviserId,
  String? userId,
  String? holderId,
  String? name,
  String? phone,
  String? address,
  String? relationship,
  String? holder,
  String? holderName,
  String? company,
  String? timestamp,
}) => Advisers(  adviserId: adviserId ?? _adviserId,
  userId: userId ?? _userId,
  holderId: holderId ?? _holderId,
  name: name ?? _name,
  phone: phone ?? _phone,
  address: address ?? _address,
  relationship: relationship ?? _relationship,
  holder: holder ?? _holder,
  holderName: holderName ?? _holderName,
  company: company ?? _company,
  timestamp: timestamp ?? _timestamp,
);
  String? get adviserId => _adviserId;
  String? get userId => _userId;
  String? get holderId => _holderId;
  String? get name => _name;
  String? get phone => _phone;
  String? get address => _address;
  String? get relationship => _relationship;
  String? get holder => _holder;
  String? get holderName => _holderName;
  String? get company => _company;
  String? get timestamp => _timestamp;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController relationshipController = TextEditingController();
  TextEditingController companyController = TextEditingController();

  set setName(String value)
  {
    _name = value;
  }

  set setPhone(String value)
  {
    _phone = value;
  }

  set setAddress(String value)
  {
    _address = value;
  }

  set setRelationship(String value)
  {
    _relationship = value;
  }

  set setCompany(String value)
  {
    _company = value;
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = checkValidString(_name);
    map['phone'] = checkValidString(_phone);
    map['address'] = checkValidString(_address);
    map['relationship'] = checkValidString(_relationship);
    map['company'] = checkValidString(_company);
    map['holder'] = checkValidString(_holder);
    map['adviser_id'] = checkValidString(_adviserId);
    return map;
  }

}