import 'dart:convert';
/// $id : "1"
/// message : null
/// success : true
/// data : [{"$id":"2","PageCount":0,"RowNo":1,"RecordCount":2,"id":291,"employee_id":1,"task_id":5613,"msg_txt":null,"img_url":"https://demo1.coronation.in/alphacapitalreportapp/File/ChatImages/IMG_30102023_204517127.png","img_url_extension":"png","file_name":"Screenshot 2023-09-27 at 8.48.52?PM.png","is_image":true,"added_date":"2023-10-30T20:45:17.143","added_date_format":"30/Oct/2023 08:45:PM","first_name":"Mukesh","last_name":"Jindal"},{"$id":"3","PageCount":0,"RowNo":2,"RecordCount":2,"id":292,"employee_id":1,"task_id":5613,"msg_txt":null,"img_url":"https://demo1.coronation.in/alphacapitalreportapp/File/ChatImages/IMG_30102023_204529703.pdf","img_url_extension":"pdf","file_name":"8856705720.pdf","is_image":true,"added_date":"2023-10-30T20:45:29.72","added_date_format":"30/Oct/2023 08:45:PM","first_name":"Mukesh","last_name":"Jindal"}]

AllTaskAttachemntResponseModel allTaskAttachemntResponseModelFromJson(String str) => AllTaskAttachemntResponseModel.fromJson(json.decode(str));
String allTaskAttachemntResponseModelToJson(AllTaskAttachemntResponseModel data) => json.encode(data.toJson());
class AllTaskAttachemntResponseModel {
  AllTaskAttachemntResponseModel({
      String? id, 
      dynamic message, 
      bool? success, 
      List<TaskAttachemnt>? data,}){
    _id = id;
    _message = message;
    _success = success;
    _data = data;
}

  AllTaskAttachemntResponseModel.fromJson(dynamic json) {
    _id = json['$id'];
    _message = json['message'];
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(TaskAttachemnt.fromJson(v));
      });
    }
  }
  String? _id;
  dynamic _message;
  bool? _success;
  List<TaskAttachemnt>? _data;
AllTaskAttachemntResponseModel copyWith({  String? id,
  dynamic message,
  bool? success,
  List<TaskAttachemnt>? data,
}) => AllTaskAttachemntResponseModel(  id: id ?? _id,
  message: message ?? _message,
  success: success ?? _success,
  data: data ?? _data,
);
  String? get id => _id;
  dynamic get message => _message;
  bool? get success => _success;
  List<TaskAttachemnt>? get data => _data;

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

/// $id : "2"
/// PageCount : 0
/// RowNo : 1
/// RecordCount : 2
/// id : 291
/// employee_id : 1
/// task_id : 5613
/// msg_txt : null
/// img_url : "https://demo1.coronation.in/alphacapitalreportapp/File/ChatImages/IMG_30102023_204517127.png"
/// img_url_extension : "png"
/// file_name : "Screenshot 2023-09-27 at 8.48.52?PM.png"
/// is_image : true
/// added_date : "2023-10-30T20:45:17.143"
/// added_date_format : "30/Oct/2023 08:45:PM"
/// first_name : "Mukesh"
/// last_name : "Jindal"

TaskAttachemnt dataFromJson(String str) => TaskAttachemnt.fromJson(json.decode(str));
String dataToJson(TaskAttachemnt data) => json.encode(data.toJson());
class TaskAttachemnt {
  TaskAttachemnt({
      num? pageCount,
      num? rowNo, 
      num? recordCount, 
      num? id, 
      num? employeeId, 
      num? taskId, 
      dynamic msgTxt, 
      String? imgUrl, 
      String? imgUrlExtension, 
      String? fileName, 
      bool? isImage, 
      String? addedDate, 
      String? addedDateFormat, 
      String? firstName, 
      String? lastName,}){
    _pageCount = pageCount;
    _rowNo = rowNo;
    _recordCount = recordCount;
    _id = id;
    _employeeId = employeeId;
    _taskId = taskId;
    _msgTxt = msgTxt;
    _imgUrl = imgUrl;
    _imgUrlExtension = imgUrlExtension;
    _fileName = fileName;
    _isImage = isImage;
    _addedDate = addedDate;
    _addedDateFormat = addedDateFormat;
    _firstName = firstName;
    _lastName = lastName;
}

  TaskAttachemnt.fromJson(dynamic json) {
    _pageCount = json['PageCount'];
    _rowNo = json['RowNo'];
    _recordCount = json['RecordCount'];
    _id = json['id'];
    _employeeId = json['employee_id'];
    _taskId = json['task_id'];
    _msgTxt = json['msg_txt'];
    _imgUrl = json['img_url'];
    _imgUrlExtension = json['img_url_extension'];
    _fileName = json['file_name'];
    _isImage = json['is_image'];
    _addedDate = json['added_date'];
    _addedDateFormat = json['added_date_format'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
  }
  num? _pageCount;
  num? _rowNo;
  num? _recordCount;
  num? _id;
  num? _employeeId;
  num? _taskId;
  dynamic _msgTxt;
  String? _imgUrl;
  String? _imgUrlExtension;
  String? _fileName;
  bool? _isImage;
  String? _addedDate;
  String? _addedDateFormat;
  String? _firstName;
  String? _lastName;
TaskAttachemnt copyWith({
  num? pageCount,
  num? rowNo,
  num? recordCount,
  num? id,
  num? employeeId,
  num? taskId,
  dynamic msgTxt,
  String? imgUrl,
  String? imgUrlExtension,
  String? fileName,
  bool? isImage,
  String? addedDate,
  String? addedDateFormat,
  String? firstName,
  String? lastName,
}) => TaskAttachemnt(
  pageCount: pageCount ?? _pageCount,
  rowNo: rowNo ?? _rowNo,
  recordCount: recordCount ?? _recordCount,
  id: id ?? _id,
  employeeId: employeeId ?? _employeeId,
  taskId: taskId ?? _taskId,
  msgTxt: msgTxt ?? _msgTxt,
  imgUrl: imgUrl ?? _imgUrl,
  imgUrlExtension: imgUrlExtension ?? _imgUrlExtension,
  fileName: fileName ?? _fileName,
  isImage: isImage ?? _isImage,
  addedDate: addedDate ?? _addedDate,
  addedDateFormat: addedDateFormat ?? _addedDateFormat,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
);
  num? get pageCount => _pageCount;
  num? get rowNo => _rowNo;
  num? get recordCount => _recordCount;
  num? get id => _id;
  num? get employeeId => _employeeId;
  num? get taskId => _taskId;
  dynamic get msgTxt => _msgTxt;
  String? get imgUrl => _imgUrl;
  String? get imgUrlExtension => _imgUrlExtension;
  String? get fileName => _fileName;
  bool? get isImage => _isImage;
  String? get addedDate => _addedDate;
  String? get addedDateFormat => _addedDateFormat;
  String? get firstName => _firstName;
  String? get lastName => _lastName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['PageCount'] = _pageCount;
    map['RowNo'] = _rowNo;
    map['RecordCount'] = _recordCount;
    map['id'] = _id;
    map['employee_id'] = _employeeId;
    map['task_id'] = _taskId;
    map['msg_txt'] = _msgTxt;
    map['img_url'] = _imgUrl;
    map['img_url_extension'] = _imgUrlExtension;
    map['file_name'] = _fileName;
    map['is_image'] = _isImage;
    map['added_date'] = _addedDate;
    map['added_date_format'] = _addedDateFormat;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    return map;
  }

}