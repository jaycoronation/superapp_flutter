import 'dart:convert';
/// $id : "1"
/// message : null
/// success : true
/// data : {"$id":"2","TaskDetail":{"$id":"3","Id":5613,"employee_id":1,"task_status_id":1,"task_message":"@AjayAgarwal Rs. 20 Lacs to be invested in Motilal Oswal Microcap 250 Index Fund","task_desc":null,"due_date":"","due_date_timestamp":null,"created_date_original_timestamp":"1697184162","created_date":"2023-10-30T12:52:09.58","created_date_original":"2023-10-13T13:32:42.213","updated_date":"2023-10-30T12:52:09.58","employee_name":"Mukesh Jindal","task_completed_remark":null,"task_reopen_remark":"We have done the redemption. money is in customer's account. we are waiting for the market to cool down by another 4-5%.","reopen_date":"10/30/2023 12:52:05 PM","created_date_original_str":"10/13/2023 1:32:42 PM","status":null,"isdue":false},"SubTaskDetail":[],"EmployeeList":[{"$id":"4","employee_id":46,"employee_name":"Ajay Agarwal","employee_sortname":"AA"}],"clientList":[{"$id":"5","client_id":44,"client_name":"Laffans Petrochemicals","client_sortname":"LP"}]}

TaskDetailsResponseModel taskDetailsResponseModelFromJson(String str) => TaskDetailsResponseModel.fromJson(json.decode(str));
String taskDetailsResponseModelToJson(TaskDetailsResponseModel data) => json.encode(data.toJson());
class TaskDetailsResponseModel {
  TaskDetailsResponseModel({
      String? id, 
      dynamic message, 
      bool? success, 
      TaskData? data,}){
    _id = id;
    _message = message;
    _success = success;
    _data = data;
}

  TaskDetailsResponseModel.fromJson(dynamic json) {
    _id = json['$id'];
    _message = json['message'];
    _success = json['success'];
    _data = json['data'] != null ? TaskData.fromJson(json['data']) : null;
  }
  String? _id;
  dynamic _message;
  bool? _success;
  TaskData? _data;
TaskDetailsResponseModel copyWith({  String? id,
  dynamic message,
  bool? success,
  TaskData? data,
}) => TaskDetailsResponseModel(  id: id ?? _id,
  message: message ?? _message,
  success: success ?? _success,
  data: data ?? _data,
);
  String? get id => _id;
  dynamic get message => _message;
  bool? get success => _success;
  TaskData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['$id'] = _id;
    map['message'] = _message;
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// $id : "2"
/// TaskDetail : {"$id":"3","Id":5613,"employee_id":1,"task_status_id":1,"task_message":"@AjayAgarwal Rs. 20 Lacs to be invested in Motilal Oswal Microcap 250 Index Fund","task_desc":null,"due_date":"","due_date_timestamp":null,"created_date_original_timestamp":"1697184162","created_date":"2023-10-30T12:52:09.58","created_date_original":"2023-10-13T13:32:42.213","updated_date":"2023-10-30T12:52:09.58","employee_name":"Mukesh Jindal","task_completed_remark":null,"task_reopen_remark":"We have done the redemption. money is in customer's account. we are waiting for the market to cool down by another 4-5%.","reopen_date":"10/30/2023 12:52:05 PM","created_date_original_str":"10/13/2023 1:32:42 PM","status":null,"isdue":false}
/// SubTaskDetail : []
/// EmployeeList : [{"$id":"4","employee_id":46,"employee_name":"Ajay Agarwal","employee_sortname":"AA"}]
/// clientList : [{"$id":"5","client_id":44,"client_name":"Laffans Petrochemicals","client_sortname":"LP"}]

TaskData dataFromJson(String str) => TaskData.fromJson(json.decode(str));
String dataToJson(TaskData data) => json.encode(data.toJson());
class TaskData {
  TaskData({
      String? id, 
      TaskDetail? taskDetail, 
      List<dynamic>? subTaskDetail, 
      List<EmployeeList>? employeeList, 
      List<ClientList>? clientList,}){
    _id = id;
    _taskDetail = taskDetail;
    _subTaskDetail = subTaskDetail;
    _employeeList = employeeList;
    _clientList = clientList;
}

