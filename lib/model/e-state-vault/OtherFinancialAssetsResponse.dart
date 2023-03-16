import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../utils/app_utils.dart';
/// investment_trust_accounts : [{"investment_trust_account_id":"17","user_id":"164","holder_id":"97","amount":"ehhr","institution":"dhhrhh","location_of_document":"hdh","asset_name":"fhh","account_number":"ehhr","notes":"rhehheeh","nominee_name":"zbbd","contact_person":"hehr","address":"","holder":"A","holder_name":"","timestamp":"1678969615","upload_doc":"https://vault.alphacapital.in/api/assets/uploads/softcopy/1678969615_IMG_20230314_143128875.jpg"}]
/// success : 1
/// message : "Financial Asset details found."

OtherFinancialAssetsResponse otherFinancialAssetsResponseFromJson(String str) => OtherFinancialAssetsResponse.fromJson(json.decode(str));
String otherFinancialAssetsResponseToJson(OtherFinancialAssetsResponse data) => json.encode(data.toJson());
class OtherFinancialAssetsResponse {
  OtherFinancialAssetsResponse({
      List<InvestmentTrustAccounts>? investmentTrustAccounts, 
      num? success, 
      String? message,}){
    _investmentTrustAccounts = investmentTrustAccounts;
    _success = success;
    _message = message;
}

