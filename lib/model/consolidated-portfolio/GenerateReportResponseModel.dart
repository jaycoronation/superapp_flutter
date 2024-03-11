import 'dart:convert';
/// success : 1
/// message : "Done"
/// pdf_file_name : "A V RAMESH__52_Portfolio_Report_07_03_24.pdf"

GenerateReportResponseModel generateReportResponseModelFromJson(String str) => GenerateReportResponseModel.fromJson(json.decode(str));
String generateReportResponseModelToJson(GenerateReportResponseModel data) => json.encode(data.toJson());
class GenerateReportResponseModel {
  GenerateReportResponseModel({
      num? success, 
      String? message, 
      String? pdfFileName,}){
    _success = success;
    _message = message;
    _pdfFileName = pdfFileName;
}

  GenerateReportResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _pdfFileName = json['pdf_file_name'];
  }
  num? _success;
  String? _message;
  String? _pdfFileName;
GenerateReportResponseModel copyWith({  num? success,
  String? message,
  String? pdfFileName,
}) => GenerateReportResponseModel(  success: success ?? _success,
  message: message ?? _message,
  pdfFileName: pdfFileName ?? _pdfFileName,
);
  num? get success => _success;
  String? get message => _message;
  String? get pdfFileName => _pdfFileName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    map['pdf_file_name'] = _pdfFileName;
    return map;
  }

}