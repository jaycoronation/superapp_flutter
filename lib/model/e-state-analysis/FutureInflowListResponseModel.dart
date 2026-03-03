import 'dart:convert';
/// future_inflows : [{"future_inflow_id":"152","user_id":"1218","source":"Salary","start_year":"2026","end_year":"2035","expected_growth":"20","amount":" 20000000","timestamp":"1767967578"}]
/// report : {"list":[{"future_inflow_id":"152","user_id":"1218","source":"Salary","start_year":"2026","end_year":"2035","expected_growth":"20","amount":" 20000000","user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL","inflation_adjusted_income":" 519173642","pv_of_income":" 372125611"}],"total":{"inflation_adjusted_income":"519173642.24","pv_of_income":"372125610.7"}}
/// total_count : "1"
/// success : 1
/// message : "Future Inflow detail found."

FutureInflowListResponseModel futureInflowListResponseModelFromJson(String str) => FutureInflowListResponseModel.fromJson(json.decode(str));
String futureInflowListResponseModelToJson(FutureInflowListResponseModel data) => json.encode(data.toJson());
class FutureInflowListResponseModel {
  FutureInflowListResponseModel({
      List<FutureInflows>? futureInflows, 
      FutureInflowsReport? futureInflowsReport, 
      String? totalCount, 
      num? success, 
      String? message,}){
    _futureInflows = futureInflows;
    _futureInflowsReport = futureInflowsReport;
    _totalCount = totalCount;
    _success = success;
    _message = message;
}

  FutureInflowListResponseModel.fromJson(dynamic json) {
    if (json['future_inflows'] != null) {
      _futureInflows = [];
      json['future_inflows'].forEach((v) {
        _futureInflows?.add(FutureInflows.fromJson(v));
      });
    }
    _futureInflowsReport = json['report'] != null ? FutureInflowsReport.fromJson(json['report']) : null;
    _totalCount = json['total_count'];
    _success = json['success'];
    _message = json['message'];
  }
  List<FutureInflows>? _futureInflows;
  FutureInflowsReport? _futureInflowsReport;
  String? _totalCount;
  num? _success;
  String? _message;
FutureInflowListResponseModel copyWith({  List<FutureInflows>? futureInflows,
  FutureInflowsReport? futureInflowsReport,
  String? totalCount,
  num? success,
  String? message,
}) => FutureInflowListResponseModel(  futureInflows: futureInflows ?? _futureInflows,
  futureInflowsReport: futureInflowsReport ?? _futureInflowsReport,
  totalCount: totalCount ?? _totalCount,
  success: success ?? _success,
  message: message ?? _message,
);
  List<FutureInflows>? get futureInflows => _futureInflows;
  FutureInflowsReport? get futureInflowsReport => _futureInflowsReport;
  String? get totalCount => _totalCount;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_futureInflows != null) {
      map['future_inflows'] = _futureInflows?.map((v) => v.toJson()).toList();
    }
    if (_futureInflowsReport != null) {
      map['report'] = _futureInflowsReport?.toJson();
    }
    map['total_count'] = _totalCount;
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// list : [{"future_inflow_id":"152","user_id":"1218","source":"Salary","start_year":"2026","end_year":"2035","expected_growth":"20","amount":" 20000000","user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL","inflation_adjusted_income":" 519173642","pv_of_income":" 372125611"}]
/// total : {"inflation_adjusted_income":"519173642.24","pv_of_income":"372125610.7"}

FutureInflowsReport futureInflowsReportFromJson(String str) => FutureInflowsReport.fromJson(json.decode(str));
String futureInflowsReportToJson(FutureInflowsReport data) => json.encode(data.toJson());
class FutureInflowsReport {
  FutureInflowsReport({
      List<FutureInflowList>? futureInflowList, 
      Total? total,}){
    _futureInflowList = futureInflowList;
    _total = total;
}

