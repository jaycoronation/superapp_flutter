import 'dart:convert';
/// success : 1
/// message : "Mail can not be sent."
/// urlData : "https://vault.alphacapital.in/api//files/estate_vault_Shahista_Shakeel_Ahmed_Sayed_20_03_2023.pdf"

ShareDataReportResponse shareDataReportResponseFromJson(String str) => ShareDataReportResponse.fromJson(json.decode(str));
String shareDataReportResponseToJson(ShareDataReportResponse data) => json.encode(data.toJson());
class ShareDataReportResponse {
  ShareDataReportResponse({
      num? success, 
      String? message, 
      String? urlData,}){
    _success = success;
    _message = message;
    _urlData = urlData;
}

  ShareDataReportResponse.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _urlData = json['url'];
  }
  num? _success;
  String? _message;
  String? _urlData;
ShareDataReportResponse copyWith({  num? success,
  String? message,
  String? urlData,
}) => ShareDataReportResponse(  success: success ?? _success,
  message: message ?? _message,
  urlData: urlData ?? _urlData,
);
  num? get success => _success;
  String? get message => _message;
  String? get urlData => _urlData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    map['url'] = _urlData;
    return map;
  }

}