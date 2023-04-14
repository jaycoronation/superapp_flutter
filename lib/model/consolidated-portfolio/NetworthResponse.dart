/// result : {"networth":[{"asset":"Debt","objectives":[{"objective":"Debt: Corporate Bond","amount":3607472,"percentage":21.17,"applicants":[{"applicant":"A V RAMESH","amount":3105618},{"applicant":"APPALLA SUNITA MALLIKA","amount":501854},{"applicant":"Amount Total","amount":3607472},{"applicant":"Percentage","amount":21.17}]}]}],"applicant_details":[{"applicant":"A V RAMESH","amount_invested":10036960,"current_amount":13696716,"gain":3659757,"dividend":0,"absolute_return":36.46,"CAGR":10.64,"weighted_days":0}],"micro_asset_stratagic":[{"asset":"Debt","amount":7708500,"actual":45,"policy":12,"variation":-33}],"micro_asset_tactical":[{"asset":"Debt","amount":7708500,"actual":45,"policy":16.400000000000006,"variation":-28.599999999999994}],"macro_asset_stratagic":[{"asset":"Volatile","amount":8133822,"actual":48,"policy":16,"variation":-32}],"macro_asset_tactical":[{"asset":"Volatile","amount":8133822,"actual":48,"policy":15,"variation":-33}]}
/// success : 1
/// message : ""

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

/// networth : [{"asset":"Debt","objectives":[{"objective":"Debt: Corporate Bond","amount":3607472,"percentage":21.17,"applicants":[{"applicant":"A V RAMESH","amount":3105618},{"applicant":"APPALLA SUNITA MALLIKA","amount":501854},{"applicant":"Amount Total","amount":3607472},{"applicant":"Percentage","amount":21.17}]}]}]
/// applicant_details : [{"applicant":"A V RAMESH","amount_invested":10036960,"current_amount":13696716,"gain":3659757,"dividend":0,"absolute_return":36.46,"CAGR":10.64,"weighted_days":0}]
/// micro_asset_stratagic : [{"asset":"Debt","amount":7708500,"actual":45,"policy":12,"variation":-33}]
/// micro_asset_tactical : [{"asset":"Debt","amount":7708500,"actual":45,"policy":16.400000000000006,"variation":-28.599999999999994}]
/// macro_asset_stratagic : [{"asset":"Volatile","amount":8133822,"actual":48,"policy":16,"variation":-32}]
/// macro_asset_tactical : [{"asset":"Volatile","amount":8133822,"actual":48,"policy":15,"variation":-33}]

class Result {
  Result({
      List<Networth>? networth, 
      List<ApplicantDetails>? applicantDetails, 
      List<MicroAssetStratagic>? microAssetStratagic, 
      List<MicroAssetTactical>? microAssetTactical, 
      List<MacroAssetStratagic>? macroAssetStratagic, 
      List<MacroAssetTactical>? macroAssetTactical,}){
    _networth = networth;
    _applicantDetails = applicantDetails;
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
  List<MicroAssetStratagic>? _microAssetStratagic;
  List<MicroAssetTactical>? _microAssetTactical;
  List<MacroAssetStratagic>? _macroAssetStratagic;
  List<MacroAssetTactical>? _macroAssetTactical;
Result copyWith({  List<Networth>? networth,
  List<ApplicantDetails>? applicantDetails,
  List<MicroAssetStratagic>? microAssetStratagic,
  List<MicroAssetTactical>? microAssetTactical,
  List<MacroAssetStratagic>? macroAssetStratagic,
  List<MacroAssetTactical>? macroAssetTactical,
}) => Result(  networth: networth ?? _networth,
  applicantDetails: applicantDetails ?? _applicantDetails,
  microAssetStratagic: microAssetStratagic ?? _microAssetStratagic,
  microAssetTactical: microAssetTactical ?? _microAssetTactical,
  macroAssetStratagic: macroAssetStratagic ?? _macroAssetStratagic,
  macroAssetTactical: macroAssetTactical ?? _macroAssetTactical,
);
  List<Networth>? get networth => _networth;
  List<ApplicantDetails>? get applicantDetails => _applicantDetails;
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
/// amount : 8133822
/// actual : 48
/// policy : 15
/// variation : -33

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
/// amount : 8133822
/// actual : 48
/// policy : 16
/// variation : -32

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
/// amount : 7708500
/// actual : 45
/// policy : 16.400000000000006
/// variation : -28.599999999999994

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
/// amount : 7708500
/// actual : 45
/// policy : 12
/// variation : -33

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

/// applicant : "A V RAMESH"
/// amount_invested : 10036960
/// current_amount : 13696716
/// gain : 3659757
/// dividend : 0
/// absolute_return : 36.46
/// CAGR : 10.64
/// weighted_days : 0

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

/// asset : "Debt"
/// objectives : [{"objective":"Debt: Corporate Bond","amount":3607472,"percentage":21.17,"applicants":[{"applicant":"A V RAMESH","amount":3105618},{"applicant":"APPALLA SUNITA MALLIKA","amount":501854},{"applicant":"Amount Total","amount":3607472},{"applicant":"Percentage","amount":21.17}]}]

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

/// objective : "Debt: Corporate Bond"
/// amount : 3607472
/// percentage : 21.17
/// applicants : [{"applicant":"A V RAMESH","amount":3105618},{"applicant":"APPALLA SUNITA MALLIKA","amount":501854},{"applicant":"Amount Total","amount":3607472},{"applicant":"Percentage","amount":21.17}]

class Objectives {
  Objectives({
      String? objective, 
      num? amount, 
      num? percentage, 
      List<Applicants>? applicants,}){
    _objective = objective;
    _amount = amount;
    _percentage = percentage;
    _applicants = applicants;
}

  Objectives.fromJson(dynamic json) {
    _objective = json['objective'];
    _amount = json['amount'];
    _percentage = json['percentage'];
    if (json['applicants'] != null) {
      _applicants = [];
      json['applicants'].forEach((v) {
        _applicants?.add(Applicants.fromJson(v));
      });
    }
  }
  String? _objective;
  num? _amount;
  num? _percentage;
  List<Applicants>? _applicants;
Objectives copyWith({  String? objective,
  num? amount,
  num? percentage,
  List<Applicants>? applicants,
}) => Objectives(  objective: objective ?? _objective,
  amount: amount ?? _amount,
  percentage: percentage ?? _percentage,
  applicants: applicants ?? _applicants,
);
  String? get objective => _objective;
  num? get amount => _amount;
  num? get percentage => _percentage;
  List<Applicants>? get applicants => _applicants;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['objective'] = _objective;
    map['amount'] = _amount;
    map['percentage'] = _percentage;
    if (_applicants != null) {
      map['applicants'] = _applicants?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// applicant : "A V RAMESH"
/// amount : 3105618

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