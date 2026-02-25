import 'dart:convert';
/// balanceSheetData : [{"year":2026,"opening_balance":230657562,"fresh_inflow":16666667,"expected_profit":23899090,"outflow":10000000,"closing_balance":261223319,"present_value":246437093,"profit_growth_calculation":12},{"year":2027,"opening_balance":261223319,"fresh_inflow":24000000,"outflow":10600000,"expected_profit":32786798,"closing_balance":307410117,"present_value":273593910,"profit_growth_calculation":12},{"year":2028,"opening_balance":307410117,"fresh_inflow":28800000,"outflow":11236000,"expected_profit":38617214,"closing_balance":363591331,"present_value":305278293,"profit_growth_calculation":12},{"year":2029,"opening_balance":363591331,"fresh_inflow":34560000,"outflow":11910160,"expected_profit":45704560,"closing_balance":431945731,"present_value":342141476,"profit_growth_calculation":12},{"year":2030,"opening_balance":431945731,"fresh_inflow":41472000,"outflow":224089660,"expected_profit":54321808,"closing_balance":303649879,"present_value":226904854,"profit_growth_calculation":12},{"year":2031,"opening_balance":303649879,"fresh_inflow":49766400,"outflow":26764512,"expected_profit":39423969,"closing_balance":366075736,"present_value":258068949,"profit_growth_calculation":12},{"year":2032,"opening_balance":366075736,"fresh_inflow":59719680,"outflow":28370382,"expected_profit":47512269,"closing_balance":444937303,"present_value":295908718,"profit_growth_calculation":12},{"year":2033,"opening_balance":444937303,"fresh_inflow":71663616,"outflow":30072605,"expected_profit":57692293,"closing_balance":544220607,"present_value":341450742,"profit_growth_calculation":12},{"year":2034,"opening_balance":544220607,"fresh_inflow":85996339,"outflow":47815442,"expected_profit":70466253,"closing_balance":652867757,"present_value":386431422,"profit_growth_calculation":12},{"year":2035,"opening_balance":652867757,"fresh_inflow":103195607,"outflow":63355461,"expected_profit":84535867,"closing_balance":777243770,"present_value":434008862,"profit_growth_calculation":12},{"year":2036,"opening_balance":777243770,"fresh_inflow":0,"outflow":35816954,"expected_profit":93269252,"closing_balance":834696068,"present_value":439707476,"profit_growth_calculation":12},{"year":2037,"opening_balance":834696068,"fresh_inflow":0,"outflow":37965971,"expected_profit":100163528,"closing_balance":896893625,"present_value":445728654,"profit_growth_calculation":12},{"year":2038,"opening_balance":896893625,"fresh_inflow":0,"outflow":40243929,"expected_profit":107627235,"closing_balance":964276931,"present_value":452090654,"profit_growth_calculation":12},{"year":2039,"opening_balance":964276931,"fresh_inflow":0,"outflow":42658565,"expected_profit":115713232,"closing_balance":1037331598,"present_value":458812766,"profit_growth_calculation":12},{"year":2040,"opening_balance":1037331598,"fresh_inflow":0,"outflow":39565819,"expected_profit":124479792,"closing_balance":1122245571,"present_value":468273866,"profit_growth_calculation":12},{"year":2041,"opening_balance":1122245571,"fresh_inflow":0,"outflow":23965582,"expected_profit":134669469,"closing_balance":1232949458,"present_value":485345972,"profit_growth_calculation":12},{"year":2042,"opening_balance":1232949458,"fresh_inflow":0,"outflow":25403517,"expected_profit":147953935,"closing_balance":1355499876,"present_value":503384423,"profit_growth_calculation":12},{"year":2043,"opening_balance":1355499876,"fresh_inflow":0,"outflow":26927728,"expected_profit":162659985,"closing_balance":1491232133,"present_value":522443919,"profit_growth_calculation":12},{"year":2044,"opening_balance":1491232133,"fresh_inflow":0,"outflow":28543392,"expected_profit":178947856,"closing_balance":1641636597,"present_value":542582254,"profit_growth_calculation":12},{"year":2045,"opening_balance":1641636597,"fresh_inflow":0,"outflow":52947991,"expected_profit":196996392,"closing_balance":1785684998,"present_value":556785023,"profit_growth_calculation":12},{"year":2046,"opening_balance":1785684998,"fresh_inflow":0,"outflow":32071355,"expected_profit":214282200,"closing_balance":1967895843,"present_value":578867194,"profit_growth_calculation":12},{"year":2047,"opening_balance":1967895843,"fresh_inflow":0,"outflow":33995636,"expected_profit":236147501,"closing_balance":2170047708,"present_value":602199300,"profit_growth_calculation":12},{"year":2048,"opening_balance":2170047708,"fresh_inflow":0,"outflow":36035374,"expected_profit":260405725,"closing_balance":2394418059,"present_value":626852090,"profit_growth_calculation":12},{"year":2049,"opening_balance":2394418059,"fresh_inflow":0,"outflow":38197497,"expected_profit":287330167,"closing_balance":2643550729,"present_value":652900321,"profit_growth_calculation":12},{"year":2050,"opening_balance":2643550729,"fresh_inflow":0,"outflow":70856356,"expected_profit":317226087,"closing_balance":2889920460,"present_value":673347509,"profit_growth_calculation":12}]
/// aspirations : {"aspirations":{"list":[{"name":"","start_year":"2025","end_year":"2080","periodicity":"5","amount":"7500000","aspiration_type":"Automobile","classification":"Lifestyle","other_aspiration":"","total_outflow":"90000000","total_inflation_adjusted_expense":"669162879","wealth_required_today_total":"24031010","volatile_component":"68%","target_return":"12%"},{"name":"","start_year":"2025","end_year":"2080","periodicity":"1","amount":"10000000","aspiration_type":"Retirement","classification":"Living","other_aspiration":"","total_outflow":"560000000","total_inflation_adjusted_expense":"3951154230","wealth_required_today_total":"142710975","volatile_component":"80%","target_return":"13%"},{"name":"","start_year":"2030","end_year":"2035","periodicity":"1","amount":"10000000","aspiration_type":"Child Education - Post Graduation","classification":"Parental Aspiration","other_aspiration":"","total_outflow":"60000000","total_inflation_adjusted_expense":"88061791","wealth_required_today_total":"40829870","volatile_component":"79%","target_return":"13%"},{"name":"","start_year":"2034","end_year":"2039","periodicity":"1","amount":"10000000","aspiration_type":"Child Education - Post Graduation","classification":"Parental Aspiration","other_aspiration":"","total_outflow":"60000000","total_inflation_adjusted_expense":"111175982","wealth_required_today_total":"26897095","volatile_component":"104%","target_return":"14%"},{"name":"","start_year":"2030","end_year":"2030","periodicity":"1","amount":"150000000","aspiration_type":"Lifestyle Villa","classification":"Real Estate","other_aspiration":"","total_outflow":"150000000","total_inflation_adjusted_expense":"189371544","wealth_required_today_total":"120349040","volatile_component":"75%","target_return":"12%"}],"total":{"aspiration_type":"Total","total_outflow":"920000000","total_inflation_adjusted_expense":"5008926426","wealth_required_today_total":"354817990","volatile_component":"79%","target_return":"13%"}},"message":"","success":1}
/// inflows : {"future_inflows":[{"source":"Salary","start_year":"2026","end_year":"2035","expected_growth":"20","amount":" 20000000","timestamp":"1767967578"}],"report":{"list":[{"future_inflow_id":"152","user_id":"1218","source":"Salary","start_year":"2026","end_year":"2035","expected_growth":"20","amount":" 20000000","user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL","inflation_adjusted_income":" 519173642","pv_of_income":" 372125611"}],"total":{"inflation_adjusted_income":"519173642.24","pv_of_income":"372125610.7"}},"success":1,"message":"Future Inflow detail found."}

