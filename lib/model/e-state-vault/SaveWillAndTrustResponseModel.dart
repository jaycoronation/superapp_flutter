import 'dart:convert';
/// success : 1
/// message : "Data saved successfully"
/// will_id : "37"

SaveWillAndTrustResponseModel saveWillAndTrustResponseModelFromJson(String str) => SaveWillAndTrustResponseModel.fromJson(json.decode(str));
String saveWillAndTrustResponseModelToJson(SaveWillAndTrustResponseModel data) => json.encode(data.toJson());
class SaveWillAndTrustResponseModel {
  SaveWillAndTrustResponseModel({
      num? success, 
      String? message, 
      String? willId,}){
    _success = success;
    _message = message;
    _willId = willId;
}

  SaveWillAndTrustResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _willId = json['will_id'] is int ? json['will_id'].toString() : json['will_id'];
  }
  num? _success;
  String? _message;
  String? _willId;
SaveWillAndTrustResponseModel copyWith({  num? success,
  String? message,
  String? willId,
}) => SaveWillAndTrustResponseModel(  success: success ?? _success,
  message: message ?? _message,
  willId: willId ?? _willId,
);
  num? get success => _success;
  String? get message => _message;
  String? get willId => _willId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    map['will_id'] = _willId;
    return map;
  }

}