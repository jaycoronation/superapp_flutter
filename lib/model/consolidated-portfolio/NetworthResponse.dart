import 'dart:convert';
/// result : {"networth":[{"asset":"Hybrid","objectives":[{"objective":"Hybrid: Conservative","applicants":[{"applicant":"SHAHISTA SHAKEEL AHMED SAYED","amount":6270},{"applicant":"Amount Total","amount":6270},{"applicant":"Percentage","amount":100}],"amount":6270,"percentage":100},{"objective":"Sub Total","applicants":[{"applicant":"SHAHISTA SHAKEEL AHMED SAYED","amount":6270},{"applicant":"Amount Total","amount":6270},{"applicant":"Percentage","amount":100}],"amount":6270,"percentage":100},{"objective":"Total","applicants":[{"applicant":"SHAHISTA SHAKEEL AHMED SAYED","amount":6270},{"applicant":"Amount Total","amount":6270},{"applicant":"Percentage","amount":100}],"amount":6270,"percentage":100}]}],"applicant_details":[{"applicant":"Shahista Shakeel Ahmed Sayed","amount_invested":6000,"current_amount":6286,"gain":286,"dividend":0,"absolute_return":4.77,"CAGR":8.92,"weighted_days":0},{"applicant":"Total","amount_invested":6000,"current_amount":6286,"gain":286,"dividend":0,"absolute_return":0,"CAGR":0,"weighted_days":0}],"scheme_allocation":[{"scheme_name":"ICICI Pru Regular Savings Fund (G)","current_value":6270,"category":"Hybrid: Conservative","allocation":100},{"scheme_name":"Total","current_value":6270,"category":"","allocation":100}],"fund_house_allocation":[{"fund_house":"ICICI Prudential Mutual Fund","current_value":6270,"allocation":100},{"fund_house":"Total","current_value":6270,"allocation":100}],"micro_asset_stratagic":[{"asset":"Debt","amount":0,"actual":0,"policy":50,"variation":50},{"asset":"Equity","amount":0,"actual":0,"policy":50,"variation":50},{"asset":"Hybrid","amount":6270,"actual":100,"policy":0,"variation":-100},{"asset":"Real Estate","amount":0,"actual":0,"policy":0,"variation":0},{"asset":"Alternate","amount":0,"actual":0,"policy":0,"variation":0},{"asset":"Total","amount":6270,"actual":100,"policy":100,"variation":0}],"micro_asset_tactical":[{"asset":"Debt","amount":0,"actual":0,"policy":52.5,"variation":52.5},{"asset":"Equity","amount":0,"actual":0,"policy":47.5,"variation":47.5},{"asset":"Hybrid","amount":6270,"actual":100,"policy":0,"variation":-100},{"asset":"Real Estate","amount":0,"actual":0,"policy":0,"variation":0},{"asset":"Alternate","amount":0,"actual":0,"policy":0,"variation":0},{"asset":"Total","amount":6270,"actual":100,"policy":100,"variation":0}],"macro_asset_stratagic":[{"asset":"Volatile","amount":4076,"actual":65,"policy":50,"variation":-15},{"asset":"Fixed Income","amount":2195,"actual":35,"policy":50,"variation":15},{"asset":"Real Estate","amount":0,"actual":0,"policy":0,"variation":0},{"asset":"Total","amount":6270,"actual":100,"policy":100,"variation":0}],"macro_asset_tactical":[{"asset":"Volatile","amount":4076,"actual":65,"policy":48,"variation":-17},{"asset":"Fixed Income","amount":2195,"actual":35,"policy":53,"variation":18},{"asset":"Real Estate","amount":0,"actual":0,"policy":0,"variation":0},{"asset":"Total","amount":6270,"actual":100,"policy":100,"variation":0}]}
/// success : 1
/// message : ""

NetworthResponse networthResponseFromJson(String str) => NetworthResponse.fromJson(json.decode(str));
String networthResponseToJson(NetworthResponse data) => json.encode(data.toJson());
class NetworthResponse {
  NetworthResponse({
      Result? result, 
      num? success, 
      String? message,}){
    _result = result;
    _success = success;
    _message = message;
}

