import 'dart:convert';
/// message : ""
/// success : true
/// data : [{"id":191,"employee_id":1,"task_id":4063,"msg_txt":"Hi","img_url":"","is_image":false,"added_date":"2023-03-30T12:09:14.387","first_name":"Mukesh","last_name":"Jindal"}]

TaskCommentResponse taskCommentResponseFromJson(String str) => TaskCommentResponse.fromJson(json.decode(str));
String taskCommentResponseToJson(TaskCommentResponse data) => json.encode(data.toJson());
class TaskCommentResponse {
  TaskCommentResponse({
      String? message, 
      bool? success, 
      List<TaskCommentData>? data,}){
    _message = message;
    _success = success;
    _data = data;
}

  TaskCommentResponse.fromJson(dynamic json) {
    _message = json['message'];
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(TaskCommentData.fromJson(v));
      });
    }
  }
  String? _message;
  bool? _success;
  List<TaskCommentData>? _data;
TaskCommentResponse copyWith({  String? message,
  bool? success,
  List<TaskCommentData>? data,
}) => TaskCommentResponse(  message: message ?? _message,
  success: success ?? _success,
  data: data ?? _data,
);
  String? get message => _message;
  bool? get success => _success;
  List<TaskCommentData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 191
/// employee_id : 1
/// task_id : 4063
/// msg_txt : "Hi"
/// img_url : ""
/// is_image : false
/// added_date : "2023-03-30T12:09:14.387"
/// first_name : "Mukesh"
/// last_name : "Jindal"

TaskCommentData dataFromJson(String str) => TaskCommentData.fromJson(json.decode(str));
String dataToJson(TaskCommentData data) => json.encode(data.toJson());
class TaskCommentData {
  TaskCommentData({
      num? id, 
      num? employeeId, 
      num? taskId, 
      String? msgTxt, 
      String? imgUrl, 
      bool? isImage, 
      String? addedDate, 
      String? firstName, 
      String? lastName,}){
    _id = id;
    _employeeId = employeeId;
    _taskId = taskId;
    _msgTxt = msgTxt;
    _imgUrl = imgUrl;
    _isImage = isImage;
    _addedDate = addedDate;
    _firstName = firstName;
    _lastName = lastName;
}

  TaskCommentData.fromJson(dynamic json) {
    _id = json['id'];
    _employeeId = json['client_id'];
    _taskId = json['task_id'];
    _msgTxt = json['msg_txt'];
    _imgUrl = json['img_url'];
    _isImage = json['is_image'];
    _addedDate = json['added_date'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
  }
  num? _id;
  num? _employeeId;
  num? _taskId;
  String? _msgTxt;
  String? _imgUrl;
  bool? _isImage;
  String? _addedDate;
  String? _firstName;
  String? _lastName;
TaskCommentData copyWith({  num? id,
  num? employeeId,
  num? taskId,
  String? msgTxt,
  String? imgUrl,
  bool? isImage,
  String? addedDate,
  String? firstName,
  String? lastName,
}) => TaskCommentData(  id: id ?? _id,
  employeeId: employeeId ?? _employeeId,
  taskId: taskId ?? _taskId,
  msgTxt: msgTxt ?? _msgTxt,
  imgUrl: imgUrl ?? _imgUrl,
  isImage: isImage ?? _isImage,
  addedDate: addedDate ?? _addedDate,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
);
  num? get id => _id;
  num? get employeeId => _employeeId;
  num? get taskId => _taskId;
  String? get msgTxt => _msgTxt;
  String? get imgUrl => _imgUrl;
  bool? get isImage => _isImage;
  String? get addedDate => _addedDate;
  String? get firstName => _firstName;
  String? get lastName => _lastName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['employee_id'] = _employeeId;
    map['task_id'] = _taskId;
    map['msg_txt'] = _msgTxt;
    map['img_url'] = _imgUrl;
    map['is_image'] = _isImage;
    map['added_date'] = _addedDate;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    return map;
  }

}