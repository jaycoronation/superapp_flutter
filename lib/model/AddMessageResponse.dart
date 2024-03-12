import 'dart:convert';
/// message : "Task Message successfully."
/// success : true
/// data : {"Id":193,"employee_id":52,"task_id":4063,"msg_txt":"Hello Sir","img_url":"","is_image":false,"added_date":"2023-03-30T15:03:23.9622781+05:30","timestamp":"AAAAAAAC8OM="}

AddMessageResponse addMessageResponseFromJson(String str) => AddMessageResponse.fromJson(json.decode(str));
String addMessageResponseToJson(AddMessageResponse data) => json.encode(data.toJson());
class AddMessageResponse {
  AddMessageResponse({
      String? message, 
      bool? success, 
      Data? data,}){
    _message = message;
    _success = success;
    _data = data;
}

  AddMessageResponse.fromJson(dynamic json) {
    _message = json['message'];
    _success = json['success'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _message;
  bool? _success;
  Data? _data;
AddMessageResponse copyWith({  String? message,
  bool? success,
  Data? data,
}) => AddMessageResponse(  message: message ?? _message,
  success: success ?? _success,
  data: data ?? _data,
);
  String? get message => _message;
  bool? get success => _success;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// Id : 193
/// employee_id : 52
/// task_id : 4063
/// msg_txt : "Hello Sir"
/// img_url : ""
/// is_image : false
/// added_date : "2023-03-30T15:03:23.9622781+05:30"
/// timestamp : "AAAAAAAC8OM="

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      num? id, 
      num? employeeId, 
      num? taskId, 
      String? msgTxt, 
      String? imgUrl, 
      bool? isImage, 
      String? addedDate, 
      String? timestamp,}){
    _id = id;
    _employeeId = employeeId;
    _taskId = taskId;
    _msgTxt = msgTxt;
    _imgUrl = imgUrl;
    _isImage = isImage;
    _addedDate = addedDate;
    _timestamp = timestamp;
}

  Data.fromJson(dynamic json) {
    _id = json['Id'];
    _employeeId = json['employee_id'];
    _taskId = json['task_id'];
    _msgTxt = json['msg_txt'];
    _imgUrl = json['img_url'];
    _isImage = json['is_image'];
    _addedDate = json['added_date'];
    _timestamp = json['timestamp'];
  }
  num? _id;
  num? _employeeId;
  num? _taskId;
  String? _msgTxt;
  String? _imgUrl;
  bool? _isImage;
  String? _addedDate;
  String? _timestamp;
Data copyWith({  num? id,
  num? employeeId,
  num? taskId,
  String? msgTxt,
  String? imgUrl,
  bool? isImage,
  String? addedDate,
  String? timestamp,
}) => Data(  id: id ?? _id,
  employeeId: employeeId ?? _employeeId,
  taskId: taskId ?? _taskId,
  msgTxt: msgTxt ?? _msgTxt,
  imgUrl: imgUrl ?? _imgUrl,
  isImage: isImage ?? _isImage,
  addedDate: addedDate ?? _addedDate,
  timestamp: timestamp ?? _timestamp,
);
  num? get id => _id;
  num? get employeeId => _employeeId;
  num? get taskId => _taskId;
  String? get msgTxt => _msgTxt;
  String? get imgUrl => _imgUrl;
  bool? get isImage => _isImage;
  String? get addedDate => _addedDate;
  String? get timestamp => _timestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = _id;
    map['employee_id'] = _employeeId;
    map['task_id'] = _taskId;
    map['msg_txt'] = _msgTxt;
    map['img_url'] = _imgUrl;
    map['is_image'] = _isImage;
    map['added_date'] = _addedDate;
    map['timestamp'] = _timestamp;
    return map;
  }

}