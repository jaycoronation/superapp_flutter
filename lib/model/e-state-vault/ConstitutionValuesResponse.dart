import 'dart:convert';
/// data : [{"id":"45","user_id":"164","notes":"test2","timestamp":"1678439178"},{"id":"44","user_id":"164","notes":"test","timestamp":"1678438825"}]
/// total_count : "2"
/// success : 1
/// message : "Constitution and values found."

ConstitutionValuesResponse constitutionValuesResponseFromJson(String str) => ConstitutionValuesResponse.fromJson(json.decode(str));
String constitutionValuesResponseToJson(ConstitutionValuesResponse data) => json.encode(data.toJson());
class ConstitutionValuesResponse {
  ConstitutionValuesResponse({
      List<Data>? data, 
      String? totalCount, 
      num? success, 
      String? message,}){
    _data = data;
    _totalCount = totalCount;
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
    _totalCount = json['total_count'];
    _success = json['success'];
    _message = json['message'];
  }
  List<Data>? _data;
  String? _totalCount;
  num? _success;
  String? _message;
ConstitutionValuesResponse copyWith({  List<Data>? data,
  String? totalCount,
  num? success,
  String? message,
}) => ConstitutionValuesResponse(  data: data ?? _data,
  totalCount: totalCount ?? _totalCount,
  success: success ?? _success,
  message: message ?? _message,
);
  List<Data>? get data => _data;
  String? get totalCount => _totalCount;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['total_count'] = _totalCount;
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['notes'] = _notes;
    map['timestamp'] = _timestamp;
    return map;
  }

}