  FutureInflowsReport.fromJson(dynamic json) {
    if (json['list'] != null) {
      _futureInflowList = [];
      json['list'].forEach((v) {
        _futureInflowList?.add(FutureInflowList.fromJson(v));
      });
    }
    _total = json['total'] != null ? Total.fromJson(json['total']) : null;
  }
  List<FutureInflowList>? _futureInflowList;
  Total? _total;
FutureInflowsReport copyWith({  List<FutureInflowList>? futureInflowList,
  Total? total,
}) => FutureInflowsReport(  futureInflowList: futureInflowList ?? _futureInflowList,
  total: total ?? _total,
);
  List<FutureInflowList>? get futureInflowList => _futureInflowList;
  Total? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_futureInflowList != null) {
      map['list'] = _futureInflowList?.map((v) => v.toJson()).toList();
    }
    if (_total != null) {
      map['total'] = _total?.toJson();
    }
    return map;
  }

}

/// inflation_adjusted_income : "519173642.24"
/// pv_of_income : "372125610.7"

Total totalFromJson(String str) => Total.fromJson(json.decode(str));
String totalToJson(Total data) => json.encode(data.toJson());
class Total {
  Total({
      String? inflationAdjustedIncome, 
      String? pvOfIncome,}){
    _inflationAdjustedIncome = inflationAdjustedIncome;
    _pvOfIncome = pvOfIncome;
}

  Total.fromJson(dynamic json) {
    _inflationAdjustedIncome = json['inflation_adjusted_income'];
    _pvOfIncome = json['pv_of_income'];
  }
  String? _inflationAdjustedIncome;
  String? _pvOfIncome;
Total copyWith({  String? inflationAdjustedIncome,
  String? pvOfIncome,
}) => Total(  inflationAdjustedIncome: inflationAdjustedIncome ?? _inflationAdjustedIncome,
  pvOfIncome: pvOfIncome ?? _pvOfIncome,
);
  String? get inflationAdjustedIncome => _inflationAdjustedIncome;
  String? get pvOfIncome => _pvOfIncome;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['inflation_adjusted_income'] = _inflationAdjustedIncome;
    map['pv_of_income'] = _pvOfIncome;
    return map;
  }

}

/// future_inflow_id : "152"
/// user_id : "1218"
/// source : "Salary"
/// start_year : "2026"
/// end_year : "2035"
/// expected_growth : "20"
/// amount : " 20000000"
/// user : {"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""}
/// name : "MUKESH JINDAL"
/// inflation_adjusted_income : " 519173642"
/// pv_of_income : " 372125611"

FutureInflowList futureInflowListFromJson(String str) => FutureInflowList.fromJson(json.decode(str));
String futureInflowListToJson(FutureInflowList data) => json.encode(data.toJson());
class FutureInflowList {
  FutureInflowList({
      String? futureInflowId, 
      String? userId, 
      String? source, 
      String? startYear, 
      String? endYear, 
      String? expectedGrowth, 
      String? amount, 
      User? user, 
      String? name, 
      String? inflationAdjustedIncome, 
      String? pvOfIncome,}){
    _futureInflowId = futureInflowId;
    _userId = userId;
    _source = source;
    _startYear = startYear;
    _endYear = endYear;
    _expectedGrowth = expectedGrowth;
    _amount = amount;
    _user = user;
    _name = name;
    _inflationAdjustedIncome = inflationAdjustedIncome;
    _pvOfIncome = pvOfIncome;
}

  FutureInflowList.fromJson(dynamic json) {
    _futureInflowId = json['future_inflow_id'];
    _userId = json['user_id'];
    _source = json['source'];
    _startYear = json['start_year'];
    _endYear = json['end_year'];
    _expectedGrowth = json['expected_growth'];
    _amount = json['amount'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _name = json['name'];
    _inflationAdjustedIncome = json['inflation_adjusted_income'];
    _pvOfIncome = json['pv_of_income'];
  }
  String? _futureInflowId;
  String? _userId;
  String? _source;
  String? _startYear;
  String? _endYear;
  String? _expectedGrowth;
  String? _amount;
  User? _user;
  String? _name;
  String? _inflationAdjustedIncome;
  String? _pvOfIncome;
FutureInflowList copyWith({  String? futureInflowId,
  String? userId,
  String? source,
  String? startYear,
  String? endYear,
  String? expectedGrowth,
  String? amount,
  User? user,
  String? name,
  String? inflationAdjustedIncome,
  String? pvOfIncome,
}) => FutureInflowList(  futureInflowId: futureInflowId ?? _futureInflowId,
  userId: userId ?? _userId,
  source: source ?? _source,
  startYear: startYear ?? _startYear,
  endYear: endYear ?? _endYear,
  expectedGrowth: expectedGrowth ?? _expectedGrowth,
  amount: amount ?? _amount,
  user: user ?? _user,
  name: name ?? _name,
  inflationAdjustedIncome: inflationAdjustedIncome ?? _inflationAdjustedIncome,
  pvOfIncome: pvOfIncome ?? _pvOfIncome,
);
  String? get futureInflowId => _futureInflowId;
  String? get userId => _userId;
  String? get source => _source;
  String? get startYear => _startYear;
  String? get endYear => _endYear;
  String? get expectedGrowth => _expectedGrowth;
  String? get amount => _amount;
  User? get user => _user;
  String? get name => _name;
  String? get inflationAdjustedIncome => _inflationAdjustedIncome;
  String? get pvOfIncome => _pvOfIncome;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['future_inflow_id'] = _futureInflowId;
    map['user_id'] = _userId;
    map['source'] = _source;
    map['start_year'] = _startYear;
    map['end_year'] = _endYear;
    map['expected_growth'] = _expectedGrowth;
    map['amount'] = _amount;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['name'] = _name;
    map['inflation_adjusted_income'] = _inflationAdjustedIncome;
    map['pv_of_income'] = _pvOfIncome;
    return map;
  }

}