BsProjectionResponseModel bsProjectionResponseModelFromJson(String str) => BsProjectionResponseModel.fromJson(json.decode(str));
String bsProjectionResponseModelToJson(BsProjectionResponseModel data) => json.encode(data.toJson());
class BsProjectionResponseModel {
  BsProjectionResponseModel({
      List<BalanceSheetData>? balanceSheetData, 
      Aspirations? aspirations, 
      Inflows? inflows,}){
    _balanceSheetData = balanceSheetData;
    _aspirations = aspirations;
    _inflows = inflows;
}

  BsProjectionResponseModel.fromJson(dynamic json) {
    if (json['balanceSheetData'] != null) {
      _balanceSheetData = [];
      json['balanceSheetData'].forEach((v) {
        _balanceSheetData?.add(BalanceSheetData.fromJson(v));
      });
    }
    _aspirations = json['aspirations'] != null ? Aspirations.fromJson(json['aspirations']) : null;
    _inflows = json['inflows'] != null ? Inflows.fromJson(json['inflows']) : null;
  }
  List<BalanceSheetData>? _balanceSheetData;
  Aspirations? _aspirations;
  Inflows? _inflows;
BsProjectionResponseModel copyWith({  List<BalanceSheetData>? balanceSheetData,
  Aspirations? aspirations,
  Inflows? inflows,
}) => BsProjectionResponseModel(  balanceSheetData: balanceSheetData ?? _balanceSheetData,
  aspirations: aspirations ?? _aspirations,
  inflows: inflows ?? _inflows,
);
  List<BalanceSheetData>? get balanceSheetData => _balanceSheetData;
  Aspirations? get aspirations => _aspirations;
  Inflows? get inflows => _inflows;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_balanceSheetData != null) {
      map['balanceSheetData'] = _balanceSheetData?.map((v) => v.toJson()).toList();
    }
    if (_aspirations != null) {
      map['aspirations'] = _aspirations?.toJson();
    }
    if (_inflows != null) {
      map['inflows'] = _inflows?.toJson();
    }
    return map;
  }

}

