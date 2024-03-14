import 'dart:convert';
/// $id : "1"
/// message : null
/// success : true
/// data : {"$id":"2","TaskList":[{"$id":"3","PageCount":0,"RowNo":1,"RecordCount":1,"id":6879,"client_id":"21","employee_id":2,"task_status_id":1,"task_message":"@RaviPatel  Please check report.","task_reopen_remark":null,"task_completed_remark":null,"due_date":null,"created_date":"2024-03-07T14:32:41.613","formated_created_date":"07/03/2024","task_added_by":"Pratik Kalariya","task_status":"Open","all_employee_ids":"2,3","all_employee_name":"Pratik Kalariya,Ravi Patel","all_employee_ids_supervisor":null,"all_employee_name_supervisor":null,"IsPinedTask":false,"PinnedTaskDate":"0001-01-01T00:00:00","unReadCount":0,"lstemployee":null,"lstclient":null}]}

TaskListResponseModel taskListResponseModelFromJson(String str) => TaskListResponseModel.fromJson(json.decode(str));
String taskListResponseModelToJson(TaskListResponseModel data) => json.encode(data.toJson());
class TaskListResponseModel {
  TaskListResponseModel({
      String? id, 
      dynamic message, 
      bool? success, 
      Data? data,}){
    _id = id;
    _message = message;
    _success = success;
    _data = data;
}

  TaskListResponseModel.fromJson(dynamic json) {
    _id = json['$id'];
    _message = json['message'];
    _success = json['success'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _id;
  dynamic _message;
  bool? _success;
  Data? _data;
TaskListResponseModel copyWith({  String? id,
  dynamic message,
  bool? success,
  Data? data,
}) => TaskListResponseModel(  id: id ?? _id,
  message: message ?? _message,
  success: success ?? _success,
  data: data ?? _data,
);
  String? get id => _id;
  dynamic get message => _message;
  bool? get success => _success;
  Data? get data => _data;

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
/// TaskList : [{"$id":"3","PageCount":0,"RowNo":1,"RecordCount":1,"id":6879,"client_id":"21","employee_id":2,"task_status_id":1,"task_message":"@RaviPatel  Please check report.","task_reopen_remark":null,"task_completed_remark":null,"due_date":null,"created_date":"2024-03-07T14:32:41.613","formated_created_date":"07/03/2024","task_added_by":"Pratik Kalariya","task_status":"Open","all_employee_ids":"2,3","all_employee_name":"Pratik Kalariya,Ravi Patel","all_employee_ids_supervisor":null,"all_employee_name_supervisor":null,"IsPinedTask":false,"PinnedTaskDate":"0001-01-01T00:00:00","unReadCount":0,"lstemployee":null,"lstclient":null}]

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      List<TaskList>? taskList,}){
    _id = id;
    _taskList = taskList;
}