  TaskData.fromJson(dynamic json) {
    _id = json['$id'];
    _taskDetail = json['TaskDetail'] != null ? TaskDetail.fromJson(json['TaskDetail']) : null;
    if (json['SubTaskDetail'] != null) {
      _subTaskDetail = [];
      json['SubTaskDetail'].forEach((v) {
        //_subTaskDetail?.add(Dynamic.fromJson(v));
      });
    }
    if (json['EmployeeList'] != null) {
      _employeeList = [];
      json['EmployeeList'].forEach((v) {
        _employeeList?.add(EmployeeList.fromJson(v));
      });
    }
    if (json['clientList'] != null) {
      _clientList = [];
      json['clientList'].forEach((v) {
        _clientList?.add(ClientList.fromJson(v));
      });
    }
  }
  String? _id;
  TaskDetail? _taskDetail;
  List<dynamic>? _subTaskDetail;
  List<EmployeeList>? _employeeList;
  List<ClientList>? _clientList;
TaskData copyWith({  String? id,
  TaskDetail? taskDetail,
  List<dynamic>? subTaskDetail,
  List<EmployeeList>? employeeList,
  List<ClientList>? clientList,
}) => TaskData(  id: id ?? _id,
  taskDetail: taskDetail ?? _taskDetail,
  subTaskDetail: subTaskDetail ?? _subTaskDetail,
  employeeList: employeeList ?? _employeeList,
  clientList: clientList ?? _clientList,
);
  String? get id => _id;
  TaskDetail? get taskDetail => _taskDetail;
  List<dynamic>? get subTaskDetail => _subTaskDetail;
  List<EmployeeList>? get employeeList => _employeeList;
  List<ClientList>? get clientList => _clientList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['$id'] = _id;
    if (_taskDetail != null) {
      map['TaskDetail'] = _taskDetail?.toJson();
    }
    if (_subTaskDetail != null) {
      map['SubTaskDetail'] = _subTaskDetail?.map((v) => v.toJson()).toList();
    }
    if (_employeeList != null) {
      map['EmployeeList'] = _employeeList?.map((v) => v.toJson()).toList();
    }
    if (_clientList != null) {
      map['clientList'] = _clientList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// $id : "5"
/// client_id : 44
/// client_name : "Laffans Petrochemicals"
/// client_sortname : "LP"

ClientList clientListFromJson(String str) => ClientList.fromJson(json.decode(str));
String clientListToJson(ClientList data) => json.encode(data.toJson());
class ClientList {
  ClientList({
      String? id, 
      num? clientId, 
      String? clientName, 
      String? clientSortname,}){
    _id = id;
    _clientId = clientId;
    _clientName = clientName;
    _clientSortname = clientSortname;
}

  ClientList.fromJson(dynamic json) {
    _id = json['$id'];
    _clientId = json['client_id'];
    _clientName = json['client_name'];
    _clientSortname = json['client_sortname'];
  }
  String? _id;
  num? _clientId;
  String? _clientName;
  String? _clientSortname;
ClientList copyWith({  String? id,
  num? clientId,
  String? clientName,
  String? clientSortname,
}) => ClientList(  id: id ?? _id,
  clientId: clientId ?? _clientId,
  clientName: clientName ?? _clientName,
  clientSortname: clientSortname ?? _clientSortname,
);
  String? get id => _id;
  num? get clientId => _clientId;
  String? get clientName => _clientName;
  String? get clientSortname => _clientSortname;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['$id'] = _id;
    map['client_id'] = _clientId;
    map['client_name'] = _clientName;
    map['client_sortname'] = _clientSortname;
    return map;
  }

}

/// $id : "4"
/// employee_id : 46
/// employee_name : "Ajay Agarwal"
/// employee_sortname : "AA"

EmployeeList employeeListFromJson(String str) => EmployeeList.fromJson(json.decode(str));
String employeeListToJson(EmployeeList data) => json.encode(data.toJson());
class EmployeeList {
  EmployeeList({
      String? id, 
      num? employeeId, 
      String? employeeName, 
      String? employeeSortname,}){
    _id = id;
    _employeeId = employeeId;
    _employeeName = employeeName;
    _employeeSortname = employeeSortname;
}

