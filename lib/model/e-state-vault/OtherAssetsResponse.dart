import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../utils/app_utils.dart';
/// other_assets : [{"other_asset_id":"10","user_id":"164","holder_id":"97","holder_name":"","asset_name":"","institution":"","account_number":"","amount":"","contact_person":"","location_of_document":"","notes":"fg","nominee_name":"gg","description":"test","approximate_value":"ggg","encumbrances":"ff","upload_doc":"","holder":"A","timestamp":"1679043605"}]
/// success : 1
/// message : "Other assets found."

OtherAssetsResponse otherAssetsResponseFromJson(String str) => OtherAssetsResponse.fromJson(json.decode(str));
String otherAssetsResponseToJson(OtherAssetsResponse data) => json.encode(data.toJson());
class OtherAssetsResponse {
  OtherAssetsResponse({
      List<OtherAssets>? otherAssets, 
      num? success, 
      String? message,}){
    _otherAssets = otherAssets;
    _success = success;
    _message = message;
}

  OtherAssetsResponse.fromJson(dynamic json) {
    if (json['other_assets'] != null) {
      _otherAssets = [];
      json['other_assets'].forEach((v) {
        _otherAssets?.add(OtherAssets.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
  }
  List<OtherAssets>? _otherAssets;
  num? _success;
  String? _message;
OtherAssetsResponse copyWith({  List<OtherAssets>? otherAssets,
  num? success,
  String? message,
}) => OtherAssetsResponse(  otherAssets: otherAssets ?? _otherAssets,
  success: success ?? _success,
  message: message ?? _message,
);
  List<OtherAssets>? get otherAssets => _otherAssets;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_otherAssets != null) {
      map['other_assets'] = _otherAssets?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// other_asset_id : "10"
/// user_id : "164"
/// holder_id : "97"
/// holder_name : ""
/// asset_name : ""
/// institution : ""
/// account_number : ""
/// amount : ""
/// contact_person : ""
/// location_of_document : ""
/// notes : "fg"
/// nominee_name : "gg"
/// description : "test"
/// approximate_value : "ggg"
/// encumbrances : "ff"
/// upload_doc : ""
/// holder : "A"
/// timestamp : "1679043605"

OtherAssets otherAssetsFromJson(String str) => OtherAssets.fromJson(json.decode(str));
String otherAssetsToJson(OtherAssets data) => json.encode(data.toJson());
class OtherAssets {
  OtherAssets({
      String? otherAssetId, 
      String? userId, 
      String? holderId, 
      String? holderName, 
      String? assetName, 
      String? institution, 
      String? accountNumber, 
      String? amount, 
      String? contactPerson, 
      String? locationOfDocument, 
      String? notes, 
      String? nomineeName, 
      String? description, 
      String? approximateValue, 
      String? encumbrances, 
      String? uploadDoc, 
      String? holder, 
      String? timestamp,}){
    _otherAssetId = otherAssetId;
    _userId = userId;
    _holderId = holderId;
    _holderName = holderName;
    _assetName = assetName;
    _institution = institution;
    _accountNumber = accountNumber;
    _amount = amount;
    _contactPerson = contactPerson;
    _locationOfDocument = locationOfDocument;
    _notes = notes;
    _nomineeName = nomineeName;
    _description = description;
    _approximateValue = approximateValue;
    _encumbrances = encumbrances;
    _uploadDoc = uploadDoc;
    _holder = holder;
    _timestamp = timestamp;
}

  OtherAssets.fromJson(dynamic json) {
    _otherAssetId = json['other_asset_id'];
    _userId = json['user_id'];
    _holderId = json['holder_id'];
    _holderName = json['holder_name'];
    _assetName = json['asset_name'];
    _institution = json['institution'];
    _accountNumber = json['account_number'];
    _amount = json['amount'];
    _contactPerson = json['contact_person'];
    _locationOfDocument = json['location_of_document'];
    _notes = json['notes'];
    _nomineeName = json['nominee_name'];
    _description = json['description'];
    _approximateValue = json['approximate_value'];
    _encumbrances = json['encumbrances'];
    _uploadDoc = json['upload_doc'];
    _holder = json['holder'];
    _timestamp = json['timestamp'];
  }
  String? _otherAssetId;
  String? _userId;
  String? _holderId;
  String? _holderName;
  String? _assetName;
  String? _institution;
  String? _accountNumber;
  String? _amount;
  String? _contactPerson;
  String? _locationOfDocument;
  String? _notes;
  String? _nomineeName;
  String? _description;
  String? _approximateValue;
  String? _encumbrances;
  String? _uploadDoc;
  String? _holder;
  String? _timestamp;
OtherAssets copyWith({  String? otherAssetId,
  String? userId,
  String? holderId,
  String? holderName,
  String? assetName,
  String? institution,
  String? accountNumber,
  String? amount,
  String? contactPerson,
  String? locationOfDocument,
  String? notes,
  String? nomineeName,
  String? description,
  String? approximateValue,
  String? encumbrances,
  String? uploadDoc,
  String? holder,
  String? timestamp,
}) => OtherAssets(  otherAssetId: otherAssetId ?? _otherAssetId,
  userId: userId ?? _userId,
  holderId: holderId ?? _holderId,
  holderName: holderName ?? _holderName,
  assetName: assetName ?? _assetName,
  institution: institution ?? _institution,
  accountNumber: accountNumber ?? _accountNumber,
  amount: amount ?? _amount,
  contactPerson: contactPerson ?? _contactPerson,
  locationOfDocument: locationOfDocument ?? _locationOfDocument,
  notes: notes ?? _notes,
  nomineeName: nomineeName ?? _nomineeName,
  description: description ?? _description,
  approximateValue: approximateValue ?? _approximateValue,
  encumbrances: encumbrances ?? _encumbrances,
  uploadDoc: uploadDoc ?? _uploadDoc,
  holder: holder ?? _holder,
  timestamp: timestamp ?? _timestamp,
);
  String? get otherAssetId => _otherAssetId;
  String? get userId => _userId;
  String? get holderId => _holderId;
  String? get holderName => _holderName;
  String? get assetName => _assetName;
  String? get institution => _institution;
  String? get accountNumber => _accountNumber;
  String? get amount => _amount;
  String? get contactPerson => _contactPerson;
  String? get locationOfDocument => _locationOfDocument;
  String? get notes => _notes;
  String? get nomineeName => _nomineeName;
  String? get description => _description;
  String? get approximateValue => _approximateValue;
  String? get encumbrances => _encumbrances;
  String? get uploadDoc => _uploadDoc;
  String? get holder => _holder;
  String? get timestamp => _timestamp;

  TextEditingController descriptionController = TextEditingController();
  TextEditingController encumbrancesController = TextEditingController();
  TextEditingController approximateValueController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController nomineeNameController = TextEditingController();

  set setDescription(String value)
  {
    _description = value;
  }

  set setEncumbrances(String value)
  {
    _encumbrances = value;
  }

  set setApproximateValue(String value)
  {
    _approximateValue = value;
  }

  set setNotes(String value)
  {
    _notes = value;
  }

  set setNomineeName(String value)
  {
    _nomineeName = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['holder'] = checkValidString(_holder);
    map['description'] = checkValidString(_description);
    map['encumbrances'] = checkValidString(_encumbrances);
    map['approximate_value'] = checkValidString(_approximateValue);
    map['notes'] = checkValidString(_notes);
    map['nominee_name'] = checkValidString(_nomineeName);
    if(checkValidString(_otherAssetId).toString().isNotEmpty)
    {
      map['other_asset_id'] = checkValidString(_otherAssetId);
    }
    return map;
  }

}