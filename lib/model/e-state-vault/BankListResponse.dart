import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../utils/app_utils.dart';
/// financial_institution_accounts : [{"upload_doc":"https://vault.alphacapital.in/api/assets/uploads/softcopy/1679032639_IMG_20230314_143128875.jpg","financial_institution_account_id":"23","user_id":"164","holder_id":"97","bank_name":"SBI","branch":"Prahaladnagar","notes":"Test notes..","nominee_name":"Maharshi Saparia","account_number_and_type":"124512451254","other_than_own_name":"Current","holder":"A","holder_name":"","approximate_value":"230000","timestamp":"1679032639"}]
/// success : 1
/// message : "Financial institution accounts found."

BankListResponse bankListResponseFromJson(String str) => BankListResponse.fromJson(json.decode(str));
String bankListResponseToJson(BankListResponse data) => json.encode(data.toJson());
class BankListResponse {
  BankListResponse({
      List<FinancialInstitutionAccounts>? financialInstitutionAccounts, 
      num? success, 
      String? message,}){
    _financialInstitutionAccounts = financialInstitutionAccounts;
    _success = success;
    _message = message;
}

  BankListResponse.fromJson(dynamic json) {
    if (json['financial_institution_accounts'] != null) {
      _financialInstitutionAccounts = [];
      json['financial_institution_accounts'].forEach((v) {
        _financialInstitutionAccounts?.add(FinancialInstitutionAccounts.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
  }
  List<FinancialInstitutionAccounts>? _financialInstitutionAccounts;
  num? _success;
  String? _message;
BankListResponse copyWith({  List<FinancialInstitutionAccounts>? financialInstitutionAccounts,
  num? success,
  String? message,
}) => BankListResponse(  financialInstitutionAccounts: financialInstitutionAccounts ?? _financialInstitutionAccounts,
  success: success ?? _success,
  message: message ?? _message,
);
  List<FinancialInstitutionAccounts>? get financialInstitutionAccounts => _financialInstitutionAccounts;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_financialInstitutionAccounts != null) {
      map['financial_institution_accounts'] = _financialInstitutionAccounts?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// upload_doc : "https://vault.alphacapital.in/api/assets/uploads/softcopy/1679032639_IMG_20230314_143128875.jpg"
/// financial_institution_account_id : "23"
/// user_id : "164"
/// holder_id : "97"
/// bank_name : "SBI"
/// branch : "Prahaladnagar"
/// notes : "Test notes.."
/// nominee_name : "Maharshi Saparia"
/// account_number_and_type : "124512451254"
/// other_than_own_name : "Current"
/// holder : "A"
/// holder_name : ""
/// approximate_value : "230000"
/// timestamp : "1679032639"

FinancialInstitutionAccounts financialInstitutionAccountsFromJson(String str) => FinancialInstitutionAccounts.fromJson(json.decode(str));
String financialInstitutionAccountsToJson(FinancialInstitutionAccounts data) => json.encode(data.toJson());
class FinancialInstitutionAccounts {
  FinancialInstitutionAccounts({
      String? uploadDoc, 
      String? financialInstitutionAccountId, 
      String? userId, 
      String? holderId, 
      String? bankName, 
      String? branch, 
      String? notes, 
      String? nomineeName, 
      String? accountNumberAndType, 
      String? otherThanOwnName, 
      String? holder, 
      String? holderName, 
      String? approximateValue, 
      String? timestamp,}){
    _uploadDoc = uploadDoc;
    _financialInstitutionAccountId = financialInstitutionAccountId;
    _userId = userId;
    _holderId = holderId;
    _bankName = bankName;
    _branch = branch;
    _notes = notes;
    _nomineeName = nomineeName;
    _accountNumberAndType = accountNumberAndType;
    _otherThanOwnName = otherThanOwnName;
    _holder = holder;
    _holderName = holderName;
    _approximateValue = approximateValue;
    _timestamp = timestamp;
}

  FinancialInstitutionAccounts.fromJson(dynamic json) {
    _uploadDoc = json['upload_doc'];
    _financialInstitutionAccountId = json['financial_institution_account_id'];
    _userId = json['user_id'];
    _holderId = json['holder_id'];
    _bankName = json['bank_name'];
    _branch = json['branch'];
    _notes = json['notes'];
    _nomineeName = json['nominee_name'];
    _accountNumberAndType = json['account_number_and_type'];
    _otherThanOwnName = json['other_than_own_name'];
    _holder = json['holder'];
    _holderName = json['holder_name'];
    _approximateValue = json['approximate_value'];
    _timestamp = json['timestamp'];
  }
  String? _uploadDoc;
  String? _financialInstitutionAccountId;
  String? _userId;
  String? _holderId;
  String? _bankName;
  String? _branch;
  String? _notes;
  String? _nomineeName;
  String? _accountNumberAndType;
  String? _otherThanOwnName;
  String? _holder;
  String? _holderName;
  String? _approximateValue;
  String? _timestamp;
FinancialInstitutionAccounts copyWith({  String? uploadDoc,
  String? financialInstitutionAccountId,
  String? userId,
  String? holderId,
  String? bankName,
  String? branch,
  String? notes,
  String? nomineeName,
  String? accountNumberAndType,
  String? otherThanOwnName,
  String? holder,
  String? holderName,
  String? approximateValue,
  String? timestamp,
}) => FinancialInstitutionAccounts(  uploadDoc: uploadDoc ?? _uploadDoc,
  financialInstitutionAccountId: financialInstitutionAccountId ?? _financialInstitutionAccountId,
  userId: userId ?? _userId,
  holderId: holderId ?? _holderId,
  bankName: bankName ?? _bankName,
  branch: branch ?? _branch,
  notes: notes ?? _notes,
  nomineeName: nomineeName ?? _nomineeName,
  accountNumberAndType: accountNumberAndType ?? _accountNumberAndType,
  otherThanOwnName: otherThanOwnName ?? _otherThanOwnName,
  holder: holder ?? _holder,
  holderName: holderName ?? _holderName,
  approximateValue: approximateValue ?? _approximateValue,
  timestamp: timestamp ?? _timestamp,
);
  String? get uploadDoc => _uploadDoc;
  String? get financialInstitutionAccountId => _financialInstitutionAccountId;
  String? get userId => _userId;
  String? get holderId => _holderId;
  String? get bankName => _bankName;
  String? get branch => _branch;
  String? get notes => _notes;
  String? get nomineeName => _nomineeName;
  String? get accountNumberAndType => _accountNumberAndType;
  String? get otherThanOwnName => _otherThanOwnName;
  String? get holder => _holder;
  String? get holderName => _holderName;
  String? get approximateValue => _approximateValue;
  String? get timestamp => _timestamp;

  TextEditingController bankNameController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController modeController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController uploadDocController = TextEditingController();
  TextEditingController nomineeNameController = TextEditingController();

  set setBankName(String value)
  {
    _bankName = value;
  }

  set setBranch(String value)
  {
    _branch = value;
  }

  set setAccountNumber(String value)
  {
    _accountNumberAndType = value;
  }

  set setValue(String value)
  {
    _approximateValue = value;
  }

  set setMode(String value)
  {
    _otherThanOwnName = value;
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
    map['bank_name'] = checkValidString(_bankName);
    map['branch'] = checkValidString(_branch);
    map['account_number_and_type'] = checkValidString(_accountNumberAndType);
    map['other_than_own_name'] = checkValidString(_otherThanOwnName);
    map['approximate_value'] = checkValidString(_approximateValue);
    map['notes'] = checkValidString(_notes);
    map['nominee_name'] = checkValidString(_nomineeName);
    map['holder'] = checkValidString(_holder);
    map['upload_doc'] = checkValidString(_uploadDoc);
    if(checkValidString(_financialInstitutionAccountId).toString().isNotEmpty)
    {
      map['financial_institution_account_id'] = checkValidString(_financialInstitutionAccountId);
    }
    return map;
  }
}