  EmployeeList.fromJson(dynamic json) {
    _id = json['$id'];
    _employeeId = json['employee_id'];
    _employeeName = json['employee_name'];
    _employeeSortname = json['employee_sortname'];
  }
  String? _id;
  num? _employeeId;
  String? _employeeName;
  String? _employeeSortname;
EmployeeList copyWith({  String? id,
  num? employeeId,
  String? employeeName,
  String? employeeSortname,
}) => EmployeeList(  id: id ?? _id,
  employeeId: employeeId ?? _employeeId,
  employeeName: employeeName ?? _employeeName,
  employeeSortname: employeeSortname ?? _employeeSortname,
);
  String? get id => _id;
  num? get employeeId => _employeeId;
  String? get employeeName => _employeeName;
  String? get employeeSortname => _employeeSortname;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['$id'] = _id;
    map['employee_id'] = _employeeId;
    map['employee_name'] = _employeeName;
    map['employee_sortname'] = _employeeSortname;
    return map;
  }

}

/// $id : "3"
/// Id : 5613
/// employee_id : 1
/// task_status_id : 1
/// task_message : "@AjayAgarwal Rs. 20 Lacs to be invested in Motilal Oswal Microcap 250 Index Fund"
/// task_desc : null
/// due_date : ""
/// due_date_timestamp : null
/// created_date_original_timestamp : "1697184162"
/// created_date : "2023-10-30T12:52:09.58"
/// created_date_original : "2023-10-13T13:32:42.213"
/// updated_date : "2023-10-30T12:52:09.58"
/// employee_name : "Mukesh Jindal"
/// task_completed_remark : null
/// task_reopen_remark : "We have done the redemption. money is in customer's account. we are waiting for the market to cool down by another 4-5%."
/// reopen_date : "10/30/2023 12:52:05 PM"
/// created_date_original_str : "10/13/2023 1:32:42 PM"
/// status : null
/// isdue : false

TaskDetail taskDetailFromJson(String str) => TaskDetail.fromJson(json.decode(str));
String taskDetailToJson(TaskDetail data) => json.encode(data.toJson());
class TaskDetail {
  TaskDetail({
      num? id,
      num? employeeId, 
      num? taskStatusId, 
      String? taskMessage,
      String? taskDesc,
      String? dueDate, 
      dynamic dueDateTimestamp, 
      String? createdDateOriginalTimestamp, 
      String? createdDate, 
      String? createdDateOriginal, 
      String? updatedDate, 
      String? employeeName, 
      dynamic taskCompletedRemark, 
      String? taskReopenRemark, 
      String? reopenDate, 
      String? createdDateOriginalStr, 
      String? allEmployeeIdsSupervisor,
      String? allEmployeeNameSupervisor,
      dynamic status,
      bool? isdue,}){
    _id = id;
    _employeeId = employeeId;
    _taskStatusId = taskStatusId;
    _taskMessage = taskMessage;
    _taskDesc = taskDesc;
    _dueDate = dueDate;
    _dueDateTimestamp = dueDateTimestamp;
    _createdDateOriginalTimestamp = createdDateOriginalTimestamp;
    _createdDate = createdDate;
    _createdDateOriginal = createdDateOriginal;
    _updatedDate = updatedDate;
    _employeeName = employeeName;
    _taskCompletedRemark = taskCompletedRemark;
    _taskReopenRemark = taskReopenRemark;
    _reopenDate = reopenDate;
    _createdDateOriginalStr = createdDateOriginalStr;
    _allEmployeeIdsSupervisor = allEmployeeIdsSupervisor;
    _allEmployeeNameSupervisor = allEmployeeNameSupervisor;
    _status = status;
    _isdue = isdue;
}

