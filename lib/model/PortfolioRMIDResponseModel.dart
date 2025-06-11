import 'dart:convert';
/// admin_id : "8"
/// success : 1
/// message : "RM account found"

PortfolioRMIDResponseModel portfolioRMIDResponseModelFromJson(String str) => PortfolioRMIDResponseModel.fromJson(json.decode(str));
String portfolioRMIDResponseModelToJson(PortfolioRMIDResponseModel data) => json.encode(data.toJson());
class PortfolioRMIDResponseModel {
  PortfolioRMIDResponseModel({
      String? adminId, 
      num? success, 
      String? message,}){
    _adminId = adminId;
    _success = success;
    _message = message;
}

  PortfolioRMIDResponseModel.fromJson(dynamic json) {
    _adminId = json['admin_id'];
    _success = json['success'];
    _message = json['message'];
  }
  String? _adminId;
  num? _success;
  String? _message;
  PortfolioRMIDResponseModel copyWith({  String? adminId,
  num? success,
  String? message,
}) => PortfolioRMIDResponseModel(  adminId: adminId ?? _adminId,
  success: success ?? _success,
  message: message ?? _message,
);
  String? get adminId => _adminId;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['admin_id'] = _adminId;
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}