/// user_id : "1218"
/// first_name : "MUKESH JINDAL"
/// last_name : ""
/// email : "jindalmukesh@gmail.com"
/// mobile : ""
/// dob : ""
/// age : ""
/// retirement_age : ""
/// life_expectancy : ""
/// tax_slab : ""
/// risk_profile : "Aggressive"
/// time_horizon : ""
/// amount_invested : ""
/// is_active : "1"
/// timestamp : ""
/// username : "MUKESH81"
/// name : "MUKESH JINDAL"
/// success : 1
/// message : ""

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
      String? userId, 
      String? firstName, 
      String? lastName, 
      String? email, 
      String? mobile, 
      String? dob, 
      String? age, 
      String? retirementAge, 
      String? lifeExpectancy, 
      String? taxSlab, 
      String? riskProfile, 
      String? timeHorizon, 
      String? amountInvested, 
      String? isActive, 
      String? timestamp, 
      String? username, 
      String? name, 
      num? success, 
      String? message,}){
    _userId = userId;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _mobile = mobile;
    _dob = dob;
    _age = age;
    _retirementAge = retirementAge;
    _lifeExpectancy = lifeExpectancy;
    _taxSlab = taxSlab;
    _riskProfile = riskProfile;
    _timeHorizon = timeHorizon;
    _amountInvested = amountInvested;
    _isActive = isActive;
    _timestamp = timestamp;
    _username = username;
    _name = name;
    _success = success;
    _message = message;
}

  User.fromJson(dynamic json) {
    _userId = json['user_id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _mobile = json['mobile'];
    _dob = json['dob'];
    _age = json['age'];
    _retirementAge = json['retirement_age'];
    _lifeExpectancy = json['life_expectancy'];
    _taxSlab = json['tax_slab'];
    _riskProfile = json['risk_profile'];
    _timeHorizon = json['time_horizon'];
    _amountInvested = json['amount_invested'];
    _isActive = json['is_active'];
    _timestamp = json['timestamp'];
    _username = json['username'];
    _name = json['name'];
    _success = json['success'];
    _message = json['message'];
  }
  String? _userId;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _mobile;
  String? _dob;
  String? _age;
  String? _retirementAge;
  String? _lifeExpectancy;
  String? _taxSlab;
  String? _riskProfile;
  String? _timeHorizon;
  String? _amountInvested;
  String? _isActive;
  String? _timestamp;
  String? _username;
  String? _name;
  num? _success;
  String? _message;
User copyWith({  String? userId,
  String? firstName,
  String? lastName,
  String? email,
  String? mobile,
  String? dob,
  String? age,
  String? retirementAge,
  String? lifeExpectancy,
  String? taxSlab,
  String? riskProfile,
  String? timeHorizon,
  String? amountInvested,
  String? isActive,
  String? timestamp,
  String? username,
  String? name,
  num? success,
  String? message,
}) => User(  userId: userId ?? _userId,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  email: email ?? _email,
  mobile: mobile ?? _mobile,
  dob: dob ?? _dob,
  age: age ?? _age,
  retirementAge: retirementAge ?? _retirementAge,
  lifeExpectancy: lifeExpectancy ?? _lifeExpectancy,
  taxSlab: taxSlab ?? _taxSlab,
  riskProfile: riskProfile ?? _riskProfile,
  timeHorizon: timeHorizon ?? _timeHorizon,
  amountInvested: amountInvested ?? _amountInvested,
  isActive: isActive ?? _isActive,
  timestamp: timestamp ?? _timestamp,
  username: username ?? _username,
  name: name ?? _name,
  success: success ?? _success,
  message: message ?? _message,
);
  String? get userId => _userId;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get dob => _dob;
  String? get age => _age;
  String? get retirementAge => _retirementAge;
  String? get lifeExpectancy => _lifeExpectancy;
  String? get taxSlab => _taxSlab;
  String? get riskProfile => _riskProfile;
  String? get timeHorizon => _timeHorizon;
  String? get amountInvested => _amountInvested;
  String? get isActive => _isActive;
  String? get timestamp => _timestamp;
  String? get username => _username;
  String? get name => _name;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['dob'] = _dob;
    map['age'] = _age;
    map['retirement_age'] = _retirementAge;
    map['life_expectancy'] = _lifeExpectancy;
    map['tax_slab'] = _taxSlab;
    map['risk_profile'] = _riskProfile;
    map['time_horizon'] = _timeHorizon;
    map['amount_invested'] = _amountInvested;
    map['is_active'] = _isActive;
    map['timestamp'] = _timestamp;
    map['username'] = _username;
    map['name'] = _name;
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// future_inflow_id : "152"
/// user_id : "1218"
/// source : "Salary"
/// start_year : "2026"
/// end_year : "2035"
/// expected_growth : "20"
/// amount : " 20000000"
/// timestamp : "1767967578"

FutureInflows futureInflowsFromJson(String str) => FutureInflows.fromJson(json.decode(str));
String futureInflowsToJson(FutureInflows data) => json.encode(data.toJson());
class FutureInflows {
  FutureInflows({
      String? futureInflowId, 
      String? userId, 
      String? source, 
      String? startYear, 
      String? endYear, 
      String? expectedGrowth, 
      String? amount, 
      String? timestamp,}){
    _futureInflowId = futureInflowId;
    _userId = userId;
    _source = source;
    _startYear = startYear;
    _endYear = endYear;
    _expectedGrowth = expectedGrowth;
    _amount = amount;
    _timestamp = timestamp;
}

  FutureInflows.fromJson(dynamic json) {
    _futureInflowId = json['future_inflow_id'];
    _userId = json['user_id'];
    _source = json['source'];
    _startYear = json['start_year'];
    _endYear = json['end_year'];
    _expectedGrowth = json['expected_growth'];
    _amount = json['amount'];
    _timestamp = json['timestamp'];
  }
  String? _futureInflowId;
  String? _userId;
  String? _source;
  String? _startYear;
  String? _endYear;
  String? _expectedGrowth;
  String? _amount;
  String? _timestamp;
FutureInflows copyWith({  String? futureInflowId,
  String? userId,
  String? source,
  String? startYear,
  String? endYear,
  String? expectedGrowth,
  String? amount,
  String? timestamp,
}) => FutureInflows(  futureInflowId: futureInflowId ?? _futureInflowId,
  userId: userId ?? _userId,
  source: source ?? _source,
  startYear: startYear ?? _startYear,
  endYear: endYear ?? _endYear,
  expectedGrowth: expectedGrowth ?? _expectedGrowth,
  amount: amount ?? _amount,
  timestamp: timestamp ?? _timestamp,
);
  String? get futureInflowId => _futureInflowId;
  String? get userId => _userId;
  String? get source => _source;
  String? get startYear => _startYear;
  String? get endYear => _endYear;
  String? get expectedGrowth => _expectedGrowth;
  String? get amount => _amount;
  String? get timestamp => _timestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['future_inflow_id'] = _futureInflowId;
    map['user_id'] = _userId;
    map['source'] = _source;
    map['start_year'] = _startYear;
    map['end_year'] = _endYear;
    map['expected_growth'] = _expectedGrowth;
    map['amount'] = _amount;
    map['timestamp'] = _timestamp;
    return map;
  }

}