  NetworthResponse.fromJson(dynamic json) {
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
    _success = json['success'];
    _message = json['message'];
  }
  Result? _result;
  num? _success;
  String? _message;
NetworthResponse copyWith({  Result? result,
  num? success,
  String? message,
}) => NetworthResponse(  result: result ?? _result,
  success: success ?? _success,
  message: message ?? _message,
);
  Result? get result => _result;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_result != null) {
      map['result'] = _result?.toJson();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// networth : [{"asset":"Hybrid","objectives":[{"objective":"Hybrid: Conservative","applicants":[{"applicant":"SHAHISTA SHAKEEL AHMED SAYED","amount":6270},{"applicant":"Amount Total","amount":6270},{"applicant":"Percentage","amount":100}],"amount":6270,"percentage":100},{"objective":"Sub Total","applicants":[{"applicant":"SHAHISTA SHAKEEL AHMED SAYED","amount":6270},{"applicant":"Amount Total","amount":6270},{"applicant":"Percentage","amount":100}],"amount":6270,"percentage":100},{"objective":"Total","applicants":[{"applicant":"SHAHISTA SHAKEEL AHMED SAYED","amount":6270},{"applicant":"Amount Total","amount":6270},{"applicant":"Percentage","amount":100}],"amount":6270,"percentage":100}]}]
/// applicant_details : [{"applicant":"Shahista Shakeel Ahmed Sayed","amount_invested":6000,"current_amount":6286,"gain":286,"dividend":0,"absolute_return":4.77,"CAGR":8.92,"weighted_days":0},{"applicant":"Total","amount_invested":6000,"current_amount":6286,"gain":286,"dividend":0,"absolute_return":0,"CAGR":0,"weighted_days":0}]
/// scheme_allocation : [{"scheme_name":"ICICI Pru Regular Savings Fund (G)","current_value":6270,"category":"Hybrid: Conservative","allocation":100},{"scheme_name":"Total","current_value":6270,"category":"","allocation":100}]
/// fund_house_allocation : [{"fund_house":"ICICI Prudential Mutual Fund","current_value":6270,"allocation":100},{"fund_house":"Total","current_value":6270,"allocation":100}]
/// micro_asset_stratagic : [{"asset":"Debt","amount":0,"actual":0,"policy":50,"variation":50},{"asset":"Equity","amount":0,"actual":0,"policy":50,"variation":50},{"asset":"Hybrid","amount":6270,"actual":100,"policy":0,"variation":-100},{"asset":"Real Estate","amount":0,"actual":0,"policy":0,"variation":0},{"asset":"Alternate","amount":0,"actual":0,"policy":0,"variation":0},{"asset":"Total","amount":6270,"actual":100,"policy":100,"variation":0}]
/// micro_asset_tactical : [{"asset":"Debt","amount":0,"actual":0,"policy":52.5,"variation":52.5},{"asset":"Equity","amount":0,"actual":0,"policy":47.5,"variation":47.5},{"asset":"Hybrid","amount":6270,"actual":100,"policy":0,"variation":-100},{"asset":"Real Estate","amount":0,"actual":0,"policy":0,"variation":0},{"asset":"Alternate","amount":0,"actual":0,"policy":0,"variation":0},{"asset":"Total","amount":6270,"actual":100,"policy":100,"variation":0}]
/// macro_asset_stratagic : [{"asset":"Volatile","amount":4076,"actual":65,"policy":50,"variation":-15},{"asset":"Fixed Income","amount":2195,"actual":35,"policy":50,"variation":15},{"asset":"Real Estate","amount":0,"actual":0,"policy":0,"variation":0},{"asset":"Total","amount":6270,"actual":100,"policy":100,"variation":0}]
/// macro_asset_tactical : [{"asset":"Volatile","amount":4076,"actual":65,"policy":48,"variation":-17},{"asset":"Fixed Income","amount":2195,"actual":35,"policy":53,"variation":18},{"asset":"Real Estate","amount":0,"actual":0,"policy":0,"variation":0},{"asset":"Total","amount":6270,"actual":100,"policy":100,"variation":0}]

Result resultFromJson(String str) => Result.fromJson(json.decode(str));
String resultToJson(Result data) => json.encode(data.toJson());
class Result {
  Result({
      List<Networth>? networth, 
      List<ApplicantDetails>? applicantDetails, 
      List<SchemeAllocation>? schemeAllocation, 
      List<FundHouseAllocation>? fundHouseAllocation, 
      List<MicroAssetStratagic>? microAssetStratagic, 
      List<MicroAssetTactical>? microAssetTactical, 
      List<MacroAssetStratagic>? macroAssetStratagic, 
      List<MacroAssetTactical>? macroAssetTactical,}){
    _networth = networth;
    _applicantDetails = applicantDetails;
    _schemeAllocation = schemeAllocation;
    _fundHouseAllocation = fundHouseAllocation;
    _microAssetStratagic = microAssetStratagic;
    _microAssetTactical = microAssetTactical;
    _macroAssetStratagic = macroAssetStratagic;
    _macroAssetTactical = macroAssetTactical;
}

  Result.fromJson(dynamic json) {
    if (json['networth'] != null) {
      _networth = [];
      json['networth'].forEach((v) {
        _networth?.add(Networth.fromJson(v));
      });
    }
    if (json['applicant_details'] != null) {
      _applicantDetails = [];
      json['applicant_details'].forEach((v) {
        _applicantDetails?.add(ApplicantDetails.fromJson(v));
      });
    }
    if (json['scheme_allocation'] != null) {
      _schemeAllocation = [];
      json['scheme_allocation'].forEach((v) {
        _schemeAllocation?.add(SchemeAllocation.fromJson(v));
      });
    }
    if (json['fund_house_allocation'] != null) {
      _fundHouseAllocation = [];
      json['fund_house_allocation'].forEach((v) {
        _fundHouseAllocation?.add(FundHouseAllocation.fromJson(v));
      });
    }
    if (json['micro_asset_stratagic'] != null) {
      _microAssetStratagic = [];
      json['micro_asset_stratagic'].forEach((v) {
        _microAssetStratagic?.add(MicroAssetStratagic.fromJson(v));
      });
    }
    if (json['micro_asset_tactical'] != null) {
      _microAssetTactical = [];
      json['micro_asset_tactical'].forEach((v) {
        _microAssetTactical?.add(MicroAssetTactical.fromJson(v));
      });
    }
    if (json['macro_asset_stratagic'] != null) {
      _macroAssetStratagic = [];
      json['macro_asset_stratagic'].forEach((v) {
        _macroAssetStratagic?.add(MacroAssetStratagic.fromJson(v));
      });
    }
    if (json['macro_asset_tactical'] != null) {
      _macroAssetTactical = [];
      json['macro_asset_tactical'].forEach((v) {
        _macroAssetTactical?.add(MacroAssetTactical.fromJson(v));
      });
    }
  }
  List<Networth>? _networth;
  List<ApplicantDetails>? _applicantDetails;
  List<SchemeAllocation>? _schemeAllocation;
  List<FundHouseAllocation>? _fundHouseAllocation;
  List<MicroAssetStratagic>? _microAssetStratagic;
  List<MicroAssetTactical>? _microAssetTactical;
  List<MacroAssetStratagic>? _macroAssetStratagic;
  List<MacroAssetTactical>? _macroAssetTactical;
Result copyWith({  List<Networth>? networth,
  List<ApplicantDetails>? applicantDetails,
  List<SchemeAllocation>? schemeAllocation,
  List<FundHouseAllocation>? fundHouseAllocation,
  List<MicroAssetStratagic>? microAssetStratagic,
  List<MicroAssetTactical>? microAssetTactical,
  List<MacroAssetStratagic>? macroAssetStratagic,
  List<MacroAssetTactical>? macroAssetTactical,
}) => Result(  networth: networth ?? _networth,
  applicantDetails: applicantDetails ?? _applicantDetails,
  schemeAllocation: schemeAllocation ?? _schemeAllocation,
  fundHouseAllocation: fundHouseAllocation ?? _fundHouseAllocation,
  microAssetStratagic: microAssetStratagic ?? _microAssetStratagic,
  microAssetTactical: microAssetTactical ?? _microAssetTactical,
  macroAssetStratagic: macroAssetStratagic ?? _macroAssetStratagic,
  macroAssetTactical: macroAssetTactical ?? _macroAssetTactical,
);
  List<Networth>? get networth => _networth;
  List<ApplicantDetails>? get applicantDetails => _applicantDetails;
  List<SchemeAllocation>? get schemeAllocation => _schemeAllocation;
  List<FundHouseAllocation>? get fundHouseAllocation => _fundHouseAllocation;
  List<MicroAssetStratagic>? get microAssetStratagic => _microAssetStratagic;
  List<MicroAssetTactical>? get microAssetTactical => _microAssetTactical;
  List<MacroAssetStratagic>? get macroAssetStratagic => _macroAssetStratagic;
  List<MacroAssetTactical>? get macroAssetTactical => _macroAssetTactical;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_networth != null) {
      map['networth'] = _networth?.map((v) => v.toJson()).toList();
    }
    if (_applicantDetails != null) {
      map['applicant_details'] = _applicantDetails?.map((v) => v.toJson()).toList();
    }
    if (_schemeAllocation != null) {
      map['scheme_allocation'] = _schemeAllocation?.map((v) => v.toJson()).toList();
    }
    if (_fundHouseAllocation != null) {
      map['fund_house_allocation'] = _fundHouseAllocation?.map((v) => v.toJson()).toList();
    }
    if (_microAssetStratagic != null) {
      map['micro_asset_stratagic'] = _microAssetStratagic?.map((v) => v.toJson()).toList();
    }
    if (_microAssetTactical != null) {
      map['micro_asset_tactical'] = _microAssetTactical?.map((v) => v.toJson()).toList();
    }
    if (_macroAssetStratagic != null) {
      map['macro_asset_stratagic'] = _macroAssetStratagic?.map((v) => v.toJson()).toList();
    }
    if (_macroAssetTactical != null) {
      map['macro_asset_tactical'] = _macroAssetTactical?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// asset : "Volatile"
/// amount : 4076
/// actual : 65
/// policy : 48
/// variation : -17

MacroAssetTactical macroAssetTacticalFromJson(String str) => MacroAssetTactical.fromJson(json.decode(str));
String macroAssetTacticalToJson(MacroAssetTactical data) => json.encode(data.toJson());
class MacroAssetTactical {
  MacroAssetTactical({
      String? asset, 
      num? amount, 
      num? actual, 
      num? policy, 
      num? variation,}){
    _asset = asset;
    _amount = amount;
    _actual = actual;
    _policy = policy;
    _variation = variation;
}

  MacroAssetTactical.fromJson(dynamic json) {
    _asset = json['asset'];
    _amount = json['amount'];
    _actual = json['actual'];
    _policy = json['policy'];
    _variation = json['variation'];
  }
  String? _asset;
  num? _amount;
  num? _actual;
  num? _policy;
  num? _variation;
MacroAssetTactical copyWith({  String? asset,
  num? amount,
  num? actual,
  num? policy,
  num? variation,
}) => MacroAssetTactical(  asset: asset ?? _asset,
  amount: amount ?? _amount,
  actual: actual ?? _actual,
  policy: policy ?? _policy,
  variation: variation ?? _variation,
);
  String? get asset => _asset;
  num? get amount => _amount;
  num? get actual => _actual;
  num? get policy => _policy;
  num? get variation => _variation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['asset'] = _asset;
    map['amount'] = _amount;
    map['actual'] = _actual;
    map['policy'] = _policy;
    map['variation'] = _variation;
    return map;
  }

}

/// asset : "Volatile"
/// amount : 4076
/// actual : 65
/// policy : 50
/// variation : -15

MacroAssetStratagic macroAssetStratagicFromJson(String str) => MacroAssetStratagic.fromJson(json.decode(str));
String macroAssetStratagicToJson(MacroAssetStratagic data) => json.encode(data.toJson());
class MacroAssetStratagic {
  MacroAssetStratagic({
      String? asset, 
      num? amount, 
      num? actual, 
      num? policy, 
      num? variation,}){
    _asset = asset;
    _amount = amount;
    _actual = actual;
    _policy = policy;
    _variation = variation;
}

  MacroAssetStratagic.fromJson(dynamic json) {
    _asset = json['asset'];
    _amount = json['amount'];
    _actual = json['actual'];
    _policy = json['policy'];
    _variation = json['variation'];
  }
  String? _asset;
  num? _amount;
  num? _actual;
  num? _policy;
  num? _variation;
MacroAssetStratagic copyWith({  String? asset,
  num? amount,
  num? actual,
  num? policy,
  num? variation,
}) => MacroAssetStratagic(  asset: asset ?? _asset,
  amount: amount ?? _amount,
  actual: actual ?? _actual,
  policy: policy ?? _policy,
  variation: variation ?? _variation,
);
  String? get asset => _asset;
  num? get amount => _amount;
  num? get actual => _actual;
  num? get policy => _policy;
  num? get variation => _variation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['asset'] = _asset;
    map['amount'] = _amount;
    map['actual'] = _actual;
    map['policy'] = _policy;
    map['variation'] = _variation;
    return map;
  }

}

