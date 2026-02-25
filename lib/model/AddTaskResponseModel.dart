import 'dart:convert';
/// $id : "1"
/// message : "Task added successfully."
/// success : true
/// data : {"Id":25449,"parent_task_id":0,"employee_id":1,"task_status_id":1,"is_final_task":true,"task_priority":3,"task_message":"New Test Task","due_date":"","task_reopen_by_emp":"","task_completed_by_emp":"","task_completed_remark":"","task_reopen_remark":"","task_deleted_remark":"","reopen_date":"","created_date_original_reopen":"2026-02-24T17:50:03.8568112+05:30","task_desc":"","is_added_by_client":true,"added_by_client_id":2567,"created_date":"2026-02-24T17:50:03.8568112+05:30","updated_date":"2026-02-24T17:50:03.8724341+05:30","timestamp":"AAAAABGEOsk="}

AddTaskResponseModel addTaskResponseModelFromJson(String str) => AddTaskResponseModel.fromJson(json.decode(str));
String addTaskResponseModelToJson(AddTaskResponseModel data) => json.encode(data.toJson());
class AddTaskResponseModel {
  AddTaskResponseModel({
      String? id, 
      String? message, 
      bool? success, 
      AddTaskData? data,}){
    _id = id;
    _message = message;
    _success = success;
    _data = data;
}

  AddTaskResponseModel.fromJson(dynamic json) {
    _id = json['$id'];
    _message = json['message'];
    _success = json['success'];
    _data = json['data'] != null ? AddTaskData.fromJson(json['data']) : null;
  }
  String? _id;
  String? _message;
  bool? _success;
  AddTaskData? _data;
AddTaskResponseModel copyWith({  String? id,
  String? message,
  bool? success,
  AddTaskData? data,
}) => AddTaskResponseModel(  id: id ?? _id,
  message: message ?? _message,
  success: success ?? _success,
  data: data ?? _data,
);
  String? get id => _id;
  String? get message => _message;
  bool? get success => _success;
  AddTaskData? get data => _data;

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

/// Id : 25449
/// parent_task_id : 0
/// employee_id : 1
/// task_status_id : 1
/// is_final_task : true
/// task_priority : 3
/// task_message : "New Test Task"
/// due_date : ""
/// task_reopen_by_emp : ""
/// task_completed_by_emp : ""
/// task_completed_remark : ""
/// task_reopen_remark : ""
/// task_deleted_remark : ""
/// reopen_date : ""
/// created_date_original_reopen : "2026-02-24T17:50:03.8568112+05:30"
/// task_desc : ""
/// is_added_by_client : true
/// added_by_client_id : 2567
/// created_date : "2026-02-24T17:50:03.8568112+05:30"
/// updated_date : "2026-02-24T17:50:03.8724341+05:30"
/// timestamp : "AAAAABGEOsk="

AddTaskData dataFromJson(String str) => AddTaskData.fromJson(json.decode(str));
String dataToJson(AddTaskData data) => json.encode(data.toJson());
class AddTaskData {
  AddTaskData({
      num? id, 
      num? parentTaskId, 
      num? employeeId, 
      num? taskStatusId, 
      bool? isFinalTask, 
      num? taskPriority, 
      String? taskMessage, 
      String? dueDate, 
      String? taskReopenByEmp, 
      String? taskCompletedByEmp, 
      String? taskCompletedRemark, 
      String? taskReopenRemark, 
      String? taskDeletedRemark, 
      String? reopenDate, 
      String? createdDateOriginalReopen, 
      String? taskDesc, 
      bool? isAddedByClient, 
      num? addedByClientId, 
      String? createdDate, 
      String? updatedDate, 
      String? timestamp,}){
    _id = id;
    _parentTaskId = parentTaskId;
    _employeeId = employeeId;
    _taskStatusId = taskStatusId;
    _isFinalTask = isFinalTask;
    _taskPriority = taskPriority;
    _taskMessage = taskMessage;
    _dueDate = dueDate;
    _taskReopenByEmp = taskReopenByEmp;
    _taskCompletedByEmp = taskCompletedByEmp;
    _taskCompletedRemark = taskCompletedRemark;
    _taskReopenRemark = taskReopenRemark;
    _taskDeletedRemark = taskDeletedRemark;
    _reopenDate = reopenDate;
    _createdDateOriginalReopen = createdDateOriginalReopen;
    _taskDesc = taskDesc;
    _isAddedByClient = isAddedByClient;
    _addedByClientId = addedByClientId;
    _createdDate = createdDate;
    _updatedDate = updatedDate;
    _timestamp = timestamp;
}

