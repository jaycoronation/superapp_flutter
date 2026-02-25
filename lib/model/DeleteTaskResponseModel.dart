import 'dart:convert';
/// $id : "1"
/// message : "Task deleted successfully."
/// success : true
/// data : null

DeleteTaskResponseModel deleteTaskResponseModelFromJson(String str) => DeleteTaskResponseModel.fromJson(json.decode(str));
String deleteTaskResponseModelToJson(DeleteTaskResponseModel data) => json.encode(data.toJson());
class DeleteTaskResponseModel {
  DeleteTaskResponseModel({
      String? id, 
      String? message, 
      bool? success, 
      dynamic data,}){
    _id = id;
    _message = message;
    _success = success;
    _data = data;
}

  DeleteTaskResponseModel.fromJson(dynamic json) {
    _id = json['$id'];
    _message = json['message'];
    _success = json['success'];
    _data = json['data'];
  }
  String? _id;
  String? _message;
  bool? _success;
  dynamic _data;
DeleteTaskResponseModel copyWith({  String? id,
  String? message,
  bool? success,
  dynamic data,
}) => DeleteTaskResponseModel(  id: id ?? _id,
  message: message ?? _message,
  success: success ?? _success,
  data: data ?? _data,
);
  String? get id => _id;
  String? get message => _message;
  bool? get success => _success;
  dynamic get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['$id'] = _id;
    map['message'] = _message;
    map['success'] = _success;
    map['data'] = _data;
    return map;
  }

}