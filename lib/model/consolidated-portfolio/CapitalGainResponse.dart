/// sale_values : [{"Applicant":"A V RAMESH","value":[{"category_key":"Equity","capital_gain":-147108.04000000000814907252788543701171875,"STCL_total":-1907.319999999999936335370875895023345947265625,"STCG_total":0,"LTCL_total":-145200.72000000000116415321826934814453125,"LTCG_total":0}],"SchemeTotal":{"CapitalGainTotal":-146717.77999999999883584678173065185546875,"LTCG_total":0,"STCL_total":-1907.319999999999936335370875895023345947265625,"STCG_total":390.259999999999990905052982270717620849609375,"LTCL_total":-145200.72000000000116415321826934814453125}}]
/// success : 1
/// message : "Result Found"
/// grand_total : {"CapitalGain_GrandTotal":-284710.079999999958090484142303466796875,"LTCG_GrandTotal":0,"STCL_GrandTotal":-14891.769999999998617568053305149078369140625,"STCG_GrandTotal":8739.059999999999490682967007160186767578125,"LTCL_GrandTotal":-278557.369999999995343387126922607421875}

class CapitalGainResponse {
  CapitalGainResponse({
      List<SaleValues>? saleValues, 
      num? success, 
      String? message, 
      GrandTotal? grandTotal,}){
    _saleValues = saleValues;
    _success = success;
    _message = message;
    _grandTotal = grandTotal;
}