  AddTaskData.fromJson(dynamic json) {
    _id = json['Id'];
    _parentTaskId = json['parent_task_id'];
    _employeeId = json['employee_id'];
    _taskStatusId = json['task_status_id'];
    _isFinalTask = json['is_final_task'];
    _taskPriority = json['task_priority'];
    _taskMessage = json['task_message'];
    _dueDate = json['due_date'];
    _taskReopenByEmp = json['task_reopen_by_emp'];
    _taskCompletedByEmp = json['task_completed_by_emp'];
    _taskCompletedRemark = json['task_completed_remark'];
    _taskReopenRemark = json['task_reopen_remark'];
    _taskDeletedRemark = json['task_deleted_remark'];
    _reopenDate = json['reopen_date'];
    _createdDateOriginalReopen = json['created_date_original_reopen'];
    _taskDesc = json['task_desc'];
    _isAddedByClient = json['is_added_by_client'];
    _addedByClientId = json['added_by_client_id'];
    _createdDate = json['created_date'];
    _updatedDate = json['updated_date'];
    _timestamp = json['timestamp'];
  }
  num? _id;
  num? _parentTaskId;
  num? _employeeId;
  num? _taskStatusId;
  bool? _isFinalTask;
  num? _taskPriority;
  String? _taskMessage;
  String? _dueDate;
  String? _taskReopenByEmp;
  String? _taskCompletedByEmp;
  String? _taskCompletedRemark;
  String? _taskReopenRemark;
  String? _taskDeletedRemark;
  String? _reopenDate;
  String? _createdDateOriginalReopen;
  String? _taskDesc;
  bool? _isAddedByClient;
  num? _addedByClientId;
  String? _createdDate;
  String? _updatedDate;
  String? _timestamp;
AddTaskData copyWith({  num? id,
  num? parentTaskId,
  num? employeeId,
  num? taskStatusId,
  bool? isFinalTask,
  num? taskPriority,
  String? taskMessage,
  String? dueDate,
  String? taskReopenByEmp,
  String? taskCompletedByEmp,
  String? taskCompletedRemark,
  String? taskReopenRemark,
  String? taskDeletedRemark,
  String? reopenDate,
  String? createdDateOriginalReopen,
  String? taskDesc,
  bool? isAddedByClient,
  num? addedByClientId,
  String? createdDate,
  String? updatedDate,
  String? timestamp,
}) => AddTaskData(  id: id ?? _id,
  parentTaskId: parentTaskId ?? _parentTaskId,
  employeeId: employeeId ?? _employeeId,
  taskStatusId: taskStatusId ?? _taskStatusId,
  isFinalTask: isFinalTask ?? _isFinalTask,
  taskPriority: taskPriority ?? _taskPriority,
  taskMessage: taskMessage ?? _taskMessage,
  dueDate: dueDate ?? _dueDate,
  taskReopenByEmp: taskReopenByEmp ?? _taskReopenByEmp,
  taskCompletedByEmp: taskCompletedByEmp ?? _taskCompletedByEmp,
  taskCompletedRemark: taskCompletedRemark ?? _taskCompletedRemark,
  taskReopenRemark: taskReopenRemark ?? _taskReopenRemark,
  taskDeletedRemark: taskDeletedRemark ?? _taskDeletedRemark,
  reopenDate: reopenDate ?? _reopenDate,
  createdDateOriginalReopen: createdDateOriginalReopen ?? _createdDateOriginalReopen,
  taskDesc: taskDesc ?? _taskDesc,
  isAddedByClient: isAddedByClient ?? _isAddedByClient,
  addedByClientId: addedByClientId ?? _addedByClientId,
  createdDate: createdDate ?? _createdDate,
  updatedDate: updatedDate ?? _updatedDate,
  timestamp: timestamp ?? _timestamp,
);
  num? get id => _id;
  num? get parentTaskId => _parentTaskId;
  num? get employeeId => _employeeId;
  num? get taskStatusId => _taskStatusId;
  bool? get isFinalTask => _isFinalTask;
  num? get taskPriority => _taskPriority;
  String? get taskMessage => _taskMessage;
  String? get dueDate => _dueDate;
  String? get taskReopenByEmp => _taskReopenByEmp;
  String? get taskCompletedByEmp => _taskCompletedByEmp;
  String? get taskCompletedRemark => _taskCompletedRemark;
  String? get taskReopenRemark => _taskReopenRemark;
  String? get taskDeletedRemark => _taskDeletedRemark;
  String? get reopenDate => _reopenDate;
  String? get createdDateOriginalReopen => _createdDateOriginalReopen;
  String? get taskDesc => _taskDesc;
  bool? get isAddedByClient => _isAddedByClient;
  num? get addedByClientId => _addedByClientId;
  String? get createdDate => _createdDate;
  String? get updatedDate => _updatedDate;
  String? get timestamp => _timestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = _id;
    map['parent_task_id'] = _parentTaskId;
    map['employee_id'] = _employeeId;
    map['task_status_id'] = _taskStatusId;
    map['is_final_task'] = _isFinalTask;
    map['task_priority'] = _taskPriority;
    map['task_message'] = _taskMessage;
    map['due_date'] = _dueDate;
    map['task_reopen_by_emp'] = _taskReopenByEmp;
    map['task_completed_by_emp'] = _taskCompletedByEmp;
    map['task_completed_remark'] = _taskCompletedRemark;
    map['task_reopen_remark'] = _taskReopenRemark;
    map['task_deleted_remark'] = _taskDeletedRemark;
    map['reopen_date'] = _reopenDate;
    map['created_date_original_reopen'] = _createdDateOriginalReopen;
    map['task_desc'] = _taskDesc;
    map['is_added_by_client'] = _isAddedByClient;
    map['added_by_client_id'] = _addedByClientId;
    map['created_date'] = _createdDate;
    map['updated_date'] = _updatedDate;
    map['timestamp'] = _timestamp;
    return map;
  }

}