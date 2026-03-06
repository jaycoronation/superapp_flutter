import 'dart:convert';
/// url : "https://vault.alphacapital.in/api/files/estate_vault_MUKESH_JINDAL__06_03_2026.pdf"
/// success : 1
/// message : ""

GenerateVaultReportResponseModel generateVaultReportResponseModelFromJson(String str) => GenerateVaultReportResponseModel.fromJson(json.decode(str));
String generateVaultReportResponseModelToJson(GenerateVaultReportResponseModel data) => json.encode(data.toJson());
class GenerateVaultReportResponseModel {
  GenerateVaultReportResponseModel({
      String? url, 
      num? success, 
      String? message,}){
    _url = url;
    _success = success;
    _message = message;
}

  GenerateVaultReportResponseModel.fromJson(dynamic json) {
    _url = json['url'];
    _success = json['success'];
    _message = json['message'];
  }
  String? _url;
  num? _success;
  String? _message;
GenerateVaultReportResponseModel copyWith({  String? url,
  num? success,
  String? message,
}) => GenerateVaultReportResponseModel(  url: url ?? _url,
  success: success ?? _success,
  message: message ?? _message,
);
  String? get url => _url;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}