import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:superapp_flutter/utils/app_utils.dart';
import 'package:superapp_flutter/utils/session_manager_vault.dart';
/// documents : [{"document_id":"38","user_id":"164","holder_id":"97","document":"Property Document","location":"At Home","softcopy":"https://vault.alphacapital.in/api/assets/uploads/softcopy/1678784496_IMG_20230314_143128875.jpg","holder":"A","holder_name":"","timestamp":"1678784496"}]
/// success : 1
/// message : "Documents found."

ImpDocListResponse impDocListResponseFromJson(String str) => ImpDocListResponse.fromJson(json.decode(str));
String impDocListResponseToJson(ImpDocListResponse data) => json.encode(data.toJson());
class ImpDocListResponse {
  ImpDocListResponse({
      List<Documents>? documents, 
      num? success, 
      String? message,}){
    _documents = documents;
    _success = success;
    _message = message;
}

  ImpDocListResponse.fromJson(dynamic json) {
    if (json['documents'] != null) {
      _documents = [];
      json['documents'].forEach((v) {
        _documents?.add(Documents.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
  }
  List<Documents>? _documents;
  num? _success;
  String? _message;
ImpDocListResponse copyWith({  List<Documents>? documents,
  num? success,
  String? message,
}) => ImpDocListResponse(  documents: documents ?? _documents,
  success: success ?? _success,
  message: message ?? _message,
);
  List<Documents>? get documents => _documents;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_documents != null) {
      map['documents'] = _documents?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// document_id : "38"
/// user_id : "164"
/// holder_id : "97"
/// document : "Property Document"
/// location : "At Home"
/// softcopy : "https://vault.alphacapital.in/api/assets/uploads/softcopy/1678784496_IMG_20230314_143128875.jpg"
/// holder : "A"
/// holder_name : ""
/// timestamp : "1678784496"

Documents documentsFromJson(String str) => Documents.fromJson(json.decode(str));
String documentsToJson(Documents data) => json.encode(data.toJson());
class Documents {
  Documents({
      String? documentId, 
      String? userId, 
      String? holderId, 
      String? document, 
      String? location, 
      String? softcopy, 
      String? holder, 
      String? holderName, 
      String? timestamp,}){
    _documentId = documentId;
    _userId = userId;
    _holderId = holderId;
    _document = document;
    _location = location;
    _softcopy = softcopy;
    _holder = holder;
    _holderName = holderName;
    _timestamp = timestamp;
}

  Documents.fromJson(dynamic json) {
    _documentId = json['document_id'];
    _userId = json['user_id'];
    _holderId = json['holder_id'];
    _document = json['document'];
    _location = json['location'];
    _softcopy = json['softcopy'];
    _holder = json['holder'];
    _holderName = json['holder_name'];
    _timestamp = json['timestamp'];
  }
  String? _documentId;
  String? _userId;
  String? _holderId;
  String? _document;
  String? _location;
  String? _softcopy;
  String? _holder;
  String? _holderName;
  String? _timestamp;
Documents copyWith({  String? documentId,
  String? userId,
  String? holderId,
  String? document,
  String? location,
  String? softcopy,
  String? holder,
  String? holderName,
  String? timestamp,
}) => Documents(  documentId: documentId ?? _documentId,
  userId: userId ?? _userId,
  holderId: holderId ?? _holderId,
  document: document ?? _document,
  location: location ?? _location,
  softcopy: softcopy ?? _softcopy,
  holder: holder ?? _holder,
  holderName: holderName ?? _holderName,
  timestamp: timestamp ?? _timestamp,
);
  String? get documentId => _documentId;
  String? get userId => _userId;
  String? get holderId => _holderId;
  String? get document => _document;
  String? get location => _location;
  String? get softcopy => _softcopy;
  String? get holder => _holder;
  String? get holderName => _holderName;
  String? get timestamp => _timestamp;

  TextEditingController documentNameController = TextEditingController();
  TextEditingController originalLocationController = TextEditingController();
  TextEditingController uploadFileController = TextEditingController();

  set setDocumentName(String value)
  {
    _document = value;
  }

  set setOriginalLocation(String value)
  {
    _location = value;
  }

  set setUploadFile(String value)
  {
    _softcopy = value;
  }

  Map<String, dynamic> toJson() {
    var sessionManagerVault = SessionManagerVault();
    final map = <String, dynamic>{};
    map['location'] = checkValidString(_location);
    map['document'] = checkValidString(_document);

    if(checkValidString(_documentId).toString().isNotEmpty)
      {
        map['document_id'] = checkValidString(_documentId);
      }

    map['user_id'] = checkValidString(_userId).toString().isNotEmpty ? checkValidString(_userId) : sessionManagerVault.getUserId().trim();
    map['holder'] = checkValidString(_holder);
    return map;
  }

}