/// asset : "Debt"
/// amount : 0
/// actual : 0
/// policy : 52.5
/// variation : 52.5

MicroAssetTactical microAssetTacticalFromJson(String str) => MicroAssetTactical.fromJson(json.decode(str));
String microAssetTacticalToJson(MicroAssetTactical data) => json.encode(data.toJson());
class MicroAssetTactical {
  MicroAssetTactical({
      String? asset, 
      num? amount, 
      num? actual, 
      num? policy, 
      num? variation,}){
    _asset = asset;
    _amount = amount;
    _actual = actual;
    _policy = policy;
    _variation = variation;
}

  MicroAssetTactical.fromJson(dynamic json) {
    _asset = json['asset'];
    _amount = json['amount'];
    _actual = json['actual'];
    _policy = json['policy'];
    _variation = json['variation'];
  }
  String? _asset;
  num? _amount;
  num? _actual;
  num? _policy;
  num? _variation;
MicroAssetTactical copyWith({  String? asset,
  num? amount,
  num? actual,
  num? policy,
  num? variation,
}) => MicroAssetTactical(  asset: asset ?? _asset,
  amount: amount ?? _amount,
  actual: actual ?? _actual,
  policy: policy ?? _policy,
  variation: variation ?? _variation,
);
  String? get asset => _asset;
  num? get amount => _amount;
  num? get actual => _actual;
  num? get policy => _policy;
  num? get variation => _variation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['asset'] = _asset;
    map['amount'] = _amount;
    map['actual'] = _actual;
    map['policy'] = _policy;
    map['variation'] = _variation;
    return map;
  }

}

