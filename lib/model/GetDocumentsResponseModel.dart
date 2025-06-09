import 'dart:convert';
/// documents : [{"document_id":"9","title":"Test","link":"http://portfolio.alphacapital.in/api/assets/upload/documents/3925/1747639275_KeyboardReferenceSheet.png","timestamp":"19-05-2025 12:51 PM"}]
/// success : 1
/// message : "1 documents found"

GetDocumentsResponseModel getDocumentsResponseModelFromJson(String str) => GetDocumentsResponseModel.fromJson(json.decode(str));
String getDocumentsResponseModelToJson(GetDocumentsResponseModel data) => json.encode(data.toJson());
class GetDocumentsResponseModel {
  GetDocumentsResponseModel({
      List<Documents>? documents, 
      num? success, 
      String? message,}){
    _documents = documents;
    _success = success;
    _message = message;
}

  GetDocumentsResponseModel.fromJson(dynamic json) {
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
GetDocumentsResponseModel copyWith({  List<Documents>? documents,
  num? success,
  String? message,
}) => GetDocumentsResponseModel(  documents: documents ?? _documents,
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

/// document_id : "9"
/// title : "Test"
/// link : "http://portfolio.alphacapital.in/api/assets/upload/documents/3925/1747639275_KeyboardReferenceSheet.png"
/// timestamp : "19-05-2025 12:51 PM"

Documents documentsFromJson(String str) => Documents.fromJson(json.decode(str));
String documentsToJson(Documents data) => json.encode(data.toJson());
class Documents {
  Documents({
      String? documentId, 
      String? title, 
      String? link, 
      String? timestamp,}){
    _documentId = documentId;
    _title = title;
    _link = link;
    _timestamp = timestamp;
}

  Documents.fromJson(dynamic json) {
    _documentId = json['document_id'];
    _title = json['title'];
    _link = json['link'];
    _timestamp = json['timestamp'];
  }
  String? _documentId;
  String? _title;
  String? _link;
  String? _timestamp;
Documents copyWith({  String? documentId,
  String? title,
  String? link,
  String? timestamp,
}) => Documents(  documentId: documentId ?? _documentId,
  title: title ?? _title,
  link: link ?? _link,
  timestamp: timestamp ?? _timestamp,
);
  String? get documentId => _documentId;
  String? get title => _title;
  String? get link => _link;
  String? get timestamp => _timestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['document_id'] = _documentId;
    map['title'] = _title;
    map['link'] = _link;
    map['timestamp'] = _timestamp;
    return map;
  }

}