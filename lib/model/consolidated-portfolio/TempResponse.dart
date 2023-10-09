import 'dart:convert';
/// asset : "Debt"
/// objectives : [{"objective":"Debt: Ultra Short Duration","schemes":[{"mf_id":"18563505","it_id":"NA","user_id":"500","SchemeName":"Aditya Birla SL Savings Fund Reg (G)","InitialValue":99995,"CurrentValue":114368,"Gain":14373,"AbsoluteReturn":14,"Annualized_return":5.36,"CAGR":"5.28","FolioNo":"1040659412","FCode":"F0003","SCode":"FS054","Exlcode":"1207","Unit":"237.846","Holdingdays":"953","Asset":"Debt","Objective":"Debt: Ultra Short Duration","UCC":"2147483647","HoldingPercentage":"0.43","ActiveStatus":"YES","ApplicantName":"ABHA AGARWAL","Cid":"01C00009","GroupLeader":"","insert_timestamp":"1696256496","ISINNO":"","Dividend":"0","Demat":"","FundHouse":"Aditya Birla Sun Life Mutual Fund","broker":"AlphaCapital"},{"mf_id":"","it_id":"","user_id":"","SchemeName":"Sub Total","InitialValue":99995,"CurrentValue":114368,"Gain":14373,"AbsoluteReturn":"","Annualized_return":"","CAGR":"","FolioNo":"","FCode":"","SCode":"","Exlcode":"","Unit":"","Holdingdays":"","Asset":"","Objective":"","UCC":"","HoldingPercentage":"","ActiveStatus":"","ApplicantName":"","Cid":"","GroupLeader":"","insert_timestamp":"","ISINNO":"","Dividend":"","Demat":"","FundHouse":"","broker":""}]},{"objective":"Debt: Money Market","schemes":[{"mf_id":"18563514","it_id":"NA","user_id":"500","SchemeName":"HDFC Money Market Fund (G)","InitialValue":105448,"CurrentValue":124412,"Gain":18965,"AbsoluteReturn":18,"Annualized_return":5.41,"CAGR":"5.1","FolioNo":"10912770/63","FCode":"F0014","SCode":"FS074","Exlcode":"659","Unit":"24.782","Holdingdays":"1214","Asset":"Debt","Objective":"Debt: Money Market","UCC":"2147483647","HoldingPercentage":"0.47","ActiveStatus":"YES","ApplicantName":"ABHA AGARWAL","Cid":"01C00009","GroupLeader":"","insert_timestamp":"1696256496","ISINNO":"","Dividend":"0","Demat":"","FundHouse":"HDFC Mutual Fund","broker":"AlphaCapital"},{"mf_id":"","it_id":"","user_id":"","SchemeName":"Sub Total","InitialValue":105448,"CurrentValue":124412,"Gain":18965,"AbsoluteReturn":"","Annualized_return":"","CAGR":"","FolioNo":"","FCode":"","SCode":"","Exlcode":"","Unit":"","Holdingdays":"","Asset":"","Objective":"","UCC":"","HoldingPercentage":"","ActiveStatus":"","ApplicantName":"","Cid":"","GroupLeader":"","insert_timestamp":"","ISINNO":"","Dividend":"","Demat":"","FundHouse":"","broker":""}]},{"objective":"Debt: Low Duration","schemes":[{"mf_id":"18563524","it_id":"NA","user_id":"500","SchemeName":"ICICI Pru Savings Fund (G)","InitialValue":570362,"CurrentValue":915128,"Gain":344766,"AbsoluteReturn":60,"Annualized_return":8.45,"CAGR":"6.88","FolioNo":"6631326/43","FCode":"F0025","SCode":"FS053","Exlcode":"964","Unit":"1922.23","Holdingdays":"2592","Asset":"Debt","Objective":"Debt: Low Duration","UCC":"2147483647","HoldingPercentage":"3.48","ActiveStatus":"YES","ApplicantName":"ABHA AGARWAL","Cid":"01C00009","GroupLeader":"","insert_timestamp":"1696256496","ISINNO":"","Dividend":"0","Demat":"","FundHouse":"ICICI Prudential Mutual Fund","broker":"AlphaCapital"},{"mf_id":"","it_id":"","user_id":"","SchemeName":"Sub Total","InitialValue":570362,"CurrentValue":915128,"Gain":344766,"AbsoluteReturn":"","Annualized_return":"","CAGR":"","FolioNo":"","FCode":"","SCode":"","Exlcode":"","Unit":"","Holdingdays":"","Asset":"","Objective":"","UCC":"","HoldingPercentage":"","ActiveStatus":"","ApplicantName":"","Cid":"","GroupLeader":"","insert_timestamp":"","ISINNO":"","Dividend":"","Demat":"","FundHouse":"","broker":""},{"AbsoluteReturn":"","ActiveStatus":"","ApplicantName":"","Asset":"","CAGR":"","Cid":"","InitialValue":775805,"CurrentValue":1153908,"Gain":378104,"Demat":"","Dividend":"","Exlcode":"","FCode":"","FolioNo":"","FundHouse":"","GroupLeader":"","HoldingPercentage":"","Holdingdays":"","ISINNO":"","Objective":"","SCode":"","SchemeName":"Total","UCC":"","Unit":"","insert_timestamp":"","it_id":"","mf_id":"","user_id":"500","investment_type":""}]}]