/// asset : "Debt"
/// amount : 0
/// actual : 0
/// policy : 50
/// variation : 50

MicroAssetStratagic microAssetStratagicFromJson(String str) => MicroAssetStratagic.fromJson(json.decode(str));
String microAssetStratagicToJson(MicroAssetStratagic data) => json.encode(data.toJson());
class MicroAssetStratagic {
  MicroAssetStratagic({
      String? asset, 
      num? amount, 
      num? actual, 
      num? policy, 
      num? variation,}){
    _asset = asset;
    _amount = amount;
    _actual = actual;
    _policy = policy;
    _variation = variation;
}

  MicroAssetStratagic.fromJson(dynamic json) {
    _asset = json['asset'];
    _amount = json['amount'];
    _actual = json['actual'];
    _policy = json['policy'];
    _variation = json['variation'];
  }
  String? _asset;
  num? _amount;
  num? _actual;
  num? _policy;
  num? _variation;
MicroAssetStratagic copyWith({  String? asset,
  num? amount,
  num? actual,
  num? policy,
  num? variation,
}) => MicroAssetStratagic(  asset: asset ?? _asset,
  amount: amount ?? _amount,
  actual: actual ?? _actual,
  policy: policy ?? _policy,
  variation: variation ?? _variation,
);
  String? get asset => _asset;
  num? get amount => _amount;
  num? get actual => _actual;
  num? get policy => _policy;
  num? get variation => _variation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['asset'] = _asset;
    map['amount'] = _amount;
    map['actual'] = _actual;
    map['policy'] = _policy;
    map['variation'] = _variation;
    return map;
  }

}