/// future_inflows : [{"source":"Salary","start_year":"2026","end_year":"2035","expected_growth":"20","amount":" 20000000","timestamp":"1767967578"}]
/// report : {"list":[{"future_inflow_id":"152","user_id":"1218","source":"Salary","start_year":"2026","end_year":"2035","expected_growth":"20","amount":" 20000000","user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL","inflation_adjusted_income":" 519173642","pv_of_income":" 372125611"}],"total":{"inflation_adjusted_income":"519173642.24","pv_of_income":"372125610.7"}}
/// success : 1
/// message : "Future Inflow detail found."

Inflows inflowsFromJson(String str) => Inflows.fromJson(json.decode(str));
String inflowsToJson(Inflows data) => json.encode(data.toJson());
class Inflows {
  Inflows({
      List<FutureInflows>? futureInflows, 
      Report? report, 
      num? success, 
      String? message,}){
    _futureInflows = futureInflows;
    _report = report;
    _success = success;
    _message = message;
}

  Inflows.fromJson(dynamic json) {
    if (json['future_inflows'] != null) {
      _futureInflows = [];
      json['future_inflows'].forEach((v) {
        _futureInflows?.add(FutureInflows.fromJson(v));
      });
    }
    _report = json['report'] != null ? Report.fromJson(json['report']) : null;
    _success = json['success'];
    _message = json['message'];
  }
  List<FutureInflows>? _futureInflows;
  Report? _report;
  num? _success;
  String? _message;
Inflows copyWith({  List<FutureInflows>? futureInflows,
  Report? report,
  num? success,
  String? message,
}) => Inflows(  futureInflows: futureInflows ?? _futureInflows,
  report: report ?? _report,
  success: success ?? _success,
  message: message ?? _message,
);
  List<FutureInflows>? get futureInflows => _futureInflows;
  Report? get report => _report;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_futureInflows != null) {
      map['future_inflows'] = _futureInflows?.map((v) => v.toJson()).toList();
    }
    if (_report != null) {
      map['report'] = _report?.toJson();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// list : [{"future_inflow_id":"152","user_id":"1218","source":"Salary","start_year":"2026","end_year":"2035","expected_growth":"20","amount":" 20000000","user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL","inflation_adjusted_income":" 519173642","pv_of_income":" 372125611"}]
/// total : {"inflation_adjusted_income":"519173642.24","pv_of_income":"372125610.7"}

Report reportFromJson(String str) => Report.fromJson(json.decode(str));
String reportToJson(Report data) => json.encode(data.toJson());
class Report {
  Report({
      List<ReportList>? reportList, 
      ReportTotal? reportTotal,}){
    _reportList = reportList;
    _reportTotal = reportTotal;
}

  Report.fromJson(dynamic json) {
    if (json['list'] != null) {
      _reportList = [];
      json['list'].forEach((v) {
        _reportList?.add(ReportList.fromJson(v));
      });
    }
    _reportTotal = json['total'] != null ? ReportTotal.fromJson(json['total']) : null;
  }
  List<ReportList>? _reportList;
  ReportTotal? _reportTotal;
Report copyWith({  List<ReportList>? reportList,
  ReportTotal? reportTotal,
}) => Report(  reportList: reportList ?? _reportList,
  reportTotal: reportTotal ?? _reportTotal,
);
  List<ReportList>? get reportList => _reportList;
  ReportTotal? get reportTotal => _reportTotal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_reportList != null) {
      map['list'] = _reportList?.map((v) => v.toJson()).toList();
    }
    if (_reportTotal != null) {
      map['total'] = _reportTotal?.toJson();
    }
    return map;
  }

}