  TaskDetail.fromJson(dynamic json) {
    _id = json['Id'];
    _employeeId = json['employee_id'];
    _taskStatusId = json['task_status_id'];
    _taskMessage = json['task_message'];
    _taskDesc = json['task_desc'];
    _dueDate = json['due_date'];
    _dueDateTimestamp = json['due_date_timestamp'];
    _createdDateOriginalTimestamp = json['created_date_original_timestamp'];
    _createdDate = json['created_date'];
    _createdDateOriginal = json['created_date_original'];
    _updatedDate = json['updated_date'];
    _employeeName = json['employee_name'];
    _taskCompletedRemark = json['task_completed_remark'];
    _taskReopenRemark = json['task_reopen_remark'];
    _reopenDate = json['reopen_date'];
    _createdDateOriginalStr = json['created_date_original_str'];
    _allEmployeeIdsSupervisor = json['all_employee_ids_supervisor'];
    _allEmployeeNameSupervisor = json['all_employee_ids_supervisor'];
    _status = json['status'];
    _isdue = json['isdue'];
  }
  num? _id;
  num? _employeeId;
  num? _taskStatusId;
  String? _taskMessage;
  String? _taskDesc;
  String? _dueDate;
  dynamic _dueDateTimestamp;
  String? _createdDateOriginalTimestamp;
  String? _createdDate;
  String? _createdDateOriginal;
  String? _updatedDate;
  String? _employeeName;
  dynamic _taskCompletedRemark;
  String? _taskReopenRemark;
  String? _reopenDate;
  String? _createdDateOriginalStr;
  String? _allEmployeeIdsSupervisor;
  String? _allEmployeeNameSupervisor;
  dynamic _status;
  bool? _isdue;
TaskDetail copyWith({
  num? id,
  num? employeeId,
  num? taskStatusId,
  String? taskMessage,
  String? taskDesc,
  String? dueDate,
  dynamic dueDateTimestamp,
  String? createdDateOriginalTimestamp,
  String? createdDate,
  String? createdDateOriginal,
  String? updatedDate,
  String? employeeName,
  dynamic taskCompletedRemark,
  String? taskReopenRemark,
  String? reopenDate,
  String? createdDateOriginalStr,
  String? allEmployeeIdsSupervisor,
  String? allEmployeeNameSupervisor,
  dynamic status,
  bool? isdue,
}) => TaskDetail(
  id: id ?? _id,
  employeeId: employeeId ?? _employeeId,
  taskStatusId: taskStatusId ?? _taskStatusId,
  taskMessage: taskMessage ?? _taskMessage,
  taskDesc: taskDesc ?? _taskDesc,
  dueDate: dueDate ?? _dueDate,
  dueDateTimestamp: dueDateTimestamp ?? _dueDateTimestamp,
  createdDateOriginalTimestamp: createdDateOriginalTimestamp ?? _createdDateOriginalTimestamp,
  createdDate: createdDate ?? _createdDate,
  createdDateOriginal: createdDateOriginal ?? _createdDateOriginal,
  updatedDate: updatedDate ?? _updatedDate,
  employeeName: employeeName ?? _employeeName,
  taskCompletedRemark: taskCompletedRemark ?? _taskCompletedRemark,
  taskReopenRemark: taskReopenRemark ?? _taskReopenRemark,
  reopenDate: reopenDate ?? _reopenDate,
  createdDateOriginalStr: createdDateOriginalStr ?? _createdDateOriginalStr,
  allEmployeeIdsSupervisor: allEmployeeIdsSupervisor ?? _allEmployeeIdsSupervisor,
  allEmployeeNameSupervisor: allEmployeeNameSupervisor ?? _allEmployeeNameSupervisor,
  status: status ?? _status,
  isdue: isdue ?? _isdue,
);
  num? get id => _id;
  num? get employeeId => _employeeId;
  num? get taskStatusId => _taskStatusId;

  set taskStatusId(num? value) {
    _taskStatusId = value;
  }

  String? get taskMessage => _taskMessage;
  String? get taskDesc => _taskDesc;

  set taskDesc(String? value) {
    _taskDesc = value;
  }

  String? get dueDate => _dueDate;
  dynamic get dueDateTimestamp => _dueDateTimestamp;
  String? get createdDateOriginalTimestamp => _createdDateOriginalTimestamp;
  String? get createdDate => _createdDate;
  String? get createdDateOriginal => _createdDateOriginal;
  String? get updatedDate => _updatedDate;
  String? get employeeName => _employeeName;
  dynamic get taskCompletedRemark => _taskCompletedRemark;
  String? get taskReopenRemark => _taskReopenRemark;
  String? get reopenDate => _reopenDate;
  String? get createdDateOriginalStr => _createdDateOriginalStr;
  String? get allEmployeeIdsSupervisor => _allEmployeeIdsSupervisor;
  String? get allEmployeeNameSupervisor => _allEmployeeNameSupervisor;
  dynamic get status => _status;
  bool? get isdue => _isdue;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['$id'] = _id;
    map['Id'] = _id;
    map['employee_id'] = _employeeId;
    map['task_status_id'] = _taskStatusId;
    map['task_message'] = _taskMessage;
    map['task_desc'] = _taskDesc;
    map['due_date'] = _dueDate;
    map['due_date_timestamp'] = _dueDateTimestamp;
    map['created_date_original_timestamp'] = _createdDateOriginalTimestamp;
    map['created_date'] = _createdDate;
    map['created_date_original'] = _createdDateOriginal;
    map['updated_date'] = _updatedDate;
    map['employee_name'] = _employeeName;
    map['task_completed_remark'] = _taskCompletedRemark;
    map['task_reopen_remark'] = _taskReopenRemark;
    map['reopen_date'] = _reopenDate;
    map['created_date_original_str'] = _createdDateOriginalStr;
    map['all_employee_ids_supervisor'] = _allEmployeeIdsSupervisor;
    map['all_employee_name_supervisor'] = _allEmployeeNameSupervisor;
    map['status'] = _status;
    map['isdue'] = _isdue;
    return map;
  }

}