/// fund_house : "ICICI Prudential Mutual Fund"
/// current_value : 6270
/// allocation : 100

FundHouseAllocation fundHouseAllocationFromJson(String str) => FundHouseAllocation.fromJson(json.decode(str));
String fundHouseAllocationToJson(FundHouseAllocation data) => json.encode(data.toJson());
class FundHouseAllocation {
  FundHouseAllocation({
      String? fundHouse, 
      num? currentValue, 
      num? allocation,}){
    _fundHouse = fundHouse;
    _currentValue = currentValue;
    _allocation = allocation;
}

  FundHouseAllocation.fromJson(dynamic json) {
    _fundHouse = json['fund_house'];
    _currentValue = json['current_value'];
    _allocation = json['allocation'];
  }
  String? _fundHouse;
  num? _currentValue;
  num? _allocation;
FundHouseAllocation copyWith({  String? fundHouse,
  num? currentValue,
  num? allocation,
}) => FundHouseAllocation(  fundHouse: fundHouse ?? _fundHouse,
  currentValue: currentValue ?? _currentValue,
  allocation: allocation ?? _allocation,
);
  String? get fundHouse => _fundHouse;
  num? get currentValue => _currentValue;
  num? get allocation => _allocation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fund_house'] = _fundHouse;
    map['current_value'] = _currentValue;
    map['allocation'] = _allocation;
    return map;
  }

}