/// inflation_adjusted_income : "519173642.24"
/// pv_of_income : "372125610.7"

ReportTotal reportTotalFromJson(String str) => ReportTotal.fromJson(json.decode(str));
String reportTotalToJson(ReportTotal data) => json.encode(data.toJson());
class ReportTotal {
  ReportTotal({
      String? inflationAdjustedIncome, 
      String? pvOfIncome,}){
    _inflationAdjustedIncome = inflationAdjustedIncome;
    _pvOfIncome = pvOfIncome;
}

  ReportTotal.fromJson(dynamic json) {
    _inflationAdjustedIncome = json['inflation_adjusted_income'];
    _pvOfIncome = json['pv_of_income'];
  }
  String? _inflationAdjustedIncome;
  String? _pvOfIncome;
ReportTotal copyWith({  String? inflationAdjustedIncome,
  String? pvOfIncome,
}) => ReportTotal(  inflationAdjustedIncome: inflationAdjustedIncome ?? _inflationAdjustedIncome,
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

ReportList reportListFromJson(String str) => ReportList.fromJson(json.decode(str));
String reportListToJson(ReportList data) => json.encode(data.toJson());
class ReportList {
  ReportList({
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

  ReportList.fromJson(dynamic json) {
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
ReportList copyWith({  String? futureInflowId,
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
}) => ReportList(  futureInflowId: futureInflowId ?? _futureInflowId,
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
      String? source, 
      String? startYear, 
      String? endYear, 
      String? expectedGrowth, 
      String? amount, 
      String? timestamp,}){
    _source = source;
    _startYear = startYear;
    _endYear = endYear;
    _expectedGrowth = expectedGrowth;
    _amount = amount;
    _timestamp = timestamp;
}

  FutureInflows.fromJson(dynamic json) {
    _source = json['source'];
    _startYear = json['start_year'];
    _endYear = json['end_year'];
    _expectedGrowth = json['expected_growth'];
    _amount = json['amount'];
    _timestamp = json['timestamp'];
  }
  String? _source;
  String? _startYear;
  String? _endYear;
  String? _expectedGrowth;
  String? _amount;
  String? _timestamp;
FutureInflows copyWith({  String? source,
  String? startYear,
  String? endYear,
  String? expectedGrowth,
  String? amount,
  String? timestamp,
}) => FutureInflows(  source: source ?? _source,
  startYear: startYear ?? _startYear,
  endYear: endYear ?? _endYear,
  expectedGrowth: expectedGrowth ?? _expectedGrowth,
  amount: amount ?? _amount,
  timestamp: timestamp ?? _timestamp,
);
  String? get source => _source;
  String? get startYear => _startYear;
  String? get endYear => _endYear;
  String? get expectedGrowth => _expectedGrowth;
  String? get amount => _amount;
  String? get timestamp => _timestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['source'] = _source;
    map['start_year'] = _startYear;
    map['end_year'] = _endYear;
    map['expected_growth'] = _expectedGrowth;
    map['amount'] = _amount;
    map['timestamp'] = _timestamp;
    return map;
  }

}

/// aspirations: {"list":[{"name":"","start_year":"2025","end_year":"2080","periodicity":"5","amount":"7500000","aspiration_type":"Automobile","classification":"Lifestyle","other_aspiration":"","total_outflow":"90000000","total_inflation_adjusted_expense":"669162879","wealth_required_today_total":"24031010","volatile_component":"68%","target_return":"12%"},{"name":"","start_year":"2025","end_year":"2080","periodicity":"1","amount":"10000000","aspiration_type":"Retirement","classification":"Living","other_aspiration":"","total_outflow":"560000000","total_inflation_adjusted_expense":"3951154230","wealth_required_today_total":"142710975","volatile_component":"80%","target_return":"13%"},{"name":"","start_year":"2030","end_year":"2035","periodicity":"1","amount":"10000000","aspiration_type":"Child Education - Post Graduation","classification":"Parental Aspiration","other_aspiration":"","total_outflow":"60000000","total_inflation_adjusted_expense":"88061791","wealth_required_today_total":"40829870","volatile_component":"79%","target_return":"13%"},{"name":"","start_year":"2034","end_year":"2039","periodicity":"1","amount":"10000000","aspiration_type":"Child Education - Post Graduation","classification":"Parental Aspiration","other_aspiration":"","total_outflow":"60000000","total_inflation_adjusted_expense":"111175982","wealth_required_today_total":"26897095","volatile_component":"104%","target_return":"14%"},{"name":"","start_year":"2030","end_year":"2030","periodicity":"1","amount":"150000000","aspiration_type":"Lifestyle Villa","classification":"Real Estate","other_aspiration":"","total_outflow":"150000000","total_inflation_adjusted_expense":"189371544","wealth_required_today_total":"120349040","volatile_component":"75%","target_return":"12%"}],"total":{"aspiration_type":"Total","total_outflow":"920000000","total_inflation_adjusted_expense":"5008926426","wealth_required_today_total":"354817990","volatile_component":"79%","target_return":"13%"}}
/// message : ""
/// success : 1

Aspirations aspirationsFromJson(String str) => Aspirations.fromJson(json.decode(str));
String aspirationsToJson(Aspirations data) => json.encode(data.toJson());
class Aspirations {
  Aspirations({
      AspirationsData? aspirationsData, 
      String? message, 
      num? success,}){
    _aspirationsData = aspirationsData;
    _message = message;
    _success = success;
}

  Aspirations.fromJson(dynamic json) {
    _aspirationsData = json['aspirations'] != null ? AspirationsData.fromJson(json['aspirations']) : null;
    _message = json['message'];
    _success = json['success'];
  }
  AspirationsData? _aspirationsData;
  String? _message;
  num? _success;
Aspirations copyWith({  AspirationsData? aspirationsData,
  String? message,
  num? success,
}) => Aspirations(  aspirationsData: aspirationsData ?? _aspirationsData,
  message: message ?? _message,
  success: success ?? _success,
);
  AspirationsData? get aspirationsData => _aspirationsData;
  String? get message => _message;
  num? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_aspirationsData != null) {
      map['aspirations'] = _aspirationsData?.toJson();
    }
    map['message'] = _message;
    map['success'] = _success;
    return map;
  }

}

/// list : [{"name":"","start_year":"2025","end_year":"2080","periodicity":"5","amount":"7500000","aspiration_type":"Automobile","classification":"Lifestyle","other_aspiration":"","total_outflow":"90000000","total_inflation_adjusted_expense":"669162879","wealth_required_today_total":"24031010","volatile_component":"68%","target_return":"12%"},{"name":"","start_year":"2025","end_year":"2080","periodicity":"1","amount":"10000000","aspiration_type":"Retirement","classification":"Living","other_aspiration":"","total_outflow":"560000000","total_inflation_adjusted_expense":"3951154230","wealth_required_today_total":"142710975","volatile_component":"80%","target_return":"13%"},{"name":"","start_year":"2030","end_year":"2035","periodicity":"1","amount":"10000000","aspiration_type":"Child Education - Post Graduation","classification":"Parental Aspiration","other_aspiration":"","total_outflow":"60000000","total_inflation_adjusted_expense":"88061791","wealth_required_today_total":"40829870","volatile_component":"79%","target_return":"13%"},{"name":"","start_year":"2034","end_year":"2039","periodicity":"1","amount":"10000000","aspiration_type":"Child Education - Post Graduation","classification":"Parental Aspiration","other_aspiration":"","total_outflow":"60000000","total_inflation_adjusted_expense":"111175982","wealth_required_today_total":"26897095","volatile_component":"104%","target_return":"14%"},{"name":"","start_year":"2030","end_year":"2030","periodicity":"1","amount":"150000000","aspiration_type":"Lifestyle Villa","classification":"Real Estate","other_aspiration":"","total_outflow":"150000000","total_inflation_adjusted_expense":"189371544","wealth_required_today_total":"120349040","volatile_component":"75%","target_return":"12%"}]
/// aspirations_total : {"aspiration_type":"Total","total_outflow":"920000000","total_inflation_adjusted_expense":"5008926426","wealth_required_today_total":"354817990","volatile_component":"79%","target_return":"13%"}

AspirationsData aspirationsDataFromJson(String str) => AspirationsData.fromJson(json.decode(str));
String aspirationsDataToJson(AspirationsData data) => json.encode(data.toJson());
class AspirationsData {
  AspirationsData({
      List<AspirationsList>? aspirationsList, 
      AspirationsTotal? aspirationsTotal,}){
    _aspirationsList = aspirationsList;
    _aspirationsTotal = aspirationsTotal;
}

