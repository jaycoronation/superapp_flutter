/// success : 1
/// transaction_details : [{"TranDate":"29 Mar 2023","Applicant":"Mukesh Jindal","SchemeName":"HDFC Tax Saver (G)","Amount":150000,"Type":"Purchase","Nature":"Purchase","FolioNo":"9290880/19","Nav":787,"Units":191,"FCode":"F0014","SCode":"FS082","Product":"F"}]

class LatestTransactionResponse {
  LatestTransactionResponse({
      num? success, 
      List<TransactionDetails>? transactionDetails,}){
    _success = success;
    _transactionDetails = transactionDetails;
}

  LatestTransactionResponse.fromJson(dynamic json) {
    _success = json['success'];
    if (json['transaction_details'] != null) {
      _transactionDetails = [];
      json['transaction_details'].forEach((v) {
        _transactionDetails?.add(TransactionDetails.fromJson(v));
      });
    }
  }
  num? _success;
  List<TransactionDetails>? _transactionDetails;
LatestTransactionResponse copyWith({  num? success,
  List<TransactionDetails>? transactionDetails,
}) => LatestTransactionResponse(  success: success ?? _success,
  transactionDetails: transactionDetails ?? _transactionDetails,
);
  num? get success => _success;
  List<TransactionDetails>? get transactionDetails => _transactionDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_transactionDetails != null) {
      map['transaction_details'] = _transactionDetails?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// TranDate : "29 Mar 2023"
/// Applicant : "Mukesh Jindal"
/// SchemeName : "HDFC Tax Saver (G)"
/// Amount : 150000
/// Type : "Purchase"
/// Nature : "Purchase"
/// FolioNo : "9290880/19"
/// Nav : 787
/// Units : 191
/// FCode : "F0014"
/// SCode : "FS082"
/// Product : "F"

class TransactionDetails {
  TransactionDetails({
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

  TransactionDetails.fromJson(dynamic json) {
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
TransactionDetails copyWith({  String? tranDate,
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
}) => TransactionDetails(  tranDate: tranDate ?? _tranDate,
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