/// scheme_name : "ICICI Pru Regular Savings Fund (G)"
/// current_value : 6270
/// category : "Hybrid: Conservative"
/// allocation : 100

SchemeAllocation schemeAllocationFromJson(String str) => SchemeAllocation.fromJson(json.decode(str));
String schemeAllocationToJson(SchemeAllocation data) => json.encode(data.toJson());
class SchemeAllocation {
  SchemeAllocation({
      String? schemeName, 
      num? currentValue, 
      String? category, 
      num? allocation,}){
    _schemeName = schemeName;
    _currentValue = currentValue;
    _category = category;
    _allocation = allocation;
}

  SchemeAllocation.fromJson(dynamic json) {
    _schemeName = json['scheme_name'];
    _currentValue = json['current_value'];
    _category = json['category'];
    _allocation = json['allocation'];
  }
  String? _schemeName;
  num? _currentValue;
  String? _category;
  num? _allocation;
SchemeAllocation copyWith({  String? schemeName,
  num? currentValue,
  String? category,
  num? allocation,
}) => SchemeAllocation(  schemeName: schemeName ?? _schemeName,
  currentValue: currentValue ?? _currentValue,
  category: category ?? _category,
  allocation: allocation ?? _allocation,
);
  String? get schemeName => _schemeName;
  num? get currentValue => _currentValue;
  String? get category => _category;
  num? get allocation => _allocation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['scheme_name'] = _schemeName;
    map['current_value'] = _currentValue;
    map['category'] = _category;
    map['allocation'] = _allocation;
    return map;
  }

}

/// applicant : "Shahista Shakeel Ahmed Sayed"
/// amount_invested : 6000
/// current_amount : 6286
/// gain : 286
/// dividend : 0
/// absolute_return : 4.77
/// CAGR : 8.92
/// weighted_days : 0

ApplicantDetails applicantDetailsFromJson(String str) => ApplicantDetails.fromJson(json.decode(str));
String applicantDetailsToJson(ApplicantDetails data) => json.encode(data.toJson());
class ApplicantDetails {
  ApplicantDetails({
      String? applicant, 
      num? amountInvested, 
      num? currentAmount, 
      num? gain, 
      num? dividend, 
      num? absoluteReturn, 
      num? cagr, 
      num? weightedDays,}){
    _applicant = applicant;
    _amountInvested = amountInvested;
    _currentAmount = currentAmount;
    _gain = gain;
    _dividend = dividend;
    _absoluteReturn = absoluteReturn;
    _cagr = cagr;
    _weightedDays = weightedDays;
}

  ApplicantDetails.fromJson(dynamic json) {
    _applicant = json['applicant'];
    _amountInvested = json['amount_invested'];
    _currentAmount = json['current_amount'];
    _gain = json['gain'];
    _dividend = json['dividend'];
    _absoluteReturn = json['absolute_return'];
    _cagr = json['CAGR'];
    _weightedDays = json['weighted_days'];
  }
  String? _applicant;
  num? _amountInvested;
  num? _currentAmount;
  num? _gain;
  num? _dividend;
  num? _absoluteReturn;
  num? _cagr;
  num? _weightedDays;
ApplicantDetails copyWith({  String? applicant,
  num? amountInvested,
  num? currentAmount,
  num? gain,
  num? dividend,
  num? absoluteReturn,
  num? cagr,
  num? weightedDays,
}) => ApplicantDetails(  applicant: applicant ?? _applicant,
  amountInvested: amountInvested ?? _amountInvested,
  currentAmount: currentAmount ?? _currentAmount,
  gain: gain ?? _gain,
  dividend: dividend ?? _dividend,
  absoluteReturn: absoluteReturn ?? _absoluteReturn,
  cagr: cagr ?? _cagr,
  weightedDays: weightedDays ?? _weightedDays,
);
  String? get applicant => _applicant;
  num? get amountInvested => _amountInvested;
  num? get currentAmount => _currentAmount;
  num? get gain => _gain;
  num? get dividend => _dividend;
  num? get absoluteReturn => _absoluteReturn;
  num? get cagr => _cagr;
  num? get weightedDays => _weightedDays;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['applicant'] = _applicant;
    map['amount_invested'] = _amountInvested;
    map['current_amount'] = _currentAmount;
    map['gain'] = _gain;
    map['dividend'] = _dividend;
    map['absolute_return'] = _absoluteReturn;
    map['CAGR'] = _cagr;
    map['weighted_days'] = _weightedDays;
    return map;
  }

}