  Data.fromJson(dynamic json) {
    _id = json['$id'];
    if (json['TaskList'] != null) {
      _taskList = [];
      json['TaskList'].forEach((v) {
        _taskList?.add(TaskList.fromJson(v));
      });
    }
  }
  String? _id;
  List<TaskList>? _taskList;
Data copyWith({  String? id,
  List<TaskList>? taskList,
}) => Data(  id: id ?? _id,
  taskList: taskList ?? _taskList,
);
  String? get id => _id;
  List<TaskList>? get taskList => _taskList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['$id'] = _id;
    if (_taskList != null) {
      map['TaskList'] = _taskList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// $id : "3"
/// PageCount : 0
/// RowNo : 1
/// RecordCount : 1
/// id : 6879
/// client_id : "21"
/// employee_id : 2
/// task_status_id : 1
/// task_message : "@RaviPatel  Please check report."
/// task_reopen_remark : null
/// task_completed_remark : null
/// due_date : null
/// created_date : "2024-03-07T14:32:41.613"
/// formated_created_date : "07/03/2024"
/// task_added_by : "Pratik Kalariya"
/// task_status : "Open"
/// all_employee_ids : "2,3"
/// all_employee_name : "Pratik Kalariya,Ravi Patel"
/// all_employee_ids_supervisor : null
/// all_employee_name_supervisor : null
/// IsPinedTask : false
/// PinnedTaskDate : "0001-01-01T00:00:00"
/// unReadCount : 0
/// lstemployee : null
/// lstclient : null

TaskList taskListFromJson(String str) => TaskList.fromJson(json.decode(str));
String taskListToJson(TaskList data) => json.encode(data.toJson());
class TaskList {
  TaskList({
      num? pageCount,
      num? rowNo, 
      num? recordCount, 
      num? id, 
      String? clientId, 
      num? employeeId, 
      num? taskStatusId, 
      String? taskMessage, 
      dynamic taskReopenRemark, 
      dynamic taskCompletedRemark, 
      dynamic dueDate, 
      String? createdDate, 
      String? formatedCreatedDate, 
      String? taskAddedBy, 
      String? taskStatus, 
      String? allEmployeeIds, 
      String? allEmployeeName, 
      dynamic allEmployeeIdsSupervisor, 
      dynamic allEmployeeNameSupervisor, 
      bool? isPinedTask, 
      String? pinnedTaskDate, 
      num? unReadCount, 
      dynamic lstemployee, 
      dynamic lstclient,}){
    _pageCount = pageCount;
    _rowNo = rowNo;
    _recordCount = recordCount;
    _id = id;
    _clientId = clientId;
    _employeeId = employeeId;
    _taskStatusId = taskStatusId;
    _taskMessage = taskMessage;
    _taskReopenRemark = taskReopenRemark;
    _taskCompletedRemark = taskCompletedRemark;
    _dueDate = dueDate;
    _createdDate = createdDate;
    _formatedCreatedDate = formatedCreatedDate;
    _taskAddedBy = taskAddedBy;
    _taskStatus = taskStatus;
    _allEmployeeIds = allEmployeeIds;
    _allEmployeeName = allEmployeeName;
    _allEmployeeIdsSupervisor = allEmployeeIdsSupervisor;
    _allEmployeeNameSupervisor = allEmployeeNameSupervisor;
    _isPinedTask = isPinedTask;
    _pinnedTaskDate = pinnedTaskDate;
    _unReadCount = unReadCount;
    _lstemployee = lstemployee;
    _lstclient = lstclient;
}

  TaskList.fromJson(dynamic json) {
    _pageCount = json['PageCount'];
    _rowNo = json['RowNo'];
    _recordCount = json['RecordCount'];
    _id = json['id'];
    _clientId = json['client_id'];
    _employeeId = json['employee_id'];
    _taskStatusId = json['task_status_id'];
    _taskMessage = json['task_message'];
    _taskReopenRemark = json['task_reopen_remark'];
    _taskCompletedRemark = json['task_completed_remark'];
    _dueDate = json['due_date'];
    _createdDate = json['created_date'];
    _formatedCreatedDate = json['formated_created_date'];
    _taskAddedBy = json['task_added_by'];
    _taskStatus = json['task_status'] ;
    _allEmployeeIds = json['all_employee_ids'];
    _allEmployeeName = json['all_employee_name'];
    _allEmployeeIdsSupervisor = json['all_employee_ids_supervisor'];
    _allEmployeeNameSupervisor = json['all_employee_name_supervisor'];
    _isPinedTask = json['IsPinedTask'];
    _pinnedTaskDate = json['PinnedTaskDate'];
    _unReadCount = json['unReadCount'];
    _lstemployee = json['lstemployee'];
    _lstclient = json['lstclient'];
  }
  num? _pageCount;
  num? _rowNo;
  num? _recordCount;
  num? _id;
  String? _clientId;
  num? _employeeId;
  num? _taskStatusId;
  String? _taskMessage;
  dynamic _taskReopenRemark;
  dynamic _taskCompletedRemark;
  dynamic _dueDate;
  String? _createdDate;
  String? _formatedCreatedDate;
  String? _taskAddedBy;
  String? _taskStatus;
  String? _allEmployeeIds;
  String? _allEmployeeName;
  dynamic _allEmployeeIdsSupervisor;
  dynamic _allEmployeeNameSupervisor;
  bool? _isPinedTask;
  String? _pinnedTaskDate;
  num? _unReadCount;
  dynamic _lstemployee;
  dynamic _lstclient;
TaskList copyWith({
  num? pageCount,
  num? rowNo,
  num? recordCount,
  num? id,
  String? clientId,
  num? employeeId,
  num? taskStatusId,
  String? taskMessage,
  dynamic taskReopenRemark,
  dynamic taskCompletedRemark,
  dynamic dueDate,
  String? createdDate,
  String? formatedCreatedDate,
  String? taskAddedBy,
  String? taskStatus,
  String? allEmployeeIds,
  String? allEmployeeName,
  dynamic allEmployeeIdsSupervisor,
  dynamic allEmployeeNameSupervisor,
  bool? isPinedTask,
  String? pinnedTaskDate,
  num? unReadCount,
  dynamic lstemployee,
  dynamic lstclient,
}) => TaskList(
  pageCount: pageCount ?? _pageCount,
  rowNo: rowNo ?? _rowNo,
  recordCount: recordCount ?? _recordCount,
  id: id ?? _id,
  clientId: clientId ?? _clientId,
  employeeId: employeeId ?? _employeeId,
  taskStatusId: taskStatusId ?? _taskStatusId,
  taskMessage: taskMessage ?? _taskMessage,
  taskReopenRemark: taskReopenRemark ?? _taskReopenRemark,
  taskCompletedRemark: taskCompletedRemark ?? _taskCompletedRemark,
  dueDate: dueDate ?? _dueDate,
  createdDate: createdDate ?? _createdDate,
  formatedCreatedDate: formatedCreatedDate ?? _formatedCreatedDate,
  taskAddedBy: taskAddedBy ?? _taskAddedBy,
  taskStatus: taskStatus ?? _taskStatus,
  allEmployeeIds: allEmployeeIds ?? _allEmployeeIds,
  allEmployeeName: allEmployeeName ?? _allEmployeeName,
  allEmployeeIdsSupervisor: allEmployeeIdsSupervisor ?? _allEmployeeIdsSupervisor,
  allEmployeeNameSupervisor: allEmployeeNameSupervisor ?? _allEmployeeNameSupervisor,
  isPinedTask: isPinedTask ?? _isPinedTask,
  pinnedTaskDate: pinnedTaskDate ?? _pinnedTaskDate,
  unReadCount: unReadCount ?? _unReadCount,
  lstemployee: lstemployee ?? _lstemployee,
  lstclient: lstclient ?? _lstclient,
);
  num? get pageCount => _pageCount;
  num? get rowNo => _rowNo;
  num? get recordCount => _recordCount;
  num? get id => _id;
  String? get clientId => _clientId;
  num? get employeeId => _employeeId;
  num? get taskStatusId => _taskStatusId;
  String? get taskMessage => _taskMessage;
  dynamic get taskReopenRemark => _taskReopenRemark;
  dynamic get taskCompletedRemark => _taskCompletedRemark;
  dynamic get dueDate => _dueDate;
  String? get createdDate => _createdDate;
  String? get formatedCreatedDate => _formatedCreatedDate;
  String? get taskAddedBy => _taskAddedBy;
  String? get taskStatus => _taskStatus;
  String? get allEmployeeIds => _allEmployeeIds;
  String? get allEmployeeName => _allEmployeeName;
  dynamic get allEmployeeIdsSupervisor => _allEmployeeIdsSupervisor;
  dynamic get allEmployeeNameSupervisor => _allEmployeeNameSupervisor;
  bool? get isPinedTask => _isPinedTask;
  String? get pinnedTaskDate => _pinnedTaskDate;
  num? get unReadCount => _unReadCount;
  dynamic get lstemployee => _lstemployee;
  dynamic get lstclient => _lstclient;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['PageCount'] = _pageCount;
    map['RowNo'] = _rowNo;
    map['RecordCount'] = _recordCount;
    map['id'] = _id;
    map['client_id'] = _clientId;
    map['employee_id'] = _employeeId;
    map['task_status_id'] = _taskStatusId;
    map['task_message'] = _taskMessage;
    map['task_reopen_remark'] = _taskReopenRemark;
    map['task_completed_remark'] = _taskCompletedRemark;
    map['due_date'] = _dueDate;
    map['created_date'] = _createdDate;
    map['formated_created_date'] = _formatedCreatedDate;
    map['task_added_by'] = _taskAddedBy;
    map['task_status'] = _taskStatus;
    map['all_employee_ids'] = _allEmployeeIds;
    map['all_employee_name'] = _allEmployeeName;
    map['all_employee_ids_supervisor'] = _allEmployeeIdsSupervisor;
    map['all_employee_name_supervisor'] = _allEmployeeNameSupervisor;
    map['IsPinedTask'] = _isPinedTask;
    map['PinnedTaskDate'] = _pinnedTaskDate;
    map['unReadCount'] = _unReadCount;
    map['lstemployee'] = _lstemployee;
    map['lstclient'] = _lstclient;
    return map;
  }

}