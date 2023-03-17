import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../utils/app_utils.dart';
/// other_debts_details : [{"other_debt_id":"11","user_id":"164","holder_name":"","holder_id":"97","description":"test description","currently_outstanding":"1234","terms":"long","to_whom_owed":"test to whom","contact":"ravi","phone":"5454544665","address":"506","holder":"A","created_on":"09/03/2023","notes":"test notes","upload_doc":"https://vault.alphacapital.in/api/assets/uploads/softcopy/1679056562_IMG_20230317_180600158.jpg","timestamp":"1679056562"}]
/// success : 1
/// message : "Other debts details found."

OtherDebtsResponse otherDebtsResponseFromJson(String str) => OtherDebtsResponse.fromJson(json.decode(str));
String otherDebtsResponseToJson(OtherDebtsResponse data) => json.encode(data.toJson());
class OtherDebtsResponse {
  OtherDebtsResponse({
      List<OtherDebtsDetails>? otherDebtsDetails, 
      num? success, 
      String? message,}){
    _otherDebtsDetails = otherDebtsDetails;
    _success = success;
    _message = message;
}

  OtherDebtsResponse.fromJson(dynamic json) {
    if (json['other_debts_details'] != null) {
      _otherDebtsDetails = [];
      json['other_debts_details'].forEach((v) {
        _otherDebtsDetails?.add(OtherDebtsDetails.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
  }
  List<OtherDebtsDetails>? _otherDebtsDetails;
  num? _success;
  String? _message;
OtherDebtsResponse copyWith({  List<OtherDebtsDetails>? otherDebtsDetails,
  num? success,
  String? message,
}) => OtherDebtsResponse(  otherDebtsDetails: otherDebtsDetails ?? _otherDebtsDetails,
  success: success ?? _success,
  message: message ?? _message,
);
  List<OtherDebtsDetails>? get otherDebtsDetails => _otherDebtsDetails;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_otherDebtsDetails != null) {
      map['other_debts_details'] = _otherDebtsDetails?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// other_debt_id : "11"
/// user_id : "164"
/// holder_name : ""
/// holder_id : "97"
/// description : "test description"
/// currently_outstanding : "1234"
/// terms : "long"
/// to_whom_owed : "test to whom"
/// contact : "ravi"
/// phone : "5454544665"
/// address : "506"
/// holder : "A"
/// created_on : "09/03/2023"
/// notes : "test notes"
/// upload_doc : "https://vault.alphacapital.in/api/assets/uploads/softcopy/1679056562_IMG_20230317_180600158.jpg"
/// timestamp : "1679056562"

OtherDebtsDetails otherDebtsDetailsFromJson(String str) => OtherDebtsDetails.fromJson(json.decode(str));
String otherDebtsDetailsToJson(OtherDebtsDetails data) => json.encode(data.toJson());
class OtherDebtsDetails {
  OtherDebtsDetails({
      String? otherDebtId, 
      String? userId, 
      String? holderName, 
      String? holderId, 
      String? description, 
      String? currentlyOutstanding, 
      String? terms, 
      String? toWhomOwed, 
      String? contact, 
      String? phone, 
      String? address, 
      String? holder, 
      String? createdOn, 
      String? notes, 
      String? uploadDoc, 
      String? timestamp,}){
    _otherDebtId = otherDebtId;
    _userId = userId;
    _holderName = holderName;
    _holderId = holderId;
    _description = description;
    _currentlyOutstanding = currentlyOutstanding;
    _terms = terms;
    _toWhomOwed = toWhomOwed;
    _contact = contact;
    _phone = phone;
    _address = address;
    _holder = holder;
    _createdOn = createdOn;
    _notes = notes;
    _uploadDoc = uploadDoc;
    _timestamp = timestamp;
}

  OtherDebtsDetails.fromJson(dynamic json) {
    _otherDebtId = json['other_debt_id'];
    _userId = json['user_id'];
    _holderName = json['holder_name'];
    _holderId = json['holder_id'];
    _description = json['description'];
    _currentlyOutstanding = json['currently_outstanding'];
    _terms = json['terms'];
    _toWhomOwed = json['to_whom_owed'];
    _contact = json['contact'];
    _phone = json['phone'];
    _address = json['address'];
    _holder = json['holder'];
    _createdOn = json['created_on'];
    _notes = json['notes'];
    _uploadDoc = json['upload_doc'];
    _timestamp = json['timestamp'];
  }
  String? _otherDebtId;
  String? _userId;
  String? _holderName;
  String? _holderId;
  String? _description;
  String? _currentlyOutstanding;
  String? _terms;
  String? _toWhomOwed;
  String? _contact;
  String? _phone;
  String? _address;
  String? _holder;
  String? _createdOn;
  String? _notes;
  String? _uploadDoc;
  String? _timestamp;
OtherDebtsDetails copyWith({  String? otherDebtId,
  String? userId,
  String? holderName,
  String? holderId,
  String? description,
  String? currentlyOutstanding,
  String? terms,
  String? toWhomOwed,
  String? contact,
  String? phone,
  String? address,
  String? holder,
  String? createdOn,
  String? notes,
  String? uploadDoc,
  String? timestamp,
}) => OtherDebtsDetails(  otherDebtId: otherDebtId ?? _otherDebtId,
  userId: userId ?? _userId,
  holderName: holderName ?? _holderName,
  holderId: holderId ?? _holderId,
  description: description ?? _description,
  currentlyOutstanding: currentlyOutstanding ?? _currentlyOutstanding,
  terms: terms ?? _terms,
  toWhomOwed: toWhomOwed ?? _toWhomOwed,
  contact: contact ?? _contact,
  phone: phone ?? _phone,
  address: address ?? _address,
  holder: holder ?? _holder,
  createdOn: createdOn ?? _createdOn,
  notes: notes ?? _notes,
  uploadDoc: uploadDoc ?? _uploadDoc,
  timestamp: timestamp ?? _timestamp,
);
  String? get otherDebtId => _otherDebtId;
  String? get userId => _userId;
  String? get holderName => _holderName;
  String? get holderId => _holderId;
  String? get description => _description;
  String? get currentlyOutstanding => _currentlyOutstanding;
  String? get terms => _terms;
  String? get toWhomOwed => _toWhomOwed;
  String? get contact => _contact;
  String? get phone => _phone;
  String? get address => _address;
  String? get holder => _holder;
  String? get createdOn => _createdOn;
  String? get notes => _notes;
  String? get uploadDoc => _uploadDoc;
  String? get timestamp => _timestamp;

  TextEditingController descriptionController = TextEditingController();
  TextEditingController currentlyOutstandingController = TextEditingController();
  TextEditingController termsController = TextEditingController();
  TextEditingController toWhomOwedController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController createdOnController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController uploadDocController = TextEditingController();

  set setDescription(String value)
  {
    _description = value;
  }

  set setCurrentlyOutstanding(String value)
  {
    _currentlyOutstanding = value;
  }

  set setTerms(String value)
  {
    _terms = value;
  }

  set setToWhomOwed(String value)
  {
    _toWhomOwed = value;
  }

  set setContact(String value)
  {
    _contact = value;
  }

  set setPhone(String value)
  {
    _phone = value;
  }

  set setAddress(String value)
  {
    _address = value;
  }

  set setCreatedOn(String value)
  {
    _createdOn = value;
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
    map['description'] = checkValidString(_description);
    map['currently_outstanding'] = checkValidString(_currentlyOutstanding);
    map['terms'] = checkValidString(_terms);
    map['to_whom_owed'] = checkValidString(_toWhomOwed);
    map['contact'] = checkValidString(_contact);
    map['phone'] = checkValidString(_phone);
    map['address'] = checkValidString(_address);
    map['created_on'] = checkValidString(_createdOn);
    map['notes'] = checkValidString(_notes);
    map['upload_doc'] = checkValidString(_uploadDoc);
    if(checkValidString(_otherDebtId).toString().isNotEmpty)
    {
      map['other_debt_id'] = checkValidString(_otherDebtId);
    }
    return map;
  }

}