/// asset : "Hybrid"
/// objectives : [{"objective":"Hybrid: Conservative","applicants":[{"applicant":"SHAHISTA SHAKEEL AHMED SAYED","amount":6270},{"applicant":"Amount Total","amount":6270},{"applicant":"Percentage","amount":100}],"amount":6270,"percentage":100},{"objective":"Sub Total","applicants":[{"applicant":"SHAHISTA SHAKEEL AHMED SAYED","amount":6270},{"applicant":"Amount Total","amount":6270},{"applicant":"Percentage","amount":100}],"amount":6270,"percentage":100},{"objective":"Total","applicants":[{"applicant":"SHAHISTA SHAKEEL AHMED SAYED","amount":6270},{"applicant":"Amount Total","amount":6270},{"applicant":"Percentage","amount":100}],"amount":6270,"percentage":100}]

Networth networthFromJson(String str) => Networth.fromJson(json.decode(str));
String networthToJson(Networth data) => json.encode(data.toJson());
class Networth {
  Networth({
      String? asset, 
      List<Objectives>? objectives,}){
    _asset = asset;
    _objectives = objectives;
}

  Networth.fromJson(dynamic json) {
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
Networth copyWith({  String? asset,
  List<Objectives>? objectives,
}) => Networth(  asset: asset ?? _asset,
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

/// objective : "Hybrid: Conservative"
/// applicants : [{"applicant":"SHAHISTA SHAKEEL AHMED SAYED","amount":6270},{"applicant":"Amount Total","amount":6270},{"applicant":"Percentage","amount":100}]
/// amount : 6270
/// percentage : 100

Objectives objectivesFromJson(String str) => Objectives.fromJson(json.decode(str));
String objectivesToJson(Objectives data) => json.encode(data.toJson());
class Objectives {
  Objectives({
      String? objective, 
      List<Applicants>? applicants, 
      num? amount, 
      num? percentage,}){
    _objective = objective;
    _applicants = applicants;
    _amount = amount;
    _percentage = percentage;
}

  Objectives.fromJson(dynamic json) {
    _objective = json['objective'];
    if (json['applicants'] != null) {
      _applicants = [];
      json['applicants'].forEach((v) {
        _applicants?.add(Applicants.fromJson(v));
      });
    }
    _amount = json['amount'];
    _percentage = json['percentage'];
  }
  String? _objective;
  List<Applicants>? _applicants;
  num? _amount;
  num? _percentage;
Objectives copyWith({  String? objective,
  List<Applicants>? applicants,
  num? amount,
  num? percentage,
}) => Objectives(  objective: objective ?? _objective,
  applicants: applicants ?? _applicants,
  amount: amount ?? _amount,
  percentage: percentage ?? _percentage,
);
  String? get objective => _objective;
  List<Applicants>? get applicants => _applicants;
  num? get amount => _amount;
  num? get percentage => _percentage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['objective'] = _objective;
    if (_applicants != null) {
      map['applicants'] = _applicants?.map((v) => v.toJson()).toList();
    }
    map['amount'] = _amount;
    map['percentage'] = _percentage;
    return map;
  }

}

/// applicant : "SHAHISTA SHAKEEL AHMED SAYED"
/// amount : 6270

Applicants applicantsFromJson(String str) => Applicants.fromJson(json.decode(str));
String applicantsToJson(Applicants data) => json.encode(data.toJson());
class Applicants {
  Applicants({
      String? applicant, 
      num? amount,}){
    _applicant = applicant;
    _amount = amount;
}

  Applicants.fromJson(dynamic json) {
    _applicant = json['applicant'];
    _amount = json['amount'];
  }
  String? _applicant;
  num? _amount;
Applicants copyWith({  String? applicant,
  num? amount,
}) => Applicants(  applicant: applicant ?? _applicant,
  amount: amount ?? _amount,
);
  String? get applicant => _applicant;
  num? get amount => _amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['applicant'] = _applicant;
    map['amount'] = _amount;
    return map;
  }

}