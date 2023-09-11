import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:superapp_flutter/utils/app_utils.dart';
/// data : [{"id":"45","user_id":"164","notes":"test2","timestamp":"1678439178"},{"id":"44","user_id":"164","notes":"test","timestamp":"1678438825"}]
/// total_count : "2"
/// success : 1
/// message : "Constitution and values found."

ConstitutionValuesResponse constitutionValuesResponseFromJson(String str) => ConstitutionValuesResponse.fromJson(json.decode(str));
String constitutionValuesResponseToJson(ConstitutionValuesResponse data) => json.encode(data.toJson());
class ConstitutionValuesResponse {
  ConstitutionValuesResponse({
      List<Data>? data, 
      num? success,
      String? message,}){
    _data = data;
    _success = success;
    _message = message;
}

  ConstitutionValuesResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
  }
  List<Data>? _data;
  num? _success;
  String? _message;
ConstitutionValuesResponse copyWith({  List<Data>? data,
  num? success,
  String? message,
}) => ConstitutionValuesResponse(  data: data ?? _data,
  success: success ?? _success,
  message: message ?? _message,
);
  List<Data>? get data => _data;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// id : "45"
/// user_id : "164"
/// notes : "test2"
/// timestamp : "1678439178"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? userId, 
      String? notes, 
      String? timestamp,}){
    _id = id;
    _userId = userId;
    _notes = notes;
    _timestamp = timestamp;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _notes = json['notes'];
    _timestamp = json['timestamp'];
  }
  String? _id;
  String? _userId;
  String? _notes;
  String? _timestamp;
Data copyWith({  String? id,
  String? userId,
  String? notes,
  String? timestamp,
}) => Data(  id: id ?? _id,
  userId: userId ?? _userId,
  notes: notes ?? _notes,
  timestamp: timestamp ?? _timestamp,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get notes => _notes;
  String? get timestamp => _timestamp;

  TextEditingController notesController = TextEditingController();

  set setNotes(String value)
  {
    _notes = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if(checkValidString(_id).toString().isNotEmpty)
    {
        map['id'] = _id;
    }
    map['notes'] = checkValidString(_notes);
    return map;
  }

}