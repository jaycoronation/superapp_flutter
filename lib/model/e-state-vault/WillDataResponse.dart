import 'dart:convert';
/// will_id : "26"
/// user_id : "164"
/// original_will_located : "tesr"
/// upload_doc_review : "https://vault.alphacapital.in/api/assets/uploads/softcopy/1678796843_IMG_20230314_143128875.jpg"
/// timestamp : "1678796843"

WillDataResponse willDataResponseFromJson(String str) => WillDataResponse.fromJson(json.decode(str));
String willDataResponseToJson(WillDataResponse data) => json.encode(data.toJson());
class WillDataResponse {
  WillDataResponse({
      String? willId, 
      String? userId, 
      String? originalWillLocated, 
      String? uploadDocReview, 
      String? timestamp,}){
    _willId = willId;
    _userId = userId;
    _originalWillLocated = originalWillLocated;
    _uploadDocReview = uploadDocReview;
    _timestamp = timestamp;
}

  WillDataResponse.fromJson(dynamic json) {
    _willId = json['will_id'];
    _userId = json['user_id'];
    _originalWillLocated = json['original_will_located'];
    _uploadDocReview = json['upload_doc_review'];
    _timestamp = json['timestamp'];
  }
  String? _willId;
  String? _userId;
  String? _originalWillLocated;
  String? _uploadDocReview;
  String? _timestamp;
WillDataResponse copyWith({  String? willId,
  String? userId,
  String? originalWillLocated,
  String? uploadDocReview,
  String? timestamp,
}) => WillDataResponse(  willId: willId ?? _willId,
  userId: userId ?? _userId,
  originalWillLocated: originalWillLocated ?? _originalWillLocated,
  uploadDocReview: uploadDocReview ?? _uploadDocReview,
  timestamp: timestamp ?? _timestamp,
);
  String? get willId => _willId;
  String? get userId => _userId;
  String? get originalWillLocated => _originalWillLocated;
  String? get uploadDocReview => _uploadDocReview;
  String? get timestamp => _timestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['will_id'] = _willId;
    map['user_id'] = _userId;
    map['original_will_located'] = _originalWillLocated;
    map['upload_doc_review'] = _uploadDocReview;
    map['timestamp'] = _timestamp;
    return map;
  }

}