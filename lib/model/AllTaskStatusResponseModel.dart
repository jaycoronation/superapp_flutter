import 'dart:convert';
/// $id : "1"
/// message : ""
/// success : true
/// data : [{"Id":1,"task_status":"Open","added_date":"2019-01-22T15:03:58.607","timestamp":"AAAAAAAL9iM="},{"$id":"3","Id":2,"task_status":"Completed","added_date":"2019-01-22T15:03:58.607","timestamp":"AAAAAAAL9iQ="}]

AllTaskStatusResponseModel allTaskStatusResponseModelFromJson(String str) => AllTaskStatusResponseModel.fromJson(json.decode(str));
String allTaskStatusResponseModelToJson(AllTaskStatusResponseModel data) => json.encode(data.toJson());
class AllTaskStatusResponseModel {
  AllTaskStatusResponseModel({
      String? id, 
      String? message,
      bool? success, 
      List<Data>? data,}){
    _id = id;
    _message = message;
    _success = success;
    _data = data;
}

  AllTaskStatusResponseModel.fromJson(dynamic json) {
    _id = json['$id'];
    _message = json['message'];
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  String? _id;
  String? _message;
  bool? _success;
  List<Data>? _data;
AllTaskStatusResponseModel copyWith({  String? id,
  String? message,
  bool? success,
  List<Data>? data,
}) => AllTaskStatusResponseModel(  id: id ?? _id,
  message: message ?? _message,
  success: success ?? _success,
  data: data ?? _data,
);
  String? get id => _id;
  String? get message => _message;
  bool? get success => _success;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['$id'] = _id;
    map['message'] = _message;
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// Id : 1
/// task_status : "Open"
/// added_date : "2019-01-22T15:03:58.607"
/// timestamp : "AAAAAAAL9iM="

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      num? id, 
      String? taskStatus, 
      String? addedDate, 
      String? timestamp,}){
    _id = id;
    _taskStatus = taskStatus;
    _addedDate = addedDate;
    _timestamp = timestamp;
}

  Data.fromJson(dynamic json) {
    _id = json['Id'];
    _taskStatus = json['task_status'];
    _addedDate = json['added_date'];
    _timestamp = json['timestamp'];
  }
  num? _id;
  String? _taskStatus;
  String? _addedDate;
  String? _timestamp;
Data copyWith({  num? id,
  String? taskStatus,
  String? addedDate,
  String? timestamp,
}) => Data(  id: id ?? _id,
  taskStatus: taskStatus ?? _taskStatus,
  addedDate: addedDate ?? _addedDate,
  timestamp: timestamp ?? _timestamp,
);
  num? get id => _id;
  String? get taskStatus => _taskStatus;
  String? get addedDate => _addedDate;
  String? get timestamp => _timestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = _id;
    map['task_status'] = _taskStatus;
    map['added_date'] = _addedDate;
    map['timestamp'] = _timestamp;
    return map;
  }

}