  AspirationsData.fromJson(dynamic json) {
    if (json['list'] != null) {
      _aspirationsList = [];
      json['list'].forEach((v) {
        _aspirationsList?.add(AspirationsList.fromJson(v));
      });
    }
    _aspirationsTotal = json['total'] != null ? AspirationsTotal.fromJson(json['total']) : null;
  }
  List<AspirationsList>? _aspirationsList;
  AspirationsTotal? _aspirationsTotal;
AspirationsData copyWith({  List<AspirationsList>? aspirationsList,
  AspirationsTotal? aspirationsTotal,
}) => AspirationsData(  aspirationsList: aspirationsList ?? _aspirationsList,
  aspirationsTotal: aspirationsTotal ?? _aspirationsTotal,
);
  List<AspirationsList>? get aspirationsList => _aspirationsList;
  AspirationsTotal? get aspirationsTotal => _aspirationsTotal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_aspirationsList != null) {
      map['list'] = _aspirationsList?.map((v) => v.toJson()).toList();
    }
    if (_aspirationsTotal != null) {
      map['total'] = _aspirationsTotal?.toJson();
    }
    return map;
  }

}

/// aspiration_type : "Total"
/// total_outflow : "920000000"
/// total_inflation_adjusted_expense : "5008926426"
/// wealth_required_today_total : "354817990"
/// volatile_component : "79%"
/// target_return : "13%"

