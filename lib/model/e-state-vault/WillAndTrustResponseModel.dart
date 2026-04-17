import 'dart:convert';
/// will : {"will_id":"37","has_will":1,"original_will_located":"test","has_living_will":1,"living_will_location":"test","has_trust":1,"trust_location":"test 3","documents":[{"doc_id":"9","file_name":"1775836191_living_will_unnamed.jpg","file_url":"https://vault.alphacapital.in/api/assets/uploads/softcopy/1775836191_living_will_unnamed.jpg","document_type":"living_will","uploaded_at":"1775836191"},{"doc_id":"12","file_name":"1776261344_trust_file-sample_150kB.pdf","file_url":"https://vault.alphacapital.in/api/assets/uploads/softcopy/1776261344_trust_file-sample_150kB.pdf","document_type":"trust","uploaded_at":"1776261344"},{"doc_id":"13","file_name":"1776261465_will_unnamed.jpg","file_url":"https://vault.alphacapital.in/api/assets/uploads/softcopy/1776261465_will_unnamed.jpg","document_type":"will","uploaded_at":"1776261465"},{"doc_id":"14","file_name":"1776261465_will_file-sample_150kB.pdf","file_url":"https://vault.alphacapital.in/api/assets/uploads/softcopy/1776261465_will_file-sample_150kB.pdf","document_type":"will","uploaded_at":"1776261465"}]}
/// success : 1

WillAndTrustResponseModel willAndTrustResponseModelFromJson(String str) => WillAndTrustResponseModel.fromJson(json.decode(str));
String willAndTrustResponseModelToJson(WillAndTrustResponseModel data) => json.encode(data.toJson());
class WillAndTrustResponseModel {
  WillAndTrustResponseModel({
      WillData? willData, 
      num? success,}){
    _willData = willData;
    _success = success;
}

  WillAndTrustResponseModel.fromJson(dynamic json) {
    _willData = json['will'] != null ? WillData.fromJson(json['will']) : null;
    _success = json['success'];
  }
  WillData? _willData;
  num? _success;
WillAndTrustResponseModel copyWith({  WillData? willData,
  num? success,
}) => WillAndTrustResponseModel(  willData: willData ?? _willData,
  success: success ?? _success,
);
  WillData? get willData => _willData;
  num? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_willData != null) {
      map['will'] = _willData?.toJson();
    }
    map['success'] = _success;
    return map;
  }

}

/// will_id : "37"
/// has_will : 1
/// original_will_located : "test"
/// has_living_will : 1
/// living_will_location : "test"
/// has_trust : 1
/// trust_location : "test 3"
/// documents : [{"doc_id":"9","file_name":"1775836191_living_will_unnamed.jpg","file_url":"https://vault.alphacapital.in/api/assets/uploads/softcopy/1775836191_living_will_unnamed.jpg","document_type":"living_will","uploaded_at":"1775836191"},{"doc_id":"12","file_name":"1776261344_trust_file-sample_150kB.pdf","file_url":"https://vault.alphacapital.in/api/assets/uploads/softcopy/1776261344_trust_file-sample_150kB.pdf","document_type":"trust","uploaded_at":"1776261344"},{"doc_id":"13","file_name":"1776261465_will_unnamed.jpg","file_url":"https://vault.alphacapital.in/api/assets/uploads/softcopy/1776261465_will_unnamed.jpg","document_type":"will","uploaded_at":"1776261465"},{"doc_id":"14","file_name":"1776261465_will_file-sample_150kB.pdf","file_url":"https://vault.alphacapital.in/api/assets/uploads/softcopy/1776261465_will_file-sample_150kB.pdf","document_type":"will","uploaded_at":"1776261465"}]

WillData willDataFromJson(String str) => WillData.fromJson(json.decode(str));
String willDataToJson(WillData data) => json.encode(data.toJson());
class WillData {
  WillData({
      String? willId, 
      num? hasWill, 
      String? originalWillLocated, 
      num? hasLivingWill, 
      String? livingWillLocation, 
      num? hasTrust, 
      String? trustLocation, 
      List<Documents>? documents,}){
    _willId = willId;
    _hasWill = hasWill;
    _originalWillLocated = originalWillLocated;
    _hasLivingWill = hasLivingWill;
    _livingWillLocation = livingWillLocation;
    _hasTrust = hasTrust;
    _trustLocation = trustLocation;
    _documents = documents;
}

