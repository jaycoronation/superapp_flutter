import 'dart:convert';
/// message : "Inquiry follow up added successfully."
/// success : 1

UpdateDeviceTokenResponseModel commanResponseFromJson(String str) => UpdateDeviceTokenResponseModel.fromJson(json.decode(str));
String commanResponseToJson(UpdateDeviceTokenResponseModel data) => json.encode(data.toJson());
class UpdateDeviceTokenResponseModel {
  UpdateDeviceTokenResponseModel({
      String? message, 
      num? success,
      num? disableConsolidatedPortfolio,
  }){
    _message = message;
    _success = success;
    _disableConsolidatedPortfolio = disableConsolidatedPortfolio;
}

  UpdateDeviceTokenResponseModel.fromJson(dynamic json) {
    _message = json['message'];
    _success = json['success'];
    _disableConsolidatedPortfolio = json['disableConsolidatedPortfolio'];
  }
  String? _message;
  num? _success;
  num? _disableConsolidatedPortfolio;
UpdateDeviceTokenResponseModel copyWith({  String? message,
  num? success,
  num? disableConsolidatedPortfolio,
}) => UpdateDeviceTokenResponseModel(  message: message ?? _message,
  success: success ?? _success,
  disableConsolidatedPortfolio: disableConsolidatedPortfolio ?? _disableConsolidatedPortfolio,
);
  String? get message => _message;
  num? get success => _success;
  num? get disableConsolidatedPortfolio => _disableConsolidatedPortfolio;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['success'] = _success;
    map['disableConsolidatedPortfolio'] = _disableConsolidatedPortfolio;
    return map;
  }

}