AspirationsTotal aspirationsTotalFromJson(String str) => AspirationsTotal.fromJson(json.decode(str));
String aspirationsTotalToJson(AspirationsTotal data) => json.encode(data.toJson());
class AspirationsTotal {
  AspirationsTotal({
      String? aspirationType, 
      String? totalOutflow, 
      String? totalInflationAdjustedExpense, 
      String? wealthRequiredTodayTotal, 
      String? volatileComponent, 
      String? targetReturn,}){
    _aspirationType = aspirationType;
    _totalOutflow = totalOutflow;
    _totalInflationAdjustedExpense = totalInflationAdjustedExpense;
    _wealthRequiredTodayTotal = wealthRequiredTodayTotal;
    _volatileComponent = volatileComponent;
    _targetReturn = targetReturn;
}

  AspirationsTotal.fromJson(dynamic json) {
    _aspirationType = json['aspiration_type'];
    _totalOutflow = json['total_outflow'];
    _totalInflationAdjustedExpense = json['total_inflation_adjusted_expense'];
    _wealthRequiredTodayTotal = json['wealth_required_today_total'];
    _volatileComponent = json['volatile_component'];
    _targetReturn = json['target_return'];
  }
  String? _aspirationType;
  String? _totalOutflow;
  String? _totalInflationAdjustedExpense;
  String? _wealthRequiredTodayTotal;
  String? _volatileComponent;
  String? _targetReturn;
AspirationsTotal copyWith({  String? aspirationType,
  String? totalOutflow,
  String? totalInflationAdjustedExpense,
  String? wealthRequiredTodayTotal,
  String? volatileComponent,
  String? targetReturn,
}) => AspirationsTotal(  aspirationType: aspirationType ?? _aspirationType,
  totalOutflow: totalOutflow ?? _totalOutflow,
  totalInflationAdjustedExpense: totalInflationAdjustedExpense ?? _totalInflationAdjustedExpense,
  wealthRequiredTodayTotal: wealthRequiredTodayTotal ?? _wealthRequiredTodayTotal,
  volatileComponent: volatileComponent ?? _volatileComponent,
  targetReturn: targetReturn ?? _targetReturn,
);
  String? get aspirationType => _aspirationType;
  String? get totalOutflow => _totalOutflow;
  String? get totalInflationAdjustedExpense => _totalInflationAdjustedExpense;
  String? get wealthRequiredTodayTotal => _wealthRequiredTodayTotal;
  String? get volatileComponent => _volatileComponent;
  String? get targetReturn => _targetReturn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['aspiration_type'] = _aspirationType;
    map['total_outflow'] = _totalOutflow;
    map['total_inflation_adjusted_expense'] = _totalInflationAdjustedExpense;
    map['wealth_required_today_total'] = _wealthRequiredTodayTotal;
    map['volatile_component'] = _volatileComponent;
    map['target_return'] = _targetReturn;
    return map;
  }

}