TempResponse tempResponseFromJson(String str) => TempResponse.fromJson(json.decode(str));
String tempResponseToJson(TempResponse data) => json.encode(data.toJson());
class TempResponse {
  TempResponse({
      String? asset, 
      List<ObjectivesTemp>? objectives,}){
    _asset = asset;
    _objectives = objectives;
}

  TempResponse.fromJson(dynamic json) {
    _asset = json['asset'];
    if (json['objectives'] != null) {
      _objectives = [];
      json['objectives'].forEach((v) {
        _objectives?.add(ObjectivesTemp.fromJson(v));
      });
    }
  }
  String? _asset;
  List<ObjectivesTemp>? _objectives;
TempResponse copyWith({  String? asset,
  List<ObjectivesTemp>? objectives,
}) => TempResponse(  asset: asset ?? _asset,
  objectives: objectives ?? _objectives,
);
  String? get asset => _asset;
  List<ObjectivesTemp>? get objectives => _objectives;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['asset'] = _asset;
    if (_objectives != null) {
      map['objectives'] = _objectives?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// objective : "Debt: Ultra Short Duration"
/// schemes : [{"mf_id":"18563505","it_id":"NA","user_id":"500","SchemeName":"Aditya Birla SL Savings Fund Reg (G)","InitialValue":99995,"CurrentValue":114368,"Gain":14373,"AbsoluteReturn":14,"Annualized_return":5.36,"CAGR":"5.28","FolioNo":"1040659412","FCode":"F0003","SCode":"FS054","Exlcode":"1207","Unit":"237.846","Holdingdays":"953","Asset":"Debt","Objective":"Debt: Ultra Short Duration","UCC":"2147483647","HoldingPercentage":"0.43","ActiveStatus":"YES","ApplicantName":"ABHA AGARWAL","Cid":"01C00009","GroupLeader":"","insert_timestamp":"1696256496","ISINNO":"","Dividend":"0","Demat":"","FundHouse":"Aditya Birla Sun Life Mutual Fund","broker":"AlphaCapital"},{"mf_id":"","it_id":"","user_id":"","SchemeName":"Sub Total","InitialValue":99995,"CurrentValue":114368,"Gain":14373,"AbsoluteReturn":"","Annualized_return":"","CAGR":"","FolioNo":"","FCode":"","SCode":"","Exlcode":"","Unit":"","Holdingdays":"","Asset":"","Objective":"","UCC":"","HoldingPercentage":"","ActiveStatus":"","ApplicantName":"","Cid":"","GroupLeader":"","insert_timestamp":"","ISINNO":"","Dividend":"","Demat":"","FundHouse":"","broker":""}]

ObjectivesTemp objectivesFromJson(String str) => ObjectivesTemp.fromJson(json.decode(str));
String objectivesToJson(ObjectivesTemp data) => json.encode(data.toJson());
class ObjectivesTemp {
  ObjectivesTemp({
      String? objective, 
      List<SchemesTemp>? schemes,}){
    _objective = objective;
    _schemes = schemes;
}

  ObjectivesTemp.fromJson(dynamic json) {
    _objective = json['objective'];
    if (json['schemes'] != null) {
      _schemes = [];
      json['schemes'].forEach((v) {
        _schemes?.add(SchemesTemp.fromJson(v));
      });
    }
  }
  String? _objective;
  List<SchemesTemp>? _schemes;
ObjectivesTemp copyWith({  String? objective,
  List<SchemesTemp>? schemes,
}) => ObjectivesTemp(  objective: objective ?? _objective,
  schemes: schemes ?? _schemes,
);
  String? get objective => _objective;
  List<SchemesTemp>? get schemes => _schemes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['objective'] = _objective;
    if (_schemes != null) {
      map['schemes'] = _schemes?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// mf_id : "18563505"
/// it_id : "NA"
/// user_id : "500"
/// SchemeName : "Aditya Birla SL Savings Fund Reg (G)"
/// InitialValue : 99995
/// CurrentValue : 114368
/// Gain : 14373
/// AbsoluteReturn : 14
/// Annualized_return : 5.36
/// CAGR : "5.28"
/// FolioNo : "1040659412"
/// FCode : "F0003"
/// SCode : "FS054"
/// Exlcode : "1207"
/// Unit : "237.846"
/// Holdingdays : "953"
/// Asset : "Debt"
/// Objective : "Debt: Ultra Short Duration"
/// UCC : "2147483647"
/// HoldingPercentage : "0.43"
/// ActiveStatus : "YES"
/// ApplicantName : "ABHA AGARWAL"
/// Cid : "01C00009"
/// GroupLeader : ""
/// insert_timestamp : "1696256496"
/// ISINNO : ""
/// Dividend : "0"
/// Demat : ""
/// FundHouse : "Aditya Birla Sun Life Mutual Fund"
/// broker : "AlphaCapital"

SchemesTemp schemesFromJson(String str) => SchemesTemp.fromJson(json.decode(str));
String schemesToJson(SchemesTemp data) => json.encode(data.toJson());
class SchemesTemp {
  SchemesTemp({
      String? mfId, 
      String? itId, 
      String? userId, 
      String? schemeName, 
      num? initialValue, 
      num? currentValue, 
      num? gain, 
      num? absoluteReturn, 
      num? annualizedReturn, 
      String? cagr, 
      String? folioNo, 
      String? fCode, 
      String? sCode, 
      String? exlcode, 
      String? unit, 
      String? holdingdays, 
      String? asset, 
      String? objective, 
      String? ucc, 
      String? holdingPercentage, 
      String? activeStatus, 
      String? applicantName, 
      String? cid, 
      String? groupLeader, 
      String? insertTimestamp, 
      String? isinno, 
      String? dividend, 
      String? demat, 
      String? fundHouse, 
      String? broker,}){
    _mfId = mfId;
    _itId = itId;
    _userId = userId;
    _schemeName = schemeName;
    _initialValue = initialValue;
    _currentValue = currentValue;
    _gain = gain;
    _absoluteReturn = absoluteReturn;
    _annualizedReturn = annualizedReturn;
    _cagr = cagr;
    _folioNo = folioNo;
    _fCode = fCode;
    _sCode = sCode;
    _exlcode = exlcode;
    _unit = unit;
    _holdingdays = holdingdays;
    _asset = asset;
    _objective = objective;
    _ucc = ucc;
    _holdingPercentage = holdingPercentage;
    _activeStatus = activeStatus;
    _applicantName = applicantName;
    _cid = cid;
    _groupLeader = groupLeader;
    _insertTimestamp = insertTimestamp;
    _isinno = isinno;
    _dividend = dividend;
    _demat = demat;
    _fundHouse = fundHouse;
    _broker = broker;
}

  SchemesTemp.fromJson(dynamic json) {
    _mfId = json['mf_id'];
    _itId = json['it_id'];
    _userId = json['user_id'];
    _schemeName = json['SchemeName'];
    _initialValue = json['InitialValue'] is num ? json['InitialValue'] : 0;
    _currentValue = json['CurrentValue'] is num ? json['CurrentValue'] : 0;
    _gain = json['Gain'];
    _absoluteReturn =   json['AbsoluteReturn'] is num ? json['AbsoluteReturn']  : 0;
    _annualizedReturn = json['Annualized_return'] is num ? json['Annualized_return'] : 0;
    _cagr = json['CAGR'] is String ? json['CAGR']  : "";
    _folioNo = json['FolioNo'];
    _fCode = json['FCode'];
    _sCode = json['SCode'];
    _exlcode = json['Exlcode'];
    _unit = json['Unit'];
    //_holdingdays = json['Holdingdays'];
    _asset = json['Asset'];
    _objective = json['Objective'];
    _ucc = json['UCC'];
    _holdingPercentage = json['HoldingPercentage'];
    _activeStatus = json['ActiveStatus'];
    _applicantName = json['ApplicantName'];
    _cid = json['Cid'];
    _groupLeader = json['GroupLeader'];
    _insertTimestamp = json['insert_timestamp'];
    _isinno = json['ISINNO'];
    _dividend = json['Dividend'];
    _demat = json['Demat'];
    _fundHouse = json['FundHouse'];
    _broker = json['broker'];
  }
  String? _mfId;
  String? _itId;
  String? _userId;
  String? _schemeName;
  num? _initialValue;
  num? _currentValue;
  num? _gain;
  num? _absoluteReturn;
  num? _annualizedReturn;
  String? _cagr;
  String? _folioNo;
  String? _fCode;
  String? _sCode;
  String? _exlcode;
  String? _unit;
  String? _holdingdays;
  String? _asset;
  String? _objective;
  String? _ucc;
  String? _holdingPercentage;
  String? _activeStatus;
  String? _applicantName;
  String? _cid;
  String? _groupLeader;
  String? _insertTimestamp;
  String? _isinno;
  String? _dividend;
  String? _demat;
  String? _fundHouse;
  String? _broker;
SchemesTemp copyWith({  String? mfId,
  String? itId,
  String? userId,
  String? schemeName,
  num? initialValue,
  num? currentValue,
  num? gain,
  num? absoluteReturn,
  num? annualizedReturn,
  String? cagr,
  String? folioNo,
  String? fCode,
  String? sCode,
  String? exlcode,
  String? unit,
  String? holdingdays,
  String? asset,
  String? objective,
  String? ucc,
  String? holdingPercentage,
  String? activeStatus,
  String? applicantName,
  String? cid,
  String? groupLeader,
  String? insertTimestamp,
  String? isinno,
  String? dividend,
  String? demat,
  String? fundHouse,
  String? broker,
}) => SchemesTemp(  mfId: mfId ?? _mfId,
  itId: itId ?? _itId,
  userId: userId ?? _userId,
  schemeName: schemeName ?? _schemeName,
  initialValue: initialValue ?? _initialValue,
  currentValue: currentValue ?? _currentValue,
  gain: gain ?? _gain,
  absoluteReturn: absoluteReturn ?? _absoluteReturn,
  annualizedReturn: annualizedReturn ?? _annualizedReturn,
  cagr: cagr ?? _cagr,
  folioNo: folioNo ?? _folioNo,
  fCode: fCode ?? _fCode,
  sCode: sCode ?? _sCode,
  exlcode: exlcode ?? _exlcode,
  unit: unit ?? _unit,
  holdingdays: holdingdays ?? _holdingdays,
  asset: asset ?? _asset,
  objective: objective ?? _objective,
  ucc: ucc ?? _ucc,
  holdingPercentage: holdingPercentage ?? _holdingPercentage,
  activeStatus: activeStatus ?? _activeStatus,
  applicantName: applicantName ?? _applicantName,
  cid: cid ?? _cid,
  groupLeader: groupLeader ?? _groupLeader,
  insertTimestamp: insertTimestamp ?? _insertTimestamp,
  isinno: isinno ?? _isinno,
  dividend: dividend ?? _dividend,
  demat: demat ?? _demat,
  fundHouse: fundHouse ?? _fundHouse,
  broker: broker ?? _broker,
);
  String? get mfId => _mfId;
  String? get itId => _itId;
  String? get userId => _userId;
  String? get schemeName => _schemeName;
  num? get initialValue => _initialValue;
  num? get currentValue => _currentValue;
  num? get gain => _gain;
  num? get absoluteReturn => _absoluteReturn;
  num? get annualizedReturn => _annualizedReturn;
  String? get cagr => _cagr;
  String? get folioNo => _folioNo;
  String? get fCode => _fCode;
  String? get sCode => _sCode;
  String? get exlcode => _exlcode;
  String? get unit => _unit;
  String? get holdingdays => _holdingdays;
  String? get asset => _asset;
  String? get objective => _objective;
  String? get ucc => _ucc;
  String? get holdingPercentage => _holdingPercentage;
  String? get activeStatus => _activeStatus;
  String? get applicantName => _applicantName;
  String? get cid => _cid;
  String? get groupLeader => _groupLeader;
  String? get insertTimestamp => _insertTimestamp;
  String? get isinno => _isinno;
  String? get dividend => _dividend;
  String? get demat => _demat;
  String? get fundHouse => _fundHouse;
  String? get broker => _broker;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mf_id'] = _mfId;
    map['it_id'] = _itId;
    map['user_id'] = _userId;
    map['SchemeName'] = _schemeName;
    map['InitialValue'] = _initialValue;
    map['CurrentValue'] = _currentValue;
    map['Gain'] = _gain;
    map['AbsoluteReturn'] = _absoluteReturn;
    map['Annualized_return'] = _annualizedReturn;
    map['CAGR'] = _cagr;
    map['FolioNo'] = _folioNo;
    map['FCode'] = _fCode;
    map['SCode'] = _sCode;
    map['Exlcode'] = _exlcode;
    map['Unit'] = _unit;
    map['Holdingdays'] = _holdingdays;
    map['Asset'] = _asset;
    map['Objective'] = _objective;
    map['UCC'] = _ucc;
    map['HoldingPercentage'] = _holdingPercentage;
    map['ActiveStatus'] = _activeStatus;
    map['ApplicantName'] = _applicantName;
    map['Cid'] = _cid;
    map['GroupLeader'] = _groupLeader;
    map['insert_timestamp'] = _insertTimestamp;
    map['ISINNO'] = _isinno;
    map['Dividend'] = _dividend;
    map['Demat'] = _demat;
    map['FundHouse'] = _fundHouse;
    map['broker'] = _broker;
    return map;
  }

}