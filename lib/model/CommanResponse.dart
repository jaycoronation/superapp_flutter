import 'dart:convert';
/// message : "Inquiry follow up added successfully."
/// success : 1

CommanResponse commanResponseFromJson(String str) => CommanResponse.fromJson(json.decode(str));
String commanResponseToJson(CommanResponse data) => json.encode(data.toJson());
class CommanResponse {
  CommanResponse({
      String? message, 
      num? success,}){
    _message = message;
    _success = success;
}

  CommanResponse.fromJson(dynamic json) {
    _message = json['message'];
    _success = json['success'];
  }
  String? _message;
  num? _success;
CommanResponse copyWith({  String? message,
  num? success,
}) => CommanResponse(  message: message ?? _message,
  success: success ?? _success,
);
  String? get message => _message;
  num? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['success'] = _success;
    return map;
  }

}