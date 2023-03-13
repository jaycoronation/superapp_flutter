import 'dart:convert';
/// investment_types : [{"investment_type_id":"1","investment_type":"Bank Balance","asset_type":"Cash"},{"investment_type_id":"2","investment_type":"Union bank Balance","asset_type":"Cash"},{"investment_type_id":"3","investment_type":"Vatika India Next","asset_type":"Cash"},{"investment_type_id":"4","investment_type":"Plot In Lucknow","asset_type":"Cash"},{"investment_type_id":"5","investment_type":"Bank Fixed Deposit","asset_type":"Debt"},{"investment_type_id":"6","investment_type":"Recurring Deposit ","asset_type":"Debt"},{"investment_type_id":"7","investment_type":"Commodities - Direct","asset_type":"Alternate"},{"investment_type_id":"8","investment_type":"Commodities Fund","asset_type":"Alternate"},{"investment_type_id":"9","investment_type":"Company Fixed Deposit","asset_type":"Debt"},{"investment_type_id":"10","investment_type":"Employee Provident Fund (EPF)","asset_type":"Debt"},{"investment_type_id":"11","investment_type":"Employee Stock Options","asset_type":"Equity"},{"investment_type_id":"12","investment_type":"Property In Faridabad","asset_type":"Real Estate"},{"investment_type_id":"13","investment_type":"Gratuity","asset_type":"Debt"},{"investment_type_id":"14","investment_type":"Infrastructure Bonds","asset_type":"Debt"},{"investment_type_id":"15","investment_type":"Mutual Fund FMP","asset_type":"Debt"},{"investment_type_id":"16","investment_type":"Stock Option","asset_type":"Equity"},{"investment_type_id":"17","investment_type":"Land / Plot","asset_type":"Real Estate"},{"investment_type_id":"18","investment_type":"Loan Given - Long Term","asset_type":"Cash"},{"investment_type_id":"19","investment_type":"Loan Given - Short Term","asset_type":"Debt"},{"investment_type_id":"20","investment_type":"Mutual Funds - Arbitrage","asset_type":"Debt"},{"investment_type_id":"21","investment_type":"Mutual Funds - Balanced","asset_type":"Hybrid"},{"investment_type_id":"22","investment_type":"Mutual Funds - Capital Protetction Fund - MIP","asset_type":"Debt"},{"investment_type_id":"23","investment_type":"Mutual Funds - Equity","asset_type":"Equity"},{"investment_type_id":"24","investment_type":"Mutual Funds - Equity ETF","asset_type":"Equity"},{"investment_type_id":"25","investment_type":"Mutual Funds - Equity linked Debenture","asset_type":"Hybrid"},{"investment_type_id":"26","investment_type":"Mutual Funds - Floating Rate","asset_type":"Debt"},{"investment_type_id":"27","investment_type":"Mutual Funds - Debt","asset_type":"Debt"},{"investment_type_id":"28","investment_type":"Mutual Funds - Gilt Short Term","asset_type":"Debt"},{"investment_type_id":"29","investment_type":"Real Estate","asset_type":"Resal Estate"},{"investment_type_id":"30","investment_type":"Mutual Funds - Gold Fund","asset_type":"Alternate"},{"investment_type_id":"31","investment_type":"Mutual Funds - Hybrid","asset_type":"Hybrid"},{"investment_type_id":"32","investment_type":"Mutual Funds - Income Fund","asset_type":"Debt"},{"investment_type_id":"33","investment_type":"Insurance -Endowment","asset_type":"Debt"},{"investment_type_id":"34","investment_type":"Mutual Funds - Liquid","asset_type":"Cash"},{"investment_type_id":"35","investment_type":"Mutual Funds - Liquid Plus","asset_type":"Cash"},{"investment_type_id":"36","investment_type":"Mutual Funds - MIP","asset_type":"Debt"},{"investment_type_id":"37","investment_type":"National Savings Certificate (NSC)","asset_type":"Debt"},{"investment_type_id":"38","investment_type":"Other Alternate Investment","asset_type":"Alternate"},{"investment_type_id":"39","investment_type":"Other Cash investment","asset_type":"Cash"},{"investment_type_id":"40","investment_type":"Other Debt Investment","asset_type":"Debt"},{"investment_type_id":"41","investment_type":"Direct Shares","asset_type":"Equity"},{"investment_type_id":"42","investment_type":"Other Hybrid Investment","asset_type":"Hybrid"},{"investment_type_id":"43","investment_type":"Other Real Estate Investment","asset_type":"Real Estate"},{"investment_type_id":"44","investment_type":"Portfolio Management Services (PMS)","asset_type":"Equity"},{"investment_type_id":"45","investment_type":"Private Equity - Direct","asset_type":"Alternate"},{"investment_type_id":"46","investment_type":"Private Equity Fund","asset_type":"Alternate"},{"investment_type_id":"47","investment_type":"Public Provident Fund (PPF)","asset_type":"Debt"},{"investment_type_id":"48","investment_type":"Real Estate Fund","asset_type":"Real Estate"},{"investment_type_id":"49","investment_type":"loan","asset_type":"Real Estate"},{"investment_type_id":"50","investment_type":"Residential Property-Park Place","asset_type":"Real Estate"},{"investment_type_id":"51","investment_type":"Residential Property-Bangalore","asset_type":"Real Estate"},{"investment_type_id":"52","investment_type":"insurance equity","asset_type":"Other"},{"investment_type_id":"53","investment_type":"Shares","asset_type":"Equity"},{"investment_type_id":"54","investment_type":"Structured Products - Nifty Linked Debentures","asset_type":"Hybrid"},{"investment_type_id":"55","investment_type":"Super Annuation Fund","asset_type":"Debt"},{"investment_type_id":"56","investment_type":"Insurance - Endowment ","asset_type":"Debt"},{"investment_type_id":"57","investment_type":"Insurance - Money back","asset_type":"Debt"},{"investment_type_id":"58","investment_type":"Gold","asset_type":"Alternate"},{"investment_type_id":"59","investment_type":"Capital Gain Account","asset_type":"Debt"},{"investment_type_id":"60","investment_type":"Real Estate - Plot","asset_type":"Real Estate"},{"investment_type_id":"61","investment_type":"Real Estate - Commercial ","asset_type":"Real Estate"},{"investment_type_id":"62","investment_type":"Real Estate - Retail","asset_type":"Real Estate"},{"investment_type_id":"63","investment_type":"Sukanya Samridhi","asset_type":"Debt"},{"investment_type_id":"64","investment_type":"Direct Equity","asset_type":"Equity"},{"investment_type_id":"65","investment_type":"NPS","asset_type":"Hybrid"},{"investment_type_id":"66","investment_type":"Hybrid Mutual Fund","asset_type":"Hybrid"},{"investment_type_id":"67","investment_type":"HDFC Click to Invest","asset_type":"Hybrid"},{"investment_type_id":"68","investment_type":"Sovgn. Gold Bond & Coins","asset_type":"Alternate"},{"investment_type_id":"69","investment_type":"2 BHK Flat","asset_type":"Real Estate"},{"investment_type_id":"70","investment_type":"Villa","asset_type":"Real Estate"},{"investment_type_id":"71","investment_type":"Plot (Bangalore)","asset_type":"Real Estate"},{"investment_type_id":"72","investment_type":"Equity Mutual Fund","asset_type":"Equity"}]
/// message : ""
/// success : 1

