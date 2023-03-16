import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../utils/app_utils.dart';
/// government_related_details : [{"government_related_id":"27","user_id":"164","holder_id":"97","amount":"1200","institution":"Test Institution","location_of_document":"At home","asset_name":"Test Asset Name","account_number":"123456","notes":"test notes","nominee_name":"Maharshi Saparia","contact_person":"Ravi Patel","address":"","holder":"A","holder_name":"","timestamp":"1678945560","upload_doc":"https://vault.alphacapital.in/api/assets/uploads/softcopy/1678945560_IMG_20230314_143128875.jpg"}]
/// success : 1
/// message : "Government related details found."

GovernmentRelatedResponse governmentRelatedResponseFromJson(String str) => GovernmentRelatedResponse.fromJson(json.decode(str));
String governmentRelatedResponseToJson(GovernmentRelatedResponse data) => json.encode(data.toJson());
class GovernmentRelatedResponse {
  GovernmentRelatedResponse({
      List<GovernmentRelatedDetails>? governmentRelatedDetails, 
      num? success, 
      String? message,}){
    _governmentRelatedDetails = governmentRelatedDetails;
    _success = success;
    _message = message;
}

  GovernmentRelatedResponse.fromJson(dynamic json) {
    if (json['government_related_details'] != null) {
      _governmentRelatedDetails = [];
      json['government_related_details'].forEach((v) {
        _governmentRelatedDetails?.add(GovernmentRelatedDetails.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
  }
  List<GovernmentRelatedDetails>? _governmentRelatedDetails;
  num? _success;
  String? _message;
GovernmentRelatedResponse copyWith({  List<GovernmentRelatedDetails>? governmentRelatedDetails,
  num? success,
  String? message,
}) => GovernmentRelatedResponse(  governmentRelatedDetails: governmentRelatedDetails ?? _governmentRelatedDetails,
  success: success ?? _success,
  message: message ?? _message,
);
  List<GovernmentRelatedDetails>? get governmentRelatedDetails => _governmentRelatedDetails;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_governmentRelatedDetails != null) {
      map['government_related_details'] = _governmentRelatedDetails?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// government_related_id : "27"
/// user_id : "164"
/// holder_id : "97"
/// amount : "1200"
/// institution : "Test Institution"
/// location_of_document : "At home"
/// asset_name : "Test Asset Name"
/// account_number : "123456"
/// notes : "test notes"
/// nominee_name : "Maharshi Saparia"
/// contact_person : "Ravi Patel"
/// address : ""
/// holder : "A"
/// holder_name : ""
/// timestamp : "1678945560"
/// upload_doc : "https://vault.alphacapital.in/api/assets/uploads/softcopy/1678945560_IMG_20230314_143128875.jpg"

GovernmentRelatedDetails governmentRelatedDetailsFromJson(String str) => GovernmentRelatedDetails.fromJson(json.decode(str));
String governmentRelatedDetailsToJson(GovernmentRelatedDetails data) => json.encode(data.toJson());
class GovernmentRelatedDetails {
  GovernmentRelatedDetails({
      String? governmentRelatedId, 
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
    _governmentRelatedId = governmentRelatedId;
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

  GovernmentRelatedDetails.fromJson(dynamic json) {
    _governmentRelatedId = json['government_related_id'];
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
  String? _governmentRelatedId;
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
GovernmentRelatedDetails copyWith({  String? governmentRelatedId,
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
}) => GovernmentRelatedDetails(  governmentRelatedId: governmentRelatedId ?? _governmentRelatedId,
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
  String? get governmentRelatedId => _governmentRelatedId;
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
  TextEditingController nomineeNameController = TextEditingController();
  TextEditingController locationOfDocumentController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController uploadDocController = TextEditingController();

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

  set setNomineeName(String value)
  {
    _nomineeName = value;
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
    map['asset_name'] = checkValidString(_assetName);
    map['institution'] = checkValidString(_institution);
    map['account_number'] = checkValidString(_accountNumber);
    map['amount'] = checkValidString(_amount);
    map['contact_person'] = checkValidString(_contactPerson);
    map['location_of_document'] = checkValidString(_locationOfDocument);
    map['notes'] = checkValidString(_notes);
    map['nominee_name'] = checkValidString(_nomineeName);
    map['upload_doc'] = checkValidString(_uploadDoc);
    if(checkValidString(_governmentRelatedId).toString().isNotEmpty)
    {
      map['government_related_id'] = checkValidString(_governmentRelatedId);
    }
    return map;
  }

}