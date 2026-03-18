import 'dart:convert';
/// insurances : [{"insurance_id":"181","type":"1","insurance_company":"ICICI Pru","policy_number":"12345678900","sum_assured":"1500000","person_covered":"mukesh jindal","start_date":"18-03-2026","end_date":"18-03-2028","premium_amount":"20000","nominee":"","timestamp":"1773641779","user_id":"500","maturity_date":"18-03-2028","last_payment_date":"18-03-2026","next_due_date":"18-04-2026"},{"insurance_id":"183","type":"1","insurance_company":"ICICI Pru","policy_number":"123456","sum_assured":"10000000","person_covered":"mukesh jindal","start_date":"15-06-2020","end_date":"15-08-2030","premium_amount":"15000","nominee":"","timestamp":"1773728375","user_id":"500","maturity_date":"15-08-2030","last_payment_date":"15-03-2026","next_due_date":"15-04-2026"}]
/// success : 1
/// message : "2 records found"

InsuranceListResponseModel insuranceListResponseModelFromJson(String str) => InsuranceListResponseModel.fromJson(json.decode(str));
String insuranceListResponseModelToJson(InsuranceListResponseModel data) => json.encode(data.toJson());
class InsuranceListResponseModel {
  InsuranceListResponseModel({
      List<Insurances>? insurances, 
      num? success, 
      String? message,}){
    _insurances = insurances;
    _success = success;
    _message = message;
}

  InsuranceListResponseModel.fromJson(dynamic json) {
    if (json['insurances'] != null) {
      _insurances = [];
      json['insurances'].forEach((v) {
        _insurances?.add(Insurances.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
  }
  List<Insurances>? _insurances;
  num? _success;
  String? _message;
InsuranceListResponseModel copyWith({  List<Insurances>? insurances,
  num? success,
  String? message,
}) => InsuranceListResponseModel(  insurances: insurances ?? _insurances,
  success: success ?? _success,
  message: message ?? _message,
);
  List<Insurances>? get insurances => _insurances;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_insurances != null) {
      map['insurances'] = _insurances?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// insurance_id : "181"
/// type : "1"
/// insurance_company : "ICICI Pru"
/// policy_number : "12345678900"
/// sum_assured : "1500000"
/// person_covered : "mukesh jindal"
/// start_date : "18-03-2026"
/// end_date : "18-03-2028"
/// premium_amount : "20000"
/// nominee : ""
/// timestamp : "1773641779"
/// user_id : "500"
/// maturity_date : "18-03-2028"
/// last_payment_date : "18-03-2026"
/// next_due_date : "18-04-2026"

Insurances insurancesFromJson(String str) => Insurances.fromJson(json.decode(str));
String insurancesToJson(Insurances data) => json.encode(data.toJson());
class Insurances {
  Insurances({
      String? insuranceId, 
      String? type, 
      String? insuranceCompany, 
      String? policyNumber, 
      String? sumAssured, 
      String? personCovered, 
      String? startDate, 
      String? endDate, 
      String? premiumAmount, 
      String? nominee, 
      String? timestamp, 
      String? userId, 
      String? maturityDate, 
      String? lastPaymentDate, 
      String? nextDueDate,}){
    _insuranceId = insuranceId;
    _type = type;
    _insuranceCompany = insuranceCompany;
    _policyNumber = policyNumber;
    _sumAssured = sumAssured;
    _personCovered = personCovered;
    _startDate = startDate;
    _endDate = endDate;
    _premiumAmount = premiumAmount;
    _nominee = nominee;
    _timestamp = timestamp;
    _userId = userId;
    _maturityDate = maturityDate;
    _lastPaymentDate = lastPaymentDate;
    _nextDueDate = nextDueDate;
}

  Insurances.fromJson(dynamic json) {
    _insuranceId = json['insurance_id'];
    _type = json['type'];
    _insuranceCompany = json['insurance_company'];
    _policyNumber = json['policy_number'];
    _sumAssured = json['sum_assured'];
    _personCovered = json['person_covered'];
    _startDate = json['start_date'];
    _endDate = json['end_date'];
    _premiumAmount = json['premium_amount'];
    _nominee = json['nominee'];
    _timestamp = json['timestamp'];
    _userId = json['user_id'];
    _maturityDate = json['maturity_date'];
    _lastPaymentDate = json['last_payment_date'];
    _nextDueDate = json['next_due_date'];
  }
  String? _insuranceId;
  String? _type;
  String? _insuranceCompany;
  String? _policyNumber;
  String? _sumAssured;
  String? _personCovered;
  String? _startDate;
  String? _endDate;
  String? _premiumAmount;
  String? _nominee;
  String? _timestamp;
  String? _userId;
  String? _maturityDate;
  String? _lastPaymentDate;
  String? _nextDueDate;
Insurances copyWith({  String? insuranceId,
  String? type,
  String? insuranceCompany,
  String? policyNumber,
  String? sumAssured,
  String? personCovered,
  String? startDate,
  String? endDate,
  String? premiumAmount,
  String? nominee,
  String? timestamp,
  String? userId,
  String? maturityDate,
  String? lastPaymentDate,
  String? nextDueDate,
}) => Insurances(  insuranceId: insuranceId ?? _insuranceId,
  type: type ?? _type,
  insuranceCompany: insuranceCompany ?? _insuranceCompany,
  policyNumber: policyNumber ?? _policyNumber,
  sumAssured: sumAssured ?? _sumAssured,
  personCovered: personCovered ?? _personCovered,
  startDate: startDate ?? _startDate,
  endDate: endDate ?? _endDate,
  premiumAmount: premiumAmount ?? _premiumAmount,
  nominee: nominee ?? _nominee,
  timestamp: timestamp ?? _timestamp,
  userId: userId ?? _userId,
  maturityDate: maturityDate ?? _maturityDate,
  lastPaymentDate: lastPaymentDate ?? _lastPaymentDate,
  nextDueDate: nextDueDate ?? _nextDueDate,
);
  String? get insuranceId => _insuranceId;
  String? get type => _type;
  String? get insuranceCompany => _insuranceCompany;
  String? get policyNumber => _policyNumber;
  String? get sumAssured => _sumAssured;
  String? get personCovered => _personCovered;
  String? get startDate => _startDate;
  String? get endDate => _endDate;
  String? get premiumAmount => _premiumAmount;
  String? get nominee => _nominee;
  String? get timestamp => _timestamp;
  String? get userId => _userId;
  String? get maturityDate => _maturityDate;
  String? get lastPaymentDate => _lastPaymentDate;
  String? get nextDueDate => _nextDueDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['insurance_id'] = _insuranceId;
    map['type'] = _type;
    map['insurance_company'] = _insuranceCompany;
    map['policy_number'] = _policyNumber;
    map['sum_assured'] = _sumAssured;
    map['person_covered'] = _personCovered;
    map['start_date'] = _startDate;
    map['end_date'] = _endDate;
    map['premium_amount'] = _premiumAmount;
    map['nominee'] = _nominee;
    map['timestamp'] = _timestamp;
    map['user_id'] = _userId;
    map['maturity_date'] = _maturityDate;
    map['last_payment_date'] = _lastPaymentDate;
    map['next_due_date'] = _nextDueDate;
    return map;
  }

}