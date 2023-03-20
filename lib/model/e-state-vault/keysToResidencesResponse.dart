import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../utils/app_utils.dart';
/// keys_to_residences : [{"keys_to_residences_id":"20","user_id":"164","holder_id":"97","name":"","phone":"","email":"","location":"test location","holder_name":"","holder":"","timestamp":"1679302774"}]
/// success : 1
/// message : "Keys to residences found."

KeysToResidencesResponse keysToResidencesResponseFromJson(String str) => KeysToResidencesResponse.fromJson(json.decode(str));
String keysToResidencesResponseToJson(KeysToResidencesResponse data) => json.encode(data.toJson());
class KeysToResidencesResponse {
  KeysToResidencesResponse({
      List<KeysToResidences>? keysToResidences, 
      num? success, 
      String? message,}){
    _keysToResidences = keysToResidences;
    _success = success;
    _message = message;
}

  KeysToResidencesResponse.fromJson(dynamic json) {
    if (json['keys_to_residences'] != null) {
      _keysToResidences = [];
      json['keys_to_residences'].forEach((v) {
        _keysToResidences?.add(KeysToResidences.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
  }
  List<KeysToResidences>? _keysToResidences;
  num? _success;
  String? _message;
KeysToResidencesResponse copyWith({  List<KeysToResidences>? keysToResidences,
  num? success,
  String? message,
}) => KeysToResidencesResponse(  keysToResidences: keysToResidences ?? _keysToResidences,
  success: success ?? _success,
  message: message ?? _message,
);
  List<KeysToResidences>? get keysToResidences => _keysToResidences;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_keysToResidences != null) {
      map['keys_to_residences'] = _keysToResidences?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// keys_to_residences_id : "20"
/// user_id : "164"
/// holder_id : "97"
/// name : ""
/// phone : ""
/// email : ""
/// location : "test location"
/// holder_name : ""
/// holder : ""
/// timestamp : "1679302774"

KeysToResidences keysToResidencesFromJson(String str) => KeysToResidences.fromJson(json.decode(str));
String keysToResidencesToJson(KeysToResidences data) => json.encode(data.toJson());
class KeysToResidences {
  KeysToResidences({
      String? keysToResidencesId, 
      String? userId, 
      String? holderId, 
      String? name, 
      String? phone, 
      String? email, 
      String? location, 
      String? holderName, 
      String? holder, 
      String? timestamp,}){
    _keysToResidencesId = keysToResidencesId;
    _userId = userId;
    _holderId = holderId;
    _name = name;
    _phone = phone;
    _email = email;
    _location = location;
    _holderName = holderName;
    _holder = holder;
    _timestamp = timestamp;
}

  KeysToResidences.fromJson(dynamic json) {
    _keysToResidencesId = json['keys_to_residences_id'];
    _userId = json['user_id'];
    _holderId = json['holder_id'];
    _name = json['name'];
    _phone = json['phone'];
    _email = json['email'];
    _location = json['location'];
    _holderName = json['holder_name'];
    _holder = json['holder'];
    _timestamp = json['timestamp'];
  }
  String? _keysToResidencesId;
  String? _userId;
  String? _holderId;
  String? _name;
  String? _phone;
  String? _email;
  String? _location;
  String? _holderName;
  String? _holder;
  String? _timestamp;
KeysToResidences copyWith({  String? keysToResidencesId,
  String? userId,
  String? holderId,
  String? name,
  String? phone,
  String? email,
  String? location,
  String? holderName,
  String? holder,
  String? timestamp,
}) => KeysToResidences(  keysToResidencesId: keysToResidencesId ?? _keysToResidencesId,
  userId: userId ?? _userId,
  holderId: holderId ?? _holderId,
  name: name ?? _name,
  phone: phone ?? _phone,
  email: email ?? _email,
  location: location ?? _location,
  holderName: holderName ?? _holderName,
  holder: holder ?? _holder,
  timestamp: timestamp ?? _timestamp,
);
  String? get keysToResidencesId => _keysToResidencesId;
  String? get userId => _userId;
  String? get holderId => _holderId;
  String? get name => _name;
  String? get phone => _phone;
  String? get email => _email;
  String? get location => _location;
  String? get holderName => _holderName;
  String? get holder => _holder;
  String? get timestamp => _timestamp;

  TextEditingController locationController = TextEditingController();

  set setLocation(String value)
  {
    _location = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['location'] = checkValidString(_location);

    if(checkValidString(_keysToResidencesId).toString().isNotEmpty)
    {
      map['keys_to_residences_id'] = checkValidString(_keysToResidencesId);
    }

    return map;
  }
}