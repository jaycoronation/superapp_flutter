import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../utils/app_utils.dart';
/// former_spouse_of_former_marriages : [{"former_spouse_id":"12","user_id":"164","holder_id":"97","holder_name":"","name":"test name","relationship":"Test Relationship","obligation":"test obligation","phone":"1234567890","address":"Test Address","holder":"A","timestamp":"1679050185"}]
/// success : 1
/// message : "Former spouse/children found."

FormerSpouseResponse formerSpouseResponseFromJson(String str) => FormerSpouseResponse.fromJson(json.decode(str));
String formerSpouseResponseToJson(FormerSpouseResponse data) => json.encode(data.toJson());
class FormerSpouseResponse {
  FormerSpouseResponse({
      List<FormerSpouseOfFormerMarriages>? formerSpouseOfFormerMarriages, 
      num? success, 
      String? message,}){
    _formerSpouseOfFormerMarriages = formerSpouseOfFormerMarriages;
    _success = success;
    _message = message;
}

  FormerSpouseResponse.fromJson(dynamic json) {
    if (json['former_spouse_of_former_marriages'] != null) {
      _formerSpouseOfFormerMarriages = [];
      json['former_spouse_of_former_marriages'].forEach((v) {
        _formerSpouseOfFormerMarriages?.add(FormerSpouseOfFormerMarriages.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
  }
  List<FormerSpouseOfFormerMarriages>? _formerSpouseOfFormerMarriages;
  num? _success;
  String? _message;
FormerSpouseResponse copyWith({  List<FormerSpouseOfFormerMarriages>? formerSpouseOfFormerMarriages,
  num? success,
  String? message,
}) => FormerSpouseResponse(  formerSpouseOfFormerMarriages: formerSpouseOfFormerMarriages ?? _formerSpouseOfFormerMarriages,
  success: success ?? _success,
  message: message ?? _message,
);
  List<FormerSpouseOfFormerMarriages>? get formerSpouseOfFormerMarriages => _formerSpouseOfFormerMarriages;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_formerSpouseOfFormerMarriages != null) {
      map['former_spouse_of_former_marriages'] = _formerSpouseOfFormerMarriages?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// former_spouse_id : "12"
/// user_id : "164"
/// holder_id : "97"
/// holder_name : ""
/// name : "test name"
/// relationship : "Test Relationship"
/// obligation : "test obligation"
/// phone : "1234567890"
/// address : "Test Address"
/// holder : "A"
/// timestamp : "1679050185"

FormerSpouseOfFormerMarriages formerSpouseOfFormerMarriagesFromJson(String str) => FormerSpouseOfFormerMarriages.fromJson(json.decode(str));
String formerSpouseOfFormerMarriagesToJson(FormerSpouseOfFormerMarriages data) => json.encode(data.toJson());
class FormerSpouseOfFormerMarriages {
  FormerSpouseOfFormerMarriages({
      String? formerSpouseId, 
      String? userId, 
      String? holderId, 
      String? holderName, 
      String? name, 
      String? relationship, 
      String? obligation, 
      String? phone, 
      String? address, 
      String? holder, 
      String? timestamp,}){
    _formerSpouseId = formerSpouseId;
    _userId = userId;
    _holderId = holderId;
    _holderName = holderName;
    _name = name;
    _relationship = relationship;
    _obligation = obligation;
    _phone = phone;
    _address = address;
    _holder = holder;
    _timestamp = timestamp;
}

  FormerSpouseOfFormerMarriages.fromJson(dynamic json) {
    _formerSpouseId = json['former_spouse_id'];
    _userId = json['user_id'];
    _holderId = json['holder_id'];
    _holderName = json['holder_name'];
    _name = json['name'];
    _relationship = json['relationship'];
    _obligation = json['obligation'];
    _phone = json['phone'];
    _address = json['address'];
    _holder = json['holder'];
    _timestamp = json['timestamp'];
  }
  String? _formerSpouseId;
  String? _userId;
  String? _holderId;
  String? _holderName;
  String? _name;
  String? _relationship;
  String? _obligation;
  String? _phone;
  String? _address;
  String? _holder;
  String? _timestamp;
FormerSpouseOfFormerMarriages copyWith({  String? formerSpouseId,
  String? userId,
  String? holderId,
  String? holderName,
  String? name,
  String? relationship,
  String? obligation,
  String? phone,
  String? address,
  String? holder,
  String? timestamp,
}) => FormerSpouseOfFormerMarriages(  formerSpouseId: formerSpouseId ?? _formerSpouseId,
  userId: userId ?? _userId,
  holderId: holderId ?? _holderId,
  holderName: holderName ?? _holderName,
  name: name ?? _name,
  relationship: relationship ?? _relationship,
  obligation: obligation ?? _obligation,
  phone: phone ?? _phone,
  address: address ?? _address,
  holder: holder ?? _holder,
  timestamp: timestamp ?? _timestamp,
);
  String? get formerSpouseId => _formerSpouseId;
  String? get userId => _userId;
  String? get holderId => _holderId;
  String? get holderName => _holderName;
  String? get name => _name;
  String? get relationship => _relationship;
  String? get obligation => _obligation;
  String? get phone => _phone;
  String? get address => _address;
  String? get holder => _holder;
  String? get timestamp => _timestamp;

  TextEditingController nameController = TextEditingController();
  TextEditingController relationshipController = TextEditingController();
  TextEditingController obligationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  set setName(String value)
  {
    _name = value;
  }

  set setRelationShip(String value)
  {
    _relationship = value;
  }

  set setObligation(String value)
  {
    _obligation = value;
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
    map['name'] = checkValidString(_name);
    map['relationship'] = checkValidString(_relationship);
    map['obligation'] = checkValidString(_obligation);
    map['address'] = checkValidString(_address);
    map['phone'] = checkValidString(_phone);
    if(checkValidString(_formerSpouseId).toString().isNotEmpty)
    {
      map['former_spouse_id'] = checkValidString(_formerSpouseId);
    }
    return map;
  }
}