  CapitalGainResponse.fromJson(dynamic json) {
    if (json['sale_values'] != null) {
      _saleValues = [];
      json['sale_values'].forEach((v) {
        _saleValues?.add(SaleValues.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
    _grandTotal = json['grand_total'] != null ? GrandTotal.fromJson(json['grand_total']) : null;
  }
  List<SaleValues>? _saleValues;
  num? _success;
  String? _message;
  GrandTotal? _grandTotal;
CapitalGainResponse copyWith({  List<SaleValues>? saleValues,
  num? success,
  String? message,
  GrandTotal? grandTotal,
}) => CapitalGainResponse(  saleValues: saleValues ?? _saleValues,
  success: success ?? _success,
  message: message ?? _message,
  grandTotal: grandTotal ?? _grandTotal,
);
  List<SaleValues>? get saleValues => _saleValues;
  num? get success => _success;
  String? get message => _message;
  GrandTotal? get grandTotal => _grandTotal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_saleValues != null) {
      map['sale_values'] = _saleValues?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    map['message'] = _message;
    if (_grandTotal != null) {
      map['grand_total'] = _grandTotal?.toJson();
    }
    return map;
  }

}

/// CapitalGain_GrandTotal : -284710.079999999958090484142303466796875
/// LTCG_GrandTotal : 0
/// STCL_GrandTotal : -14891.769999999998617568053305149078369140625
/// STCG_GrandTotal : 8739.059999999999490682967007160186767578125
/// LTCL_GrandTotal : -278557.369999999995343387126922607421875

class GrandTotal {
  GrandTotal({
      num? capitalGainGrandTotal, 
      num? lTCGGrandTotal, 
      num? sTCLGrandTotal, 
      num? sTCGGrandTotal, 
      num? lTCLGrandTotal,}){
    _capitalGainGrandTotal = capitalGainGrandTotal;
    _lTCGGrandTotal = lTCGGrandTotal;
    _sTCLGrandTotal = sTCLGrandTotal;
    _sTCGGrandTotal = sTCGGrandTotal;
    _lTCLGrandTotal = lTCLGrandTotal;
}

  GrandTotal.fromJson(dynamic json) {
    _capitalGainGrandTotal = json['CapitalGain_GrandTotal'];
    _lTCGGrandTotal = json['LTCG_GrandTotal'];
    _sTCLGrandTotal = json['STCL_GrandTotal'];
    _sTCGGrandTotal = json['STCG_GrandTotal'];
    _lTCLGrandTotal = json['LTCL_GrandTotal'];
  }
  num? _capitalGainGrandTotal;
  num? _lTCGGrandTotal;
  num? _sTCLGrandTotal;
  num? _sTCGGrandTotal;
  num? _lTCLGrandTotal;
GrandTotal copyWith({  num? capitalGainGrandTotal,
  num? lTCGGrandTotal,
  num? sTCLGrandTotal,
  num? sTCGGrandTotal,
  num? lTCLGrandTotal,
}) => GrandTotal(  capitalGainGrandTotal: capitalGainGrandTotal ?? _capitalGainGrandTotal,
  lTCGGrandTotal: lTCGGrandTotal ?? _lTCGGrandTotal,
  sTCLGrandTotal: sTCLGrandTotal ?? _sTCLGrandTotal,
  sTCGGrandTotal: sTCGGrandTotal ?? _sTCGGrandTotal,
  lTCLGrandTotal: lTCLGrandTotal ?? _lTCLGrandTotal,
);
  num? get capitalGainGrandTotal => _capitalGainGrandTotal;
  num? get lTCGGrandTotal => _lTCGGrandTotal;
  num? get sTCLGrandTotal => _sTCLGrandTotal;
  num? get sTCGGrandTotal => _sTCGGrandTotal;
  num? get lTCLGrandTotal => _lTCLGrandTotal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CapitalGain_GrandTotal'] = _capitalGainGrandTotal;
    map['LTCG_GrandTotal'] = _lTCGGrandTotal;
    map['STCL_GrandTotal'] = _sTCLGrandTotal;
    map['STCG_GrandTotal'] = _sTCGGrandTotal;
    map['LTCL_GrandTotal'] = _lTCLGrandTotal;
    return map;
  }

}

/// Applicant : "A V RAMESH"
/// value : [{"category_key":"Equity","capital_gain":-147108.04000000000814907252788543701171875,"STCL_total":-1907.319999999999936335370875895023345947265625,"STCG_total":0,"LTCL_total":-145200.72000000000116415321826934814453125,"LTCG_total":0}]
/// SchemeTotal : {"CapitalGainTotal":-146717.77999999999883584678173065185546875,"LTCG_total":0,"STCL_total":-1907.319999999999936335370875895023345947265625,"STCG_total":390.259999999999990905052982270717620849609375,"LTCL_total":-145200.72000000000116415321826934814453125}

class SaleValues {
  SaleValues({
      String? applicant, 
      List<Value>? value, 
      SchemeTotal? schemeTotal,}){
    _applicant = applicant;
    _value = value;
    _schemeTotal = schemeTotal;
}

  SaleValues.fromJson(dynamic json) {
    _applicant = json['Applicant'];
    if (json['value'] != null) {
      _value = [];
      json['value'].forEach((v) {
        _value?.add(Value.fromJson(v));
      });
    }
    _schemeTotal = json['SchemeTotal'] != null ? SchemeTotal.fromJson(json['SchemeTotal']) : null;
  }
  String? _applicant;
  List<Value>? _value;
  SchemeTotal? _schemeTotal;
SaleValues copyWith({  String? applicant,
  List<Value>? value,
  SchemeTotal? schemeTotal,
}) => SaleValues(  applicant: applicant ?? _applicant,
  value: value ?? _value,
  schemeTotal: schemeTotal ?? _schemeTotal,
);
  String? get applicant => _applicant;
  List<Value>? get value => _value;
  SchemeTotal? get schemeTotal => _schemeTotal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Applicant'] = _applicant;
    if (_value != null) {
      map['value'] = _value?.map((v) => v.toJson()).toList();
    }
    if (_schemeTotal != null) {
      map['SchemeTotal'] = _schemeTotal?.toJson();
    }
    return map;
  }

}

/// CapitalGainTotal : -146717.77999999999883584678173065185546875
/// LTCG_total : 0
/// STCL_total : -1907.319999999999936335370875895023345947265625
/// STCG_total : 390.259999999999990905052982270717620849609375
/// LTCL_total : -145200.72000000000116415321826934814453125

class SchemeTotal {
  SchemeTotal({
      num? capitalGainTotal, 
      num? lTCGTotal, 
      num? sTCLTotal, 
      num? sTCGTotal, 
      num? lTCLTotal,}){
    _capitalGainTotal = capitalGainTotal;
    _lTCGTotal = lTCGTotal;
    _sTCLTotal = sTCLTotal;
    _sTCGTotal = sTCGTotal;
    _lTCLTotal = lTCLTotal;
}

