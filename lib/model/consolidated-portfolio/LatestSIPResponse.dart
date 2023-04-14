/// sip_stp_details : [{"TranDate":"20 Mar 2023","Applicant":"Abha Agarwal","SchemeName":"Kotak Smallcap Fund (G)","Amount":20000,"Type":"SIP","Nature":"Purchase","FolioNo":"8043196/35","Nav":157,"Units":128,"FCode":"F0020","SCode":"FS075","Product":"F"}]
/// success : 1

class LatestSipResponse {
  LatestSipResponse({
      List<SipStpDetails>? sipStpDetails, 
      num? success,}){
    _sipStpDetails = sipStpDetails;
    _success = success;
}

  LatestSipResponse.fromJson(dynamic json) {
    if (json['sip_stp_details'] != null) {
      _sipStpDetails = [];
      json['sip_stp_details'].forEach((v) {
        _sipStpDetails?.add(SipStpDetails.fromJson(v));
      });
    }
    _success = json['success'];
  }
  List<SipStpDetails>? _sipStpDetails;
  num? _success;
LatestSipResponse copyWith({  List<SipStpDetails>? sipStpDetails,
  num? success,
}) => LatestSipResponse(  sipStpDetails: sipStpDetails ?? _sipStpDetails,
  success: success ?? _success,
);
  List<SipStpDetails>? get sipStpDetails => _sipStpDetails;
  num? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_sipStpDetails != null) {
      map['sip_stp_details'] = _sipStpDetails?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    return map;
  }

}

/// TranDate : "20 Mar 2023"
/// Applicant : "Abha Agarwal"
/// SchemeName : "Kotak Smallcap Fund (G)"
/// Amount : 20000
/// Type : "SIP"
/// Nature : "Purchase"
/// FolioNo : "8043196/35"
/// Nav : 157
/// Units : 128
/// FCode : "F0020"
/// SCode : "FS075"
/// Product : "F"

class SipStpDetails {
  SipStpDetails({
      String? tranDate, 
      String? applicant, 
      String? schemeName, 
      num? amount, 
      String? type, 
      String? nature, 
      String? folioNo, 
      num? nav, 
      num? units, 
      String? fCode, 
      String? sCode, 
      String? product,}){
    _tranDate = tranDate;
    _applicant = applicant;
    _schemeName = schemeName;
    _amount = amount;
    _type = type;
    _nature = nature;
    _folioNo = folioNo;
    _nav = nav;
    _units = units;
    _fCode = fCode;
    _sCode = sCode;
    _product = product;
}

  SipStpDetails.fromJson(dynamic json) {
    _tranDate = json['TranDate'];
    _applicant = json['Applicant'];
    _schemeName = json['SchemeName'];
    _amount = json['Amount'];
    _type = json['Type'];
    _nature = json['Nature'];
    _folioNo = json['FolioNo'];
    _nav = json['Nav'];
    _units = json['Units'];
    _fCode = json['FCode'];
    _sCode = json['SCode'];
    _product = json['Product'];
  }
  String? _tranDate;
  String? _applicant;
  String? _schemeName;
  num? _amount;
  String? _type;
  String? _nature;
  String? _folioNo;
  num? _nav;
  num? _units;
  String? _fCode;
  String? _sCode;
  String? _product;
SipStpDetails copyWith({  String? tranDate,
  String? applicant,
  String? schemeName,
  num? amount,
  String? type,
  String? nature,
  String? folioNo,
  num? nav,
  num? units,
  String? fCode,
  String? sCode,
  String? product,
}) => SipStpDetails(  tranDate: tranDate ?? _tranDate,
  applicant: applicant ?? _applicant,
  schemeName: schemeName ?? _schemeName,
  amount: amount ?? _amount,
  type: type ?? _type,
  nature: nature ?? _nature,
  folioNo: folioNo ?? _folioNo,
  nav: nav ?? _nav,
  units: units ?? _units,
  fCode: fCode ?? _fCode,
  sCode: sCode ?? _sCode,
  product: product ?? _product,
);
  String? get tranDate => _tranDate;
  String? get applicant => _applicant;
  String? get schemeName => _schemeName;
  num? get amount => _amount;
  String? get type => _type;
  String? get nature => _nature;
  String? get folioNo => _folioNo;
  num? get nav => _nav;
  num? get units => _units;
  String? get fCode => _fCode;
  String? get sCode => _sCode;
  String? get product => _product;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TranDate'] = _tranDate;
    map['Applicant'] = _applicant;
    map['SchemeName'] = _schemeName;
    map['Amount'] = _amount;
    map['Type'] = _type;
    map['Nature'] = _nature;
    map['FolioNo'] = _folioNo;
    map['Nav'] = _nav;
    map['Units'] = _units;
    map['FCode'] = _fCode;
    map['SCode'] = _sCode;
    map['Product'] = _product;
    return map;
  }

}