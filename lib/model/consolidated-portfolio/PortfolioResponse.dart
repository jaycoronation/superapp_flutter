/// result : {"portfolio":[{"applicant_name":"A V RAMESH","data":[{"asset":"Debt","objectives":[{"objective":"Debt: Corporate Bond","schemes":[{"mf_id":"15495362","it_id":"NA","user_id":"52","SchemeName":"Aditya Birla SL Corporate Bond Fund (G)","InitialValue":1500000,"CurrentValue":1872876,"Gain":372876,"AbsoluteReturn":25,"Annualized_return":7.33,"CAGR":"6.72","FolioNo":"1039194267","FCode":"F0003","SCode":"FS142","Exlcode":"2793","Unit":"19790.3","Holdingdays":"1245","Asset":"Debt","Objective":"Debt: Corporate Bond","UCC":"2147483647","HoldingPercentage":"13.68","ActiveStatus":"YES","ApplicantName":"A V RAMESH","Cid":"01C02603","GroupLeader":"","insert_timestamp":"1681137006","ISINNO":"","Dividend":"0","Demat":"","FundHouse":"Aditya Birla Sun Life Mutual Fund","broker":"AlphaCapital"}]}]}]}]}
/// success : 1

class PortfolioResponse {
  PortfolioResponse({
      Result? result, 
      num? success,}){
    _result = result;
    _success = success;
}

  PortfolioResponse.fromJson(dynamic json) {
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
    _success = json['success'];
  }
  Result? _result;
  num? _success;
PortfolioResponse copyWith({  Result? result,
  num? success,
}) => PortfolioResponse(  result: result ?? _result,
  success: success ?? _success,
);
  Result? get result => _result;
  num? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_result != null) {
      map['result'] = _result?.toJson();
    }
    map['success'] = _success;
    return map;
  }

}

/// portfolio : [{"applicant_name":"A V RAMESH","data":[{"asset":"Debt","objectives":[{"objective":"Debt: Corporate Bond","schemes":[{"mf_id":"15495362","it_id":"NA","user_id":"52","SchemeName":"Aditya Birla SL Corporate Bond Fund (G)","InitialValue":1500000,"CurrentValue":1872876,"Gain":372876,"AbsoluteReturn":25,"Annualized_return":7.33,"CAGR":"6.72","FolioNo":"1039194267","FCode":"F0003","SCode":"FS142","Exlcode":"2793","Unit":"19790.3","Holdingdays":"1245","Asset":"Debt","Objective":"Debt: Corporate Bond","UCC":"2147483647","HoldingPercentage":"13.68","ActiveStatus":"YES","ApplicantName":"A V RAMESH","Cid":"01C02603","GroupLeader":"","insert_timestamp":"1681137006","ISINNO":"","Dividend":"0","Demat":"","FundHouse":"Aditya Birla Sun Life Mutual Fund","broker":"AlphaCapital"}]}]}]}]

class Result {
  Result({
      List<Portfolio>? portfolio,}){
    _portfolio = portfolio;
}

