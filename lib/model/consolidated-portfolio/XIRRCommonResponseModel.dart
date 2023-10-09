import 'dart:convert';
/// performance : [{"Asset":"Debt","InvestedAmount":5551746,"CurrentValue":9849209,"Gain":4297463,"XIRR":7.2486114501953},{"Asset":"Equity","InvestedAmount":53259564,"CurrentValue":88605280,"Gain":35345716,"XIRR":14.424751281738},{"Asset":"Gold","InvestedAmount":45000,"CurrentValue":51109,"Gain":6109,"XIRR":4.5539093017578},{"Asset":"Hybrid","InvestedAmount":5949262,"CurrentValue":6493928,"Gain":544666,"XIRR":8.7664031982422},{"Asset":"Overall","InvestedAmount":64805572,"CurrentValue":104999526,"Gain":40193954,"XIRR":12.897148132324}]
/// xirr : [{"Asset":"Debt","InvestedAmount":9409760,"CurrentValue":9849209,"Gain":439449,"XIRR":7.8783416748047},{"Asset":"Equity","InvestedAmount":74411153,"CurrentValue":88605280,"Gain":14194127,"XIRR":48.398543167114},{"Asset":"Gold","InvestedAmount":53024,"CurrentValue":51109,"Gain":-1915,"XIRR":-7.0370101928711},{"Asset":"Hybrid","InvestedAmount":6248116,"CurrentValue":6493928,"Gain":245812,"XIRR":15.924781799316},{"Asset":"Overall","InvestedAmount":90122053,"CurrentValue":104999526,"Gain":14877473,"XIRR":40.839238357544}]
/// xirr_previous : [{"Asset":"Debt","InvestedAmount":10284666,"CurrentValue":10873865,"Gain":589199,"XIRR":5.7482147216797},{"Asset":"Equity","InvestedAmount":57814911,"CurrentValue":57261153,"Gain":-553758,"XIRR":-1.0323257446289},{"Asset":"Gold","InvestedAmount":45985,"CurrentValue":53024,"Gain":7039,"XIRR":15.35230255127},{"Asset":"Hybrid","InvestedAmount":748837,"CurrentValue":748116,"Gain":-721,"XIRR":-0.096641540527344},{"Asset":"Overall","InvestedAmount":68894399,"CurrentValue":68936158,"Gain":41759,"XIRR":0.064620971679688}]
/// success : 1
/// message : ""

XirrCommonResponseModel xirrCommonResponseModelFromJson(String str) => XirrCommonResponseModel.fromJson(json.decode(str));
String xirrCommonResponseModelToJson(XirrCommonResponseModel data) => json.encode(data.toJson());
class XirrCommonResponseModel {
  XirrCommonResponseModel({
      List<Xirr>? performance,
      List<Xirr>? xirr, 
      List<Xirr>? xirrPrevious,
      num? success, 
      String? message,}){
    _performance = performance;
    _xirr = xirr;
    _xirrPrevious = xirrPrevious;
    _success = success;
    _message = message;
}

  XirrCommonResponseModel.fromJson(dynamic json) {
    if (json['performance'] != null) {
      _performance = [];
      json['performance'].forEach((v) {
        _performance?.add(Xirr.fromJson(v));
      });
    }
    if (json['xirr'] != null) {
      _xirr = [];
      json['xirr'].forEach((v) {
        _xirr?.add(Xirr.fromJson(v));
      });
    }
    if (json['xirr_previous'] != null) {
      _xirrPrevious = [];
      json['xirr_previous'].forEach((v) {
        _xirrPrevious?.add(Xirr.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
  }
  List<Xirr>? _performance;
  List<Xirr>? _xirr;
  List<Xirr>? _xirrPrevious;
  num? _success;
  String? _message;
XirrCommonResponseModel copyWith({  List<Xirr>? performance,
  List<Xirr>? xirr,
  List<Xirr>? xirrPrevious,
  num? success,
  String? message,
}) => XirrCommonResponseModel(  performance: performance ?? _performance,
  xirr: xirr ?? _xirr,
  xirrPrevious: xirrPrevious ?? _xirrPrevious,
  success: success ?? _success,
  message: message ?? _message,
);
  List<Xirr>? get performance => _performance;
  List<Xirr>? get xirr => _xirr;
  List<Xirr>? get xirrPrevious => _xirrPrevious;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_performance != null) {
      map['performance'] = _performance?.map((v) => v.toJson()).toList();
    }
    if (_xirr != null) {
      map['xirr'] = _xirr?.map((v) => v.toJson()).toList();
    }
    if (_xirrPrevious != null) {
      map['xirr_previous'] = _xirrPrevious?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// Asset : "Debt"
/// InvestedAmount : 9409760
/// CurrentValue : 9849209
/// Gain : 439449
/// XIRR : 7.8783416748047

Xirr xirrFromJson(String str) => Xirr.fromJson(json.decode(str));
String xirrToJson(Xirr data) => json.encode(data.toJson());
class Xirr {
  Xirr({
      String? asset, 
      num? investedAmount, 
      num? currentValue, 
      num? gain, 
      num? xirr,}){
    _asset = asset;
    _investedAmount = investedAmount;
    _currentValue = currentValue;
    _gain = gain;
    _xirr = xirr;
}

  Xirr.fromJson(dynamic json) {
    _asset = json['Asset'];
    _investedAmount = json['InvestedAmount'];
    _currentValue = json['CurrentValue'];
    _gain = json['Gain'];
    _xirr = json['XIRR'];
  }
  String? _asset;
  num? _investedAmount;
  num? _currentValue;
  num? _gain;
  num? _xirr;
Xirr copyWith({  String? asset,
  num? investedAmount,
  num? currentValue,
  num? gain,
  num? xirr,
}) => Xirr(  asset: asset ?? _asset,
  investedAmount: investedAmount ?? _investedAmount,
  currentValue: currentValue ?? _currentValue,
  gain: gain ?? _gain,
  xirr: xirr ?? _xirr,
);
  String? get asset => _asset;
  num? get investedAmount => _investedAmount;
  num? get currentValue => _currentValue;
  num? get gain => _gain;
  num? get xirr => _xirr;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Asset'] = _asset;
    map['InvestedAmount'] = _investedAmount;
    map['CurrentValue'] = _currentValue;
    map['Gain'] = _gain;
    map['XIRR'] = _xirr;
    return map;
  }

}

