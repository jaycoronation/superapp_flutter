import 'dart:convert';
/// message : ""
/// success : true
/// data : [{"Id":1,"task_status":"Open","added_date":"2019-01-22T15:03:58.607","timestamp":"AAAAAAAL9iM="},{"$id":"3","Id":2,"task_status":"Completed","added_date":"2019-01-22T15:03:58.607","timestamp":"AAAAAAAL9iQ="}]

AllTaskStatusResponseModel allTaskStatusResponseModelFromJson(String str) => AllTaskStatusResponseModel.fromJson(json.decode(str));
String allTaskStatusResponseModelToJson(AllTaskStatusResponseModel data) => json.encode(data.toJson());
class AllTaskStatusResponseModel {
  AllTaskStatusResponseModel({
      String? message, 
      bool? success, 
      List<TaskStatusData>? taskStatusData,}){
    _message = message;
    _success = success;
    _taskStatusData = taskStatusData;
}

  AllTaskStatusResponseModel.fromJson(dynamic json) {
    _message = json['message'];
    _success = json['success'];
    if (json['data'] != null) {
      _taskStatusData = [];
      json['data'].forEach((v) {
        _taskStatusData?.add(TaskStatusData.fromJson(v));
      });
    }
  }
  String? _message;
  bool? _success;
  List<TaskStatusData>? _taskStatusData;
AllTaskStatusResponseModel copyWith({  String? message,
  bool? success,
  List<TaskStatusData>? taskStatusData,
}) => AllTaskStatusResponseModel(  message: message ?? _message,
  success: success ?? _success,
  taskStatusData: taskStatusData ?? _taskStatusData,
);
  String? get message => _message;
  bool? get success => _success;
  List<TaskStatusData>? get taskStatusData => _taskStatusData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['success'] = _success;
    if (_taskStatusData != null) {
      map['data'] = _taskStatusData?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// Id : 1
/// task_status : "Open"
/// added_date : "2019-01-22T15:03:58.607"
/// timestamp : "AAAAAAAL9iM="

TaskStatusData taskStatusDataFromJson(String str) => TaskStatusData.fromJson(json.decode(str));
String taskStatusDataToJson(TaskStatusData data) => json.encode(data.toJson());
class TaskStatusData {
  TaskStatusData({
      num? id, 
      String? taskStatus, 
      String? addedDate, 
      String? timestamp,}){
    _id = id;
    _taskStatus = taskStatus;
    _addedDate = addedDate;
    _timestamp = timestamp;
}

  TaskStatusData.fromJson(dynamic json) {
    _id = json['Id'];
    _taskStatus = json['task_status'];
    _addedDate = json['added_date'];
    _timestamp = json['timestamp'];
  }
  num? _id;
  String? _taskStatus;
  String? _addedDate;
  String? _timestamp;
TaskStatusData copyWith({  num? id,
  String? taskStatus,
  String? addedDate,
  String? timestamp,
}) => TaskStatusData(  id: id ?? _id,
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