  SchemeTotal.fromJson(dynamic json) {
    _capitalGainTotal = json['CapitalGainTotal'];
    _lTCGTotal = json['LTCG_total'];
    _sTCLTotal = json['STCL_total'];
    _sTCGTotal = json['STCG_total'];
    _lTCLTotal = json['LTCL_total'];
  }
  num? _capitalGainTotal;
  num? _lTCGTotal;
  num? _sTCLTotal;
  num? _sTCGTotal;
  num? _lTCLTotal;
SchemeTotal copyWith({  num? capitalGainTotal,
  num? lTCGTotal,
  num? sTCLTotal,
  num? sTCGTotal,
  num? lTCLTotal,
}) => SchemeTotal(  capitalGainTotal: capitalGainTotal ?? _capitalGainTotal,
  lTCGTotal: lTCGTotal ?? _lTCGTotal,
  sTCLTotal: sTCLTotal ?? _sTCLTotal,
  sTCGTotal: sTCGTotal ?? _sTCGTotal,
  lTCLTotal: lTCLTotal ?? _lTCLTotal,
);
  num? get capitalGainTotal => _capitalGainTotal;
  num? get lTCGTotal => _lTCGTotal;
  num? get sTCLTotal => _sTCLTotal;
  num? get sTCGTotal => _sTCGTotal;
  num? get lTCLTotal => _lTCLTotal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CapitalGainTotal'] = _capitalGainTotal;
    map['LTCG_total'] = _lTCGTotal;
    map['STCL_total'] = _sTCLTotal;
    map['STCG_total'] = _sTCGTotal;
    map['LTCL_total'] = _lTCLTotal;
    return map;
  }

}

/// category_key : "Equity"
/// capital_gain : -147108.04000000000814907252788543701171875
/// STCL_total : -1907.319999999999936335370875895023345947265625
/// STCG_total : 0
/// LTCL_total : -145200.72000000000116415321826934814453125
/// LTCG_total : 0

class Value {
  Value({
      String? categoryKey, 
      num? capitalGain, 
      num? sTCLTotal, 
      num? sTCGTotal, 
      num? lTCLTotal, 
      num? lTCGTotal,}){
    _categoryKey = categoryKey;
    _capitalGain = capitalGain;
    _sTCLTotal = sTCLTotal;
    _sTCGTotal = sTCGTotal;
    _lTCLTotal = lTCLTotal;
    _lTCGTotal = lTCGTotal;
}

  Value.fromJson(dynamic json) {
    _categoryKey = json['category_key'];
    _capitalGain = json['capital_gain'];
    _sTCLTotal = json['STCL_total'];
    _sTCGTotal = json['STCG_total'];
    _lTCLTotal = json['LTCL_total'];
    _lTCGTotal = json['LTCG_total'];
  }
  String? _categoryKey;
  num? _capitalGain;
  num? _sTCLTotal;
  num? _sTCGTotal;
  num? _lTCLTotal;
  num? _lTCGTotal;
Value copyWith({  String? categoryKey,
  num? capitalGain,
  num? sTCLTotal,
  num? sTCGTotal,
  num? lTCLTotal,
  num? lTCGTotal,
}) => Value(  categoryKey: categoryKey ?? _categoryKey,
  capitalGain: capitalGain ?? _capitalGain,
  sTCLTotal: sTCLTotal ?? _sTCLTotal,
  sTCGTotal: sTCGTotal ?? _sTCGTotal,
  lTCLTotal: lTCLTotal ?? _lTCLTotal,
  lTCGTotal: lTCGTotal ?? _lTCGTotal,
);
  String? get categoryKey => _categoryKey;
  num? get capitalGain => _capitalGain;
  num? get sTCLTotal => _sTCLTotal;
  num? get sTCGTotal => _sTCGTotal;
  num? get lTCLTotal => _lTCLTotal;
  num? get lTCGTotal => _lTCGTotal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['category_key'] = _categoryKey;
    map['capital_gain'] = _capitalGain;
    map['STCL_total'] = _sTCLTotal;
    map['STCG_total'] = _sTCGTotal;
    map['LTCL_total'] = _lTCLTotal;
    map['LTCG_total'] = _lTCGTotal;
    return map;
  }

}