/// name : ""
/// start_year : "2025"
/// end_year : "2080"
/// periodicity : "5"
/// amount : "7500000"
/// aspiration_type : "Automobile"
/// classification : "Lifestyle"
/// other_aspiration : ""
/// total_outflow : "90000000"
/// total_inflation_adjusted_expense : "669162879"
/// wealth_required_today_total : "24031010"
/// volatile_component : "68%"
/// target_return : "12%"

AspirationsList aspirationsListFromJson(String str) => AspirationsList.fromJson(json.decode(str));
String aspirationsListToJson(AspirationsList data) => json.encode(data.toJson());
class AspirationsList {
  AspirationsList({
      String? name, 
      String? startYear, 
      String? endYear, 
      String? periodicity, 
      String? amount, 
      String? aspirationType, 
      String? classification, 
      String? otherAspiration, 
      String? totalOutflow, 
      String? totalInflationAdjustedExpense, 
      String? wealthRequiredTodayTotal, 
      String? volatileComponent, 
      String? targetReturn,}){
    _name = name;
    _startYear = startYear;
    _endYear = endYear;
    _periodicity = periodicity;
    _amount = amount;
    _aspirationType = aspirationType;
    _classification = classification;
    _otherAspiration = otherAspiration;
    _totalOutflow = totalOutflow;
    _totalInflationAdjustedExpense = totalInflationAdjustedExpense;
    _wealthRequiredTodayTotal = wealthRequiredTodayTotal;
    _volatileComponent = volatileComponent;
    _targetReturn = targetReturn;
}

  AspirationsList.fromJson(dynamic json) {
    _name = json['name'];
    _startYear = json['start_year'];
    _endYear = json['end_year'];
    _periodicity = json['periodicity'];
    _amount = json['amount'];
    _aspirationType = json['aspiration_type'];
    _classification = json['classification'];
    _otherAspiration = json['other_aspiration'];
    _totalOutflow = json['total_outflow'];
    _totalInflationAdjustedExpense = json['total_inflation_adjusted_expense'];
    _wealthRequiredTodayTotal = json['wealth_required_today_total'];
    _volatileComponent = json['volatile_component'];
    _targetReturn = json['target_return'];
  }
  String? _name;
  String? _startYear;
  String? _endYear;
  String? _periodicity;
  String? _amount;
  String? _aspirationType;
  String? _classification;
  String? _otherAspiration;
  String? _totalOutflow;
  String? _totalInflationAdjustedExpense;
  String? _wealthRequiredTodayTotal;
  String? _volatileComponent;
  String? _targetReturn;
AspirationsList copyWith({  String? name,
  String? startYear,
  String? endYear,
  String? periodicity,
  String? amount,
  String? aspirationType,
  String? classification,
  String? otherAspiration,
  String? totalOutflow,
  String? totalInflationAdjustedExpense,
  String? wealthRequiredTodayTotal,
  String? volatileComponent,
  String? targetReturn,
}) => AspirationsList(  name: name ?? _name,
  startYear: startYear ?? _startYear,
  endYear: endYear ?? _endYear,
  periodicity: periodicity ?? _periodicity,
  amount: amount ?? _amount,
  aspirationType: aspirationType ?? _aspirationType,
  classification: classification ?? _classification,
  otherAspiration: otherAspiration ?? _otherAspiration,
  totalOutflow: totalOutflow ?? _totalOutflow,
  totalInflationAdjustedExpense: totalInflationAdjustedExpense ?? _totalInflationAdjustedExpense,
  wealthRequiredTodayTotal: wealthRequiredTodayTotal ?? _wealthRequiredTodayTotal,
  volatileComponent: volatileComponent ?? _volatileComponent,
  targetReturn: targetReturn ?? _targetReturn,
);
  String? get name => _name;
  String? get startYear => _startYear;
  String? get endYear => _endYear;
  String? get periodicity => _periodicity;
  String? get amount => _amount;
  String? get aspirationType => _aspirationType;
  String? get classification => _classification;
  String? get otherAspiration => _otherAspiration;
  String? get totalOutflow => _totalOutflow;
  String? get totalInflationAdjustedExpense => _totalInflationAdjustedExpense;
  String? get wealthRequiredTodayTotal => _wealthRequiredTodayTotal;
  String? get volatileComponent => _volatileComponent;
  String? get targetReturn => _targetReturn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['start_year'] = _startYear;
    map['end_year'] = _endYear;
    map['periodicity'] = _periodicity;
    map['amount'] = _amount;
    map['aspiration_type'] = _aspirationType;
    map['classification'] = _classification;
    map['other_aspiration'] = _otherAspiration;
    map['total_outflow'] = _totalOutflow;
    map['total_inflation_adjusted_expense'] = _totalInflationAdjustedExpense;
    map['wealth_required_today_total'] = _wealthRequiredTodayTotal;
    map['volatile_component'] = _volatileComponent;
    map['target_return'] = _targetReturn;
    return map;
  }

}

