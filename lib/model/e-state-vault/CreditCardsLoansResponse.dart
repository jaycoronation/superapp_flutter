import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../utils/app_utils.dart';
/// credit_cards_and_loans : [{"credit_cards_and_loan_id":"28","user_id":"164","holder_id":"97","type":"Car Loan","account_number":"djnd","holder":"A","holder_name":"","institution":"tjjt","amount":"6363","created_on":"17/03/2023","contact_person":"urjr","location_of_document":"gwge","notes":"rhfh","upload_doc":"https://vault.alphacapital.in/api/assets/uploads/softcopy/1679045367_IMG_20230317_145924584.jpg","timestamp":"1679045367"}]
/// success : 1
/// message : "Credit cards/loans details found."

CreditCardsLoansResponse creditCardsLoansResponseFromJson(String str) => CreditCardsLoansResponse.fromJson(json.decode(str));
String creditCardsLoansResponseToJson(CreditCardsLoansResponse data) => json.encode(data.toJson());
class CreditCardsLoansResponse {
  CreditCardsLoansResponse({
      List<CreditCardsAndLoans>? creditCardsAndLoans, 
      num? success, 
      String? message,}){
    _creditCardsAndLoans = creditCardsAndLoans;
    _success = success;
    _message = message;
}

  CreditCardsLoansResponse.fromJson(dynamic json) {
    if (json['credit_cards_and_loans'] != null) {
      _creditCardsAndLoans = [];
      json['credit_cards_and_loans'].forEach((v) {
        _creditCardsAndLoans?.add(CreditCardsAndLoans.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
  }
  List<CreditCardsAndLoans>? _creditCardsAndLoans;
  num? _success;
  String? _message;
CreditCardsLoansResponse copyWith({  List<CreditCardsAndLoans>? creditCardsAndLoans,
  num? success,
  String? message,
}) => CreditCardsLoansResponse(  creditCardsAndLoans: creditCardsAndLoans ?? _creditCardsAndLoans,
  success: success ?? _success,
  message: message ?? _message,
);
  List<CreditCardsAndLoans>? get creditCardsAndLoans => _creditCardsAndLoans;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_creditCardsAndLoans != null) {
      map['credit_cards_and_loans'] = _creditCardsAndLoans?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// credit_cards_and_loan_id : "28"
/// user_id : "164"
/// holder_id : "97"
/// type : "Car Loan"
/// account_number : "djnd"
/// holder : "A"
/// holder_name : ""
/// institution : "tjjt"
/// amount : "6363"
/// created_on : "17/03/2023"
/// contact_person : "urjr"
/// location_of_document : "gwge"
/// notes : "rhfh"
/// upload_doc : "https://vault.alphacapital.in/api/assets/uploads/softcopy/1679045367_IMG_20230317_145924584.jpg"
/// timestamp : "1679045367"

CreditCardsAndLoans creditCardsAndLoansFromJson(String str) => CreditCardsAndLoans.fromJson(json.decode(str));
String creditCardsAndLoansToJson(CreditCardsAndLoans data) => json.encode(data.toJson());
class CreditCardsAndLoans {
  CreditCardsAndLoans({
      String? creditCardsAndLoanId, 
      String? userId, 
      String? holderId, 
      String? type, 
      String? accountNumber, 
      String? holder, 
      String? holderName, 
      String? institution, 
      String? amount, 
      String? createdOn, 
      String? contactPerson, 
      String? locationOfDocument, 
      String? notes, 
      String? uploadDoc, 
      String? timestamp,}){
    _creditCardsAndLoanId = creditCardsAndLoanId;
    _userId = userId;
    _holderId = holderId;
    _type = type;
    _accountNumber = accountNumber;
    _holder = holder;
    _holderName = holderName;
    _institution = institution;
    _amount = amount;
    _createdOn = createdOn;
    _contactPerson = contactPerson;
    _locationOfDocument = locationOfDocument;
    _notes = notes;
    _uploadDoc = uploadDoc;
    _timestamp = timestamp;
}

  CreditCardsAndLoans.fromJson(dynamic json) {
    _creditCardsAndLoanId = json['credit_cards_and_loan_id'];
    _userId = json['user_id'];
    _holderId = json['holder_id'];
    _type = json['type'];
    _accountNumber = json['account_number'];
    _holder = json['holder'];
    _holderName = json['holder_name'];
    _institution = json['institution'];
    _amount = json['amount'];
    _createdOn = json['created_on'];
    _contactPerson = json['contact_person'];
    _locationOfDocument = json['location_of_document'];
    _notes = json['notes'];
    _uploadDoc = json['upload_doc'];
    _timestamp = json['timestamp'];
  }
  String? _creditCardsAndLoanId;
  String? _userId;
  String? _holderId;
  String? _type;
  String? _accountNumber;
  String? _holder;
  String? _holderName;
  String? _institution;
  String? _amount;
  String? _createdOn;
  String? _contactPerson;
  String? _locationOfDocument;
  String? _notes;
  String? _uploadDoc;
  String? _timestamp;
CreditCardsAndLoans copyWith({  String? creditCardsAndLoanId,
  String? userId,
  String? holderId,
  String? type,
  String? accountNumber,
  String? holder,
  String? holderName,
  String? institution,
  String? amount,
  String? createdOn,
  String? contactPerson,
  String? locationOfDocument,
  String? notes,
  String? uploadDoc,
  String? timestamp,
}) => CreditCardsAndLoans(  creditCardsAndLoanId: creditCardsAndLoanId ?? _creditCardsAndLoanId,
  userId: userId ?? _userId,
  holderId: holderId ?? _holderId,
  type: type ?? _type,
  accountNumber: accountNumber ?? _accountNumber,
  holder: holder ?? _holder,
  holderName: holderName ?? _holderName,
  institution: institution ?? _institution,
  amount: amount ?? _amount,
  createdOn: createdOn ?? _createdOn,
  contactPerson: contactPerson ?? _contactPerson,
  locationOfDocument: locationOfDocument ?? _locationOfDocument,
  notes: notes ?? _notes,
  uploadDoc: uploadDoc ?? _uploadDoc,
  timestamp: timestamp ?? _timestamp,
);
  String? get creditCardsAndLoanId => _creditCardsAndLoanId;
  String? get userId => _userId;
  String? get holderId => _holderId;
  String? get type => _type;
  String? get accountNumber => _accountNumber;
  String? get holder => _holder;
  String? get holderName => _holderName;
  String? get institution => _institution;
  String? get amount => _amount;
  String? get createdOn => _createdOn;
  String? get contactPerson => _contactPerson;
  String? get locationOfDocument => _locationOfDocument;
  String? get notes => _notes;
  String? get uploadDoc => _uploadDoc;
  String? get timestamp => _timestamp;

  TextEditingController typeController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController institutionController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController createdOnController = TextEditingController();
  TextEditingController contactPersonController = TextEditingController();
  TextEditingController locationOfDocumentController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController uploadDocController = TextEditingController();

  set setType(String value)
  {
    _type = value;
  }

  set setAccountNumber(String value)
  {
    _accountNumber = value;
  }

  set setInstitution(String value)
  {
    _institution = value;
  }

  set setAmount(String value)
  {
    _amount = value;
  }

  set setCreatedOn(String value)
  {
    _createdOn = value;
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['holder'] = checkValidString(_holder);
    map['type'] = checkValidString(_type);
    map['account_number'] = checkValidString(_accountNumber);
    map['institution'] = checkValidString(_institution);
    map['amount'] = checkValidString(_amount);
    map['created_on'] = checkValidString(_createdOn);
    map['contact_person'] = checkValidString(_contactPerson);
    map['location_of_document'] = checkValidString(_locationOfDocument);
    map['notes'] = checkValidString(_notes);
    map['upload_doc'] = checkValidString(_uploadDoc);
    if(checkValidString(_creditCardsAndLoanId).toString().isNotEmpty)
    {
      map['credit_cards_and_loan_id'] = checkValidString(_creditCardsAndLoanId);
    }
    return map;
  }


}