  WillData.fromJson(dynamic json) {
    _willId = json['will_id'];
    _hasWill = json['has_will'];
    _originalWillLocated = json['original_will_located'];
    _hasLivingWill = json['has_living_will'];
    _livingWillLocation = json['living_will_location'];
    _hasTrust = json['has_trust'];
    _trustLocation = json['trust_location'];
    if (json['documents'] != null) {
      _documents = [];
      json['documents'].forEach((v) {
        _documents?.add(Documents.fromJson(v));
      });
    }
  }
  String? _willId;
  num? _hasWill;
  String? _originalWillLocated;
  num? _hasLivingWill;
  String? _livingWillLocation;
  num? _hasTrust;
  String? _trustLocation;
  List<Documents>? _documents;
WillData copyWith({  String? willId,
  num? hasWill,
  String? originalWillLocated,
  num? hasLivingWill,
  String? livingWillLocation,
  num? hasTrust,
  String? trustLocation,
  List<Documents>? documents,
}) => WillData(  willId: willId ?? _willId,
  hasWill: hasWill ?? _hasWill,
  originalWillLocated: originalWillLocated ?? _originalWillLocated,
  hasLivingWill: hasLivingWill ?? _hasLivingWill,
  livingWillLocation: livingWillLocation ?? _livingWillLocation,
  hasTrust: hasTrust ?? _hasTrust,
  trustLocation: trustLocation ?? _trustLocation,
  documents: documents ?? _documents,
);
  String? get willId => _willId;
  num? get hasWill => _hasWill;
  String? get originalWillLocated => _originalWillLocated;
  num? get hasLivingWill => _hasLivingWill;
  String? get livingWillLocation => _livingWillLocation;
  num? get hasTrust => _hasTrust;
  String? get trustLocation => _trustLocation;
  List<Documents>? get documents => _documents;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['will_id'] = _willId;
    map['has_will'] = _hasWill;
    map['original_will_located'] = _originalWillLocated;
    map['has_living_will'] = _hasLivingWill;
    map['living_will_location'] = _livingWillLocation;
    map['has_trust'] = _hasTrust;
    map['trust_location'] = _trustLocation;
    if (_documents != null) {
      map['documents'] = _documents?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// doc_id : "9"
/// file_name : "1775836191_living_will_unnamed.jpg"
/// file_url : "https://vault.alphacapital.in/api/assets/uploads/softcopy/1775836191_living_will_unnamed.jpg"
/// document_type : "living_will"
/// uploaded_at : "1775836191"

Documents documentsFromJson(String str) => Documents.fromJson(json.decode(str));
String documentsToJson(Documents data) => json.encode(data.toJson());
class Documents {
  Documents({
      String? docId, 
      String? fileName, 
      String? fileUrl, 
      String? documentType, 
      String? uploadedAt,}){
    _docId = docId;
    _fileName = fileName;
    _fileUrl = fileUrl;
    _documentType = documentType;
    _uploadedAt = uploadedAt;
}

  Documents.fromJson(dynamic json) {
    _docId = json['doc_id'];
    _fileName = json['file_name'];
    _fileUrl = json['file_url'];
    _documentType = json['document_type'];
    _uploadedAt = json['uploaded_at'];
  }
  String? _docId;
  String? _fileName;
  String? _fileUrl;
  String? _documentType;
  String? _uploadedAt;
Documents copyWith({  String? docId,
  String? fileName,
  String? fileUrl,
  String? documentType,
  String? uploadedAt,
}) => Documents(  docId: docId ?? _docId,
  fileName: fileName ?? _fileName,
  fileUrl: fileUrl ?? _fileUrl,
  documentType: documentType ?? _documentType,
  uploadedAt: uploadedAt ?? _uploadedAt,
);
  String? get docId => _docId;
  String? get fileName => _fileName;
  String? get fileUrl => _fileUrl;
  String? get documentType => _documentType;
  String? get uploadedAt => _uploadedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['doc_id'] = _docId;
    map['file_name'] = _fileName;
    map['file_url'] = _fileUrl;
    map['document_type'] = _documentType;
    map['uploaded_at'] = _uploadedAt;
    return map;
  }

}