/// year : 2026
/// opening_balance : 230657562
/// fresh_inflow : 16666667
/// expected_profit : 23899090
/// outflow : 10000000
/// closing_balance : 261223319
/// present_value : 246437093
/// profit_growth_calculation : 12

BalanceSheetData balanceSheetDataFromJson(String str) => BalanceSheetData.fromJson(json.decode(str));
String balanceSheetDataToJson(BalanceSheetData data) => json.encode(data.toJson());
class BalanceSheetData {
  BalanceSheetData({
      num? year, 
      num? openingBalance, 
      num? freshInflow, 
      num? expectedProfit, 
      num? outflow, 
      num? closingBalance, 
      num? presentValue, 
      num? profitGrowthCalculation,}){
    _year = year;
    _openingBalance = openingBalance;
    _freshInflow = freshInflow;
    _expectedProfit = expectedProfit;
    _outflow = outflow;
    _closingBalance = closingBalance;
    _presentValue = presentValue;
    _profitGrowthCalculation = profitGrowthCalculation;
}

  BalanceSheetData.fromJson(dynamic json) {
    _year = json['year'];
    _openingBalance = json['opening_balance'];
    _freshInflow = json['fresh_inflow'];
    _expectedProfit = json['expected_profit'];
    _outflow = json['outflow'];
    _closingBalance = json['closing_balance'];
    _presentValue = json['present_value'];
    _profitGrowthCalculation = json['profit_growth_calculation'];
  }
  num? _year;
  num? _openingBalance;
  num? _freshInflow;
  num? _expectedProfit;
  num? _outflow;
  num? _closingBalance;
  num? _presentValue;
  num? _profitGrowthCalculation;
BalanceSheetData copyWith({  num? year,
  num? openingBalance,
  num? freshInflow,
  num? expectedProfit,
  num? outflow,
  num? closingBalance,
  num? presentValue,
  num? profitGrowthCalculation,
}) => BalanceSheetData(  year: year ?? _year,
  openingBalance: openingBalance ?? _openingBalance,
  freshInflow: freshInflow ?? _freshInflow,
  expectedProfit: expectedProfit ?? _expectedProfit,
  outflow: outflow ?? _outflow,
  closingBalance: closingBalance ?? _closingBalance,
  presentValue: presentValue ?? _presentValue,
  profitGrowthCalculation: profitGrowthCalculation ?? _profitGrowthCalculation,
);
  num? get year => _year;
  num? get openingBalance => _openingBalance;
  num? get freshInflow => _freshInflow;
  num? get expectedProfit => _expectedProfit;
  num? get outflow => _outflow;
  num? get closingBalance => _closingBalance;
  num? get presentValue => _presentValue;
  num? get profitGrowthCalculation => _profitGrowthCalculation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['year'] = _year;
    map['opening_balance'] = _openingBalance;
    map['fresh_inflow'] = _freshInflow;
    map['expected_profit'] = _expectedProfit;
    map['outflow'] = _outflow;
    map['closing_balance'] = _closingBalance;
    map['present_value'] = _presentValue;
    map['profit_growth_calculation'] = _profitGrowthCalculation;
    return map;
  }

}