  Result.fromJson(dynamic json) {
    if (json['portfolio'] != null) {
      _portfolio = [];
      json['portfolio'].forEach((v) {
        _portfolio?.add(Portfolio.fromJson(v));
      });
    }
  }
  List<Portfolio>? _portfolio;
Result copyWith({  List<Portfolio>? portfolio,
}) => Result(  portfolio: portfolio ?? _portfolio,
);
  List<Portfolio>? get portfolio => _portfolio;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_portfolio != null) {
      map['portfolio'] = _portfolio?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// applicant_name : "A V RAMESH"
/// data : [{"asset":"Debt","objectives":[{"objective":"Debt: Corporate Bond","schemes":[{"mf_id":"15495362","it_id":"NA","user_id":"52","SchemeName":"Aditya Birla SL Corporate Bond Fund (G)","InitialValue":1500000,"CurrentValue":1872876,"Gain":372876,"AbsoluteReturn":25,"Annualized_return":7.33,"CAGR":"6.72","FolioNo":"1039194267","FCode":"F0003","SCode":"FS142","Exlcode":"2793","Unit":"19790.3","Holdingdays":"1245","Asset":"Debt","Objective":"Debt: Corporate Bond","UCC":"2147483647","HoldingPercentage":"13.68","ActiveStatus":"YES","ApplicantName":"A V RAMESH","Cid":"01C02603","GroupLeader":"","insert_timestamp":"1681137006","ISINNO":"","Dividend":"0","Demat":"","FundHouse":"Aditya Birla Sun Life Mutual Fund","broker":"AlphaCapital"}]}]}]

class Portfolio {
  Portfolio({
      String? applicantName, 
      List<Data>? data,}){
    _applicantName = applicantName;
    _data = data;
}

  Portfolio.fromJson(dynamic json) {
    _applicantName = json['applicant_name'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  String? _applicantName;
  List<Data>? _data;
Portfolio copyWith({  String? applicantName,
  List<Data>? data,
}) => Portfolio(  applicantName: applicantName ?? _applicantName,
  data: data ?? _data,
);
  String? get applicantName => _applicantName;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['applicant_name'] = _applicantName;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// asset : "Debt"
/// objectives : [{"objective":"Debt: Corporate Bond","schemes":[{"mf_id":"15495362","it_id":"NA","user_id":"52","SchemeName":"Aditya Birla SL Corporate Bond Fund (G)","InitialValue":1500000,"CurrentValue":1872876,"Gain":372876,"AbsoluteReturn":25,"Annualized_return":7.33,"CAGR":"6.72","FolioNo":"1039194267","FCode":"F0003","SCode":"FS142","Exlcode":"2793","Unit":"19790.3","Holdingdays":"1245","Asset":"Debt","Objective":"Debt: Corporate Bond","UCC":"2147483647","HoldingPercentage":"13.68","ActiveStatus":"YES","ApplicantName":"A V RAMESH","Cid":"01C02603","GroupLeader":"","insert_timestamp":"1681137006","ISINNO":"","Dividend":"0","Demat":"","FundHouse":"Aditya Birla Sun Life Mutual Fund","broker":"AlphaCapital"}]}]

class Data {
  Data({
      String? asset, 
      List<Objectives>? objectives,}){
    _asset = asset;
    _objectives = objectives;
}

  Data.fromJson(dynamic json) {
    _asset = json['asset'];
    if (json['objectives'] != null) {
      _objectives = [];
      json['objectives'].forEach((v) {
        _objectives?.add(Objectives.fromJson(v));
      });
    }
  }
  String? _asset;
  List<Objectives>? _objectives;
Data copyWith({  String? asset,
  List<Objectives>? objectives,
}) => Data(  asset: asset ?? _asset,
  objectives: objectives ?? _objectives,
);
  String? get asset => _asset;
  List<Objectives>? get objectives => _objectives;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['asset'] = _asset;
    if (_objectives != null) {
      map['objectives'] = _objectives?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// objective : "Debt: Corporate Bond"
/// schemes : [{"mf_id":"15495362","it_id":"NA","user_id":"52","SchemeName":"Aditya Birla SL Corporate Bond Fund (G)","InitialValue":1500000,"CurrentValue":1872876,"Gain":372876,"AbsoluteReturn":25,"Annualized_return":7.33,"CAGR":"6.72","FolioNo":"1039194267","FCode":"F0003","SCode":"FS142","Exlcode":"2793","Unit":"19790.3","Holdingdays":"1245","Asset":"Debt","Objective":"Debt: Corporate Bond","UCC":"2147483647","HoldingPercentage":"13.68","ActiveStatus":"YES","ApplicantName":"A V RAMESH","Cid":"01C02603","GroupLeader":"","insert_timestamp":"1681137006","ISINNO":"","Dividend":"0","Demat":"","FundHouse":"Aditya Birla Sun Life Mutual Fund","broker":"AlphaCapital"}]

class Objectives {
  Objectives({
      String? objective, 
      List<Schemes>? schemes,}){
    _objective = objective;
    _schemes = schemes;
}

  Objectives.fromJson(dynamic json) {
    _objective = json['objective'];
    if (json['schemes'] != null) {
      _schemes = [];
      json['schemes'].forEach((v) {
        _schemes?.add(Schemes.fromJson(v));
      });
    }
  }
  String? _objective;
  List<Schemes>? _schemes;
Objectives copyWith({  String? objective,
  List<Schemes>? schemes,
}) => Objectives(  objective: objective ?? _objective,
  schemes: schemes ?? _schemes,
);
  String? get objective => _objective;
  List<Schemes>? get schemes => _schemes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['objective'] = _objective;
    if (_schemes != null) {
      map['schemes'] = _schemes?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// mf_id : "15495362"
/// it_id : "NA"
/// user_id : "52"
/// SchemeName : "Aditya Birla SL Corporate Bond Fund (G)"
/// InitialValue : 1500000
/// CurrentValue : 1872876
/// Gain : 372876
/// AbsoluteReturn : 25
/// Annualized_return : 7.33
/// CAGR : "6.72"
/// FolioNo : "1039194267"
/// FCode : "F0003"
/// SCode : "FS142"
/// Exlcode : "2793"
/// Unit : "19790.3"
/// Holdingdays : "1245"
/// Asset : "Debt"
/// Objective : "Debt: Corporate Bond"
/// UCC : "2147483647"
/// HoldingPercentage : "13.68"
/// ActiveStatus : "YES"
/// ApplicantName : "A V RAMESH"
/// Cid : "01C02603"
/// GroupLeader : ""
/// insert_timestamp : "1681137006"
/// ISINNO : ""
/// Dividend : "0"
/// Demat : ""
/// FundHouse : "Aditya Birla Sun Life Mutual Fund"
/// broker : "AlphaCapital"

class Schemes {
  Schemes({
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

  Schemes.fromJson(dynamic json) {
    _mfId = json['mf_id'];
    _itId = json['it_id'];
    _userId = json['user_id'];
    _schemeName = json['SchemeName'];
    _initialValue = json['InitialValue'];
    _currentValue = json['CurrentValue'];
    _gain = json['Gain'];
    _absoluteReturn = json['AbsoluteReturn'];
    _annualizedReturn = json['Annualized_return'];
    _cagr = json['CAGR'];
    _folioNo = json['FolioNo'];
    _fCode = json['FCode'];
    _sCode = json['SCode'];
    _exlcode = json['Exlcode'];
    _unit = json['Unit'];
    _holdingdays = json['Holdingdays'];
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
Schemes copyWith({  String? mfId,
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
}) => Schemes(  mfId: mfId ?? _mfId,
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