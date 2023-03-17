import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../utils/app_utils.dart';
/// fiduciary_obligations : [{"fiduciary_obligation_id":"8","user_id":"164","holder_id":"97","holder_name":"","name":"test name","instructions":"test instructions","created_on":"17/03/2023","notes":"test notes","relationship":"test Relationship","types_of_records":"test obligation","contact":"test contact person","phone":"5454546446","address":"506 coronation","holder":"A","timestamp":"1679054590"}]
/// success : 1
/// message : "Fiduciary obligation found."

FiduciaryObligationResponse fiduciaryObligationResponseFromJson(String str) => FiduciaryObligationResponse.fromJson(json.decode(str));
String fiduciaryObligationResponseToJson(FiduciaryObligationResponse data) => json.encode(data.toJson());
class FiduciaryObligationResponse {
  FiduciaryObligationResponse({
      List<FiduciaryObligations>? fiduciaryObligations, 
      num? success, 
      String? message,}){
    _fiduciaryObligations = fiduciaryObligations;
    _success = success;
    _message = message;
}

  FiduciaryObligationResponse.fromJson(dynamic json) {
    if (json['fiduciary_obligations'] != null) {
      _fiduciaryObligations = [];
      json['fiduciary_obligations'].forEach((v) {
        _fiduciaryObligations?.add(FiduciaryObligations.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
  }
  List<FiduciaryObligations>? _fiduciaryObligations;
  num? _success;
  String? _message;
FiduciaryObligationResponse copyWith({  List<FiduciaryObligations>? fiduciaryObligations,
  num? success,
  String? message,
}) => FiduciaryObligationResponse(  fiduciaryObligations: fiduciaryObligations ?? _fiduciaryObligations,
  success: success ?? _success,
  message: message ?? _message,
);
  List<FiduciaryObligations>? get fiduciaryObligations => _fiduciaryObligations;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_fiduciaryObligations != null) {
      map['fiduciary_obligations'] = _fiduciaryObligations?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// fiduciary_obligation_id : "8"
/// user_id : "164"
/// holder_id : "97"
/// holder_name : ""
/// name : "test name"
/// instructions : "test instructions"
/// created_on : "17/03/2023"
/// notes : "test notes"
/// relationship : "test Relationship"
/// types_of_records : "test obligation"
/// contact : "test contact person"
/// phone : "5454546446"
/// address : "506 coronation"
/// holder : "A"
/// timestamp : "1679054590"

FiduciaryObligations fiduciaryObligationsFromJson(String str) => FiduciaryObligations.fromJson(json.decode(str));
String fiduciaryObligationsToJson(FiduciaryObligations data) => json.encode(data.toJson());
class FiduciaryObligations {
  FiduciaryObligations({
      String? fiduciaryObligationId, 
      String? userId, 
      String? holderId, 
      String? holderName, 
      String? name, 
      String? instructions, 
      String? createdOn, 
      String? notes, 
      String? relationship, 
      String? typesOfRecords, 
      String? contact, 
      String? phone, 
      String? address, 
      String? holder, 
      String? timestamp,}){
    _fiduciaryObligationId = fiduciaryObligationId;
    _userId = userId;
    _holderId = holderId;
    _holderName = holderName;
    _name = name;
    _instructions = instructions;
    _createdOn = createdOn;
    _notes = notes;
    _relationship = relationship;
    _typesOfRecords = typesOfRecords;
    _contact = contact;
    _phone = phone;
    _address = address;
    _holder = holder;
    _timestamp = timestamp;
}

  FiduciaryObligations.fromJson(dynamic json) {
    _fiduciaryObligationId = json['fiduciary_obligation_id'];
    _userId = json['user_id'];
    _holderId = json['holder_id'];
    _holderName = json['holder_name'];
    _name = json['name'];
    _instructions = json['instructions'];
    _createdOn = json['created_on'];
    _notes = json['notes'];
    _relationship = json['relationship'];
    _typesOfRecords = json['types_of_records'];
    _contact = json['contact'];
    _phone = json['phone'];
    _address = json['address'];
    _holder = json['holder'];
    _timestamp = json['timestamp'];
  }
  String? _fiduciaryObligationId;
  String? _userId;
  String? _holderId;
  String? _holderName;
  String? _name;
  String? _instructions;
  String? _createdOn;
  String? _notes;
  String? _relationship;
  String? _typesOfRecords;
  String? _contact;
  String? _phone;
  String? _address;
  String? _holder;
  String? _timestamp;
FiduciaryObligations copyWith({  String? fiduciaryObligationId,
  String? userId,
  String? holderId,
  String? holderName,
  String? name,
  String? instructions,
  String? createdOn,
  String? notes,
  String? relationship,
  String? typesOfRecords,
  String? contact,
  String? phone,
  String? address,
  String? holder,
  String? timestamp,
}) => FiduciaryObligations(  fiduciaryObligationId: fiduciaryObligationId ?? _fiduciaryObligationId,
  userId: userId ?? _userId,
  holderId: holderId ?? _holderId,
  holderName: holderName ?? _holderName,
  name: name ?? _name,
  instructions: instructions ?? _instructions,
  createdOn: createdOn ?? _createdOn,
  notes: notes ?? _notes,
  relationship: relationship ?? _relationship,
  typesOfRecords: typesOfRecords ?? _typesOfRecords,
  contact: contact ?? _contact,
  phone: phone ?? _phone,
  address: address ?? _address,
  holder: holder ?? _holder,
  timestamp: timestamp ?? _timestamp,
);
  String? get fiduciaryObligationId => _fiduciaryObligationId;
  String? get userId => _userId;
  String? get holderId => _holderId;
  String? get holderName => _holderName;
  String? get name => _name;
  String? get instructions => _instructions;
  String? get createdOn => _createdOn;
  String? get notes => _notes;
  String? get relationship => _relationship;
  String? get typesOfRecords => _typesOfRecords;
  String? get contact => _contact;
  String? get phone => _phone;
  String? get address => _address;
  String? get holder => _holder;
  String? get timestamp => _timestamp;

  TextEditingController nameController = TextEditingController();
  TextEditingController relationshipController = TextEditingController();
  TextEditingController obligationController = TextEditingController();
  TextEditingController instructionsController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController createdOnController = TextEditingController();
  TextEditingController notesController = TextEditingController();

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
    _typesOfRecords = value;
  }

  set setInstructions(String value)
  {
    _instructions = value;
  }

  set setContact(String value)
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

  set setCreatedOn(String value)
  {
    _createdOn = value;
  }

  set setNotes(String value)
  {
    _notes = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['holder'] = checkValidString(_holder);
    map['name'] = checkValidString(_name);
    map['relationship'] = checkValidString(_relationship);
    map['types_of_records'] = checkValidString(_typesOfRecords);
    map['instructions'] = checkValidString(_instructions);
    map['contact'] = checkValidString(_contact);
    map['address'] = checkValidString(_address);
    map['phone'] = checkValidString(_phone);
    map['created_on'] = checkValidString(_createdOn);
    map['notes'] = checkValidString(_notes);
    if(checkValidString(_fiduciaryObligationId).toString().isNotEmpty)
    {
      map['fiduciary_obligation_id'] = checkValidString(_fiduciaryObligationId);
    }
    return map;
  }

}