  OtherFinancialAssetsResponse.fromJson(dynamic json) {
    if (json['investment_trust_accounts'] != null) {
      _investmentTrustAccounts = [];
      json['investment_trust_accounts'].forEach((v) {
        _investmentTrustAccounts?.add(InvestmentTrustAccounts.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
  }
  List<InvestmentTrustAccounts>? _investmentTrustAccounts;
  num? _success;
  String? _message;
OtherFinancialAssetsResponse copyWith({  List<InvestmentTrustAccounts>? investmentTrustAccounts,
  num? success,
  String? message,
}) => OtherFinancialAssetsResponse(  investmentTrustAccounts: investmentTrustAccounts ?? _investmentTrustAccounts,
  success: success ?? _success,
  message: message ?? _message,
);
  List<InvestmentTrustAccounts>? get investmentTrustAccounts => _investmentTrustAccounts;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_investmentTrustAccounts != null) {
      map['investment_trust_accounts'] = _investmentTrustAccounts?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// investment_trust_account_id : "17"
/// user_id : "164"
/// holder_id : "97"
/// amount : "ehhr"
/// institution : "dhhrhh"
/// location_of_document : "hdh"
/// asset_name : "fhh"
/// account_number : "ehhr"
/// notes : "rhehheeh"
/// nominee_name : "zbbd"
/// contact_person : "hehr"
/// address : ""
/// holder : "A"
/// holder_name : ""
/// timestamp : "1678969615"
/// upload_doc : "https://vault.alphacapital.in/api/assets/uploads/softcopy/1678969615_IMG_20230314_143128875.jpg"

InvestmentTrustAccounts investmentTrustAccountsFromJson(String str) => InvestmentTrustAccounts.fromJson(json.decode(str));
String investmentTrustAccountsToJson(InvestmentTrustAccounts data) => json.encode(data.toJson());
class InvestmentTrustAccounts {
  InvestmentTrustAccounts({
      String? investmentTrustAccountId, 
      String? userId, 
      String? holderId, 
      String? amount, 
      String? institution, 
      String? locationOfDocument, 
      String? assetName, 
      String? accountNumber, 
      String? notes, 
      String? nomineeName, 
      String? contactPerson, 
      String? address, 
      String? holder, 
      String? holderName, 
      String? timestamp, 
      String? uploadDoc,}){
    _investmentTrustAccountId = investmentTrustAccountId;
    _userId = userId;
    _holderId = holderId;
    _amount = amount;
    _institution = institution;
    _locationOfDocument = locationOfDocument;
    _assetName = assetName;
    _accountNumber = accountNumber;
    _notes = notes;
    _nomineeName = nomineeName;
    _contactPerson = contactPerson;
    _address = address;
    _holder = holder;
    _holderName = holderName;
    _timestamp = timestamp;
    _uploadDoc = uploadDoc;
}

  InvestmentTrustAccounts.fromJson(dynamic json) {
    _investmentTrustAccountId = json['investment_trust_account_id'];
    _userId = json['user_id'];
    _holderId = json['holder_id'];
    _amount = json['amount'];
    _institution = json['institution'];
    _locationOfDocument = json['location_of_document'];
    _assetName = json['asset_name'];
    _accountNumber = json['account_number'];
    _notes = json['notes'];
    _nomineeName = json['nominee_name'];
    _contactPerson = json['contact_person'];
    _address = json['address'];
    _holder = json['holder'];
    _holderName = json['holder_name'];
    _timestamp = json['timestamp'];
    _uploadDoc = json['upload_doc'];
  }
  String? _investmentTrustAccountId;
  String? _userId;
  String? _holderId;
  String? _amount;
  String? _institution;
  String? _locationOfDocument;
  String? _assetName;
  String? _accountNumber;
  String? _notes;
  String? _nomineeName;
  String? _contactPerson;
  String? _address;
  String? _holder;
  String? _holderName;
  String? _timestamp;
  String? _uploadDoc;
InvestmentTrustAccounts copyWith({  String? investmentTrustAccountId,
  String? userId,
  String? holderId,
  String? amount,
  String? institution,
  String? locationOfDocument,
  String? assetName,
  String? accountNumber,
  String? notes,
  String? nomineeName,
  String? contactPerson,
  String? address,
  String? holder,
  String? holderName,
  String? timestamp,
  String? uploadDoc,
}) => InvestmentTrustAccounts(  investmentTrustAccountId: investmentTrustAccountId ?? _investmentTrustAccountId,
  userId: userId ?? _userId,
  holderId: holderId ?? _holderId,
  amount: amount ?? _amount,
  institution: institution ?? _institution,
  locationOfDocument: locationOfDocument ?? _locationOfDocument,
  assetName: assetName ?? _assetName,
  accountNumber: accountNumber ?? _accountNumber,
  notes: notes ?? _notes,
  nomineeName: nomineeName ?? _nomineeName,
  contactPerson: contactPerson ?? _contactPerson,
  address: address ?? _address,
  holder: holder ?? _holder,
  holderName: holderName ?? _holderName,
  timestamp: timestamp ?? _timestamp,
  uploadDoc: uploadDoc ?? _uploadDoc,
);
  String? get investmentTrustAccountId => _investmentTrustAccountId;
  String? get userId => _userId;
  String? get holderId => _holderId;
  String? get amount => _amount;
  String? get institution => _institution;
  String? get locationOfDocument => _locationOfDocument;
  String? get assetName => _assetName;
  String? get accountNumber => _accountNumber;
  String? get notes => _notes;
  String? get nomineeName => _nomineeName;
  String? get contactPerson => _contactPerson;
  String? get address => _address;
  String? get holder => _holder;
  String? get holderName => _holderName;
  String? get timestamp => _timestamp;
  String? get uploadDoc => _uploadDoc;

  TextEditingController assetNameController = TextEditingController();
  TextEditingController institutionController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController contactPersonController = TextEditingController();
  TextEditingController locationOfDocumentController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController uploadDocController = TextEditingController();
  TextEditingController nomineeNameController = TextEditingController();

  set setAssetName(String value)
  {
    _assetName = value;
  }

  set setInstitution(String value)
  {
    _institution = value;
  }

  set setAccountNumber(String value)
  {
    _accountNumber = value;
  }

  set setAmount(String value)
  {
    _amount = value;
  }

  set setContactPerson(String value)
  {
    _contactPerson = value;
  }

  set setLocationOfDocument(String value)
  {
    _locationOfDocument = value;
  }

  set setNotes(String value)
  {
    _notes = value;
  }

  set setUploadDoc(String value)
  {
    _uploadDoc = value;
  }

  set setNomineeName(String value)
  {
    _nomineeName = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['amount'] = checkValidString(_amount);
    map['institution'] = checkValidString(_institution);
    map['location_of_document'] = checkValidString(_locationOfDocument);
    map['asset_name'] = checkValidString(_assetName);
    map['account_number'] = checkValidString(_accountNumber);
    map['notes'] = checkValidString(_notes);
    map['nominee_name'] = checkValidString(_nomineeName);
    map['contact_person'] = checkValidString(_contactPerson);
    map['holder'] = checkValidString(_holder);
    map['upload_doc'] = checkValidString(_uploadDoc);
    if(checkValidString(_investmentTrustAccountId).toString().isNotEmpty)
    {
      map['investment_trust_account_id'] = checkValidString(_investmentTrustAccountId);
    }
    return map;
  }

}