InvestmentTypeResponseModel investmentTypeResponseModelFromJson(String str) => InvestmentTypeResponseModel.fromJson(json.decode(str));
String investmentTypeResponseModelToJson(InvestmentTypeResponseModel data) => json.encode(data.toJson());
class InvestmentTypeResponseModel {
  InvestmentTypeResponseModel({
      List<InvestmentTypes>? investmentTypes, 
      String? message, 
      num? success,}){
    _investmentTypes = investmentTypes;
    _message = message;
    _success = success;
}

  InvestmentTypeResponseModel.fromJson(dynamic json) {
    if (json['investment_types'] != null) {
      _investmentTypes = [];
      json['investment_types'].forEach((v) {
        _investmentTypes?.add(InvestmentTypes.fromJson(v));
      });
    }
    _message = json['message'];
    _success = json['success'];
  }
  List<InvestmentTypes>? _investmentTypes;
  String? _message;
  num? _success;
InvestmentTypeResponseModel copyWith({  List<InvestmentTypes>? investmentTypes,
  String? message,
  num? success,
}) => InvestmentTypeResponseModel(  investmentTypes: investmentTypes ?? _investmentTypes,
  message: message ?? _message,
  success: success ?? _success,
);
  List<InvestmentTypes>? get investmentTypes => _investmentTypes;
  String? get message => _message;
  num? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_investmentTypes != null) {
      map['investment_types'] = _investmentTypes?.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    map['success'] = _success;
    return map;
  }

}

/// investment_type_id : "1"
/// investment_type : "Bank Balance"
/// asset_type : "Cash"

InvestmentTypes investmentTypesFromJson(String str) => InvestmentTypes.fromJson(json.decode(str));
String investmentTypesToJson(InvestmentTypes data) => json.encode(data.toJson());
class InvestmentTypes {
  InvestmentTypes({
      String? investmentTypeId, 
      String? investmentType, 
      String? assetType,}){
    _investmentTypeId = investmentTypeId;
    _investmentType = investmentType;
    _assetType = assetType;
}

  InvestmentTypes.fromJson(dynamic json) {
    _investmentTypeId = json['investment_type_id'];
    _investmentType = json['investment_type'];
    _assetType = json['asset_type'];
  }
  String? _investmentTypeId;
  String? _investmentType;
  String? _assetType;
InvestmentTypes copyWith({  String? investmentTypeId,
  String? investmentType,
  String? assetType,
}) => InvestmentTypes(  investmentTypeId: investmentTypeId ?? _investmentTypeId,
  investmentType: investmentType ?? _investmentType,
  assetType: assetType ?? _assetType,
);
  String? get investmentTypeId => _investmentTypeId;
  String? get investmentType => _investmentType;
  String? get assetType => _assetType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['investment_type_id'] = _investmentTypeId;
    map['investment_type'] = _investmentType;
    map['asset_type'] = _assetType;
    return map;
  }

}