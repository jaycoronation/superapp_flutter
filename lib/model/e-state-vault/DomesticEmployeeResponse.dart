import 'dart:convert';
/// domestic_employees_id : "20"
/// user_id : "164"
/// is_domestic_employee : "Yes"
/// employee_instruction : "test"
/// timestamp : "1678880987"

DomesticEmployeeResponse domesticEmployeeResponseFromJson(String str) => DomesticEmployeeResponse.fromJson(json.decode(str));
String domesticEmployeeResponseToJson(DomesticEmployeeResponse data) => json.encode(data.toJson());
class DomesticEmployeeResponse {
  DomesticEmployeeResponse({
      String? domesticEmployeesId, 
      String? userId, 
      String? isDomesticEmployee, 
      String? employeeInstruction, 
      String? timestamp,}){
    _domesticEmployeesId = domesticEmployeesId;
    _userId = userId;
    _isDomesticEmployee = isDomesticEmployee;
    _employeeInstruction = employeeInstruction;
    _timestamp = timestamp;
}

  DomesticEmployeeResponse.fromJson(dynamic json) {
    _domesticEmployeesId = json['domestic_employees_id'];
    _userId = json['user_id'];
    _isDomesticEmployee = json['is_domestic_employee'];
    _employeeInstruction = json['employee_instruction'];
    _timestamp = json['timestamp'];
  }
  String? _domesticEmployeesId;
  String? _userId;
  String? _isDomesticEmployee;
  String? _employeeInstruction;
  String? _timestamp;
DomesticEmployeeResponse copyWith({  String? domesticEmployeesId,
  String? userId,
  String? isDomesticEmployee,
  String? employeeInstruction,
  String? timestamp,
}) => DomesticEmployeeResponse(  domesticEmployeesId: domesticEmployeesId ?? _domesticEmployeesId,
  userId: userId ?? _userId,
  isDomesticEmployee: isDomesticEmployee ?? _isDomesticEmployee,
  employeeInstruction: employeeInstruction ?? _employeeInstruction,
  timestamp: timestamp ?? _timestamp,
);
  String? get domesticEmployeesId => _domesticEmployeesId;
  String? get userId => _userId;
  String? get isDomesticEmployee => _isDomesticEmployee;
  String? get employeeInstruction => _employeeInstruction;
  String? get timestamp => _timestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['domestic_employees_id'] = _domesticEmployeesId;
    map['user_id'] = _userId;
    map['is_domestic_employee'] = _isDomesticEmployee;
    map['employee_instruction'] = _employeeInstruction;
    map['timestamp'] = _timestamp;
    return map;
  }

}