import 'dart:convert';
/// $id : "1"
/// message : null
/// success : true
/// Recommendation_data : [{"$id":"2","id":19,"client_id":21,"employee_id":1,"employee_id_assign":1,"title":"Suggested Investment Plan – Alpha Capital |","description":"<p>sdfsadf asdfasdf</p>","added_date":"2025-06-05T16:45:02.75","employee_f_name":"Mukesh","employee_l_name":"Jindal","is_mail_sent_to_client":true,"file_path":null,"file_path2":null,"sfile_name":null,"sfile_name2":null}]

RecommendationListResponseModel recommendationListResponseModelFromJson(String str) => RecommendationListResponseModel.fromJson(json.decode(str));
String recommendationListResponseModelToJson(RecommendationListResponseModel data) => json.encode(data.toJson());
class RecommendationListResponseModel {
  RecommendationListResponseModel({
      String? id, 
      dynamic message, 
      bool? success, 
      List<RecommendationData>? recommendationData,}){
    _id = id;
    _message = message;
    _success = success;
    _recommendationData = recommendationData;
}

  RecommendationListResponseModel.fromJson(dynamic json) {
    _id = json['$id'];
    _message = json['message'];
    _success = json['success'];
    if (json['data'] != null) {
      _recommendationData = [];
      json['data'].forEach((v) {
        _recommendationData?.add(RecommendationData.fromJson(v));
      });
    }
  }
  String? _id;
  dynamic _message;
  bool? _success;
  List<RecommendationData>? _recommendationData;
RecommendationListResponseModel copyWith({  String? id,
  dynamic message,
  bool? success,
  List<RecommendationData>? recommendationData,
}) => RecommendationListResponseModel(  id: id ?? _id,
  message: message ?? _message,
  success: success ?? _success,
  recommendationData: recommendationData ?? _recommendationData,
);
  String? get id => _id;
  dynamic get message => _message;
  bool? get success => _success;
  List<RecommendationData>? get recommendationData => _recommendationData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['$id'] = _id;
    map['message'] = _message;
    map['success'] = _success;
    if (_recommendationData != null) {
      map['Recommendation_data'] = _recommendationData?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// $id : "2"
/// id : 19
/// client_id : 21
/// employee_id : 1
/// employee_id_assign : 1
/// title : "Suggested Investment Plan – Alpha Capital |"
/// description : "<p>sdfsadf asdfasdf</p>"
/// added_date : "2025-06-05T16:45:02.75"
/// employee_f_name : "Mukesh"
/// employee_l_name : "Jindal"
/// is_mail_sent_to_client : true
/// file_path : null
/// file_path2 : null
/// sfile_name : null
/// sfile_name2 : null

RecommendationData recommendationDataFromJson(String str) => RecommendationData.fromJson(json.decode(str));
String recommendationDataToJson(RecommendationData data) => json.encode(data.toJson());
class RecommendationData {
  RecommendationData({
      String? id, 
      num? idNum,
      num? clientId, 
      num? employeeId, 
      num? employeeIdAssign, 
      String? title, 
      String? description, 
      String? addedDate, 
      String? employeeFName, 
      String? employeeLName, 
      bool? isMailSentToClient, 
      dynamic filePath, 
      dynamic filePath2, 
      dynamic sfileName, 
      dynamic sfileName2,}){
    _id = id;
    _idNum = idNum;
    _clientId = clientId;
    _employeeId = employeeId;
    _employeeIdAssign = employeeIdAssign;
    _title = title;
    _description = description;
    _addedDate = addedDate;
    _employeeFName = employeeFName;
    _employeeLName = employeeLName;
    _isMailSentToClient = isMailSentToClient;
    _filePath = filePath;
    _filePath2 = filePath2;
    _sfileName = sfileName;
    _sfileName2 = sfileName2;
}

  RecommendationData.fromJson(dynamic json) {
    _id = json['$id'];
    _idNum = json['id'];
    _clientId = json['client_id'];
    _employeeId = json['employee_id'];
    _employeeIdAssign = json['employee_id_assign'];
    _title = json['title'];
    _description = json['description'];
    _addedDate = json['added_date'];
    _employeeFName = json['employee_f_name'];
    _employeeLName = json['employee_l_name'];
    _isMailSentToClient = json['is_mail_sent_to_client'];
    _filePath = json['file_path'];
    _filePath2 = json['file_path2'];
    _sfileName = json['sfile_name'];
    _sfileName2 = json['sfile_name2'];
  }
  String? _id;
  num? _idNum;
  num? _clientId;
  num? _employeeId;
  num? _employeeIdAssign;
  String? _title;
  String? _description;
  String? _addedDate;
  String? _employeeFName;
  String? _employeeLName;
  bool? _isMailSentToClient;
  dynamic _filePath;
  dynamic _filePath2;
  dynamic _sfileName;
  dynamic _sfileName2;
RecommendationData copyWith({  String? id,
  num? idNum,
  num? clientId,
  num? employeeId,
  num? employeeIdAssign,
  String? title,
  String? description,
  String? addedDate,
  String? employeeFName,
  String? employeeLName,
  bool? isMailSentToClient,
  dynamic filePath,
  dynamic filePath2,
  dynamic sfileName,
  dynamic sfileName2,
}) => RecommendationData(  id: id ?? _id,
  idNum: idNum ?? _idNum,
  clientId: clientId ?? _clientId,
  employeeId: employeeId ?? _employeeId,
  employeeIdAssign: employeeIdAssign ?? _employeeIdAssign,
  title: title ?? _title,
  description: description ?? _description,
  addedDate: addedDate ?? _addedDate,
  employeeFName: employeeFName ?? _employeeFName,
  employeeLName: employeeLName ?? _employeeLName,
  isMailSentToClient: isMailSentToClient ?? _isMailSentToClient,
  filePath: filePath ?? _filePath,
  filePath2: filePath2 ?? _filePath2,
  sfileName: sfileName ?? _sfileName,
  sfileName2: sfileName2 ?? _sfileName2,
);
  String? get id => _id;
  num? get idNum => _idNum;
  num? get clientId => _clientId;
  num? get employeeId => _employeeId;
  num? get employeeIdAssign => _employeeIdAssign;
  String? get title => _title;
  String? get description => _description;
  String? get addedDate => _addedDate;
  String? get employeeFName => _employeeFName;
  String? get employeeLName => _employeeLName;
  bool? get isMailSentToClient => _isMailSentToClient;
  dynamic get filePath => _filePath;
  dynamic get filePath2 => _filePath2;
  dynamic get sfileName => _sfileName;
  dynamic get sfileName2 => _sfileName2;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['$id'] = _id;
    map['id'] = _idNum;
    map['client_id'] = _clientId;
    map['employee_id'] = _employeeId;
    map['employee_id_assign'] = _employeeIdAssign;
    map['title'] = _title;
    map['description'] = _description;
    map['added_date'] = _addedDate;
    map['employee_f_name'] = _employeeFName;
    map['employee_l_name'] = _employeeLName;
    map['is_mail_sent_to_client'] = _isMailSentToClient;
    map['file_path'] = _filePath;
    map['file_path2'] = _filePath2;
    map['sfile_name'] = _sfileName;
    map['sfile_name2'] = _sfileName2;
    return map;
  }

}